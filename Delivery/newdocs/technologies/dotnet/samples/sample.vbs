' Samples scripts, used to launch samples from documentation
' (C) 2003-2004 Eiffel Software, All Rights Reserved.

Option Explicit

Dim SamplesPath
Dim SampleDir
Dim SamplePrj

Sub LoadSample()
	Dim WshShell
	Dim Path
	Dim Quote
	Dim Is2003
	
	If Not IsEmpty (SampleDir) And Not IsEmpty (SamplePrj) Then
		Set WshShell = CreateObject ("WScript.Shell")
		Is2003 = CanLaunch2003()
		If Is2003 Then
			Path = WshShell.RegRead ("HKLM\SOFTWARE\Microsoft\VisualStudio\7.1\Setup\Eiffel\ProductDir")
		Else
			Path = WshShell.RegRead ("HKLM\SOFTWARE\Microsoft\VisualStudio\7.0\Setup\Eiffel\ProductDir")
		End If
		If Not IsEmpty (Path) Then
			If Is2003 Then
				SamplesPath = Path + "Compiler\Examples\v1.1.4322" + SampleDir + "\" + SamplePrj
				Path = WshShell.RegRead ("HKLM\SOFTWARE\Microsoft\VisualStudio\7.1\InstallDir")
			Else
				SamplesPath = Path + "Compiler\Examples\v1.0.3705" + SampleDir + "\" + SamplePrj
				Path = WshShell.RegRead ("HKLM\SOFTWARE\Microsoft\VisualStudio\7.0\InstallDir")
			End If
			If Not IsEmpty (Path) Then
				Quote = Chr(34)
				Path = Quote + Path + "Devenv.exe" + Quote + " " + Quote + SamplesPath + Quote
				WshShell.Run Path, 1, False 
			End If
		End If
	End If

End Sub

Function CanLaunch2003()
	Dim WshShell
	Dim Installed
		
	Set WshShell = CreateObject ("WScript.Shell")
	Installed = WshShell.RegRead ("HKLM\SOFTWARE\ISE\Eiffel ENViSioN! 2.0\Setup")
	CanLaunch2003 = (Installed = "2003")
End Function
