note
	description: "Objects that process `text' to include extra hidden characters %
		%at the Windows level."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP

inherit
	EV_TEXTABLE_IMP
		redefine
			text,
			set_text
		end

feature -- Access

	text: STRING_32
			-- Text displayed in `Current'.
		do
			Result := unescaped_text (wel_text)
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			wel_set_text (escaped_text (a_text))
		end

feature {NONE} -- Implementation

	escaped_text (s: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- `text' with doubled ampersands.
		local
			n, l_count: INTEGER
			l_amp_code: NATURAL_32
			l_string_32: STRING_32
		do
			l_amp_code := ('&').code.as_natural_32
			l_count := s.count
			n := s.index_of_code (l_amp_code, 1)

			if n > 0 then
					-- There is an ampersand present in `s'.
					-- Replace all occurrences of "&" with "&&".
					--| Cannot be replaced with `{STRING_32}.replace_substring_all' because
					--| we only want it to happen once, not forever.
				from
					create l_string_32.make (l_count + 1)
					l_string_32.append_string_general (s)
				until
					n > l_count
				loop
					n := l_string_32.index_of_code (l_amp_code, n)
					if n > 0 then
						l_string_32.insert_character ('&', n)
							-- Increase count local by one as a character has been inserted.
						l_count := l_count + 1
						n := n + 2
					else
						n := l_count + 1
					end
				end
				Result := l_string_32
			else
				Result := s
			end
		ensure
			ampersand_occurrences_doubled: s.as_string_32.occurrences ('&') =
				(old s.twin.as_string_32).occurrences ('&') * 2
		end

	unescaped_text (s: STRING_32): STRING_32
			-- Replace all occurrences of "&&" with "&".
			--| Cannot be replaced with {STRING_32}.replace_substring_all because
			--| it will replace any number of ampersands with only one.
			--| Has to be a previously escaped string. Enforced with a check
			--| inside routine body.
		require
			s_not_void: s /= Void
		local
			n, l_count: INTEGER
		do
			from
				n := 1
				l_count := s.count
			until
				n > l_count
			loop
				n := s.index_of ('&', n)
				if n > 0 then
					s.remove (n)
					l_count := l_count - 1
					n := n + 1
				else
					n := l_count + 1
				end
			end
			Result := s
		ensure
			ampersand_occurrences_halved: old s.twin.occurrences ('&') = s.occurrences ('&') * 2
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_INTERNALLY_PROCESSED_TEXTABLE_IMP










