indexing
	description: "[
		Set of features to access ISE runtime functionality.
		To be used at your own risk. 
		]"
	external_name: "EiffelSoftware.Runtime.RUN_TIME"
	assembly: "EiffelSoftware.Runtime", "5.5.0.0", "neutral", "def26f296efef469"
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	ISE_RUNTIME

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Equality

	frozen deep_equal (a_context, target, source: SYSTEM_OBJECT): BOOLEAN is
			-- Compare `target' and `source' in context of `a_context'
		external
			"IL static signature (System.Object, System.Object, System.Object): System.Boolean use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"deep_equal"
		end

	frozen standard_is_equal (target, source: SYSTEM_OBJECT): BOOLEAN is
			-- Is `target' attached to an object of the same type
			-- as `source', and field-by-field identical to it?
		external
			"IL static signature (System.Object, System.Object): System.Boolean use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"standard_is_equal"
		end

feature -- Duplication

	frozen standard_copy (target, source: SYSTEM_OBJECT) is
			-- Copy `source' onto `target'.
		external
			"IL static signature (System.Object, System.Object) use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"standard_copy"
		end

	frozen standard_clone (o: SYSTEM_OBJECT): SYSTEM_OBJECT is
			-- Create a new instance of same type as `o'.
		external
			"IL static signature (System.Object): System.Object use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"standard_clone"
		end

	frozen deep_twin (target: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object): System.Object use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"deep_twin"
		end
		
feature -- Hash code

	frozen hash_code (o: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"hash_code"
		end

feature -- Externals

	frozen check_assert (b: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Boolean use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"check_assert"
		end

	frozen initialize_assertions (t: RUNTIME_TYPE_HANDLE) is
		external
			"IL static signature (System.RuntimeTypeHandle) use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"assertion_initialize"
		end
		
	frozen conforms_to (obj1, obj2: SYSTEM_OBJECT): BOOLEAN is
			-- Generating type name of object `o'.
			-- (type of which it is a direct instance)
		external
			"IL static signature (System.Object, System.Object): System.Boolean use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"conforms_to"
		end
	
	frozen generic_parameter_count (o: SYSTEM_OBJECT): INTEGER is
			-- Number of generic parameters. 0 if none.
		external
			"IL static signature (System.Object): System.Int32 use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"generic_parameter_count"
		end

	frozen type_of_generic_parameter (o: SYSTEM_OBJECT; pos: INTEGER): TYPE is
			-- Type of generic parameter at position `pos' in type associated to `o'.
		external
			"IL static signature (System.Object, System.Int32): System.Type use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"type_of_generic_parameter"
		end

	frozen generator (o: SYSTEM_OBJECT): SYSTEM_STRING is
			-- Generating class name of object `o'.
			-- (base class of the type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"generator"
		end

	frozen generating_type (o: SYSTEM_OBJECT): SYSTEM_STRING is
			-- Generating type name of object `o'.
			-- (type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"generating_type"
		end

feature -- Exceptions

	frozen last_exception: EXCEPTION is
		external
			"IL static_field signature :System.Exception use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"last_exception"
		end

feature -- Basic Operations

	frozen raise (e: EXCEPTION) is
		external
			"IL static signature (System.Exception): System.Void use EiffelSoftware.Runtime.RUN_TIME"
		alias
			"raise"
		end

end -- class ISE_RUNTIME
