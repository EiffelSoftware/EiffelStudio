indexing
	description:    "Root object for a XML Document";
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

class
	XML_DOCUMENT
inherit
	ANY
		redefine
			out
		end		
feature
	-- document_type: XML_DOCUMENT_TYPE
	root_element: XML_ELEMENT
feature
	out: STRING is
		do
			!! Result.make (0);
			Result.append ("XML_DOCUMENT%N")
			if
				root_element /= Void
			then
					-- a root element does exist
				Result.append (root_element.out)
			else
					-- the document is empty
				Result.append ("the document is empty%N")
			end
			Result.append ("%NXML_DOCUMENT end%N")
		end
end -- XML_DOCUMENT

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