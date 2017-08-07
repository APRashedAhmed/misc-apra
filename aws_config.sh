# Config file to perform a full setup on the AWS VM

# Make sure yum is updated
yes Y | sudo yum update

# Development tools
yes Y | sudo yum groupinstall 'Development Tools'
# Just to be sure they were installed
yes Y | sudo yum install gcc gcc-gfortran
# One extra lib that needs to be installed
yes Y | sudo yum install libGL

# Git
yes Y | sudo yum install git

# Go to main directory, mkdir downloads and cd there
cd; mkdir -p downloads; cd downloads

# Anaconda
wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
# Change permissions and run
chmod +x Anaconda3-4.4.0-Linux-x86_64.sh
./Anaconda3-4.4.0-Linux-x86_64.sh

# Souce the bashrc file
cd; source .bashrc
# Activate and install conda-build
source activate;
yes Y | conda install conda-build

# Clone the repos
mkdir -p bnet; cd bnet
git clone https://github.com/apra93/BrainNet.git
git clone https://github.com/apra93/PyUtils.git

# Make the bnet env
cd BrainNet
conda env create -f bnet.yml
# Activate bnet
source activate bnet
yes Y | conda install tqdm

# Add pytutils
cd ../PyUtils
python setup.py develop

# Activate bnet again because I'm paranoid
source activate bnet
# Time to run the script
cd ../BrainNet
python random_sampling.py -h
