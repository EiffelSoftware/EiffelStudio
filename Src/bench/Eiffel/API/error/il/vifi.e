indexing
	description: "Error when a class inherits from a frozen class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIFI

inherit
	ERROR

create
	make

feature {NONE} -- Initialization

	make (cl: CLASS_C) is
			-- Create error in class `cl'.
		require
			cl_not_void: cl /= Void
		do
			class_c := cl
		ensure
			class_c_set: class_c = cl
		end

feature -- Access

	class_c: CLASS_C
			-- Class in which error occurred.

	parent_class: CLASS_C
			-- Class from which user tries to inherit from in `class_c'.

feature -- Properties

	code: STRING is "VIFI"
		-- Error code

feature -- Setting

	set_parent_class (cl: CLASS_C) is
		require
			cl_not_void: cl /= Void
		do
			parent_class := cl
		ensure
			parent_class_set: parent_class = cl
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Class: ")
			class_c.append_signature (st)
			st.add_string (" inherit from frozen class ")
			parent_class.append_signature (st)			
			st.add_new_line
		end

end -- class VIFI
