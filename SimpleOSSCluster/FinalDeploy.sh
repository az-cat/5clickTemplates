#!/bin/bash
mkdir -p /home/azureuser/bin/
cd /home/azureuser/bin

#download utilites and the HeadComputeNodeDeploy script
wget https://raw.githubusercontent.com/az-cat/sandbox/Ubuntu/DeployMultiVM/HeadComputeNodeDeploy.sh
wget https://raw.githubusercontent.com/az-cat/utils/master/authMe.sh
wget https://raw.githubusercontent.com/az-cat/utils/master/myClusRun.sh
chmod +x *

#Run HeadComputeNodeDeploy script
runuser -l root -c '/home/azureuser/bin/HeadComputeNodeDeploy.sh'
