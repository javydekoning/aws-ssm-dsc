Configuration bastion 
{
  Import-DscResource -name 'WindowsFeature' -ModuleName 'PSDesiredStateConfiguration'
  Import-DscResource -ModuleName 'cChoco'

  WindowsFeature MyFeatureInstance {
    Ensure = 'Present'
    Name   = 'RSAT'
  }

  cChocoInstaller installChoco
  {
    InstallDir = 'c:\choco'
  }

  $ChocoPackages = @('firefox','filezilla','sublimetext3','putty')
  $ChocoPackages.ForEach({
    cChocoPackageInstaller $_
    {
       Name        = "$_"
       AutoUpgrade = $True
       DependsOn   = "[cChocoInstaller]installChoco"
    }
  })
}

bastion -OutputPath C:\Temp\bastion
Start-DscConfiguration -Path C:\Temp\bastion -ComputerName localhost -Wait -Verbose -Force