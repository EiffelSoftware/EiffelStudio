/*
 * Include all the information needed to produce the Eiffel code
 *
 */
using System;
using System.Reflection;

public class EiffelMethodFactory : IComparable
{
	// Constructor, set `ID' with `MethodID'.
	public EiffelMethodFactory( int PolymorphID )
	{
		PolymorphIDs = new int[1];
		PolymorphIDs [0] = PolymorphID;
		NewSlot = false;
	}

	// Constructor, set `InternalPolymorphIDs' with `OtherIDs'.
	public EiffelMethodFactory( System.Collections.ICollection OtherIDs )
	{
		if( OtherIDs == null || OtherIDs.Count == 0 )
			throw new ApplicationException( "Cannot create EiffelMethodFactory with no Polymorphic identifier" );
		PolymorphIDs = new int [OtherIDs.Count];
		OtherIDs.CopyTo( PolymorphIDs, 0 );
		NewSlot = false;
	}

	// Constructor, set fields with fields of `Other'.
	public EiffelMethodFactory( EiffelMethodFactory Other )
	{
		PolymorphIDs =( int [] )Other.PolymorphIDs.Clone();
		InternalName = Other.Name();
		Info = Other.Info;
		IsDeferred = Other.IsDeferred;
		NewSlot = Other.NewSlot;
		ArgumentsNames = Other.ArgumentsNames;
	}

	// Is Method Polymorphic?
	public bool IsPolymorphic
	{
		get
		{
			return( Info.IsVirtual && !Info.IsFinal );
		}
	}
	
	// Compare with `obj'.
	public virtual Int32 CompareTo( Object obj )
	{
		int Comp = Info.GetParameters().Length.CompareTo((( EiffelMethodFactory )obj ).Info.GetParameters().Length );
		if( Comp == 0 )
		{
			ParameterInfo[] Parameters = Info.GetParameters();
			ParameterInfo[] OtherParameters = (( EiffelMethodFactory )obj ).Info.GetParameters();
			for (int i = 0; i < Parameters.Length && Comp == 0; i++)
			{
				if( Parameters [i].ParameterType.IsArray )
					Comp = 1;
				else if( OtherParameters [i].ParameterType.IsArray )
					Comp = -1;
			}
		}
		return Comp;
	}

	// Set `Name' with `MethodName'.
	internal void SetName( String MethodName )
	{
		InternalName = MethodName;
	}

	// Add `OtherIDs' to `InternalPolymorphIDs'.
	internal void AddPolymorphIDs( System.Collections.ArrayList OtherIDs )
	{
		int [] NewPolymorphIDs = new int [PolymorphIDs.Length + OtherIDs.Count];
		PolymorphIDs.CopyTo( NewPolymorphIDs, 0 );
		OtherIDs.CopyTo( NewPolymorphIDs, PolymorphIDs.Length );
		PolymorphIDs = NewPolymorphIDs;
	}

	// Is `OtherID' a polymorph id?
	internal bool HasPolymorphID( int OtherID )
	{
		return( Array.IndexOf( PolymorphIDs, OtherID ) >= 0 );
	}

	// Do `this' and `OtherMethod' have any common Polymorph ID?
	internal bool HasPolymorphID( EiffelMethodFactory OtherMethod )
	{
		for( int i = 0; i < PolymorphIDs.Length; i++ )
			if( OtherMethod.HasPolymorphID( PolymorphIDs [i] ))
				return true;
		return false;
	}
	
	// Set `Info' with `Inf'.
	internal void SetMethodInfo( MethodInfo Inf )
	{
		Info = Inf;
	}

	// Set `IsDeferred' with `Deferred'
	internal void SetDeferred( Boolean Deferred )
	{
		IsDeferred = Deferred;
	}

	// Set `ArgumentsNames' with `ArgNames'.
	internal void SetArgumentsNames( String [] ArgNames )
	{
		ArgumentsNames = ArgNames;
	}
	
	// Set `NewSlot' with true.
	internal void SetNewSlot()
	{
		NewSlot = true;
	}
	
	// Eiffel Name (Resolve overloading)
	internal String Name()
	{
		if( InternalName != null )
			return InternalName;
		else
			return Info.Name;
	}

	// Is `InternalName' non null?
	internal bool HasEiffelName()
	{
		return InternalName != null;
	}
	
	// Polymorphic IDs: Two features with same PolymorphID are polymorphic in .NET
	// i.e. they have the same name/signature, are virtual and belong to classes that
	// inherit one from the other.
	// There can be multiple Polymorphic IDs associated to one method in case that
	// method "merges" parent methods (via MethodImpl).
	internal int[] PolymorphIDs;
	
	// Associated MethodInfo
	internal MethodInfo Info;

	// Is method deferred?
	internal Boolean IsDeferred;
	
	// Is method a new slot, i.e. not inherited?
	internal Boolean NewSlot;
	
	// Internal name
	protected String InternalName;
	
	// Routine arguments names
	internal String [] ArgumentsNames;
	
}
