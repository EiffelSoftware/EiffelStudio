note
	description: "Summary description for {WIKI_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_FACTORY

inherit
	WIKI_LIST_FACTORY

feature -- Factory

	new_indentation (s: READABLE_STRING_8): WIKI_INDENTATION
			-- wiki Indentation object creation from first chars.
			-- It ignores the rest of the string.
		require
			s.starts_with_general (":")
		local
			i,n: INTEGER
			lev: NATURAL
		do
			from
				i := 1
				n := s.count
				lev := 0
			until
				s[i] /= ':' or i > n
			loop
				lev := lev + 1
				i := i + 1
			end
			create Result.make (lev)
		end

	new_indented_string (s: READABLE_STRING_8): WIKI_INDENTATION
			-- New indented string from `s'.
			-- `s' is expected to start with sequence of colons such as "::text".
		require
			s.starts_with_general (":")
		local
			lev: NATURAL
		do
			Result := new_indentation (s)
			lev := Result.indentation_level
			Result.append_text (s.substring (lev.to_integer_32 + 1, s.count))
--			Result.add_element (new_string_item (s.substring (lev.to_integer_32 + 1, s.count)))
		end

	new_string_item (s: READABLE_STRING_8): WIKI_STRING
		do
			if s = Void then
				create Result.make ("")
			else
				create Result.make (s)
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
