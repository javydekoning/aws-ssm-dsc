Configuration PSModules 
{
    Import-DscResource -name 'PackageManagement','PackageManagementSource' -ModuleName 'PackageManagement'
    PackageManagementSource SourceRepository
    {
        Ensure             = "Present"
        Name               = "MyNuget"
        ProviderName       = "Nuget"
        SourceUri          = "http://nuget.org/api/v2/"
        InstallationPolicy = "Trusted"
    }

    PackageManagementSource PSGallery
    {
        Ensure             = "Present"
        Name               = "psgallery"
        ProviderName       = "PowerShellGet"
        SourceUri          = "https://www.powershellgallery.com/api/v2/"
        InstallationPolicy = "Trusted"
    }

    $modules = @('ComputerManagementDsc','cChoco')
    $modules.ForEach({
      PackageManagement $_
      {
        Ensure    = 'present'
        Name      = "$_"
        Source    = "PSGallery"
        DependsOn = "[PackageManagementSource]PSGallery"
      }    
    })
    
}
PSModules -OutputPath C:\Temp\PSModules
Start-DscConfiguration -Path C:\Temp\PSModules -ComputerName localhost -Wait -Verbose -Force