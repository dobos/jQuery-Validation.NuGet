echo Downloading packages...

$package = "jquery-validation"
$version = "1.15.1"

if (-not (Test-Path nuget.exe)) {
	wget -OutFile nuget.exe https://dist.nuget.org/win-x86-commandline/v3.3.0/nuget.exe
}

if (-not (Test-Path "$package.zip")) {
	wget -OutFile "$package.zip" "https://github.com/jzaefferer/$package/releases/download/$version/$package-$version.zip"
}

& 'C:\Program Files\7-Zip\7z.exe' x -y -o"$package" "$package.zip"

echo Building NuGet package...

mkdir pkg\lib
mkdir pkg\tools
mkdir pkg\content
mkdir pkg\content\Scripts
mkdir pkg\content\Scripts\jQuery-Validation

cp -Force "$package\dist\*" pkg\content\Scripts\jQuery-Validation\

.\nuget.exe pack pkg\jQuery-Validation.NuGet.nuspec

