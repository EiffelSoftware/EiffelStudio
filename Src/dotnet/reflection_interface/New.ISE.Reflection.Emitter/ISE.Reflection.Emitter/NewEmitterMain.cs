/*
 * Emitter generates pseudo Eiffel code from metadata.
 *
 */
#undef DEBUG
#define BASIC
#define DEBUG_CONSOLE

using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Diagnostics;

[assembly: AssemblyTitle( "Emitter" )]
[assembly: AssemblyDescription( "Generate Eiffel classes from a .Net assembly." )]
[assembly: AssemblyConfiguration( "" )]
[assembly: AssemblyCompany( "Interactive Software Engineering Inc." )]
[assembly: AssemblyProduct( "ISE EiffelEmitter" )]
[assembly: AssemblyCopyright( "ISE" )]
[assembly: AssemblyTrademark( "ISE" )]
[assembly: AssemblyCulture( "" )]

[assembly: AssemblyVersion( "1.0.0" )]

[assembly: AssemblyDelaySign( false )]
[assembly: AssemblyKeyFile( "Emitter.key" )]
[assembly: AssemblyKeyName( "" )]

public class EmitterMain : ArgParser 
{
	
    	// Give the set of valid command-line switches to the base class
    	public EmitterMain(): base( new string[] { "?", "dest", "d", "target", "t", "f", "format", "g", "generation", "p", "prefix" } )
    	{ 
   			NameFormatter.EiffelFormatting = true;
   			NameFormatter.XmlGeneration = true;
    	}

	// Show application's usage info and report command-line argument errors.
    	internal override void OnUsage( String errorInfo )
    	{
        	if( errorInfo != null )
        	{
        	    	// A command-line argument error occurred, report it to user
            		// errInfo identifies the argument that is in error.
            		Console.WriteLine( "Command-line switch error: {0}\n", errorInfo );
        	}
	    	Console.WriteLine( "Usage: emitter [/d[est]] <destination path> [/t[arget]] <assembly path> [/f[ormat]] <format> [/g[eneration]] <generation> [/p[refix]] <prefix>" );
	    	Console.WriteLine( "   /?  Show this usage information" );
	    	Console.WriteLine( "   destination path: Path where generated files will be saved." );
	    	Console.WriteLine( "   assembly path: Path to assembly( .dll or .exe )." );
	    	Console.WriteLine( "   format: If equal to 'default', will format variable names with .NET convention." );
	    	Console.WriteLine( "   generation: If equal to `default', will generate Eiffel classes only without importing the assembly to the Eiffel Assembly Cache." );
	    	Console.WriteLine( "   prefix: The prefix to prepend the generated files with." );
			Process.GetCurrentProcess().Kill();
    	}

    	// Called for each non-switch command-line argument( filespecs )
    	protected override SwitchStatus OnNonSwitch( String switchValue )
    	{
		SwitchStatus ss = SwitchStatus.NoError;
		return( ss );
	    }

    	// Called for each switch command-line argument
    	protected override SwitchStatus OnSwitch( String switchSymbol, String switchValue )
    	{
		SwitchStatus ss = SwitchStatus.NoError;
		switch( switchSymbol )
		{ 
			case "?":   // User wants to see Usage
		    		ss = SwitchStatus.ShowUsage; 
		    	break;

			case "dest":   // User specifies destination path
				if( switchValue.Length > 1 )
		    			DestinationPath = switchValue;
		   	break;
			
			case "d":   // User specifies destination path
				if( switchValue.Length > 1 )
				{
					if( System.IO.Directory.Exists( System.IO.Directory.GetCurrentDirectory() + "\\" + DestinationPath ))
		    			DestinationPath = switchValue;
		    		else
		    		{
		    			Console.WriteLine( "Destination directory does not exist." );
		    			ss = SwitchStatus.Error;
		    		}
		    	}	
		   	break;
		   	
			case "target":   // User specifies assembly path
		    		if( switchValue.Length > 1 )
		    			AssemblyPath = switchValue;
		    		else
		    		{
		    			Console.WriteLine( "No assembly specified." );
		    			ss = SwitchStatus.Error;
					}
		    	break;

			case "t":   // User specifies assembly path
		    		if( switchValue.Length > 1 )
		    			AssemblyPath = switchValue;
		    		else
		    		{
		    			Console.WriteLine( "No assembly specified." );
		    			ss = SwitchStatus.Error;
				}
		    	break;

			case "p":
			case "prefix":
					if (switchValue.Length > 1) {
						Prefix = switchValue;
					} else {
						Console.WriteLine ("No prefix specified. Using no prefix.");
					}
				break;
		    	
		   	case "f": // Eiffel name formatting
		    		if( switchValue.ToLower()== DefaultFormattingSwitch )
		    			NameFormatter.EiffelFormatting = false;
		    	break;
		    	
		    	case "format": // Eiffel name formatting
		    		if( switchValue.ToLower()== DefaultFormattingSwitch )
		    			NameFormatter.EiffelFormatting = false;
		    	break;
		    	
		    	case "g": // XML generation
		    		if( switchValue.ToLower() == DefaultXmlSwitch )
		    			NameFormatter.XmlGeneration = false;
		    	break;
		    	
		    	case "generation": // XML generation
		    		if( switchValue.ToLower() == DefaultXmlSwitch )
		    			NameFormatter.XmlGeneration = false;
		    	break;
		    	
			default:
		    		Console.WriteLine( "Invalid switch: \"" + switchSymbol + "\".\n" );
		    		ss = SwitchStatus.Error; 
		    	break;
		}
		return( ss );
	    }

    	// Called when all command-line arguments have been parsed
    	protected override SwitchStatus OnDoneParse()
    	{
			SwitchStatus ss;
			if( AssemblyPath == null )
			{
		    	Console.WriteLine( "No assembly specified." );
		    	ss = SwitchStatus.Error;
			}
			else
        		ss = SwitchStatus.NoError;
        	return( ss );
    	}
    
	// Path to folder where code will be stored
 	internal String DestinationPath;
 	
 	// Assembly path( *.dll, *.exe )
 	internal String AssemblyPath;

	// Prefix to all generated classes
	internal String Prefix;
 	
	static public void Main()
	{
		EmitterMain EmitterArgsParser;

		#if DEBUG
			Console.WriteLine( "Starting..." );
		#endif

		EmitterArgsParser = new EmitterMain();
		try
		{
			if( !EmitterArgsParser.Parse())
				EmitterArgsParser.OnUsage( null );
		}
		catch
		{
			EmitterArgsParser.OnUsage( null );
		}
		
		Emitter emitter = new Emitter();
		emitter.Emit( EmitterArgsParser.AssemblyPath, EmitterArgsParser.DestinationPath, EmitterArgsParser.Prefix );

		#if DEBUG
			Console.WriteLine( "Terminating..." );
		#endif
	}
	
	// Switch value for `f' switch
	public string DefaultFormattingSwitch = "default";

	// Switch value for `g' switch
	public string DefaultXmlSwitch = "default";
}
