# Simple Cluster with DataSynapse installed

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Faz-cat%2FHPC-5clickTemplates%2Fmaster%2FDataSynapse%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png" />
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Faz-cat%2FHPC-5clickTemplates%2Fmaster%2FDataSynapse%2Fazuredeploy.json" target="_blank">
<img src="http://armviz.io/visualizebutton.png"/>
</a>
<br></br>
<b>Quickstart</b>
	
	1) Deploy ARM Template
		a. Click on the link above
		b. Create a resource group with a custom name in a region
		c. Select vm size for the grid manager and for the engines
		d. Specify the number of engines
		e. Supply the SAS key for the DataSynapse bits
		f. Logon to thee IP specified in the output http://outputip:8080
	2) Wait for deployment, about 5 minutes
	3) Logon to machine IP listed in the deployment output, http://outputip:8080
	4) Use username: admin, password: admin
	5) Select 'Services / Service Test' and run the LinPack becnhmark

<b>Architecture</b>

<img src="https://github.com/az-cat/HPC-5clickTemplates/blob/master/images/hpc_vmss_architecture.png"  align="middle" width="395" height="274"  alt="hpc_vmss_architecture" border="1"/> <br></br>
This template is designed to assist in the assessment of the TIBCO DataSynapse Scheduler in the Microsoft Azure environment. It automatically downloads and configures DataSynapse. In addition it authenticates all of the nodes on the cluster and creates a common share directory to be used for each of the nodes. A Virtual Machine Jumpbox is created and a Virtual Machine Scale Set (VMSS) of the same type of machine is created. The VMSS enables easy scaling and quick deployment of the cluster. The Jumpbox serves as the head node. A network card is attached to the Jumpbox and placed in a Virtual Network. The Jumpbox and VMSS reside in the same virtual network. A public IP is assigned to the network with port 8080 open. The Jumpbox can be accessed with the following command:

<code>http://publicip:8080</code>

Four Storage Accounts are created for the VMSS and one for the Jumpbox. An NFS file share is created from the head node's OS disk and shared with all of the VMSS nodes. This NFS share is located at /mnt/nfsshare/ No other file sharing or server is used. The Jumpbox and each of the nodes in the VMSS also have a data disk mounted at /mnt/resource/ that provides local storage space.


