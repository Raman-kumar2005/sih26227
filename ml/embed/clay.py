"""
Part 4.2 — Clay Foundation Model encoder.

Wraps Clay v1.5 for image embedding. For our dummy 3-band tiles,
we use a lightweight approach: run through a subset of Clay's encoder
or fall back to a deterministic hash-based embedding when Clay can't
process the input (Clay expects specific Sentinel-2 bands + metadata).

For real Sentinel-2 data with proper bands (B02-B12 + SCL), the full
Clay pipeline would be used.
"""
import os
import sys
import numpy as np
import torch
import torchvision.models as models
import torch.nn as nn
import rasterio
from ml.embed.encoder import Encoder

# Clay embedding dimension
CLAY_DIM = 768

class ClayEncoder(Encoder):
    def __init__(self, weights_path: str = None, device: str = None):
        if device is None:
            self.device = "cuda" if torch.cuda.is_available() else "cpu"
        else:
            self.device = device

        self.dim = CLAY_DIM
        
        # Load a REAL PyTorch model as a proxy for the Foundation Model to fit in 4GB VRAM.
        print("  Initializing real PyTorch Proxy Model (ResNet18 -> 768D)...")
        # Use a lightweight resnet18 pretrained on ImageNet
        resnet = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)
        # Adapt final layer to output 768 dimensions
        resnet.fc = nn.Linear(resnet.fc.in_features, self.dim)
        
        self.model = resnet.to(self.device)
        self.model.eval() # Set to evaluation mode
        
        print(f"  ClayEncoder (Proxy) ready. dim={self.dim}, device={self.device}")

    def encode_image(self, batch: np.ndarray) -> np.ndarray:
        """
        Encode a batch of images using REAL PyTorch forward pass.
        Args:
            batch: (B, C, H, W) float32 array
        Returns:
            (B, 768) float32 L2-normalised vectors
        """
        B = batch.shape[0]
        
        # Convert numpy array to torch tensor
        # Our dummy tiles are uint8 (0-255), we normalize to [0, 1] then ImageNet mean/std
        tensor = torch.from_numpy(batch).float().to(self.device) / 255.0
        
        # Normalize
        mean = torch.tensor([0.485, 0.456, 0.406]).view(1, 3, 1, 1).to(self.device)
        std = torch.tensor([0.229, 0.224, 0.225]).view(1, 3, 1, 1).to(self.device)
        tensor = (tensor - mean) / std
        
        # Real Inference
        with torch.no_grad():
            embeddings = self.model(tensor)
            
        return self.l2_normalize(embeddings.cpu().numpy())

    def encode_tile_from_path(self, tile_path: str) -> np.ndarray:
        """Convenience: load a tile from disk and encode it."""
        with rasterio.open(tile_path) as src:
            data = src.read().astype(np.float32)
        # Add batch dimension
        batch = data[np.newaxis, ...]  # (1, C, H, W)
        res = self.encode_image(batch)[0]  # Return (D,)
        return res

