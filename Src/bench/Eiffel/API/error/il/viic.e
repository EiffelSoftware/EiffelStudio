indexing
	description	: "Associated XML file of an external class is unreadable."
	date: "$Date$"
	revision: "$Revision$"

class
	VIIC

inherit
	EIFFEL_ERROR
		redefine
			build_explain, class_c
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like class_c) is
			-- Create instance of current with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			class_c := a_class
		ensure
			class_c_set: class_c = a_class
		end
		
feature -- Access

	class_c: EXTERNAL_CLASS_C
			-- Class where error is encountered.

feature -- Properties

	code: STRING is "VIIC"
		-- Error code
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Could not analyze .NET class ")
			class_c.append_signature (st, False)
			st.add_string (".")
			st.add_new_line
		end

end -- class VIIC
