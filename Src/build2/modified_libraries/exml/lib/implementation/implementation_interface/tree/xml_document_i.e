indexing
   description:    "Root object for a XML Document";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

deferred class
   XML_DOCUMENT_I

inherit
   XML_COMPOSITE_I

feature {ANY} -- Access
   -- document_type: XML_DOCUMENT_TYPE
   -- TODO: Implement!

   root_element: XML_ELEMENT is
      do
	 -- Since a document must only have one child element it is
	 -- safe to take the first one.
	 Result := first_element
      end

feature {NONE} -- Implementation

   first_element: XML_ELEMENT is
      local
	 cs: like new_cursor
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off or Result /= Void
	 loop
	    Result ?= cs.item
	    cs.forth
	 end
      end

end -- XML_DOCUMENT_I

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