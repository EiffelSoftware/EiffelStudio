indexing
   description: "class representing xml comment"
   status:	"See notice at end of class.";
   author:	"Andreas Leitner";

class 
   XML_COMMENT
inherit
   XML_NODE
      redefine
	 implementation
      end
creation
   make_from_imp

feature {ANY} -- Access

   data: UCSTRING is
	 -- the actual character data of this comment.
      do
	 Result := implementation.data
      end
   
feature {ANY} -- Basic Routines   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_comment (Current)
      end
   
feature {ANY} -- Element change


feature {NONE} -- Implementation
   implementation: XML_COMMENT_I

invariant
   data_not_void: data /= Void        
end -- XML_COMMENT

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
