indexing
	description: "Access to ISE runtime features for CLI"
	external_name: "ISE.Runtime.RUN_TIME"
	date: "$Date$"
	revision: "$Revision$"

external class
	ISE_RUNTIME

feature -- Externals

	frozen check_assert (b: BOOLEAN): BOOLEAN is
		external
			"IL static signature (System.Boolean): System.Boolean use ISE.Runtime.RUN_TIME"
		alias
			"check_assert"
		end

	frozen generic_parameter_count (o: SYSTEM_OBJECT): INTEGER is
			-- Number of generic parameters. 0 if none.
		external
			"IL static signature (System.Object): System.Int32 use ISE.Runtime.RUN_TIME"
		alias
			"generic_parameter_count"
		end

	frozen generator (o: ANY): SYSTEM_STRING is
			-- Generating class name of object `o'.
			-- (base class of the type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use ISE.Runtime.RUN_TIME"
		alias
			"generator"
		end

	frozen generating_type (o: ANY): SYSTEM_STRING is
			-- Generating type name of object `o'.
			-- (type of which it is a direct instance)
		external
			"IL static signature (System.Object): System.String use ISE.Runtime.RUN_TIME"
		alias
			"generating_type"
		end
	
end -- class ISE_RUNTIME
