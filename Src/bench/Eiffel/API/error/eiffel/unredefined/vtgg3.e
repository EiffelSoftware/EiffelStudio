-- Error when a local type violated the constrained genericity validity
-- rule

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

feature

	entity_name: STRING;

	set_entity_name (s: STRING) is
		do
			entity_name := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Entity name: ");
			ow.put_string (entity_name);
			ow.new_line;
			old_build_explain (ow);
		end;

end
