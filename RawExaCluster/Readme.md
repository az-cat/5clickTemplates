# Simple VMSS Cluster with Exa Powerflow installed

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Faz-cat%2FHPC-5clickTemplates%2Fmaster%2FRawExaCluster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png" />
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Faz-cat%2FHPC-5clickTemplates%2Fmaster%2FRawExaCluster%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>
<br></br>
<b>Quickstart</b>

	1) Deploy ARM Template
		a. Click on the link above
		b. Select HPC available region
		c. Select vm size (H16m/H16mr or A8/A9) and quantity (make sure to have quota for it)
		d. Name, less than 10 characters
		e. License server IP, use default if in MSFT
		f. Benchmark model
	2) Wait for deployment (may be long if a larger model)
	3) Logon to machine IP listed in portal
	4) Navigate to /mnt/scratch/benchmark
	5) Run StarCCM+, 'np 80' is the number of cores you want to run on
		a. time(starccm+ -np 80 -machinefile ../hosts -power -podkey ENTER_YOUR_PODKEY_HERE -rsh ssh
		-mpi intel -cpubind bandwidth,v -mppflags " -ppn 8 -genv I_MPI_DAPL_PROVIDER=ofa-v2-ib0
		-genv I_MPI_DAPL_UD=0 -genv I_MPI_DYNAMIC_CONNECTION=0" -batch /mnt/scratch/benchmark/runAndRecord.java 
		/mnt/scratch/benchmark/NAME_OF_THE_SIM_FILE.sim)


<b>Architecture</b>

<img src="https://github.com/az-cat/HPC-5clickTemplates/blob/master/images/hpc_vmss_architecture.png"  align="middle" width="395" height="274"  alt="hpc_vmss_architecture" border="1"/> <br></br>
This template is designed to assist in the assessment of the CD-Adapco StarCCM+ CFD Software in the Microsoft Azure environment. It automatically downloads and configures StarCCM+. In addition it authenticates all of the nodes on the cluster and creates a common share directory to be used for each of the nodes. A Virtual Machine Jumpbox is created and a Virtual Machine Scale Set (VMSS) of the same type of machine is created. The VMSS enables easy scaling and quick deployment of the cluster. The Jumpbox serves as the head node. A network card is attached to the Jumpbox and placed in a Virtual Network. The Jumpbox and VMSS reside in the same virtual network. A public IP is assigned to the network with port 22 open. The Jumpbox can be accessed with the following command:

<code>ssh {username}@{vm-private-ip-address}</code>

Four Storage Accounts are created for the VMSS and one for the Jumpbox. One NFS file share is created from the head node's OS disk and shared with all of the VMSS nodes, /mnt/nfsshare, another share is created on the temp disk of the head node, /mnt/scratch. The temp disk is a physically attached disk and will typically provide faster performance on each of the nodes.


<b>Software Configuration</b>

A number of packages are installed during deployment in order to support the NFS share and the tools that are used to create the authentication. During the authentication phase of the deployment, files named <u>nodenames.txt</u> and <u>nodeips.txt</u> are placed in ~/bin. These are files that contain the names and ip addresses of all of the nodes in the VMSS a copy of the <u>nodenames.txt</u> is placed in <u>/mnt/resource/hosts</u>. Each of these nodes should be accesible with the following command:

<code>ssh {username}@{vm-private-ip-address}</code>

In addition StarCCM+ version 11.02.010-R8 is installed into the <u>/mnt/scratch/applications/</u> directory and the path to the StarCCM+ binary is added to ~.bashrc. The benchmark model that was selected at deploy time is downloaded and unpacked. It is placed in /mnt/scratch/benchmark on the Jumpbox. A file named runAndRecord.java contains the scripting commands for StarCCM+. With these two files a benchmark can be run by issuing the following command.

<code>time((starccm+ -np 80 -machinefile ../hosts -power -podkey YOUR_POD_KEY_HERE -rsh ssh -mpi intel -cpubind bandwidth,v -mppflags " -ppn 8 -genv I_MPI_DAPL_PROVIDER=ofa-v2-ib0 -genv I_MPI_DAPL_UD=0 -genv I_MPI_DYNAMIC_CONNECTION=0" -batch /mnt/scratch/benchmark/runAndRecord.java NAME_OF_YOUR_SIM_FILE_HERE.sim)</code>

<b>Licensing</b>

When the parameters are entered for deployment the user has the ability to insert their POD Key which is the license line supplied by CD-Adapco. Internal Microsoft employees can contact <a>az-cat@microsoft.com</a> for a POD Key that can be used for benchmarking, performance testing, and other non-sales related activities. If you are using this as part of a sales process you will need to simply place the customer POD Key in as a parameter at deploy time. Additionally the CDLMD_LICENSE_FILE enviornment variable is set to 1999@flex.cd-adapco.com.

<b>Known Issues</b>

H-Series VMs are only available in the South Central region, A8 and A9 VMs are only available in East US, North Central US, South Central US, West US, North Europe, West Europe, and Japan East.
