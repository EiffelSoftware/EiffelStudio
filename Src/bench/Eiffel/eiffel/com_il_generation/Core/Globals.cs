using System;
using System.IO;
using System.Runtime.InteropServices;

#if BETA2
[ClassInterfaceAttribute (ClassInterfaceType.None)]
#endif
internal class Globals
{
	// Initial values for IDs
	internal static int NoValue = -1;

	// Eiffel classes to be generated
	internal static EiffelClass[] ClassTable;

	// System.Object Type
	internal static Type ObjectType = Type.GetType( "System.Object" );

	// Void Type
	internal static Type VoidType = Type.GetType( "void" );

	// Standard Method kind
	internal static int MethodKind = 1;

	// Standard Field Access kind
	internal static int FieldAccessKind = 3;

	// Standard Field Setting kind
	internal static int FieldSettingKind = 5;

	// Standard Constructor kind
	internal static int CreatorKind = 2;

	// Static Method kind
	internal static int StaticMethodKind = 7;

	// Static Field Access kind
	internal static int StaticFieldAccessKind = 4;

	// Static Field Setting kind
	internal static int StaticFieldSettingKind = 6;

	// Get Property kind
	internal static int GetPropertyKind = 8;

	// Set Property kind
	internal static int SetPropertyKind = 9;

	// Operator kind
	internal static int DeferredMethodKind = 10;

	// Operator kind
	internal static int OperatorKind = 11;

	// Enum kind
	internal static int EnumFieldKind = 13;

	// Eiffel `Result' keyword
	internal static String ResultName = "Result";

	// Store/Retrieve I1 element type to/from array
	internal static int IlI1 = 30;

	// Store/Retrieve I2 element type to/from array
	internal static int IlI2 = 31;

	// Store/Retrieve I4 element type to/from array
	internal static int IlI4 = 32;

	// Store/Retrieve I8 element type to/from array
	internal static int IlI8 = 33;

	// Store/Retrieve R4 element type to/from array
	internal static int IlR4 = 34;

	// Store/Retrieve R8 element type to/from array
	internal static int IlR8 = 35;

	// Store/Retrieve Reference element type to/from array
	internal static int Ref = 36;

	// Log debug information
	internal static void Log( String text )
	{
		FileStream fs = new FileStream("log.txt", FileMode.Append, FileAccess.Write);
		StreamWriter s = new StreamWriter( fs );
		s.WriteLine(text);
  		s.Close();
	}

	// Delete Log file
	internal static void DeleteLog () {
		File.Delete ("log.txt");
	}

	// Log exception
	internal static void LogError( Exception error )
	{
		#if DEBUG
			Log( error.ToString());
		#endif
		LastException = error;
		throw error;
	}

	// Log exception with additional info
	internal static void LogError( Exception error, String Info )
	{
		#if DEBUG
			Log( error.ToString());
			Log( Info );
		#endif
		LastException = error;
  		throw error;
	}

	// Name of type with entry point
	internal static String EntryTypeName = "STARTUP";

	// Name of entry point
	internal static String EntryPointName = "Main";

	// Lower Bound of arrays
	internal static System.Reflection.MethodInfo GetLowerBound = Type.GetType( "System.Array" ).GetMethod( "GetLowerBound" );

	// Upper Bound of arrays
	internal static System.Reflection.MethodInfo GetUpperBound = Type.GetType( "System.Array" ).GetMethod( "GetUpperBound" );

	// Element count of arrays
	internal static System.Reflection.MethodInfo GetLength = Type.GetType( "System.Array" ).GetMethod( "GetLength" );

	//Web Method Attribute
	internal static System.Web.Services.WebMethodAttribute WebMethodAttribute = new System.Web.Services.WebMethodAttribute();

	// Any class name
	internal static String AnyName = "System.Object";

	// Any class type id
	internal static int AnyID;

	// System.Object type name
	internal static String ObjectName = "System.Object";

	// Prefix for override functions used to emulate renaming/covariance
	internal static String OverridePrefix = "__";
	
	// Last exception
	internal static Exception LastException = new System.ApplicationException();
}
