class
	CHARACTER_ARRAY
inherit
	CHARACTER_ARRAY_ABS
creation
	make_from_c
feature {NONE} -- Initialisation
	make_from_c (content_ptr: POINTER; len: INTEGER) is
		require
			content_ptr_not_void: content_ptr /= Void
			len >= 0
      local
			needed: INTEGER;
			ptr: POINTER
      do
			lower := 1;
			upper := len;
			needed := len;

			-- allocate storage space
			-- TODO: could be simplified, for now code has just been copied from ARRAY.make
			if needed > 0 then
				if capacity < needed then
					storage := storage.calloc(needed);
					capacity := needed;
				else
					clear_all;
				end;
			end;
			
			-- copy data
			ptr := mem_cpy (storage.to_external, content_ptr, len)
      end;

feature {NONE} -- Externals

	mem_cpy (dest, src: POINTER; c: INTEGER): POINTER is
			-- dirty old memcpy stub, to do some low level C stuff in Eiffel
		external
			"C"
		alias
			"memcpy_wrap"
		end
end -- class CHARACTER_ARRAY
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