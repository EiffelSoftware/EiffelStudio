-- Error when address operator is applied to a non-existing feature

class VZAA1 

inherit

	FEATURE_ERROR	
		redefine
			build_explain
		end;

feature

	address_name: STRING;
			-- Feature name involved: it is not a final name of the class
			-- of id `class_id'.

	set_address_name (s: STRING) is
			-- Assign `s' to `address_name'.
		do
			address_name := s;
		end;

	code: STRING is "VZAA";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Address name: ");
			ow.put_string (address_name);
			ow.new_line;
		end
		
end
