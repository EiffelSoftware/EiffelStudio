/*
*
* Undefine clause of an Eiffel class. Used by the Eiffel writter to generate Eiffel code.
*
*/

using System;
using System.Collections;

public class UndefineClauses
{
	// Constructor
	public UndefineClauses()
	{
		ClausesList = new System.Collections.Hashtable();
	}

	// Add a new clause
	virtual internal void Add( String parentClass, String Name )
	{
		ArrayList ClausesForClass;

		if( ClausesList.ContainsKey( parentClass ))
			(( ArrayList )( ClausesList[ parentClass ])).Add( Name );
		else
		{
			ClausesForClass = new ArrayList();
			ClausesForClass.Add( Name );
			ClausesList.Add( parentClass, ClausesForClass );
		}
	}

	// Is `className' one of the classes with feature to be redefined?
	virtual internal bool HasClause( String className )
	{
		return ClausesList.ContainsKey( className );
	}

	// Is there any renaming clause?
	virtual internal bool HasClause()
	{
		return( ClausesList.Count > 0 );
	}

	// Is feature `Name' from `parentClass' undefined?
	virtual internal bool Has( String Name, String parentClass )
	{
		if( HasClause( parentClass ))
			return((( System.Collections.ArrayList )ClausesList [parentClass]).Contains( Name ));
		return false;
	}
	// Number of redefine clauses for class `className'
	virtual internal int Count( String className )
	{
		if( ClausesList.ContainsKey( className ))
			return(( ArrayList )( ClausesList[ className ])).Count;
		else
			return 0;
	}

	// Retrieve ith redefined feature for class `className'.
	virtual internal String UndefineFeature( String className, int index )
	{
		return ( String )(((( ArrayList )( ClausesList[ className ]))[ index ]));
	}

	// Parent class with feature(s) to be redefined
	// Key: Parent class name
	// Value: List of strings representing the names of the features to be redefined
	private Hashtable ClausesList;
}