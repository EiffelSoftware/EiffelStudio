/*
indexing
	description: "Class that generates custom attributes"
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.Reflection;
using System.Reflection.Emit;
// Used to access Debugger class
//using System.Diagnostics;

namespace ISE.Compiler {

internal class CustomAttributesFactory
{
	// Begins creation of new custom attribute
	public void StartNewAttribute( int targetID, int attributeTypeID, int ArgCount )
	{
		if( COMPILER.Classes [attributeTypeID] == null )
			throw new ApplicationException( "Could not find custom attribute type " + attributeTypeID.ToString());
		ConstructorArguments = new Object [ArgCount];
		TargetID = targetID;
		AttributeTypeID = attributeTypeID;
		ConstructorArgsTypes = new Type[ArgCount];
		CurrentArgIndex = 0;
	}

	// Add custom attribute constructor argument
	public void AddCAConstructorArg( Object Value )
	{
		if( CurrentArgIndex >= ConstructorArguments.Length )
			throw new ApplicationException( "Too many arguments for constructor of " + COMPILER.Classes [AttributeTypeID].Name );
		ConstructorArguments [CurrentArgIndex] = Value;
		ConstructorArgsTypes [CurrentArgIndex] = Value.GetType();
		CurrentArgIndex++;
	}
	
	// Add custom attribute constructor argument with type
	public void AddCAConstructorArg( Object Value, Type ArgType )
	{
		if( CurrentArgIndex >= ConstructorArguments.Length )
			throw new ApplicationException( "Too many arguments for constructor of " + COMPILER.Classes [AttributeTypeID].Name );
		ConstructorArguments [CurrentArgIndex] = Value;
		ConstructorArgsTypes [CurrentArgIndex] = ArgType;
		CurrentArgIndex++;
	}

	// Add custom attribute to class defined by `TargetID'.
	public void GenerateClassCA()
	{
		CLASS CurrentClass = COMPILER.Classes [TargetID];
		if( CurrentClass == null )
			throw new ApplicationException( "Cannot find type with identifier " + TargetID.ToString());
		(( TypeBuilder )CurrentClass.Builder ).SetCustomAttribute( GetCABuilder());
	}
	
	// Add custom attribute to method of `TargetID' with id `FeatureID'.
	public void GenerateFeatureCA( int FeatureID )
	{
		CLASS CurrentClass = COMPILER.Classes [TargetID];
		if( CurrentClass == null )
			throw new ApplicationException( "Cannot find type with identifier " + TargetID.ToString());
		FEATURE CurrentMethod = ( FEATURE ) CurrentClass.FeatureIDTable [FeatureID];
		if( CurrentMethod == null )
			throw new ApplicationException( "Cannot find method with identifier " + FeatureID.ToString() + " in class " + COMPILER.Classes [TargetID].Name );
		if( CurrentMethod.is_attribute )
			(( FieldBuilder )CurrentMethod.attribute_builder ).SetCustomAttribute( GetCABuilder());
		else
			(( MethodBuilder )CurrentMethod.method_builder ).SetCustomAttribute( GetCABuilder());
	}
	
	// Custom attribute builder
	protected CustomAttributeBuilder GetCABuilder()
	{
		CLASS AttributeClass = COMPILER.Classes [AttributeTypeID];
		if( AttributeClass == null )
			throw new ApplicationException( "Cannot find custom attribute type with identifier " + AttributeTypeID.ToString());
		ConstructorInfo Constr = AttributeClass.Builder.GetConstructor( ConstructorArgsTypes );
		if( Constr == null )
			throw new ApplicationException( "Could not find custom attribute constructor with given signature." );
		return new CustomAttributeBuilder( Constr, ConstructorArguments );		
	}

	// Current index in custom attribute constructor arguments array
	private int CurrentArgIndex;
	
	// Target entity identifier (class or method)
	private int TargetID;
	
	// Attribute type identifier
	private int AttributeTypeID;
	
	// Constructor arguments
	Object [] ConstructorArguments;

	// Constructor arguments types
	Type[] ConstructorArgsTypes;
} // end of

} // end of namespace
