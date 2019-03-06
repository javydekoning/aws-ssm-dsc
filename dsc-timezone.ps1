Configuration DSCTimeZone 
{
  Import-DscResource -ModuleName 'ComputerManagementDsc' 
  TimeZone TimeZone
  {
    IsSingleInstance = 'Yes'
    TimeZone         = 'W. Europe Standard Time'
  }   
}
DSCTimeZone -OutputPath C:\Temp\DSCTimeZone
Start-DscConfiguration -Path C:\Temp\DSCTimeZone -ComputerName localhost -Wait -Verbose -Force