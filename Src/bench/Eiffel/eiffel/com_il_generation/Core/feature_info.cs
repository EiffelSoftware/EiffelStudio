/* 
indexing
	description: "Info about a feature that can be discarded as soon as
		a MethodBuilder or an AttributeBuilder is created. Having this
		saves a lot of space in memory since the information was never
		used after the Builder was created."
	date: "$Date$"
	revision: "$Revision$"
*/

using System;

namespace ISE.Compiler {

internal class FEATURE_INFO {
	
	public FEATURE_INFO (int arg_count) {
		parameter_names = new string [arg_count];
		feature_id = COMPILER.NoValue;
	}

	public string real_name;
	public string eiffel_name;
	public string name() {
		if (real_name == null)
			return eiffel_name;
		else
			return real_name;
	}

	// Parameter Names
	public string[] parameter_names;
	
	// Is feature deferred?
	public bool is_deferred;

	// Is feature redefined/implemented from parent?
	public bool is_redefined;

	// Is feature frozen?
	public bool is_frozen;

	// Is feature a static?
	public bool is_static;

	// Is feature an invariant?
	public bool is_invariant;

	// Belongs to interface
	public bool is_interface_routine;
	
	// Feature identifier in class
	public int feature_id;

	// Set `real_name' with `a_feature_name'.
	public void set_real_name( string a_feature_name ) {
		real_name = a_feature_name;
	}

	// Set `eiffel_name' with `a_feature_name'.
	public void set_eiffel_name( string a_feature_name ) {
		eiffel_name = a_feature_name;
	}

	// Set `is_deferred' with `val'.
	public void set_is_deferred (bool val) {
		is_deferred = val;
	}

	// Set `is_redefined' with `val'.
	public void set_is_redefined (bool val) {
		is_redefined = val;
	}

	// Set `is_frozen' with `val'.
	public void set_is_frozen (bool val) {
		is_frozen = val;
	}

	// Set `is_static' with `val'.
	public void set_is_static (bool val) {
		is_static = val;
	}

	// Set `is_invariant' with `val'.
	public void set_is_invariant (bool val) {
		is_invariant = val;
	}

	// Set `is_interface_routine' with `ID'.
	public void set_is_interface_routine (bool val) {
		is_interface_routine = val;
	}

	// Set `feature_id' with `ID'.
	public void set_feature_id( int ID ) {
		feature_id = ID;
	}
} // end of FEATURE_INFO

} // end of namespace
