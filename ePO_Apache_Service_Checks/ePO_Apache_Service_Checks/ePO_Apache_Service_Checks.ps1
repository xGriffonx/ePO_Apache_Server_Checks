<#	ePO Apache Server Service Check
	Script Built: 4/23/18 - Tyler Wing
	Last Modified: 
	Currently configured for ePO 5.3.1
#>

$ePOserver = "Server1"
$agentHandler = "Server2"


#Check Apache service on ePO
if (Get-Process apache | Where-Object {$_.WorkingSet -gt 1700000}){
    $ePOwarning = "<br /> <font color=red> WARNING : The Apache service on $ePOserver has exceeded it's memory allocation and has been restarted </font>"
    Restart-Service -Name mcafeeapachesrv -Force
    Start-Sleep -Seconds 30
    if(Get-Service mcafeeapachesrv | Where-Object {$_.Status -ne "Running"}){
        Start-Service mcafeeapachesrv
    }
}

#Check Apache service on Agent Handler
if (Get-Process apache | Where-Object {$_.WorkingSet -gt 1700000}){
    $AHwarning = "<br /> <font color=red> WARNING : The Apache service on $agentHandler has exceeded it's memory allocation and has been restarted </font>"
    Restart-Service -Name mcafeeapachesrv -Force
    Start-Sleep -Seconds 30
    if(Get-Service mcafeeapachesrv | Where-Object {$_.Status -ne "Running"}){
        Start-Service mcafeeapachesrv
    }
}
