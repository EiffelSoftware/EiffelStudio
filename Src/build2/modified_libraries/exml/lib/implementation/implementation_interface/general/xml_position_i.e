indexing
   description:	""
   status:			"See notice at end of class."
   author:			"Andreas Leitner"
   note:				"Although it is not DOM (Level 1) conforming, it has %
   %been writen with DOM in mind. I prefer to have this %
   %parser follow the Eiffel design guide lines";
deferred class
   
   XML_POSITION_I

inherit
   IMPLEMENTATION

feature {ANY} -- Access
   position: INTEGER is
	 -- character position of token in file. If information is not 
	 -- available to the parser this is set to 0. Otherwise it is 
	 -- a 1 based index.
      deferred
      ensure
	 not_negative: position >= 0
      end
   
   column: INTEGER is
	 -- column of token in file. If information is not 
	 -- available to the parser this is set to 0. Otherwise it is 
	 -- a 1 based index.
      deferred
      ensure
	 not_negative: position >= 0
      end 
   
   row: INTEGER is
	 -- column of token in file. If information is not 
	 -- available to the parser this is set to 0. Otherwise it is 
	 -- a 1 based index.
      deferred
      ensure
	 not_negative: position >= 0
      end 
   
   file_name: STRING is
	 -- file that the element resides in. This may be void if the 
	 -- origin of the tree is not a file, or the filename was not available.
      deferred
      end
   
   
end -- class XML_POSITION_I
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
