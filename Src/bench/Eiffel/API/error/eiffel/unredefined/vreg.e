indexing

	description: 
		"Error when there are entities with the same name.";
	date: "$Date$";
	revision: "$Revision $"

class VREG 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature -- Properties

	entity_name: STRING;
			-- Argument name violating the VREG rule

	code: STRING is "VREG";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate name: ");
			ow.put_string (entity_name);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_entity_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			entity_name := s;
		end;

end -- class VREG
