indexing
	description:"Objects representing a XML-tag"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"
deferred class
	XML_TAG_ABS
feature {NONE} -- Initialisation
	make_from_c (name_ptr: POINTER) is
			-- make a tag based on a zero-terminated C-string.
			-- Note: The string must be copied, 'name_ptr' is only
			-- guarantied to be valid inside this routine.
		require
			name_ptr_not_null: name_ptr /= default_pointer
			-- 'name_ptr' must be a zero-terminated
		deferred
		ensure
			name_not_void: name /= Void
		end
feature -- Access
	name: STRING
		-- stores the tag-name
invariant
	name_not_void: name /= Void
end -- class XML_TAG_ABS
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