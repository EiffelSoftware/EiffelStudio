note
	description: "Summary description for {CMS_SELECTABLE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SELECTABLE

inherit

	CMS_IDEABLE

feature -- Access

	selected_id: INTEGER

	synopsis: READABLE_STRING_32
			-- A brief statement given a general view of current.
		deferred
		end

feature -- Status Report

	is_selected : BOOLEAN
			-- Is the current element selected?
		do
			Result := id = selected_id
		end

feature -- Element Change

	set_selected_id (a_val: INTEGER)
			-- Set `selected_id' with `a_val'.
		require
			id_positive: a_val >= 0
		do
			selected_id := a_val
		ensure
			selected_id_set: selected_id = a_val
		end

	set_synopsis (a_synopsis: like synopsis)
			-- Set `synopsis' with `a_synopsis'.		
		deferred
		ensure
			synopsis_set: synopsis.same_string (a_synopsis)
		end

end
