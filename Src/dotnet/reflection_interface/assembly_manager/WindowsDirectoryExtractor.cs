using System;

using System.Runtime.InteropServices;

public class WindowsDirectoryExtractor
{
	[DllImport("kernel32.dll")]

	public static extern int GetWindowsDirectoryW(
		[MarshalAs(UnmanagedType.LPTStr)] string res, int size);	
		
	public string WindowsDirectoryName()
		// Windows installation directory.
	{
		String str = new String(' ', 50);
		int nb = GetWindowsDirectoryW(str, 50);
		return str.Trim();
	}
} 