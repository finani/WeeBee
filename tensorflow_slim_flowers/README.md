# Download the git repository (tensorflow/models) on the Host
> Based on tensorflow:1.14.0-gpu-py3-jupyter
1. git clone https://github.com/tensorflow/models/
- on the host becuase the docker don't have the git
- If you want to run this on the docker, do apt-get install git-all

# Download the flower dataset
2. mkdir /tf/data/flowers
3. pip install --upgrade pip
4. pip install contextlib2 pillow
5. DATA_DIR=/tf/data/flowers
6. python /tf/models/research/slim/download_and_convert_data.py --dataset_name=flowers --dataset_dir="${DATA_DIR}"

> gedit ~/docker/models/research/slim/download_and_convert_data.py
- on the host
```
tf.flags -> tf.compat.v1.flags
```
> gedit ~/docker/models/research/slim/datasets/download_and_convert_flowers.py
- on the host
```
tf.gfile.GFile -> tf.io.gfile.GFile
tf.gfile.Remove -> tf.io.gfile.remove
tf.gfile.DeleteRecursively -> tf.io.gfile.rmtree
tf.gfile.Exists -> tf.io.gfile.exists
tf.gfile.MakeDirs -> tf.io.gfile.makedirs
tf.placeholder -> tf.compat.v1.placeholder
tf.Session -> tf.compat.v1.Session
tf.python_io -> tf.compat.v1.python_io
```
> gedit ~/docker/models/research/slim/datasets/dataset_utils.py
```
tf.gfile.Open -> tf.io.gfile.GFile
tf.gfile.Exists -> tf.io.gfile.exists
```

# Download pre-trained model
7. mkdir /tf/data/my_checkpoints
8. CHECKPOINT_DIR=/tf/data/my_checkpoints
9. cd ${CHECKPOINT_DIR}
10. cd ~/docker/data/my_checkpoints && sudo wget http://download.tensorflow.org/models/inception_v3_2016_08_28.tar.gz
- on the host
- If you want to run this on the docker, do apt-get install wget && wget http://download.tensorflow.org/models/inception_v3_2016_08_28.tar.gz
11. tar -xvf inception_v3_2016_08_28.tar.gz
12. rm inception_v3_2016_08_28.tar.gz

# Install Bazel 0.18.0
1. wget https://github.com/bazelbuild/bazel/releases/download/0.18.0/bazel-0.18.0-installer-linux-x86_64.sh
- on the host
- If you want to run this on the docker, do apt-get install wget && wget https://github.com/bazelbuild/bazel/releases/download/0.18.0/bazel-0.18.0-installer-linux-x86_64.sh
- https://github.com/bazelbuild/bazel/releases/tag/0.18.0
2. chmod +x bazel-<version>-installer-linux-x86_64.sh
3. ./bazel-0.18.0-installer-linux-x86_64.sh --user
4. export PATH="$PATH:$HOME/bin"

# Fine-Tuning pre-trained model
1. DATASET_DIR=/tf/data/flowers
2. TRAIN_DIR=/tf/data/flowers-models/inception_v3
3. CHECKPOINT_PATH=/tf/data/my_checkpoints/inception_v3.ckpt
4. python /tf/models/research/slim/train_image_classifier.py \
    --train_dir=${TRAIN_DIR} \
    --dataset_dir=${DATASET_DIR} \
    --dataset_name=flowers \
    --dataset_split_name=train \
    --model_name=inception_v3 \
    --checkpoint_path=${CHECKPOINT_PATH} \
    --checkpoint_exclude_scopes=InceptionV3/Logits,InceptionV3/AuxLogits \
    --trainable_scopes=InceptionV3/Logits,InceptionV3/AuxLogits \
    --clone_on_cpu=True
5. tensorboard --logdir=/tf/data/flowers-models/inception_v3
- http://127.0.0.1:6006
    
> gedit ~/docker/models/research/slim/train_image_classifier.py
```
tf.gfile.Open -> tf.io.gfile.GFile
tf.gfile.Exists -> tf.io.gfile.exists
tf.app.run -> tf.compat.v1.app.run
tf.logging.set_verbosity -> tf.compat.v1.logging.set_verbosity
tf.logging.INFO -> tf.compat.v1.logging.INFO
slim.create_global_step -> tf.train.create_golabal_step
```
> gedit ~/docker/models/research/slim/datasets/flowers.py
```
tf.FixedLenFeature -> tf.io.FixedLenFeature
```
> gedit ~/docker/models/research/slim/datasets/dataset_utils.py
```
tf.gfile.Open -> tf.io.gfile.GFile
tf.gfile.Exists -> tf.io.gfile.exists
```
> ...

# Train the model from the first
1. DATASET_DIR=/tf/data/flowers
2. TRAIN_DIR=/tf/data/train_logs
3. python /tf/models/research/slim/train_image_classifier.py \
    --train_dir=${TRAIN_DIR} \
    --dataset_name=flowers \
    --dataset_split_name=train \
    --dataset_dir=${DATASET_DIR} \
    --model_name=inception_v3 \
    --clone_on_cpu=True
4. tensorboard --logdir=/tf/data/train_logs
- http://127.0.0.1:6006

# Evaluate the trained model
1. python /tf/models/research/slim/eval_image_classifier.py \
    --alsologtostderr \
    --checkpoint_path=${CHECKPOINT_FILE} \
    --dataset_dir=${DATASET_DIR} \
    --dataset_name=flowers \
    --dataset_split_name=validation \
    --model_name=inception_v3

# Freeze the graph
1. python /tf/models/research/slim/export_inference_graph.py \
  --alsologtostderr \
  --model_name=inception_v3 \
  --output_file=/tf/data/inception_v3_inf_graph.pb
2. python /usr/local/lib/python3.6/dist-packages/tensorflow/python/tools/freeze_graph.py \
  --input_graph=/tf/data/inception_v3_inf_graph.pb \
  --input_checkpoint=/tf/data/flowers-models/model.ckpt-20177 \
  --input_binary=true \
  --output_graph=/tf/data/flowers-models/frozen_inception_v3-flowers-20177.pb \
  --output_node_names=InceptionV3/Predictions/Reshape_1
  
  
