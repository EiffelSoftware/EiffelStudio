indexing

	description: 
		"Error for export list rule.";
	date: "$Date$";
	revision: "$Revision $"

class VLEL 

inherit

	EIFFEL_ERROR
		redefine
			is_defined
		end
	
feature -- Properties

	parent: CLASS_C;
			-- Parent node involved

	code: STRING is "VLEL";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				parent /= Void
		ensure then
			valid_parent: Result implies parent /= Void
		end

feature -- Output

	print_parent (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Parent for which export list appears: ");
			parent.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_parent (p: CLASS_C) is
			-- Assign `p' to `parent_id'.
		do
			parent := p
		end;

end -- class VLEL
