public class FolderDialog
{
	
	// Initialize structure.
	public FolderDialog()
	{
		Browser = new FolderBrowser.FolderBrowser();
	}
	
	
	// Last folder selected by user.
	// `null' if AskForFolder was not called.
	public string LastFolder;
	
	
	// Set starting folder.
	public void SetStartingFolder( string a_name )
	{
		if ( a_name != null && a_name.Length > 0 )
		{
			Browser.SetStartingFolder( ref a_name );
		}
	}
	
	// Display standard folder dialog and fill LastFolder.
	public void AskForFolder()
	{
		Browser.FolderName( out LastFolder );
	}

	// Associated graphical structure.
	private FolderBrowser.FolderBrowser Browser;
	
}