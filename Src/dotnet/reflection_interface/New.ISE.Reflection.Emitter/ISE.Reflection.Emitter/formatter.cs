 /*
 * Include all the information needed to produce the Eiffel code
 *
 */
using System;
using System.Reflection;
using System.Reflection.Emit;
using System.IO;

public class Formatter 
{
	public Formatter()
	{
 		VariableMappings = new System.Collections.Hashtable(70);
			// List of features in ANY Eiffel class that are required and might conflict
			// with existing .NET names.
		VariableMappings.Add( "copy", "copy_" );
		VariableMappings.Add( "clone", "clone_" );
		VariableMappings.Add( "is_equal", "is_equal_" );
		VariableMappings.Add( "isequal", "is_equal_" );
		VariableMappings.Add( "equal", "equal_" );
		VariableMappings.Add( "default", "default_" );
		VariableMappings.Add( "default_create", "default_create_" );
		VariableMappings.Add( "defaultcreate", "default_create_" );
		VariableMappings.Add( "out", "out_" );

			// List of Eiffel keyword that might conflict with existing .NET names
		VariableMappings.Add( "current", "current_" );
		VariableMappings.Add( "class", "class_" );
		VariableMappings.Add( "end", "end_" );
		VariableMappings.Add( "indexing", "indexing_" );
		VariableMappings.Add( "deferred", "deferred_" );
		VariableMappings.Add( "expanded", "expanded_" );
		VariableMappings.Add( "obsolete", "obsolete_" );
		VariableMappings.Add( "feature", "feature_" );
		VariableMappings.Add( "is", "is_" );
		VariableMappings.Add( "frozen", "frozen_" );
		VariableMappings.Add( "prefix", "prefix_" );
		VariableMappings.Add( "infix", "infix_" );
		VariableMappings.Add( "not", "not_" );
		VariableMappings.Add( "and", "and_" );
		VariableMappings.Add( "or", "or_" );
		VariableMappings.Add( "xor", "xor_" );
		VariableMappings.Add( "else", "else_" );
		VariableMappings.Add( "implies", "implies_" );
		VariableMappings.Add( "do", "do_" );
		VariableMappings.Add( "once", "once_" );
		VariableMappings.Add( "local", "local_" );
		VariableMappings.Add( "old", "old_" );
		VariableMappings.Add( "like", "like_" );
		VariableMappings.Add( "if", "if_" );
		VariableMappings.Add( "elseif", "elseif_" );
		VariableMappings.Add( "create", "create_" );
		VariableMappings.Add( "then", "then_" );
		VariableMappings.Add( "inspect", "inspect_" );
		VariableMappings.Add( "when", "when_" );
		VariableMappings.Add( "from", "from_" );
		VariableMappings.Add( "loop", "loop_" );
		VariableMappings.Add( "precursor", "precursor_" );
		VariableMappings.Add( "until", "until_" );
		VariableMappings.Add( "debug", "debug_" );
		VariableMappings.Add( "rescue", "rescue_" );
		VariableMappings.Add( "retry", "retry_" );
		VariableMappings.Add( "unique", "unique_" );
		VariableMappings.Add( "creation", "creation_" );
		VariableMappings.Add( "inherit", "inherit_" );
		VariableMappings.Add( "rename", "rename_" );
		VariableMappings.Add( "as", "as_" );
		VariableMappings.Add( "export", "export_" );
		VariableMappings.Add( "all", "all_" );
		VariableMappings.Add( "redefine", "redefine_" );
		VariableMappings.Add( "undefine", "undefine_" );
		VariableMappings.Add( "select", "select_" );
		VariableMappings.Add( "strip", "strip_" );
		VariableMappings.Add( "external", "external_" );
		VariableMappings.Add( "alias", "alias_" );
		VariableMappings.Add( "require", "require_" );
		VariableMappings.Add( "ensure", "ensure_" );
		VariableMappings.Add( "invariant", "invariant_" );
		VariableMappings.Add( "check", "check_" );
		VariableMappings.Add( "variant", "variant_" );
		VariableMappings.Add( "true", "true_" );
		VariableMappings.Add( "false", "false_" );
		VariableMappings.Add( "result", "result_" );
		VariableMappings.Add( "bit", "bit_" );

		// Basic types mappings
		TypeMappings = new System.Collections.Hashtable();
		TypeMappings.Add( "Int32", "INTEGER" );
		TypeMappings.Add( "UInt32", "INTEGER" );
		TypeMappings.Add( "Int64", "INTEGER_64" );
		TypeMappings.Add( "UInt64", "INTEGER_64" );
		TypeMappings.Add( "Int16", "INTEGER_16" );
		TypeMappings.Add( "UInt16", "INTEGER_16" );
		TypeMappings.Add( "Byte", "INTEGER_8" );
		TypeMappings.Add( "SByte", "INTEGER_8" );
		TypeMappings.Add( "Char", "CHARACTER" );
		TypeMappings.Add( "Double", "DOUBLE" );
		TypeMappings.Add( "Single", "REAL" );
		TypeMappings.Add( "Boolean", "BOOLEAN" );
		TypeMappings.Add( "UIntPtr", "POINTER" );
		TypeMappings.Add( "IntPtr", "POINTER" );
		TypeMappings.Add( "ValueType", "VALUE_TYPE" );
		TypeMappings.Add( "Enum", "ENUM" );
		TypeMappings.Add( "Object", "SYSTEM_OBJECT" );
		TypeMappings.Add( "String", "SYSTEM_STRING" );
		TypeMappings.Add ( "Array", "SYSTEM_ARRAY" );
		TypeMappings.Add ( "Queue", "SYSTEM_QUEUE" );
		TypeMappings.Add ( "Console", "SYSTEM_CONSOLE" );
		TypeMappings.Add ( "Stream", "SYSTEM_STREAM" );
		TypeMappings.Add ( "Stack", "SYSTEM_STACK" );
		TypeMappings.Add ( "Directory", "SYSTEM_DIRECTORY" );
		TypeMappings.Add ( "File", "SYSTEM_FILE" );
		TypeMappings.Add ( "DateTime", "SYSTEM_DATE_TIME");
		TypeMappings.Add ( "SortedList", "SYSTEM_SORTED_LIST");

		// Assembly mappings
		AssemblyMappings = new System.Collections.Hashtable ();
		AssemblyMappings.Add ("Accessibility", "ACCESS");
		AssemblyMappings.Add ("mscorlib", "");
		AssemblyMappings.Add ("cscompmgd", "CS");
		AssemblyMappings.Add ("System", "SYSTEM_DLL");
		AssemblyMappings.Add ("System.Data", "DATA");
		AssemblyMappings.Add ("System.DirectoryServices", "DIR_SERV");
		AssemblyMappings.Add ("System.Drawing", "DRAWING");
		AssemblyMappings.Add ("System.EnterpriseServices", "ENT_SERV");
		AssemblyMappings.Add ("System.Runtime.Remoting", "RT_REMOTING");
		AssemblyMappings.Add ("System.Runtime.Serialization.Formatters.Soap", "SOAP");
		AssemblyMappings.Add ("System.Web", "WEB");
		AssemblyMappings.Add ("System.Web.RegularExpressions", "REGEXP");
		AssemblyMappings.Add ("System.Windows.Forms", "WINFORMS");
		AssemblyMappings.Add ("System.XML", "XML");
		
		
		
		// Illegal Eiffel character mappings
		IlegalChars = new System.Collections.Hashtable();
		
		// Exclude the following characters in checking for illegal characters
		System.Collections.ArrayList Excludes = new System.Collections.ArrayList();
		Excludes.Add(new ExcludeCharacters (0x23, 0x23));
		Excludes.Add(new ExcludeCharacters (0x30, 0x39));
		Excludes.Add(new ExcludeCharacters (0x41, 0x5A));
		Excludes.Add(new ExcludeCharacters (0x5F, 0x5F));
		Excludes.Add(new ExcludeCharacters (0x61, 0x7A));
		
		bool Excluded;
		char Ch;
		for (int i = 0; i <= 182; i++){
			Excluded = false;
			for (int j = 0; j < Excludes.Count; j++){
				Excluded = ((ExcludeCharacters)Excludes[j]).IsIn(i);
				if (Excluded) break;
			}
			if (!Excluded){
				Ch = (char) i;
				IlegalChars.Add(Ch, "ec_illegal_" + i.ToString() + "_");
			}
		}
	}
	
