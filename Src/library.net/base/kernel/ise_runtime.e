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

end -- class ISE_RUNTIME
