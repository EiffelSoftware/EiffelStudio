indexing
	description:"inherits from ARRAY [CHARACTER] and implements the %
					%functionality of beeing created from a C-type string%
					%with a length value"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

deferred class
	CHARACTER_ARRAY_ABS
inherit
	ARRAY [CHARACTER]
		redefine
			out
		end
feature {NONE} -- Initialisation
	make_from_c (content_ptr: POINTER; len: INTEGER) is
			-- make a ARRAY [CHARACTER] object from a C-type
			-- character array at 'content_ptr' with the length
			-- 'len'
			-- Note: the memory must be copied from
		require
			content_ptr_not_null: content_ptr /= default_pointer
			len >= 0
		deferred
      end

	make_from_string (a_string: STRING) is
		require
			a_string_not_void: a_string /= void
		local
			i: INTEGER
		do
			make (1, a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				put (a_string.item (i), i)
				i := i + 1
			end
		end

feature
	out: STRING is
		local
			i: INTEGER
		do
			from
				i := lower
				!! Result.make (0)
			until
				i > upper
			loop
				Result.append_character (item (i))
				i := i + 1
			end
		end
feature
	append (other: like Current) is
			-- append 'other' to Current
		require
			other /= Void
		local
			i: INTEGER		
		do
			from
				i := 1
			until
				i > other.count
			loop
				force (other.item (i), count + 1)
				i := i + 1
			end
		end

end -- class CHARACTER_ARRAY_ABS
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner
 and others
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