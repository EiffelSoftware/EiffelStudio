indexing
	description: "Objects that process `text' to include extra hidden characters %
		%at the Windows level."
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

	text: STRING is
			-- Text displayed in `Current'.
		do
			if text_length > 0 then
				Result := wel_text
				unescape_ampersands (Result)
			end
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (escaped_text (a_text))
		end

feature {NONE} -- Implementation

	escaped_text (s: STRING): STRING is
			-- `text' with doubled ampersands.
		do
			if s /= Void then
				Result := clone (s)
				escape_ampersands (Result)
			end
		end

	escape_ampersands (s: STRING) is
			-- Replace all occurrences of "&" with "&&".
			--| Cannot be replaced with {STRING}.replace_substring_all because
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
					s.insert ("&", n)
					n := n + 2
				else
					n := s.count + 1
				end
			end
		ensure
			ampersand_occurrences_doubled: s.occurrences ('&') =
				(old clone (s)).occurrences ('&') * 2
		end

	unescape_ampersands (s: STRING) is
			-- Replace all occurrences of "&&" with "&".
			--| Cannot be replaced with {STRING}.replace_substring_all because
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
						is_escaped_string: (s @ n) = '&'
					end
					n := n + 1
				else
					n := s.count + 1
				end
			end
		ensure
			ampersand_occurrences_halved: (old clone (s)).occurrences ('&') =
				s.occurrences ('&') * 2
		end

end -- class EV_INTERNALLY_PROCESSED_TEXTABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