	// Exclude the legal characters
	private struct ExcludeCharacters
	{
		public ExcludeCharacters (int s, int f)
		{
			start = s;
			finish = f;
		}
		
		public bool IsIn(int index){
			if ((index >= start) && (index <= finish)) 
				return true;
			else
				return false;
		}
		
		private int start;
		private int finish;
	}

	
	// Format Eiffel way if true (i.e. AnAtom gives an_atom)
	public bool EiffelFormatting
	{
		get { return InternalEiffelFormatting;}
		set { InternalEiffelFormatting = value;}
	}

	// Generate XML files if true 
	public bool XmlGeneration
	{
		get { return InternalXmlGeneration;}
		set { InternalXmlGeneration = value;}
	}
	
	// Format a strong name to adhere to Eiffel external syntax
	// String name: name to be formatted
	public String FormatStrongName( String name )
	{
		return name.Replace( ",", "%%," );
	}

	// Set a prefix for all classes in current assemblies
	public void SetClassPrefix (String prefix) {
		ClassPrefix = prefix;
	}

	// Set current assembly being emitted
	public void SetAssembly (Assembly ass) {
		CurrentAssembly = ass;
	}

	// Format a type name with the Eiffel syntax (e.g. "System.ArrayList" yields "SYSTEM_ARRAYLIST")
	// String name: name to be formatted
	public String FormatTypeName( Type type )
	{
		string formattedName, ContainerClass, NestedClass;
		if (type.IsNestedAssembly || type.IsNestedFamANDAssem ||
			type.IsNestedFamily || type.IsNestedFamORAssem ||
			type.IsNestedPrivate || type.IsNestedPublic)
		{
			String name = type.FullName;
			int AmpPos = name.LastIndexOf( '+' );
			bool is_array = false;

			ContainerClass = name.Substring( 0, AmpPos );
			NestedClass = name.Substring( AmpPos + 1, name.Length - AmpPos - 1 );
			if( NestedClass.EndsWith( "[]" )) {
				is_array = true;
				formattedName = "NATIVE_ARRAY [";
			} else {
				formattedName = "";
			}

			formattedName = GeneratePrefix (type, formattedName);

			NestedClass = FormatToEiffel (NestedClass);

			formattedName = formattedName + NestedClass +  "_IN_";
			formattedName += FormatTypeName( type.Assembly.GetType (ContainerClass));

			if (is_array)
				formattedName = formattedName + "]";
		} else {
			String name = type.Name;
			name = name.TrimEnd( Ampersand );
			if( TypeMappings.ContainsKey( name ))
				return ( String )TypeMappings [name];

			formattedName = String.Copy( name );

			if(( name [0] < 'A' )||( name [0] > 'Z' && name [0] < 'a' )||( name [0] > 'z' ))
				formattedName = "X" + formattedName;

			if( formattedName.EndsWith( "[]" )) {
				Type element_type = type.GetElementType();
				formattedName = formattedName.TrimEnd( Trimmed );
				formattedName = "NATIVE_ARRAY [" + FormatTypeName (element_type) + "]";
			} else {
				formattedName = formattedName.Replace( '.', '_' );
				formattedName = FormatToEiffel( formattedName ); 
				formattedName = GeneratePrefix (type, formattedName);
			}
		}
		formattedName = formattedName.ToUpper();
		return formattedName;
	}
	

