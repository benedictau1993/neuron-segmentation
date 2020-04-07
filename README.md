# Automated Image Segmentation on Neurons

[![School](https://img.shields.io/badge/UChicago-MSCA-red)]() [![Field](https://img.shields.io/badge/Field-ComputerVision-lightgray)]()  [![Contributors](https://img.shields.io/badge/Contributors-3-green)]() 

# Research Motivation

Image segmentation is a key topic in image processing and computer vision with applications such as scene understanding, medical image analysis, robotic perception, video surveillance, augmented reality, and image compression, amongst many others. Various algorithms for image segmentation have been developed in the literature. Large Scale Inference is still an open problem for dense image segmentation and is a key step into any kind of supervised or unsupervised method for machine learning.

With recent advancements in techniques for image segmentation, it is now possible to replace traditional complex multi-step segmentation pipelines with a single neural network that is learned end-to-end. Computational costs aside, the problem of agglomeration of various established convolutional networks for segmentation remains and is up for further investigation.

The frameworks and knowledge generated from tackling these problems can be easily applied to other image problems, specifically for detecting segments.


## Research Statement

Neural pathway reconstruction from serial section electron microscopy (ssEM) data reveals synaptic associations among classes of neurons, which in turn advances our understanding of the infrastructure and communication within the nervous system. However, current approaches to neuron segmentations often require hundreds of man-hours of expert annotation. For computer vision to be most useful in practice, segmentation algorithms must generalize across brain tissues to allow completely automated mapping of neural circuits. Furthermore, it is paramount that an image segmentation network well-trained on a certain portion of data be transferable for inference on a different portion of data. Therefore, we aim to extend the current literature by developing an automated image segmentation method that is iteratively optimized and extensive to various neural circuits. Ultimately, we hope such approaches can be extended to various image identification problems.

## Data Description

Our data comes in two parts. First, we use the Circuit Reconstruction from Electron Microscopy Images (CREMI) dataset, which in itself is a collection of three datasets (1.5 GB each), each consisting of two 5x5x5 μm volumes (training and testing, each 1250×1250×125 px) of serial section electron microscopy of the adult fly brain. Each volume has neuron and synapse labelings and annotations for pre-and postsynaptic partners. We use these annotations as ground truth to train our networks (Google Flood Fill Network, U-NET, TopoNet, SpyNet, etc.) We would then apply our networks to the Octopus brain dataset of the Argonne National Laboratory (around 1TB per unit), each sampled at 6x6x30 nm resolution.

## Team
- **Benedict Au** - [Github](https://github.com/benedictau1993/)
- **Jenny Zhen** - [Github](https://github.com/JennyZhen95)
- **Amanda Zang** - [Github](https://github.com/AmandaZang)
