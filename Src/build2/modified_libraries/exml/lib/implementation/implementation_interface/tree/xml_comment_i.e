indexing
   description: "class representing xml comment"
   status:	"See notice at end of class.";
   author:	"Andreas Leitner";

deferred class 
   XML_COMMENT_I
inherit
   XML_NODE_I

feature {ANY} -- Access

   data: UCSTRING is
	 -- the actual character data of this comment.
      deferred
      end
   
   
invariant
   data_not_void: data /= Void        
end -- XML_COMMENT_I

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
