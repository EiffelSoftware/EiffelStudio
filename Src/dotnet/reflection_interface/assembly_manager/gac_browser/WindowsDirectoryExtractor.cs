using System;

using System.Runtime.InteropServices;

namespace ISE.AssemblyManager
{
	public class WindowsDirectoryExtractor
	{
		[DllImport( "kernel32.dll" )]

		public static extern int GetWindowsDirectoryW(
			[MarshalAs(UnmanagedType.LPTStr)] string res, int size );	

		// Windows installation directory.
		public string WindowsDirectoryName()
		{
			String str = new String( ' ', 50 );
			int nb = GetWindowsDirectoryW( str, 50 );
			return str.Trim();
		}
	} 
}