indexing
   description:	"A tree based XML Parser using any XML_EVENT_PARSER implementation as back end."
   status:	"See notice at end of class."
   author:	"Andreas Leitner"
   note:	"Although it is not DOM (Level 1) conforming, it has %
   %been writen with DOM in mind. I prefer to have this %
   %parser follow the Eiffel design guide lines";
class
   TOE_DOCUMENT

inherit
   XML_DOCUMENT_I
      undefine
	 has,
	 is_equal,
	 copy,
	 occurrences
      end
   
   TOE_COMPOSITE
   
creation
   make
   
end -- class TOE_DOCUMENT
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
