-- position to a xml token or node that comes from a stream
-- that means the token or node has at least the following attributes:
-- byte_index
-- column
-- row
deferred class
   
   XML_STREAM_POSITION

inherit
   XML_POSITION
      redefine
	 out
      end

feature {ANY} -- Access
   
   byte_index: INTEGER is
	 -- byte index of token in stream.
      deferred
      end
   
   column: INTEGER is
	 -- column of token in stream.
      deferred
      end 
   
   row: INTEGER is
	 -- column of token in stream.
      deferred
      end 
   
feature {ANY} -- Debug
   
   out: STRING is
      do
	 !! Result.make (0)
	 Result.append_string (" ln: ")
	 Result.append_string (row.out)
	 Result.append_string (" cl: ")
	 Result.append_string (column.out)
	 Result.append_string (" byte: ")
	 Result.append_string (byte_index.out)
	 Result.append_string (" -> ")
	 Result.append_string (source.out)
      end
invariant   
   byte_index_positive: byte_index > 0
   column_positive: column > 0
   row_positive: row > 0
end -- class XML_STREAM_POSITION
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
