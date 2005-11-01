/*
indexing
	description: "Comparer using ReferenceEquals. Mostly used for having a set of objects using the .NET Hashtable."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Collections;

namespace EiffelSoftware.Runtime {

[System.Runtime.InteropServices.ComVisibleAttribute (false)]
public class RT_REFERENCE_COMPARER : IComparer {
/*
feature -- Comparison
*/
	public int Compare (object a, object b) { 
		if (a == b) {
			return 0;
		} else {
			return 1;
		}
	} 
}

}

