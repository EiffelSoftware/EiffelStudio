indexing
	description: "Error when a local type violated the constrained %
				%genericity validity rule."
	date: "$Date$"
	revision: "$Revision $"

class VTCG3 

inherit
	VTCG
		redefine
			build_explain
		end

feature -- Properties

	entity_name: STRING

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if entity_name /= Void then
				st.add_string ("Entity name: ")
				st.add_string (entity_name)
				st.add_new_line
			end
			{VTCG} Precursor (st)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_entity_name (s: STRING) is
		do
			entity_name := s
		end

end -- class VTCG3
