indexing
	description:"Table of XML-attributes"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

class
	XML_ATTRIBUTE_TABLE

inherit
	DS_HASH_TABLE [XML_ATTRIBUTE, STRING]
		rename
			make as make_hash_table
		end
creation
	make

feature -- Initialization

	make is
			-- Initialize
		do
			make_hash_table (3)			
		end
feature
	add_attribute (v: XML_ATTRIBUTE) is
		require
			v_not_void: v /= Void
		do
			force (v, v.name)
		end
end -- class XML_ATTRIBUTE_TABLE
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