using System;
using System.Reflection;
using System.Reflection.Emit;
using System.IO;
#if CTW
	using ComComponent;
#endif

public class EiffelClassGenerator:Globals
{
	// Initialize instance
	public EiffelClassGenerator()
	{
		FileNameMappings = new System.Collections.Hashtable();
	}
	
#if CTW
	internal void SetComComponent (ComComponentClass component) 
	{
		comComponent = component;
	}
#endif

	// Generate Eiffel code in `Pathname' corresponding to assembly in `Filename'.
	// Filename: Name of file to be analyzed
	// Pathname: Path where Eiffel code should be generated
	virtual internal void Emit (String FileName, String PathName) 
	{
		Type [] types;
		string GeneratedFileName;
		Assembly assembly;
		Module [] modules;
		int  i, j, l;
		StreamWriter FileStream;
#if CTW
		int advanceCalls = 0;
#endif
		if (PathName != null) 
		{
			if (PathName.Length > 0) 
			{
				if (!PathName.EndsWith ("\\") ) 
					PathName += "\\";
			}
		}

		// Generate only classes part of the given assembly.
		assembly = Assembly.LoadFrom (FileName) ;
		modules = assembly.GetModules();
		
		for (i = 0; i < modules.Length; i++) 
		{
			types = modules [i].GetTypes();

			for (j = 0; j < types.Length; j++) 
			{				
				if (ClassIDTable [types [j]] != null) 
				{	
					EiffelClassFactory CurrentClass = (EiffelClassFactory) ClassTable [ (int) ClassIDTable [types [j]]];
					GeneratedFileName = PathName;
					string CurrentName = "";
					string[] PathElements = types [j].FullName.Split (new char[] {'.'});
					for (int k = 0; k < PathElements.Length - 1; k++)
					{
						CurrentName += PathElements [k];
						GeneratedFileName += NameFormatter.FormatToEiffel (PathElements [k]);
						l = 2;
						while (FileNameMappings.Contains (GeneratedFileName) &&
								((String) FileNameMappings [GeneratedFileName]) != CurrentName)
						{
							GeneratedFileName.TrimEnd (Digits);
							GeneratedFileName += l.ToString();
							l++;
						}
						if (!FileNameMappings.Contains (GeneratedFileName))
							FileNameMappings [GeneratedFileName] = CurrentName;
						GeneratedFileName += "\\";
					}
					if (GeneratedFileName != null && !System.IO.Directory.Exists (GeneratedFileName))
						System.IO.Directory.CreateDirectory (GeneratedFileName);
					GeneratedFileName += NameFormatter.FormatToEiffel (CurrentClass.Name);
					CurrentName += PathElements [PathElements.Length - 1];
					l = 2;
					while (FileNameMappings.Contains (GeneratedFileName) &&
							((String) FileNameMappings [GeneratedFileName]) != CurrentName)
					{
						GeneratedFileName.TrimEnd (Digits);
						GeneratedFileName += l.ToString();
						l++;
					}
					if (!FileNameMappings.Contains (GeneratedFileName))
						FileNameMappings [GeneratedFileName] = CurrentName;
					GeneratedFileName += EiffelFileExtension;
					FileStream = new StreamWriter (GeneratedFileName, false, System.Text.Encoding.ASCII);
					if (FileStream == null) 
						throw new ApplicationException ("Could not create file '" + GeneratedFileName + "'\n") ;
					FileStream.Write (CurrentClass.Code());
					FileStream.Close();
				}
			}

#if CTW
			if (modules.Length >= 30) 
			{
				if ((((Double) i) / (modules.Length / 30) )== (i / (modules.Length / 30) ))
				{
					if (advanceCalls <= 30) 
					{
						comComponent.Advance (1) ;
						advanceCalls++;
					}
				}
				if ((i == modules.Length - 1) && (advanceCalls < 30) )
					comComponent.Advance (30 - advanceCalls) ;		
			}
			else
			{
				if (modules.Length == 1)
				{
					comComponent.Advance (15) ;
					comComponent.Advance (15) ;
				}
				else
					comComponent.Advance (30 / (modules.Length) );
				if (i == modules.Length - 1) 
					comComponent.Advance (15) ;
			}				
#endif


		}
	}

#if CTW
	private ComComponentClass comComponent;
#endif

	protected System.Collections.Hashtable FileNameMappings;
}
