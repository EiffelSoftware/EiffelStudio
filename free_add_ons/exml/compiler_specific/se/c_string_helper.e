class
	C_STRING_HELPER
inherit
	C_STRING_HELPER_ABS
feature
	create_copy_of_string_from_zstring (c_string_ptr: POINTER) is
		do
				-- make Eiffel String object
			!! last_string.from_external (c_string_ptr)
				-- copy data
			last_string := clone (last_string)
				-- well, I hope this implementation really works allways
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