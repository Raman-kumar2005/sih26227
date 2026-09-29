"""
Part 4.1 — Encoder ABC.

Every downstream component talks ONLY to this interface.
Swap encoder by replacing one file.
"""
from abc import ABC, abstractmethod
import numpy as np


class Encoder(ABC):
    """Abstract base class for image/text encoders."""

    @abstractmethod
    def encode_image(self, batch: np.ndarray) -> np.ndarray:
        """
        Encode a batch of images.
        
        Args:
            batch: (B, C, H, W) float32 array
        Returns:
            (B, D) float32 array, L2-normalised
        """
        ...

    def encode_text(self, texts: list[str]) -> np.ndarray:
        """
        Encode a list of text strings.
        Default: raise NotImplementedError (not all encoders support text).
        """
        raise NotImplementedError(f"{self.__class__.__name__} does not support text encoding")

    @staticmethod
    def l2_normalize(vectors: np.ndarray) -> np.ndarray:
        """L2-normalize each row."""
        norms = np.linalg.norm(vectors, axis=1, keepdims=True)
        norms = np.maximum(norms, 1e-8)
        return vectors / norms
