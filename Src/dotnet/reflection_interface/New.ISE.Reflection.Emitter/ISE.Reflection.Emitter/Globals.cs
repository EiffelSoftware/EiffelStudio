/*
 * Include global data
 *
 */

public class Globals
{
	// Emitter Version Number
	static protected System.String VersionNumber = "3.1rc1";

	// Formats COOL names into Eiffel ones
	static internal Formatter NameFormatter = new Formatter();
	
	// Table associating ids with class information
	// Key: Class UID
	// Value: Instance of EiffelClass
	static internal System.Collections.Hashtable ClassTable;

	// Table associating ids with method information
	// Key: Method ID
	// Value: List of instances of EiffelMethod
	//static public System.Collections.Hashtable MethodTable = new System.Collections.Hashtable( );

	// Table associating Types with ids
	// Key: Instance of Type
	// Value: Class UID
	static internal System.Collections.Hashtable ClassIDTable;

	// Table associating method information with ids
	// Key: Instance of EiffelMehod
	// Value: Method Polymorphic ID
	static internal System.Collections.Hashtable PolymorphicIDTable = new System.Collections.Hashtable( );
	
	// List of methods that should not be generated
	// Item: MethodInfo
	static internal System.Collections.ArrayList NonGeneratedMethods = new System.Collections.ArrayList( );
	
	// Object Type, used for comparisons
	static internal System.Type ObjectType = System.Type.GetType( "System.Object" );
	
	// Void type
	static internal System.Type VoidType = System.Type.GetType( "void" );

	// FieldInfo Type
	static internal System.Type FieldInfoType = System.Type.GetType( "System.Reflection.FieldInfo" );	

	// Is `type' to be generated? (i.e. is public and CLS compliant)
	static internal bool IsGeneratedType( System.Type type )
	{
		if( !IsCLSCompliant( type ))
			return false;
		if( type.IsPublic )
			return true;
		if(  type.IsNestedPublic || type.IsNestedFamily || type.IsNestedFamORAssem )
		{
			string TypeName = type.FullName.Substring( 0, type.FullName.IndexOf( '+' ));
			foreach( System.Reflection.Assembly assembly in Assemblies )
			{
				System.Type CurrentType = assembly.GetType( TypeName );
				if( CurrentType != null )
					return CurrentType.IsPublic;
			}
		}
		return false;
	}
	
	// Is `Field' to be generated? (i.e. is public and CLS compliant)
	static internal bool IsGeneratedField( System.Reflection.FieldInfo field )
	{
		return( !field.IsPrivate )&&IsCLSCompliant( field );
	}

	// Is `method' to be generated? (i.e. is public and CLS compliant)
	static internal bool IsGeneratedMethod( System.Reflection.MethodBase method )
	{
		if( NonGeneratedMethods.Contains( method ))
			return false;
		if(( method.IsPublic || method.IsFamily || method.IsFamilyOrAssembly )&&IsCLSCompliant( method ))
			return true;
		// MethodImpl
		foreach( System.Reflection.MethodInfo Method in MethodImpls )
		{
			if( Method.Name == method.Name && Method.GetParameters().Length == method.GetParameters().Length )
			{
				System.Reflection.ParameterInfo[] OtherParameters = method.GetParameters();
				System.Reflection.ParameterInfo[] Parameters = Method.GetParameters();
				bool Same = true;
				for( int i = 0; i < Parameters.Length && Same; i ++ )
					Same =( Parameters [i].ParameterType == OtherParameters [i].ParameterType );
				if( Same )
					return( method.IsPrivate && method.IsVirtual && method.IsFinal );
			}
		}
		return false;
	}

	// Is `Event' to be generated? (i.e. is public and CLS compliant)
	static internal bool IsGeneratedEvent( System.Reflection.EventInfo Event )
	{
		return IsCLSCompliant( Event );
	}

	// Is `Member' a CLS compliant member?
	static internal bool IsCLSCompliant( System.Reflection.MemberInfo Member )
	{
		System.CLSCompliantAttribute Ca;
		Ca =( System.CLSCompliantAttribute )System.Attribute.GetCustomAttribute ( Member, typeof( System.CLSCompliantAttribute ));
		return( Ca == null || Ca.IsCompliant );
	}
	
	internal bool IsVirtualObjectMethod( EiffelMethodFactory Method )
	{
		return (Method.Info.IsVirtual && Method.Info.DeclaringType == typeof( System.Object ));
	}
	
	// Return a new unique Method ConflictID
	internal int NewConflictID()
	{
		InternalConflictID++;
		return InternalConflictID;
	}

	// Return a new unique Method PolymorphID
	internal int NewPolymorphID()
	{
		InternalPolymorphID++;
		return InternalPolymorphID;
	}

	// Ampersand sign to be removed from type names in external signatures
	static protected char[] Ampersand = new char[] {'&'};
	
	// Internally used by `NewConflictID'
	private static int InternalConflictID = -1;
	
	// Internally used by `NewPolymorphID'
	private static int InternalPolymorphID = -1;
	
	// Class System.Object ID
	static protected int ObjectID;
	
