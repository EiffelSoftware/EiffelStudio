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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("Address name: ");
			put_string (address_name);
			new_line;
		end
		
end
