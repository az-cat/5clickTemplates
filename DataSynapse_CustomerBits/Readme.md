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
