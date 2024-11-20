param (
	[Parameter()]
	[ValidateNotNullOrEmpty()]
	[string]
	$OutputPath = '.\bin\v2rayN'
)

Write-Host 'Building'

dotnet publish `
	.\v2rayN\v2rayN.csproj `
	-c Release `
	-r win-x86 `
	--self-contained false `
	-p:PublishReadyToRun=false `
	-p:PublishSingleFile=true `
	-o "$OutputPath\win-x86"

dotnet publish `
	.\v2rayN.Desktop\v2rayN.Desktop.csproj `
	-c Release `
	-r linux-x86 `
	--self-contained true `
	-p:PublishReadyToRun=false `
	-p:PublishSingleFile=true `
	-o "$OutputPath\linux-x86"


if ( -Not $? ) {
	exit $lastExitCode
	}

if ( Test-Path -Path .\bin\v2rayN ) {
    rm -Force "$OutputPath\win-x86\*.pdb"
    rm -Force "$OutputPath\linux-x86\*.pdb"
}

Write-Host 'Build done'

ls $OutputPath
7z a  v2rayN.zip $OutputPath
exit 0
