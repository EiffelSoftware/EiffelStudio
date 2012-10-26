note
	description: "Summary description for {ABSTRACT_ARRAY_PREFERENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_ARRAY_PREFERENCE [G -> READABLE_STRING_GENERAL]

inherit
	TYPED_PREFERENCE [ARRAY [G]]

feature {PREFERENCE, PREFERENCE_WIDGET, PREFERENCES_STORAGE_I, PREFERENCE_VIEW} -- Access

	text_value: STRING_32
			-- String representation of `value'.				
		local
			index: INTEGER
		do
			create Result.make_empty
			if attached value as l_array then
				from
					index := l_array.lower
				until
					index > l_array.upper
				loop
					if attached l_array.item (index) as l_item then
						if is_choice and then index = selected_index then
							Result.append_character ('[')
							Result.append_string_general (l_item)
							Result.append_character (']')
						else
							Result.append_string_general (l_item)
						end
						if not (index = l_array.count) then
							Result.append (";")
						end
					end
					index := index + 1
				end
			else
				check has_value: False end
				Result := ""
			end
		end

feature -- Access		

	string_type: STRING
			-- String description of this preference type.
		deferred
		end

	selected_value: detachable G
			-- Value of the selected index.
		do
			if
				(attached value as l_value) and then
				l_value.valid_index (selected_index)
			then
				Result := l_value.item (selected_index)
			end
		end

	selected_index: INTEGER
			-- Selected index from list.

feature -- Status Setting

	set_is_choice (a_flag: BOOLEAN)
			-- Set `is_choice' to`a_flag'.
		do
			is_choice := a_flag
			if selected_index = 0 then
				selected_index := 1
			end
		end

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		require
			index_valie: a_index > 0
			is_choice: is_choice
		do
			selected_index := a_index
		ensure
			index_set: selected_index = a_index
		end

feature -- Query

	is_choice: BOOLEAN
			-- Is this preference a single choice or the full list?

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := True
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		do
			if is_choice then
				Result := "COMBO"
			else
				Result := "TEXT"
			end
		end

feature {NONE} -- Implementation

	auto_default_value: ARRAY [G]
			-- Value to use when Current is using auto by default (until real auto is set)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
