indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_INHERIT_ERROR

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
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
			-- Class in which error occured.

	parent_class: CLASS_C
			-- Class from which user tries to inherit from in `class_c'.

feature -- Properties

	code: STRING is "IL_inherit_error"
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
			st.add_string ("inherit from ")
			st.add_new_line
			parent_class.append_signature (st)			
		end

end -- class IL_INHERIT_ERROR
