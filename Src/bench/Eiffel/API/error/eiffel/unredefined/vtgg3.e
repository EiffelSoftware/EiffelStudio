indexing

	description: 
		"Error when a local type violated the constrained %
		%genericity validity rule.";
	date: "$Date$";
	revision: "$Revision $"

class VTGG3 

inherit

	VTGG
		redefine
			build_explain
		select
			build_explain
		end;
	VTGG
		rename
			build_explain as old_build_explain
		end;

feature -- Properties

	entity_name: STRING;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Entity name: ");
			ow.put_string (entity_name);
			ow.new_line;
			old_build_explain (ow);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_entity_name (s: STRING) is
		do
			entity_name := s;
		end;

end -- class VTGG3
