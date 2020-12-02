mklink /J "C:\Program Files (x86)\Windows Installer XML v3" %~dp0v3.0
mklink /J "C:\Program Files (x86)\MSBuild\Microsoft\WiX" %~dp0
cd v3.0
mklink /J bin %~dp0
