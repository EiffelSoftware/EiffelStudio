class
	XML_TAG
inherit
	XML_TAG_ABS
creation
	make_from_c
feature {NONE} -- Initialisation
	make_from_c (name_ptr: POINTER) is
		do
			!! name.make (0)
			name.from_c (name_ptr)
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