	// Unary Operators
	// Key: Operator code
	// Value: Eiffel infix feature name
	static internal System.Collections.Hashtable UnaryOperators()
	{
		if( InternalUnaryOperators == null )
		{
			InternalUnaryOperators = new System.Collections.Hashtable();
			InternalUnaryOperators.Add( "op_Decrement", "prefix \"#--\"" );
			InternalUnaryOperators.Add( "op_Increment", "prefix \"#++\"" );
			InternalUnaryOperators.Add( "op_UnaryNegation", "prefix \"-\"" );
			InternalUnaryOperators.Add( "op_UnaryPlus", "prefix \"+\"" );
			InternalUnaryOperators.Add( "op_LogicalNot", "prefix \"not\"" );
			InternalUnaryOperators.Add( "op_True", "prefix \"#true\"" );
			InternalUnaryOperators.Add( "op_False", "prefix \"#false\"" );
			InternalUnaryOperators.Add( "op_AddressOf", "prefix \"&\"" );
			InternalUnaryOperators.Add( "op_OnesComplement", "prefix \"#~\"" );
			InternalUnaryOperators.Add( "op_PointerDereference", "prefix \"*\"" );
		}
		return InternalUnaryOperators;
	}
	
	// Binary Operators
	// Key: Operator code
	// Value: Eiffel infix feature name
	static internal System.Collections.Hashtable BinaryOperators()
	{
		if( InternalBinaryOperators == null )
		{
			InternalBinaryOperators = new System.Collections.Hashtable();
			InternalBinaryOperators.Add( "op_Addition", "infix \"+\"" );
			InternalBinaryOperators.Add( "op_Subtraction", "infix \"-\"" );
			InternalBinaryOperators.Add( "op_Multiply", "infix \"*\"" );
			InternalBinaryOperators.Add( "op_Division", "infix \"/\"" );
			InternalBinaryOperators.Add( "op_Modulus", "infix \"\\\\\"" );
			InternalBinaryOperators.Add( "op_ExclusiveOr", "infix \"xor\"" );
			InternalBinaryOperators.Add( "op_BitwiseAnd", "infix \"&\"" );
			InternalBinaryOperators.Add( "op_BitwiseOr", "infix \"|\"" );
			InternalBinaryOperators.Add( "op_LogicalAnd", "infix \"and\"" );
			InternalBinaryOperators.Add( "op_LogicalOr", "infix \"or\"" );
			InternalBinaryOperators.Add( "op_Assign", "infix \"#=\"" );
			InternalBinaryOperators.Add( "op_LeftShift", "infix \"#<<\"" );
			InternalBinaryOperators.Add( "op_RightShift", "infix \"#>>\"" );
			InternalBinaryOperators.Add( "op_SignedRightShift", "infix \"#|>>\"" );
			InternalBinaryOperators.Add( "op_UnsignedRightShift", "infix \"|>>\"" );
			InternalBinaryOperators.Add( "op_Equality", "infix \"#==\"" );
			InternalBinaryOperators.Add( "op_GreaterThan", "infix \">\"" );
			InternalBinaryOperators.Add( "op_LessThan", "infix \"<\"" );
			InternalBinaryOperators.Add( "op_Inequality", "infix \"|=\"" );
			InternalBinaryOperators.Add( "op_GreaterThanOrEqual", "infix \">=\"" );
			InternalBinaryOperators.Add( "op_LessThanOrEqual", "infix \"<=\"" );
			InternalBinaryOperators.Add( "op_UnsignedRightShiftAssignment", "infix \"#|>>=\"" );
			InternalBinaryOperators.Add( "op_MemberSelection", "infix \"#->\"" );
			InternalBinaryOperators.Add( "op_RightShiftAssignment", "infix \"#>>=\"" );
			InternalBinaryOperators.Add( "op_MultiplicationAssignment", "infix \"#*=\"" );
			InternalBinaryOperators.Add( "op_PointerToMemberSelection", "infix \"#->*\"" );
			InternalBinaryOperators.Add( "op_SubtractionAssignment", "infix \"#-=\"" );
			InternalBinaryOperators.Add( "op_ExclusiveOrAssignment", "infix \"#^=\"" );
			InternalBinaryOperators.Add( "op_LeftShiftAssignment", "infix \"#<<=\"" );
			InternalBinaryOperators.Add( "op_ModulusAssignment", "infix \"#\\\\=\"" );
			InternalBinaryOperators.Add( "op_AdditionAssignment", "infix \"#+=\"" );
			InternalBinaryOperators.Add( "op_BitwiseAndAssignment", "infix \"#&=\"" );
			InternalBinaryOperators.Add( "op_BitwiseOrAssignment", "infix \"#|=\"" );
			InternalBinaryOperators.Add( "op_Comma", "infix \"#,\"" );
			InternalBinaryOperators.Add( "op_DivisionAssignment", "infix \"#/=\"" );
		}
		return InternalBinaryOperators;
	}

	// Unary Operators
	// Key: Operator code
	// Value: Eiffel infix feature name
	static internal System.Collections.Hashtable InternalUnaryOperators;
	
	// Binary Operators
	// Key: Operator code
	// Value: Eiffel infix feature name
	static internal System.Collections.Hashtable InternalBinaryOperators;
	
	// List of MethodImpls
	static protected System.Collections.ArrayList MethodImpls;
	
	// List of assemblies (including all external assemblies)
	static protected System.Collections.ArrayList Assemblies;
	
	// List of types in same polymorphic branch, above given type.
	static protected System.Collections.ArrayList Family( System.Type type )
	{
		System.Collections.ArrayList Result = new System.Collections.ArrayList();
		if( type != null )
		{
			Result.Add( type );
			Result.AddRange( Family( type.BaseType ));
			foreach( System.Type Interface in type.GetInterfaces())
				Result.AddRange( Family( Interface ));
		}
		return Result;
	}

	// Eiffel source file extension
	static protected string EiffelFileExtension = ".e";

	// Array of digits, used to remove from end of string.
	internal char[] Digits = new char[]{ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
}

