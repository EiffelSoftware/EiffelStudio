indexing
	description: "Error when a class performs inheritance of a frozen class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIFI1

inherit
	VIFI
		redefine
			subcode
		end

create
	make

feature -- Access

	subcode: INTEGER is 1
			-- Identifier for VIFI error.

	parent_class: CLASS_C
			-- Class from which user tries to inherit from in `class_c'.

feature -- Setting

	set_parent_class (cl: CLASS_C) is
			-- Set `parent_class' with `cl'.
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
			check
				parent_class_set: parent_class /= Void
			end
			st.add_string ("Class ")
			class_c.append_signature (st)
			st.add_string (" inherit from frozen class ")
			parent_class.append_signature (st)			
			st.add_new_line
		end

end -- class VIFI1
