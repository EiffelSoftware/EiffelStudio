indexing

	description: 
		"Error for class violating the expanded client rule.";
	date: "$Date$";
	revision: "$Revision $"

class VLEC 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end;

feature -- Properties

	client: E_CLASS;
			-- Unvalid class type

	code: STRING is "VLEC";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				client /= Void
		ensure then
			valid_client: Result implies client /= Void
		end

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Name of class involved in cycle: ");
			client.append_name (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER}

	set_client (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			client := c.e_class;
		end;

end -- class VLEC
