indexing
	description: 
		"Eiffel Vision textable. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
	
feature -- Access

	text: STRING is
			-- Text displayed in label.
		do
			Result := wel_text
			if Result /= Void then
				if Result.empty then
					Result := Void
				else
					unescape_ampersands (Result)
				end
			end
		end 

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (escaped_text (a_text))
		end

	remove_text is
			-- Make `text' `Void'.
		do
			set_text ("")
		end

feature {NONE} -- Implementation

	wel_set_text (a_text: STRING) is
			-- Set `a_text' in WEL object.
		deferred
		end

	wel_text: STRING is
			-- Text from WEL object.
			-- Note: may be Void.
		deferred
--		ensure
--			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

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
			ampersand_occurrences_doubled: (old clone (s)).occurrences ('&') =
				s.occurrences ('&') * 2
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
			ampersand_occurrences_halved: s.occurrences ('&') =
				(old clone (s)).occurrences ('&') * 2
		end

	line_count: INTEGER is
			-- Number of lines `text' uses.
		do
			if text /= Void then
				Result := text.occurrences ('%N') + 1
			end
		ensure
			non_negative: Result >= 0
		end

feature -- Obsolete

	safe_text: STRING is
			-- Convenience function for Windows implementation.
			-- Returns `text' but if `Void' returns empty string.
		obsolete
			"Just use `wel_text'."
		do
			Result := wel_text
		ensure
			not_void: Result /= Void
		end

	set_default_minimum_size is
			-- Set to the size of the text.
		obsolete
			"Implement using {EV_FONT_IMP}.text_metrics."
		do
			check
				inapplicable: False
			end
		end

end -- class EV_TEXTABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.19  2000/03/29 07:00:49  pichery
--| Commented bad postcondition after discussion with Sam.
--| Should be fixed by Vincent.
--|
--| Revision 1.18  2000/03/28 22:11:41  brendel
--| Added check for Void string.
--|
--| Revision 1.17  2000/03/28 00:04:23  brendel
--| Revised.
--| Changed feature order and comments with _I.
--| Removed redundant deferred redeclaration of align_* features.
--| Added deferred wel_set_text and wel_text, to be implemented by WEL object.
--| Added set_text, that uses wel_set_text to pass filtered text. See code.
--| Added text, that uses wel_text to retreive text with inverted filter.
--| Declared safe_text obsolete. wel_text can be used instead.
--|
--| Revision 1.16  2000/03/03 00:55:10  brendel
--| Added feature `line_count'.
--| Formatted for 80 columns.
--|
--| Revision 1.15  2000/02/25 18:03:26  brendel
--| Added feature `safe_text' that never returns a Void string.
--|
--| Revision 1.14  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.3  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.2  2000/01/10 17:15:32  rogers
--| The three alignment functions names have been changed to the format
--| set_*****_algnment. Remove text has been implemented.
--|
--| Revision 1.12.6.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
