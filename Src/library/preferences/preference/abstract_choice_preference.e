deferred class
	ABSTRACT_CHOICE_PREFERENCE [G]

inherit
	PREFERENCE

feature -- Status report

	is_valid_string_for_selection (s: READABLE_STRING_32): BOOLEAN
			-- <Precursor>
		do
			Result := has_value and then value_as_list_of_text.has (s)
		ensure then
			Result implies has_value
			Result implies value_as_list_of_text.has (s)
		end

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
			-- `value' as list of strings.
		require
			has_value
		deferred
		end

feature -- Formatting

	escaped_string (s: STRING_32): STRING_32
		deferred
		end

feature -- Modification

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		require
			index_valid: a_index > 0
		deferred
		ensure
			index_set: selected_index = a_index
		end

	select_value_from_string (s: READABLE_STRING_32)
			-- <Precursor>
		do
			across
				value_as_list_of_text as v
			loop
				if v.same_string (s) then
					set_selected_index (@ v.target_index)
				end
			end
		ensure then
			value_as_list_of_text [selected_index].same_string (s)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
