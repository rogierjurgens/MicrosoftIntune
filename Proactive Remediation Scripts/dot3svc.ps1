$ServiceName = 'dot3svc'

# Try to fetch the service
try {
    $serviceObject = Get-Service -Name $ServiceName
}
catch {
    Write-Error "Couldn't get service $ServiceName"
    exit 0
}

# Check for services if it is running if not exit with 1 for remediation script to start
if ($serviceObject.Status -ne "Running"){
    Write-Host "$($serviceObject.DisplayName) ($($serviceObject.Name)) is not running!"
    Exit 1
}

elseif ($serviceObject.Status -eq "Running") {
    Write-Host "$($serviceObject.DisplayName) ($($serviceObject.Name)) is running"
    Exit 0
}