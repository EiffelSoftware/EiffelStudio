indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class VRRR2 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature -- Properties

	code: STRING is "VRRR";
			-- Error code

	subcode: INTEGER is 2;

	is_deferred: BOOLEAN;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Kind of routine: ");
			if is_deferred then
				st.add_string ("deferred")
			else
				st.add_string ("external")
			end;
			st.add_new_line
		end;

feature {COMPILER_EXPORTER}

	set_is_deferred (b: BOOLEAN) is
		do
			is_deferred := b;
		end;

end -- class VRRR2