	// Format a variable name: solve clashes with Eiffel reserved names
	public String FormatVariableName( String name )
	{
		String ContainerClass, NestedClass, l_name;

		l_name = name.ToLower();
		l_name = (String) VariableMappings [l_name];
		if (l_name != null)
			return l_name;
		int AmpPos = name.IndexOf( '+' );

		if( AmpPos != -1 )
		{
			ContainerClass = name.Substring( 0, AmpPos );
			NestedClass = name.Substring( AmpPos + 1, name.Length - AmpPos - 1 );
			return( FormatVariableName( NestedClass )+ "_in_" + FormatVariableName( ContainerClass ));
		}
		name = name.TrimEnd( Ampersand );
		if( name.StartsWith( "_" ))
			name = 'a' + name;
		if( name.EndsWith( "[]" ))
			name = "array_" + FormatVariableName( name.TrimEnd( Trimmed ));
		name = name.Replace( '.', '_' );
		if( EiffelFormatting )
			name = FormatToEiffel( name );
			
		// TEMP HACK - renames eiffel illegal chars to readable strings
		if (name.IndexOf("infix \"") == -1)
		{
			foreach (object Ch in IlegalChars.Keys){
				for (int i = 0; i < name.Length; i++){
					name = name.Replace(Ch.ToString(), (string) IlegalChars[Ch]);
				}
			}
		}else{
			foreach (object Ch in IlegalChars.Keys){
				for (int i = 0; i < name.IndexOf("infix"); i++){
					name = name.Replace(Ch.ToString(), (string) IlegalChars[Ch]);
				}
			}
		}
		
		return name;
	}

