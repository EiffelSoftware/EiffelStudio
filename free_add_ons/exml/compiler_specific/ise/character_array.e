class
	CHARACTER_ARRAY
inherit
	CHARACTER_ARRAY_ABS
creation
	make_from_c
feature {NONE} -- Initialisation
	make_from_c (content_ptr: POINTER; len: INTEGER) is
		local
			ptr: POINTER
		do
			make_area (len)
			ptr := mem_cpy ($area, content_ptr, len)
			lower := 1;
			upper := len;

		end
feature {NONE} -- Externals

	mem_cpy (dest, src: POINTER; c: INTEGER): POINTER is
			-- copies 'c' bytes from 'src' to 'dest'
		external
			"C [macro <memory.h>] (EIF_POINTER, EIF_POINTER, EIF_INTEGER): EIF_POINTER"
		alias
			"memcpy"
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