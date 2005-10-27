indexing

	description: 
		"Error for invalid expanded type.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VTEC

inherit

	FEATURE_ERROR
		undefine
			subcode
		redefine
			build_explain
		end
	
feature -- Properties

	code: STRING is "VTEC"
			-- Error code

	entity_name: STRING
			-- Entity name for source of error

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if entity_name /= Void then
				st.add_string ("Entity name: ")
				st.add_string (entity_name)
				st.add_new_line
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_entity_name (s: STRING) is
		do
			entity_name := s
		end

end
