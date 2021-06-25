deferred class
	CHOICE_PREFERENCE [G]

inherit
	LIST_PREFERENCE [G]
		undefine
			is_valid_string_for_selection,
			select_value_from_string
		redefine
			text_value,
			set_value_from_string,
			generating_preference_type,
			string_type,
			escaped_characters
		end

	ABSTRACT_CHOICE_PREFERENCE [G]

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.
		local
			i: INTEGER
			s: like item_to_string_representation
		do
			create Result.make_empty
			if attached value as lst then
				i := 0
				across
					lst as c
				loop
					i := i + 1
					if attached c as l_item then
						if not Result.is_empty then
							Result.append_character (';')
						end
						s := escaped_string (item_to_string_representation (l_item))
						if i = selected_index then
							s := s.twin
							s.prepend_character ('[')
							s.append_character (']')
						end
						Result.append_string_general (s)
					end
				end
			else
				check has_value: False end
				create Result.make_empty
			end
		end

	escaped_characters: LIST [CHARACTER_32]
			-- Escaped characters to avoid issue with item separator, and selection markers.
		once
			Result := Precursor
			Result.extend ('[')
			Result.extend (']')
		end

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "CHOICE"
		end

	selected_value_as_text: detachable STRING_32
		do
			if attached selected_value as v then
				Result := item_to_string_representation (v)
			end
		end

	selected_value: detachable G
			-- Value of the selected index.
		do
			if
				(attached value as l_value) and then
				l_value.valid_index (selected_index)
			then
				Result := l_value.i_th (selected_index)
			end
		end

	selected_index: INTEGER
			-- Selected index from list.

feature -- Change

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		local
			l_value: like value
			s: STRING_32
			i: INTEGER
		do
			l_value := new_value
			internal_value := l_value
			if
				attached splitted_strings (a_value.to_string_32) as l_parts and then
				not l_parts.is_empty and then
				(l_parts.count > 1 or not l_parts.first.is_empty)
			then
				i := 1
				across
					l_parts as c
				loop
					s := c
					if not s.is_empty and then s.item (1) = '[' and then s.item (s.count) = ']' then
						s := s.substring (2, s.count - 1)
						selected_index := i
					end
					l_value.force (item_from_string_representation (unescaped_string (s)))
					i := i + 1
				end
			end
			set_value (l_value)
		end

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		do
			selected_index := a_index
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "COMBO"
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
