indexing

	description: 
		"Error for unknown free option";
	date: "$Date$";
	revision: "$Revision $"

class VD32

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	option_name: STRING;
			-- Option name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Unknown option: ");
			st.add_string (option_name);
			st.add_new_line;
		end;

feature {D_OPTION_SD, CLUST_PROP_SD} -- Setting

	set_option_name (s: STRING) is
			-- Assign `s' to `option_name'
		do
			option_name := s
		end;

end -- class VD32
