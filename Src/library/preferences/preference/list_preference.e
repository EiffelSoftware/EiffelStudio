note
	description: "Summary description for {LIST_PREFERENCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIST_PREFERENCE [G]

inherit
	TYPED_PREFERENCE [LIST [G]]

feature -- Access

	value_as_array: ARRAY [G]
			-- `value' as an ARRAY [G]
			-- to ease migration from ARRAY_PREFERENCE to LIST_PREFERENCE
		local
			lst: like value
			i: INTEGER
		do
			lst := value
			if lst.is_empty then
				create Result.make_empty
			else
				i := 1
				create Result.make_filled (lst.first, i, i + lst.count - 1)
				across
					lst as c
				loop
					Result.put (c.item, i)
					i := i + 1
				end
			end
		ensure
			value_unmodified: value.count = old (value.count)
			same_count: Result.count = value.count
			same: not value.is_empty implies (across value as c all c.item ~ Result[Result.lower + c.target_index - c.first_index] end)
		end

feature {PREFERENCE, PREFERENCE_WIDGET, PREFERENCES_STORAGE_I, PREFERENCE_VIEW} -- Access

	text_value: STRING_32
			-- String representation of `value'.				
		local
			index: INTEGER
		do
			create Result.make_empty
			if attached value as lst then
				across
					lst as c
				loop
					if attached c.item as l_item then
						if not Result.is_empty then
							Result.append_character (item_separator)
						end
						Result.append_string_general (escaped_string (item_to_string_representation (l_item)))
					end
				end
			else
				check has_value: False end
				create Result.make_empty
			end
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

feature -- Access

	value_count: INTEGER
		do
			Result := value.count
		end

	value_as_list_of_text: LIST [STRING_32]
		local
			l_value: like value
			lst: ARRAYED_LIST [STRING_32]
		do
			l_value := value
			create lst.make (l_value.count)
			across
				l_value as c
			loop
				lst.force (item_to_string_representation (c.item))
			end
			Result := lst
		end

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "LIST"
		end

feature -- Change

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		local
			lst: LIST [STRING_32]
			values: ARRAYED_LIST [G]
			l_value: like value
		do
			l_value := new_value
			internal_value := l_value
			lst := splitted_strings (a_value.to_string_32)

			across
				lst as c
			loop
				if not c.item.is_empty then
					l_value.force (item_from_string_representation (unescaped_string (c.item)))
				end
			end
			set_value (l_value)
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := True
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

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

	new_value: LIST [G]
		deferred
		end

	auto_default_value: LIST [G]
			-- Value to use when Current is using auto by default (until real auto is set)
		deferred
		end

	item_to_string_representation (obj: G): STRING_32
			-- String representation of `obj'.
		deferred
		end

	item_from_string_representation (s: STRING_32): G
			-- Item from string representation `s'.
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
