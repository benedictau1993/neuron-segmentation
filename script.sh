# compute_partition
python /project2/msca/nizhen/capstone/hanyu_ffn/compute_partitions.py \
    --input_volume /project2/msca/nizhen/capstone/data/trainA.hdf:volumes/raw \
    --output_volume /project2/msca/nizhen/capstone/data/af.h5:af \
    --thresholds 0.025,0.05,0.075,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9 \
    --lom_radius 24,24,24 \
    --min_size 10000


# build_coordinates
export SAMPLE=cell_goodpeeps

python /project2/msca/nizhen/capstone/hanyu_ffn/build_coordinates.py \
     --partition_volumes $SAMPLE:/project2/msca/nizhen/capstone/data/af.h5:af \
     --coordinate_output /project2/msca/nizhen/capstone/data/tf_record_file \
     --margin 5,5,5

