indexing
   description:	""
   status:	"See notice at end of class."
   author:	"Andreas Leitner"
   note:        "";

class
   TOE_TREE_FACTORY

inherit
   EXPAT_EVENT_FACTORY
   
feature {ANY} -- Creation
   
   create_tree_parser: XML_TREE_PARSER is
	 -- Create a tree based parser
      do
	 !! Result.make_from_imp (create_tree_parser_imp)
      end
   
   create_tree_parser_imp: XML_TREE_PARSER_I is
	 -- Create a tree based parser implementation
      do
	 !TOE_TREE_PARSER! Result.make_from_imp (create_event_parser_imp)
      end
   
end -- class TOE_TREE_FACTORY
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
