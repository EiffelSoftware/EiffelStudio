indexing
	description	: "Associated XML file of an external class is unreadable."
	date: "$Date$"
	revision: "$Revision$"

class
	VIIC

inherit
	ERROR

create
	make

feature {NONE} -- Initialization

	make (a_class: EXTERNAL_CLASS_C) is
			-- Create instance of current with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			external_class := a_class
		ensure
			external_class_set: external_class = a_class
		end

feature -- Access

	external_class: CLASS_C
			-- External class whose XML content is not readable.

feature -- Properties

	code: STRING is "VIIC"
		-- Error code
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Could not analyze class ")
			external_class.append_signature (st)
			st.add_string (".")
			st.add_new_line
		end

end -- class VIIC
