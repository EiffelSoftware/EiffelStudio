note
	description: "Summary description for {ABSTRACT_CHOICE_PREFERENCE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_CHOICE_PREFERENCE [G]

inherit
	PREFERENCE

feature -- Access	

	selected_value_as_text: detachable STRING_32
		deferred
		end

	selected_value: detachable G
			-- Value of the selected index.
		deferred
		end

	selected_index: INTEGER
			-- Selected index from list.
		deferred
		end

	value_as_list_of_text: LIST [STRING_32]
			-- `value' as list of strings
		deferred
		end

feature -- Formatting

	escaped_string (s: STRING_32): STRING_32
		deferred
		end

feature -- Change

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		require
			index_valid: a_index > 0
		deferred
		ensure
			index_set: selected_index = a_index
		end

end
