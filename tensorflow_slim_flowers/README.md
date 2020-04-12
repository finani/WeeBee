# Download the git repository (tensorflow/models) on the Host
1. git clone https://github.com/tensorflow/models/
- on the host becuase the docker don't have the git
- If you want to run this on the docker, do sudo apt-get install git-all

# Download the flower dataset and install used modules
2. mkdir ~/tf/data/flowers
3. pip install --upgrade pip
4. pip install contextlib2 pillow
5. gedit ~/docker/models/research/slim/download_and_convert_data.py
- on the host
```
tf.flags -> tf.compat.v1.flags
```
6. gedit ~/docker/models/research/slim/dataset/download_and_convert_flowers.py
- on the host
```
tf.gfile.GFile -> tf.io.gfile.GFile
tf.gfile.Remove -> tf.io.gfile.remove
tf.gfile.Exists -> tf.io.gfile.exists
tf.gfile.MakeDirs -> tf.io.gfile.makedirs
```
7. DATA_DIR=/tmp/flowers
8. python download_and_convert_data.py --dataset_name=flowers --dataset_dir="${DATA_DIR}"
