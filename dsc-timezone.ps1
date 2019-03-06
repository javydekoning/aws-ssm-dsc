Configuration TimeZone 
{
  Import-DscResource -ModuleName 'ComputerManagementDsc' 
  TimeZone TimeZone
  {
    IsSingleInstance = 'Yes'
    TimeZone         = 'W. Europe Standard Time'
  }   
}
TimeZone -OutputPath C:\Temp\TimeZone
Start-DscConfiguration -Path C:\Temp\TimeZone -ComputerName localhost -Wait -Verbose -Force