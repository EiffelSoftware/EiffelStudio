public class FolderDialog
{
	// Last folder selected by user.
	// `null' if AskForFolder was not called.
	public string LastFolder;
	
	// Display standard folder dialog and fill LastFolder.
	public void AskForFolder()
	{
		FolderBrowser.FolderBrowser browser = new FolderBrowser.FolderBrowser();
		browser.FolderName( out LastFolder );
	}
	
}