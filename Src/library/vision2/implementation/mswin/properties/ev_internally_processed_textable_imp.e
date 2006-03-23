indexing
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

	text: STRING_32 is
			-- Text displayed in `Current'.
		do
			Result := wel_text
			unescape_ampersands (Result)
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (escaped_text (a_text))
		end

feature {NONE} -- Implementation

	escaped_text (s: STRING_GENERAL): STRING_32 is
			-- `text' with doubled ampersands.
		do
			if s /= Void then
				Result := s.twin
				escape_ampersands (Result)
			end
		end

	escape_ampersands (s: STRING_32) is
			-- Replace all occurrences of "&" with "&&".
			--| Cannot be replaced with `{STRING_32}.replace_substring_all' because
			--| we only want it to happen once, not forever.
		require
			s_not_void: s /= Void
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > s.count
			loop
				n := s.index_of ('&', n)
				if n > 0 then
					s.insert_string ("&", n)
					n := n + 2
				else
					n := s.count + 1
				end
			end
		ensure
			ampersand_occurrences_doubled: s.occurrences ('&') =
				(old s.twin).occurrences ('&') * 2
		end

	unescape_ampersands (s: STRING_32) is
			-- Replace all occurrences of "&&" with "&".
			--| Cannot be replaced with {STRING_32}.replace_substring_all because
			--| it will replace any number of ampersands with only one.
			--| Has to be a previously escaped string. Enforced with a check
			--| inside routine body.
		require
			s_not_void: s /= Void
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > s.count
			loop
				n := s.index_of ('&', n)
				if n > 0 then
					s.remove (n)
					check
						is_escaped_string: (s.item (n)) = '&'
					end
					n := n + 1
				else
					n := s.count + 1
				end
			end
		ensure
			ampersand_occurrences_halved: old s.twin.occurrences ('&') = s.occurrences ('&') * 2
		end

indexing
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

