indexing

	description: 
		"Error when the result type of a an expanded feature is deferred.";
	date: "$Date$";
	revision: "$Revision $"

class VTEC1 

inherit

	VTEC
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 1;
		end;

	entity_name: STRING;
			-- Entity name for source of error

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if entity_name /= Void then
				st.add_string ("Entity name: ");
				st.add_string (entity_name);
				st.add_new_line;
			end;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_entity_name (s: STRING) is
		do
			entity_name := s
		end;

end -- class VTEC1
