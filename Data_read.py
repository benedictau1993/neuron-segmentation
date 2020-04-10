from cremi import Annotations, Volume
from cremi.io.CremiFile import CremiFile
import numpy as np
import random

file = CremiFile("sample_A_padded_20160501.hdf", "r")

print("Has raw: " + str(file.has_raw()))
print("Has neuron ids: " + str(file.has_neuron_ids()))
print("Has clefts: " + str(file.has_clefts()))
print("Has annotations: " + str(file.has_annotations()))

raw = file.read_raw()
neuron_ids = file.read_neuron_ids()
clefts = file.read_clefts()
annotations = file.read_annotations()


print("Read raw: " + str(raw) + \
      ", resolution " + str(raw.resolution) + \
      ", offset " + str(raw.offset) + \
      ("" if raw.comment == None else ", comment \"" + raw.comment + "\""))

print("Read neuron_ids: " + str(neuron_ids) + \
      ", resolution " + str(neuron_ids.resolution) + \
      ", offset " + str(neuron_ids.offset) + \
      ("" if neuron_ids.comment == None else ", comment \"" + neuron_ids.comment + "\""))

print("Read clefts: " + str(clefts) + \
      ", resolution " + str(clefts.resolution) + \
      ", offset " + str(clefts.offset) + \
      ("" if clefts.comment == None else ", comment \"" + clefts.comment + "\""))

print("Read annotations:")
for (id, type, location) in zip(annotations.ids(), annotations.types(), annotations.locations()):
    print(str(id) + " of type " + str(type) + " at " + str(np.array(location)+np.array(annotations.offset)))
print("Pre- and post-synaptic partners:")
for (pre, post) in annotations.pre_post_partners:
    print(str(pre) + " -> " + str(post))


# Read data
# raw dataset
raw.data[()]
raw.data.value # deprecated
raw.data.shape  # (200, 3072, 3072)


# neuron_ids data
# neuron_ids.data[()]
neuron_ids.data.shape  # (125, 1250, 1250)



# # shape
#
# raw.data.dims
# raw.data.id
# raw.data.shape
# raw.data.attrs

