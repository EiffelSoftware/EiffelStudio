class
   C_STRING_HELPER
inherit
   C_STRING_HELPER_NP

feature {NONE} -- externals

   make_string_from_c_zero_terminated_string_safe (psz: POINTER): STRING is
	 -- Same as `make_string_from_c_zero_terminated_string', 
	 -- except you may give it a `default_pointer' - in that case 
	 -- it will give you back Void
      do
	 if
	    psz /= default_pointer
	  then
	    Result := make_string_from_c_zero_terminated_string (psz)
	 end
      end
   
   make_ucstring_from_c_utf8_zero_terminated_string_safe (psz: POINTER): UCSTRING is
	 -- Same as `make_string_from_c_zero_terminated_string', 
	 -- except you may give it a `default_pointer' - in that case 
	 -- it will give you back Void
      do
	 if
	    psz /= default_pointer
	  then
	    Result := make_ucstring_from_c_utf8_zero_terminated_string (psz)
	 end
      end
   
   make_ucstring_from_c_utf8_zero_terminated_string (psz: POINTER): UCSTRING is
	 -- Returns an Eiffel STRING object created from a zero terminated C
	 -- String located at `psz'.
	 -- The string is copied so the memory allocated at `psz' may be
	 -- freed without affecting the returned string.
	 -- The C String is assumed to be in utf8 format
      require
	 psz_valid: psz /= default_pointer
      do
	 !! Result.make_from_utf8 (make_string_from_c_zero_terminated_string (psz))
      end

   make_ucstring_from_c_utf8_runlength_string (ps: POINTER; length: INTEGER): UCSTRING is
	 -- Returns an Eiffel UCSTRING object created from a runlength
	 -- C string encoded in UTF8. The string is copied so the memory allocated at
	 -- `ps' may be freed without affecting the returned string.
      require
	 ps_not_default: ps /= default_pointer
	 positive_length: length >= 0
      do
	 !! Result.make_from_utf8 (make_string_from_c_runlength_string (ps, length))
      end
   
   
   
end -- C_STRING_HELPER
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
