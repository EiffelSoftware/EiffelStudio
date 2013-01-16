note
	description: "Summary description for {ABSTRACT_ARRAY_PREFERENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_ARRAY_PREFERENCE [G -> READABLE_STRING_GENERAL]

inherit
	TYPED_PREFERENCE [ARRAY [G]]

	ABSTRACT_CHOICE_PREFERENCE [G]

feature {PREFERENCE_EXPORTER} -- Access

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
							Result.append (escaped_string (l_item.to_string_32))
							Result.append_character (']')
						else
							Result.append (escaped_string (l_item.to_string_32))
						end
						if not (index = l_array.count) then
							Result.append_string_general (";")
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

	value_as_list_of_text: LIST [STRING_32]
		local
			l_value: like value
		do
			l_value := value
			create {ARRAYED_LIST [STRING_32]} Result.make (l_value.count)
			across
				l_value as c
			loop
				Result.force (c.item.to_string_32)
			end
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

	selected_value_as_text: detachable STRING_32
		do
			if attached selected_value as v then
				Result := v.to_string_32
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
--		require
--			index_valie: a_index > 0
--			is_choice: is_choice
		do
			check is_choice: is_choice end
			selected_index := a_index
--		ensure
--			index_set: selected_index = a_index
		end

feature -- Status report

	is_choice: BOOLEAN
			-- Is this preference a single choice or the full list?

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := True
		end

feature {NONE} -- Formatting

	item_separator: CHARACTER_32 = ';'

	escape_character: CHARACTER_32 = '%%'

	escaped_characters: LIST [CHARACTER_32]
			-- Escaped characters to avoid issue with item separator, and selection markers.
		once
			create {ARRAYED_LIST [CHARACTER_32]} Result.make (2)
			Result.extend (item_separator)
			Result.extend (escape_character)
			Result.extend ('[')
			Result.extend (']')
		end

feature -- Formatting

	escaped_string (s: STRING_32): STRING_32
			-- Escaped string `s' to avoid issue with `item_separator' (i.e  ';')
		local
			i,n: INTEGER
			c: CHARACTER_32
			l_escaped_characters: like escaped_characters
		do
			from
				i := 1
				n := s.count
				create Result.make (n)
				l_escaped_characters := escaped_characters
			until
				i > n
			loop
				c := s[i]
				if i < n then
					if l_escaped_characters.has (c) then
						Result.append_character (escape_character)
					end
				end
				Result.append_character (c)
				i := i + 1
			end
		end

	unescaped_string (s: STRING_32): STRING_32
		local
			i,n: INTEGER
			c: CHARACTER_32
		do
			from
				i := 1
				n := s.count
				create Result.make (n)
			until
				i > n
			loop
				c := s[i]
				if c = escape_character and i < n then
					if escaped_characters.has (s[i+1]) then
						i := i + 1
						c := s[i]
					end
				end
				Result.append_character (c)
				i := i + 1
			end
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

	splitted_strings (s: STRING_32): ARRAYED_LIST [STRING_32]
		local
			i, p, n: INTEGER
			c: CHARACTER_32
		do
			create Result.make (0)
			from
				i := 1
				p := 1
				n := s.count
			until
				i > n
			loop
				c := s[i]
				if c = escape_character then -- escape character
					i := i + 1
				elseif c = item_separator then
					Result.extend (s.substring (p, i - 1))
					p := i + 1
				end
				i := i + 1
			end
			if i > p then
				Result.extend (s.substring (p, i - 1))
			end
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
