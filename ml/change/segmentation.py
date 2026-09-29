import torch
import torchvision.models.segmentation as segmentation
import numpy as np

class DeepSegmentationModel:
    """
    Priority C: Deep Image Segmentation for Change Detection.
    Replaces numerical heuristics with a real Convolutional Neural Network (DeepLabV3).
    """
    def __init__(self, device: str = "cpu"):
        self.device = device
        # Load a pretrained DeepLabV3 model for semantic segmentation
        self.model = segmentation.deeplabv3_resnet50(pretrained=True).to(self.device)
        self.model.eval()
        
    def predict_mask(self, image_tensor: torch.Tensor) -> np.ndarray:
        """
        Runs inference to generate a pixel-level segmentation mask.
        image_tensor: (1, 3, H, W) normalized tensor
        """
        with torch.no_grad():
            output = self.model(image_tensor.to(self.device))['out'][0]
        # Get the predicted class for each pixel
        predictions = output.argmax(0).cpu().numpy()
        return predictions

    def calculate_change_mask(self, before_tensor: torch.Tensor, after_tensor: torch.Tensor) -> np.ndarray:
        """
        Calculates morphological change (expansion/contraction) by diffing segmentation masks.
        """
        mask_before = self.predict_mask(before_tensor)
        mask_after = self.predict_mask(after_tensor)
        
        # 1 = Changed pixel, 0 = Unchanged pixel
        change_mask = (mask_before != mask_after).astype(np.uint8)
        return change_mask
