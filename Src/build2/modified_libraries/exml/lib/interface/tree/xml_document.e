indexing
   description:    "Root object for a XML Document";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class
   XML_DOCUMENT
inherit
   XML_COMPOSITE
      redefine
	 implementation
      end	
creation
   make_from_imp
   
feature {ANY} -- Access
   -- document_type: XML_DOCUMENT_TYPE
   -- TODO: Implement!
   
   
   root_element: XML_ELEMENT is
	 -- root element of document.
      do
	 Result := implementation.root_element
      end
   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_document (Current)
      end
   
   

feature {NONE} -- Implementation
   implementation: XML_DOCUMENT_I
   
   
   
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
