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

	build_explain is
		do
			if entity_name /= Void then
				put_string ("Entity name: ");
				put_string (entity_name);
				new_line;
			end;
		end;

end