	// Format argument type name taking into account enums (and embedded enums)
	// ArgumentType: type to be named
	public String FormatArgumentTypeName( Type ArgumentType )
	{
		String formattedName;
		Type innerType;

		#if( DEBUG_PASS4 )
			Console.WriteLine( "Entering FormatArgumentTypeName" );
		#endif
		if( ArgumentType.IsByRef )
			innerType = ArgumentType.GetElementType();
		else
			innerType = ArgumentType;

		formattedName = FormatTypeName( innerType );

		#if( DEBUG_PASS4 )
			Console.WriteLine( "Exiting FormatArgumentTypeName: " + formattedName );
		#endif

		return formattedName;
	}

	// Check whether a type is an enum or an array of enums (can be embedded)
	// type: Type to be checked
	public Boolean IsEnum( Type type )
	{
		Boolean result;
		Type innerType ;
		
		if( type.IsByRef )
			innerType = type.GetElementType();
		else
			innerType = type;

		#if( DEBUG_PASS4 )
			Console.WriteLine( "Entering IsEnum( " + type + ")" );
		#endif

		if( type.Equals( Type.GetType( "System.Array" )))
			return false;
		result = innerType.IsEnum;
		while(( !result )&&( innerType.IsArray ))
		{
			innerType  = innerType.GetElementType();

			#if( DEBUG_PASS4 )
				Console.WriteLine( "innerType: " + innerType );
			#endif

			result = innerType.IsEnum;
		}
		#if( DEBUG_PASS4 )
			Console.WriteLine( "Exiting IsEnum: " + result );
		#endif

		return result;
	}

	public string FormatToEiffel( string Value )
	{
		bool PreviousUpper = true;
		string Result = "";
		foreach( char CurrentChar in Value )
		{
			if( char.IsUpper( CurrentChar )&& !PreviousUpper )
				Result += "_";
			Result += char.ToLower( CurrentChar );
			PreviousUpper = char.IsUpper( CurrentChar )||( CurrentChar ==  '_' );
		}
		return Result;
	}

	// Prepend appropriate prefix
	public string GeneratePrefix (Type type, String name) {
		string Result;

		// TEMPORARY - if an assembly is known then generate the
		// Eiffel class name using <AssemblyName>_<TypeName>, else
		// generate the class name using the Types full name
		if (AssemblyMappings.ContainsKey (type.Assembly.GetName().Name)){

			if ((ClassPrefix != null) && (type.Assembly.Equals (CurrentAssembly))) {
				Result = String.Concat (ClassPrefix, name);
			} else {
				string assembly_name = type.Assembly.GetName().Name;

				if (AssemblyMappings.ContainsKey (assembly_name)) {
					Result = (string) AssemblyMappings [assembly_name];
				} else {
					Result = assembly_name;
				}
				if (!Result.Equals (String.Empty)) {
					Result = Result + "_" + name;
				} else {
					Result = name;
				}
			}
		}else{
			Result = type.FullName;
		}

		Result = Result.Replace( '.', '_' );
		Result = FormatToEiffel (Result);
		return Result;
	}

	// Forbidden variables mappings
	static private System.Collections.Hashtable VariableMappings;

	// Assembly name mappings
	static private System.Collections.Hashtable AssemblyMappings;

	// Types mappings
	static private System.Collections.Hashtable TypeMappings;

	// Illegal Eiffel character mappings
	static private System.Collections.Hashtable IlegalChars;

	// Characters removed from end of variable name
	private char[] Trimmed = new char[] {'[', ']'};

	// Ampersand sign to be removed from type names in external signatures
	static protected char[] Ampersand = new char[] {'&'};
	
	// Internal value for `EiffelFormatting' property
	private bool InternalEiffelFormatting;

	// Internal value for `XmlGeneration' property
	private bool InternalXmlGeneration;

	// Prefix for classes
	private string ClassPrefix = null;

	// Current assembly being generated. Only on this assembly name
	// will be prefixed
	private Assembly CurrentAssembly = null;
}
