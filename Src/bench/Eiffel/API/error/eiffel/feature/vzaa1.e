indexing

	description: 
		"Error when address operator is applied to a non-existing feature.";
	date: "$Date$";
	revision: "$Revision $"

class VZAA1 

inherit

	FEATURE_ERROR	
		redefine
			build_explain
		end;

feature -- Properties

	address_name: STRING;
			-- Feature name involved: it is not a final name of the class
			-- of id `class_id'.

	code: STRING is "VZAA";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Address name: ");
			ow.put_string (address_name);
			ow.new_line;
		end
		
feature {COMPILER_EXPORTER} -- Setting

	set_address_name (s: STRING) is
			-- Assign `s' to `address_name'.
		do
			address_name := s;
		end;

end -- class VZAA1
