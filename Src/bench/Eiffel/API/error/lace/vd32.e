indexing

	description: 
		"Error for unknown free option";
	date: "$Date$";
	revision: "$Revision $"

class VD32

inherit

	ERROR
		redefine
			build_explain
		end;

feature -- Property

	code: STRING is "VD32";
			-- Error code

	option_name: STRING;
			-- Option name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Unknown option: ");
			ow.put_string (option_name);
			ow.new_line;
		end;

feature {D_OPTION_SD, CLUST_PROP_SD} -- Setting

	set_option_name (s: STRING) is
			-- Assign `s' to `option_name'
		do
			option_name := s
		end;

end -- class VD32
