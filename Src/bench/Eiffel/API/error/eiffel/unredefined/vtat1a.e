indexing
	description: ""
	date: "$Date$"
	revision: "$Revision $"

class VTAT1A 

inherit
	VTAT1
		redefine
			build_explain
		end

feature -- Properties

	argument_name: STRING;
			-- Argument name which anchored type in unvalid

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Anchor name: ")
			st.add_string (argument_name)
			st.add_new_line
			{VTAT1} Precursor (st)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_argument_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s
		end

end -- class VTAT1A
