indexing

	description: 
		"Error when a deferred or an external feature has a rescue clause.";
	date: "$Date$";
	revision: "$Revision $"

class VXRC 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	code: STRING is "VXRC";
			-- Error code

	is_deferred: BOOLEAN;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if is_deferred then
				st.add_string ("Kind of routine: deferred")
			else
				st.add_string ("Kind of routine: external")
			end;
			st.add_new_line
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_deferred (b: BOOLEAN) is
		do
			is_deferred := b
		end;

end -- class VXRC
