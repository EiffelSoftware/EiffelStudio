-- Error when the result type of a an expanded feature is deferred

class VTEC1 

inherit

	VTEC
		redefine
			subcode, build_explain
		end;

feature 

	subcode: INTEGER is
		do
			Result := 1;
		end;

	entity_name: STRING;
			-- Entity name for source of error

	set_entity_name (s: STRING) is
		do
			entity_name := s
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if entity_name /= Void then
				ow.put_string ("Entity name: ");
				ow.put_string (entity_name);
				ow.new_line;
			end;
		end;

end
