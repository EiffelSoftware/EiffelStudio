class
	XML_TAG
inherit
	XML_TAG_ABS
	C_STRING_HELPER
feature {NONE} -- Initialisation
	make_from_c (name_ptr: POINTER) is
		do
				-- TODO: copy string first
			create_copy_of_string_from_zstring (name_ptr)
			name := last_string
		end
end -- class XML_TAG
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