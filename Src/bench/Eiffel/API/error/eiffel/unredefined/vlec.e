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

	client: CLASS_C;
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

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Name of class involved in cycle: ");
			client.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_client (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			client := c
		end;

end -- class VLEC
