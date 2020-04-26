import h5py
import os
import numpy as np

def sample_cremi(file, z, x, y):
    """Samples n x n x n cube from cremi data.
    
    Appends sampled cube to h5file.f5/volumes/sample/
    
    Args:
    file: str, cremi file
    z: int, in [1:125]
    x: int, in [1:1250]
    y: int, in [1:1250]
    
    Example call:
    sample_cremi("./data_cremi/sample_C_20160501.hdf", 100, 100, 100)
    """

    with h5py.File(file, 'a') as h5file:
        print(f"Found file: {file}")
        image = h5file["/volumes/raw"]
        print("Found raw image volume")
        seg = h5file["/volumes/labels/neuron_ids"]
        print("Found neuron_ids labels volume")
        image_sample = image[:z, :x, :y]
        seg_sample = seg[:z, :x, :y]
        print(f"Created samples: {z}x{x}x{y}")
        print(f"Creating datasets in {file}")
        h5file.create_dataset("volumes/sample/raw",  data=image_sample)
        print("volumes/sample/raw")
        h5file.create_dataset("volumes/sample/neuron_ids",  data=seg_sample)
        print("volumes/sample/neuron_ids")
