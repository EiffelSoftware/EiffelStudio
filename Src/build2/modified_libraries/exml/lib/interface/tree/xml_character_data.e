indexing
   description: "common heir for xml-nodes that consist of character data"
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class 
   XML_CHARACTER_DATA
inherit
   XML_NODE
      redefine
	 implementation
      end
creation
   make_from_imp

feature {ANY} -- Access

   content: UCSTRING is
	 -- the actual character data of this node.
      do
	 Result := implementation.content
      end
   
feature {ANY} -- Basic Routines   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_character_data (Current)
      end
   
feature {ANY} -- Element change

   append_content (other: like Current) is
	 -- append the content of 'other' to 
	 -- the content of Current
      require
	 other /= Void
      do
	 implementation.append_content (other)
      end

feature {NONE} -- Implementation
   implementation: XML_CHARACTER_DATA_I

invariant
   content_not_void: content /= Void        
end -- XML_CHARACTER_DATA

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
