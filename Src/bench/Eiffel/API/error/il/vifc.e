indexing
	description	: "IL Full-name Conflict when two classes of system have same full-name."
	date: "$Date$"
	revision: "$Revision$"

class
	VIFC

inherit
	ERROR

create
	make

feature {NONE} -- Initialization

	make (a_list: SEARCH_TABLE [CLASS_C]; a_full_name: STRING) is
			-- Create error which collects all classes of `a_list'
			-- sharing same `a_full_name'.
		require
			a_list_not_void: a_list /= Void
			a_full_name_not_void: a_full_name /= Void
		do
			classes := a_list
			full_name := a_full_name
		ensure
			classes_set: classes = a_list
			full_name_set: full_name = a_full_name
		end

feature -- Access

	classes: SEARCH_TABLE [CLASS_C]
			-- Classes in which error occurred.

	full_name: STRING
			-- Full name on which there is a conflict.

feature -- Properties

	code: STRING is "VIFC"
		-- Error code
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Following classes have same IL full name `")
			st.add_string (full_name)
			st.add_string ("'")
			st.add_new_line
			from
				classes.start
			until
				classes.after
			loop
				st.add_string ("Class: ")
				classes.item_for_iteration.append_signature (st)
				st.add_new_line
				classes.forth
			end
		end

end -- class VIFC
