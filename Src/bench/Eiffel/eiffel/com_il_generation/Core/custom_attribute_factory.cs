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

internal class CustomAttributesFactory
{
	// Begins creation of new custom attribute
	public void StartNewAttribute( int targetID, int attributeTypeID, int ArgCount )
	{
		if( EiffelReflectionEmit.Classes [attributeTypeID] == null )
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
			throw new ApplicationException( "Too many arguments for constructor of " + EiffelReflectionEmit.Classes [AttributeTypeID].Name );
		ConstructorArguments [CurrentArgIndex] = Value;
		ConstructorArgsTypes [CurrentArgIndex] = Value.GetType();
		CurrentArgIndex++;
	}
	
	// Add custom attribute constructor argument with type
	public void AddCAConstructorArg( Object Value, Type ArgType )
	{
		if( CurrentArgIndex >= ConstructorArguments.Length )
			throw new ApplicationException( "Too many arguments for constructor of " + EiffelReflectionEmit.Classes [AttributeTypeID].Name );
		ConstructorArguments [CurrentArgIndex] = Value;
		ConstructorArgsTypes [CurrentArgIndex] = ArgType;
		CurrentArgIndex++;
	}

	// Add custom attribute to class defined by `TargetID'.
	public void GenerateClassCA()
	{
		EiffelClass CurrentClass = EiffelReflectionEmit.Classes [TargetID];
		if( CurrentClass == null )
			throw new ApplicationException( "Cannot find type with identifier " + TargetID.ToString());
		(( TypeBuilder )CurrentClass.Builder ).SetCustomAttribute( GetCABuilder());
	}
	
	// Add custom attribute to method of `TargetID' with id `FeatureID'.
	public void GenerateFeatureCA( int FeatureID )
	{
		EiffelClass CurrentClass = EiffelReflectionEmit.Classes [TargetID];
		if( CurrentClass == null )
			throw new ApplicationException( "Cannot find type with identifier " + TargetID.ToString());
		EiffelMethod CurrentMethod = ( EiffelMethod ) CurrentClass.FeatureIDTable [FeatureID];
		if( CurrentMethod == null )
			throw new ApplicationException( "Cannot find method with identifier " + FeatureID.ToString() + " in class " + EiffelReflectionEmit.Classes [TargetID].Name );
		if( CurrentMethod.IsAttribute )
			(( FieldBuilder )CurrentMethod.AttributeBuilder ).SetCustomAttribute( GetCABuilder());
		else
			(( MethodBuilder )CurrentMethod.Builder ).SetCustomAttribute( GetCABuilder());
	}
	
	// Custom attribute builder
	protected CustomAttributeBuilder GetCABuilder()
	{
		EiffelClass AttributeClass = EiffelReflectionEmit.Classes [AttributeTypeID];
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
}
