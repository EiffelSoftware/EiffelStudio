/*
 * Include all the information needed to produce the Eiffel code
 *
 */
using System;
using System.Reflection;

public class EiffelCreationRoutine
{
	// Constructor, set `Info' with `inf'.
	public EiffelCreationRoutine( ConstructorInfo inf )
	{
		SetConstructorInfo( inf );
		ArgumentsNames = new String [] {};
	}

	// Constructor, set fields with fields of `Other'.
	public EiffelCreationRoutine( EiffelCreationRoutine Other )
	{
		Info = Other.Info;
		ArgumentsNames = Other.ArgumentsNames;
	}

	// Set `Info' with `Inf'.
	internal void SetConstructorInfo( ConstructorInfo Inf )
	{
		Info = Inf;
	}

	// Set `ArgumentsNames' with `ArgNames'.
	internal void SetArgumentsNames( String [] ArgNames )
	{
		ArgumentsNames = ArgNames;
	}
	
	// Associated ConstructorInfo
	internal ConstructorInfo Info;
	
	// Routine arguments names
	internal String [] ArgumentsNames;
}
