indexing
   description:	""
   status:			"See notice at end of class."
   author:			"Andreas Leitner"
   note:			"";
deferred class
   XML_TREE_FACTORY

feature {ANY} -- Creation
   
   create_tree_parser: XML_TREE_PARSER is
	 -- Create a tree based parser
      deferred
      end
   
   create_tree_parser_imp: XML_TREE_PARSER_I is
	 -- Create a tree based parser implementation
      deferred
      end
   
end -- class XML_TREE_FACTORY
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
