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
     --coordinate_output /project2/msca/nizhen/capstone/data/tf_record_file2 \
     --margin 5,5,5


# build_coordinates_parallel
export SAMPLE=cell_goodpeeps

python /project2/msca/nizhen/capstone/hanyu_ffn/build_coordinates_parallel.py \
     --partition_volumes $SAMPLE:/project2/msca/nizhen/capstone/data/af.h5:af \
     --coordinate_output /project2/msca/nizhen/capstone/data/tf_record_file2 \
     --margin 5,5,5


# sbatch job
#!/bin/bash
#SBATCH --job-name=train_sbatch
#SBATCH --output=train_sbatch.out
#SBATCH --error=train_sbatch.err
#SBATCH --time=4-00:00:00
#SBATCH --partition=mscagpu
#SBATCH -A mscagpu
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=14
#SBATCH --mem-per-cpu=7000

module load python
source activate hpn-env
bash train.sh




# training
export SAMPLE=cell_goodpeeps
export T_FOLDER=/project2/msca/nizhen/capstone/model_2/training_points_8_11_1_1/

tensorboard --logdir $T_FOLDER &

python /project2/msca/nizhen/capstone/hanyu_ffn_debug/train.py \
    --train_coords /project2/msca/nizhen/capstone/data/tf_record_file_2 \
    --data_volumes $SAMPLE:/project2/msca/nizhen/capstone/data/trainA.hdf:volumes/raw \
    --label_volumes $SAMPLE:/project2/msca/nizhen/capstone/data/trainA.hdf:volumes/labels/neuron_ids \
    --model_name convstack_3d.ConvStack3DFFNModel \
    --model_args "{\"depth\": 8, \"fov_size\": [11, 11, 11], \"deltas\": [1, 1, 1]}" \
    --image_mean 126 \
    --image_stddev 41 \
    --train_dir $T_FOLDER \
    --max_steps 100000



# Inference config
image {
  hdf5: "/project2/msca/nizhen/capstone/data/testA.hdf:volumes/raw"
}
image_mean: 126
image_stddev: 41
checkpoint_interval: 1800
seed_policy: "PolicyPeaks"
model_checkpoint_path: "/project2/msca/nizhen/capstone/model_step_100k/training_points_8_11_1_1/model.ckpt-100001"
model_name: "convstack_3d.ConvStack3DFFNModel"
model_args: "{\"depth\": 8, \"fov_size\": [11,11,11], \"deltas\": [1,1,1]}"
segmentation_output_dir: "/project2/msca/nizhen/capstone/results_100k/inference_testA"
inference_options {
  init_activation: 0.95
  pad_value: 0.05
  move_threshold: 0.7
  min_boundary_dist { x: 1 y: 1 z: 1}
  segment_threshold: 0.4
  min_segment_size: 10
}


# Inference
python /project2/msca/nizhen/capstone/hanyu_ffn/run_inference.py \
    --inference_request="$(cat /project2/msca/nizhen/capstone/config.pbtxt)" \
    --bounding_box 'start { x:0 y:0 z:0 } size { x:128 y:128 z:128 }'


# sbatch job
#!/bin/bash
#SBATCH --job-name=inference_sbatch
#SBATCH --output=inference_sbatch.out
#SBATCH --error=inference_sbatch.err
#SBATCH --time=4-00:00:00
#SBATCH --partition=gpu2
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=14
#SBATCH --mem-per-cpu=7000

module load python
source activate hpn-env
bash inference.sh