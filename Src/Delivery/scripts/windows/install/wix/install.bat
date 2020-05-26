mklink /J "C:\Program Files (x86)\Windows Installer XML v3" %~dp0install\wix\v3.0
mklink /J "C:\Program Files (x86)\MSBuild\Microsoft\WiX" %~dp0install\wix
cd v3.0
mklink /J bin %~dp0
