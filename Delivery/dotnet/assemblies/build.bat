call emitter.exe /init /nooutput
call emitter.exe /add /nooutput %WINDIR%\Microsoft.NET\Framework\v1.0.3705\System.Windows.Forms.dll
call emitter.exe /add /nooutput %WINDIR%\Microsoft.NET\Framework\v1.0.3705\System.Web.Services.dll

copy System.Object.xml mscorlib-1_0_3300_0--b77a5c561934e089\classes
copy mscorlib-1_0_3300_0--b77a5c561934e089\types.xml mscorlib-1_0_3300_0--b77a5c561934e089\original_types.xml
copy types.xml mscorlib-1_0_3300_0--b77a5c561934e089
