class
   C_STRING_HELPER_NP
feature {NONE} -- externals

   make_string_from_c_zero_terminated_string (psz: POINTER): STRING is
	 -- Returns an Eiffel STRING object created from a zero terminated C
	 -- String located at `psz'.
	 -- The string is copied so the memory allocated at `psz' may be
	 -- freed without affecting the returned string.
      require
	 psz_valid: psz /= Void and then psz /= default_pointer
      do
	 !! Result.from_external (psz)
	 Result := clone (Result)
	 -- Well, I hope this implementation really works always ?!
      end
   
   make_string_from_c_runlength_string (ps: POINTER; len: INTEGER): STRING is
	 -- Returns an Eiffel STRING object created from a runlength
	 -- C string. The string is copied so the memory allocated at
	 -- `ps' may be freed without affecting the returned string.
      require
	 ps_valid: ps /= default_pointer
	 len_valid: len > 0
      local
	 ptr: POINTER
	 storage: NATIVE_ARRAY[CHARACTER];
	 i: INTEGER
      do
	 storage := storage.calloc(len);
	 -- copy data
	 ptr := mem_cpy (storage.to_external, ps, len)
	 create Result.make (len)
	 from
	    i := 0
	 until
	    i = len
	 loop
	    Result.append_character (storage.item (i))
	    i := i + 1
	 end
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
   
   mem_cpy (dest, src: POINTER; c: INTEGER): POINTER is
	 -- copies 'c' bytes from 'src' to 'dest'.
	 -- This causes a lot of warnings during the C-compilation.
	 -- If you can fix this, please send me a patch.
      external
	 "C"
      alias
	 "exml_memcpy"
      end
   

end -- C_STRING_HELPER_NP
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
