indexing

	description: 
		"Error when tilda operator is applied to a non-existing feature.";
	date: "$Date$";
	revision: "$Revision $"

class VXXX

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	address_name: STRING;
			-- Feature name involved: it is not a final name of the class
			-- of id `class_id'.

	code: STRING is "VXXX";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Address name: ");
			st.add_string (address_name);
			st.add_new_line;
		end
		
feature {COMPILER_EXPORTER} -- Setting

	set_address_name (s: STRING) is
			-- Assign `s' to `address_name'.
		do
			address_name := s;
		end;

end -- class VXXX

