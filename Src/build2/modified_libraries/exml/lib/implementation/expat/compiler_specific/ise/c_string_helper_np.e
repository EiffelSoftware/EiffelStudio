class
   C_STRING_HELPER_NP
feature {NONE} -- externals

   make_string_from_c_zero_terminated_string (psz: POINTER): STRING is
	 -- Returns an Eiffel STRING object created from a zero terminated C
	 -- String located at `psz'.
	 -- The string is copied so the memory allocated at `psz' may be
	 -- freed without affecting the returned string.
      do
	 !! Result.make (0)
	 Result.from_c (psz)
      end

   make_string_from_c_runlength_string (ps: POINTER; length: INTEGER): STRING is
	 -- Returns an Eiffel STRING object created from a runlength
	 -- C string. The string is copied so the memory allocated at
	 -- `ps' may be freed without affecting the returned string.
      do
	 create Result.make (length)
	 Result.from_c_substring (ps, 1, length)
      end

   ptr_contents (ptr: POINTER): POINTER is
	 -- returns the contents of a pointer given 'ptr' is of the C-type void**
      external
	 "C [macro <exml_parser.h>]"
      end

   ptr_move (ptr: POINTER; pos: INTEGER): POINTER is
	 -- moves 'ptr' 'pos' characters further
      external
	 "C [macro <exml_parser.h>]"
      end
end
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------
