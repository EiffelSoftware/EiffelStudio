indexing
	description: "Key generator for eBOOK page keys"
	status: "See notice at end of class."
	author: "Andreas Leitner"

class
	STRING_KEY_GENERATOR

inherit
	EBOOK_GLOBALS
creation
	make

feature -- Initialization

	make is
			-- Initialize
		do
		end
feature
	next_key is
		do
			key_base := key_base + 1
		end	
	last_key: STRING is
		do
			Result := key_base.out
			Result.prepend (page_key_prefix)
		end
feature {NONE} -- implementation
	key_base: INTEGER
end -- class STRING_KEY_GENERATOR
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