indexing

	description: 
		"Error for a call to a local ar an argument with parameters.";
	date: "$Date$";
	revision: "$Revision $"

class VUEX1 

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature -- Properties

	access: ACCESS_INV_AS;
			-- Access to an argument or a local

	code: STRING is "VUEX";
			-- Error code

	subcode: INTEGER is 1;

feature {COMPILER_EXPORTER} -- Setting

	set_access (a: like access) is
			-- Assign `a' to `access'.
		do
			access := a;
		end;

end -- class VUEX1
