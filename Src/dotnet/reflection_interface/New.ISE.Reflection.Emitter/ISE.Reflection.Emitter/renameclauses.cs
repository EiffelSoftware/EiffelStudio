/*
*
* Renaming clause of an Eiffel class. Used by the Eiffel writter to generate Eiffel code.
*
*/

using System;
using System.Collections;

public class RenameClauses : Globals
{
	// Constructor
	public RenameClauses()
	{
		ClausesList = new System.Collections.Hashtable();
	}

	// Add a new clause
	virtual internal void Add( String parentClass, String OldName, String NewName )
	{
		String[] Clause;
		ArrayList ClausesForClass;

		if( OldName != NewName && !Has( parentClass, OldName, NewName ))
		{
			if( BinaryOperators().ContainsKey( OldName ))
				OldName =( String )BinaryOperators() [OldName];
			if( UnaryOperators().ContainsKey( OldName ))
				OldName =( String )UnaryOperators() [OldName];
			
			if( BinaryOperators().ContainsKey( NewName ))
				NewName =( String )BinaryOperators() [NewName];
			if( UnaryOperators().ContainsKey( NewName ))
				NewName =( String )UnaryOperators() [NewName];
			
			Clause = new String[2];
			Clause[ 0 ]= OldName;
			Clause[ 1 ]= NewName;
			if( ClausesList.ContainsKey( parentClass ))
				(( ArrayList )( ClausesList[ parentClass ])).Add( Clause );
			else
			{
				ClausesForClass = new ArrayList();
				ClausesForClass.Add( Clause );
				ClausesList.Add( parentClass, ClausesForClass );
			}
		}
	}

	// Is `className' one of the classes with feature to be renamed?
	virtual internal Boolean HasClause( String className )
	{
		return ClausesList.ContainsKey( className );
	}

	// Is there any renaming clause?
	virtual internal Boolean HasClause()
	{
		return( ClausesList.Count > 0 );
	}

	// Is there a clause for `ParentName' that renames `OldName' into `NewName'?
	virtual internal Boolean Has( String ParentName, String OldName, String NewName )
	{
		Boolean found = false;
		String Source;
		String Target;
		
		if( ClausesList.ContainsKey( ParentName ))
		{
			System.Collections.ArrayList List =(( System.Collections.ArrayList )ClausesList [ParentName]);
			for( int i = 0; !found&&( i < List.Count ); i++ )
			{
				Source =(( String [] )List [i]) [0];
				Target =(( String [] )List [i]) [1];

				if( BinaryOperators().ContainsKey( Source ))
					Source =( String )BinaryOperators() [Source];
				if( UnaryOperators().ContainsKey( Source ))
					Source =( String )UnaryOperators() [Source];				
				if( BinaryOperators().ContainsKey( Target ))
					Target =( String )BinaryOperators() [Target];
				if( UnaryOperators().ContainsKey( Target ))
					Target =( String )UnaryOperators() [Target];
			
				found =( Source == OldName )&&( Target == NewName );
			}
		}
			return found;
	}
	
	// Number of rename clauses for class `className'
	virtual internal int Count( String className )
	{
		if( ClausesList.ContainsKey( className ))
			return(( ArrayList )( ClausesList[ className ])).Count;
		else
			return 0;
	}

	// Retrieve ith renaming clause source for class `className'.
	virtual internal String RenameClauseSource( String className, int index )
	{
		return ( String )((( String[] )((( ArrayList )( ClausesList[ className ]))[ index ]))[ 0 ]);
	}

	// Retrieve ith renaming clause target for class `className'.
	virtual internal String RenameClauseTarget( String className, int index )
	{
		return ( String )((( String[] )((( ArrayList )( ClausesList[ className ]))[ index ]))[ 1 ]);
	}

	// Parent class with feature(s) to be renamed
	// Key: Parent class name
	// Value: List of arrays of two strings made of the new and the old names
	private Hashtable ClausesList;
}
