Configuration WebServer
{    
  # Import the module that defines custom resources
  Import-DscResource -Module PSDesiredStateConfiguration

  # Install the IIS role
  WindowsFeature IIS
  {
    Ensure          = 'Present'
    Name            = 'Web-Server'
  }

  # Ensure w3svc is running
  Service w3svc
  {
    Name        = 'w3svc'
    State       = 'Running'
    StartupType = 'Automatic'
    DependsOn   = '[WindowsFeature]IIS'
  }
}
WebServer -OutputPath C:\Temp\WebServer

Start-DscConfiguration -Path C:\Temp\WebServer -ComputerName localhost -Wait -Verbose -Force