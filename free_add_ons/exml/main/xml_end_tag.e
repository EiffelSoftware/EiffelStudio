indexing
	description:"Objects representing a XML-end-tag"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"
class
	XML_END_TAG
inherit
	XML_TAG
		redefine
			out
		end
creation
	make_from_c

feature
	out: STRING is
		do
			!! Result.make (0)
			Result.append ("</")
			Result.append (name)
			Result.append (">")
		end


end -- class XML_END_TAG
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner
 and others
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