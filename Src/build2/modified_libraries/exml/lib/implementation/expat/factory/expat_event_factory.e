indexing
   description:	""
   status:			"See notice at end of class."
   author:			"Andreas Leitner"
   note:			"";
class
   EXPAT_EVENT_FACTORY

feature {ANY} -- Creation
   
   create_event_parser: XML_EVENT_PARSER is
	 -- Create a event based parser
      do
	 !! Result.make_from_imp (create_event_parser_imp)
      end
   
   create_event_parser_imp: XML_EVENT_PARSER_I is
	 -- Create a event based parser implementation
      do
	 !EXPAT_EVENT_PARSER! Result.make
      end
   
end -- class EXPAT_EVENT_FACTORY
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
