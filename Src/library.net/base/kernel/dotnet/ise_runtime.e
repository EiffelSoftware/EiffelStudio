indexing
	description: "Access to ISE runtime features for CLI"
	external_name: "ISE.Runtime.RUN_TIME"
	date: "$Date$"
	revision: "$Revision$"

external class
	ISE_RUNTIME

inherit
	SYSTEM_OBJECT

feature -- Equality

	frozen deep_equal (target, source: ANY): BOOLEAN is
			-- Copy `source' onto `target'.
		external
			"IL static signature (ISE.Runtime.EIFFEL_TYPE_INFO, ISE.Runtime.EIFFEL_TYPE_INFO): System.Boolean use ISE.Runtime.RUN_TIME"
		alias
			"deep_equal"
		end

feature -- Duplication

	frozen standard_copy (target, source: ANY) is
			-- Copy `source' onto `target'.
		external
			"IL static signature (ISE.Runtime.EIFFEL_TYPE_INFO, ISE.Runtime.EIFFEL_TYPE_INFO) use ISE.Runtime.RUN_TIME"
		alias
			"standard_copy"
		end

	frozen standard_clone (o: ANY): SYSTEM_OBJECT is
			-- Create a new instance of same type as `o'.
		external
			"IL static signature (ISE.Runtime.EIFFEL_TYPE_INFO): ISE_Runtime.EIFFEL_TYPE_INFO.Object use ISE.Runtime.GENERIC_CONFORMANCE"
		alias
			"create_like_object"
		end

	frozen deep_clone (o: ANY): SYSTEM_OBJECT is
		external
			"IL static signature (ISE.Runtime.EIFFEL_TYPE_INFO): ISE.Runtime.EIFFEL_TYPE_INFO use ISE.Runtime.RUN_TIME"
		alias
			"deep_clone"
		end
		
feature -- Output

	frozen tagged_out (o: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Object): System.String use ISE.Runtime.RUN_TIME"
		alias
			"tagged_out"
		end

feature -- Hash code

	frozen hash_code (o: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use ISE.Runtime.RUN_TIME"
		alias
			"hash_code"
		end

feature -- Externals

	frozen check_assert (b: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Boolean use ISE.Runtime.RUN_TIME"
		alias
			"check_assert"
		end

	frozen conforms_to (obj1, obj2: SYSTEM_OBJECT): BOOLEAN is
			-- Generating type name of object `o'.
			-- (type of which it is a direct instance)
		external
			"IL static signature (System.Object, System.Object): System.Boolean use ISE.Runtime.GENERIC_CONFORMANCE"
		alias
			"conforms_to"
		end
	
	frozen generic_parameter_count (o: SYSTEM_OBJECT): INTEGER is
			-- Number of generic parameters. 0 if none.
		external
			"IL static signature (System.Object): System.Int32 use ISE.Runtime.RUN_TIME"
		alias
			"generic_parameter_count"
		end

	frozen generator (o: SYSTEM_OBJECT): SYSTEM_STRING is
			-- Generating class name of object `o'.
			-- (base class of the type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use ISE.Runtime.RUN_TIME"
		alias
			"generator"
		end

	frozen generating_type (o: SYSTEM_OBJECT): SYSTEM_STRING is
			-- Generating type name of object `o'.
			-- (type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use ISE.Runtime.RUN_TIME"
		alias
			"generating_type"
		end
	
end -- class ISE_RUNTIME
