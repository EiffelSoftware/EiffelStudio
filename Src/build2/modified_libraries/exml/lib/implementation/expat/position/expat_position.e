indexing
   description:	""
   status:			"See notice at end of class."
   author:			"Andreas Leitner"
   note:				"Although it is not DOM (Level 1) conforming, it has %
   %been writen with DOM in mind. I prefer to have this %
   %parser follow the Eiffel design guide lines";
class
   
   EXPAT_POSITION

inherit
   XML_STREAM_POSITION

creation
   make

feature {ANY} -- Initialisation
   make (a_source: XML_SOURCE; a_byte_index, a_column, a_row: INTEGER;) is
      require
	 a_byte_index_positive: a_byte_index >= 0
	 a_column_positive: a_column >= 0
	 a_row_positive: a_row >= 0
      do
	 source := a_source
	 byte_index := a_byte_index
	 column := a_column
	 row := a_row
      ensure
	 source_set: source = a_source
	 byte_index_set: byte_index = a_byte_index
	 column_set: column = a_column
	 row_set: row = a_row
      end
   
feature {ANY} -- Access
   source: XML_SOURCE
	 -- file that the element resides in.      
   
   byte_index: INTEGER
	 -- character position of token in file.
   
   column: INTEGER
	 -- column of token in file.
   
   row: INTEGER
	 -- column of token in file.
   

end -- class EXPAT_POSITION
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
