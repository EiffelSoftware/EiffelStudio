-- Error when there are entities with the same name

class VREG 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;
	
feature 

	entity_name: STRING;
			-- Argument name violating the VREG rule

	code: STRING is "VREG";
			-- Error code

	set_entity_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			entity_name := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate name: ");
			ow.put_string (entity_name);
			ow.new_line;
		end;

end
