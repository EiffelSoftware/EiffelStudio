indexing
	description: "common heir for xml-nodes that consist of character data"
	status:			"See notice at end of class.";
	author:			"Andreas Leitner";

class 
	XML_CHARACTER_DATA
inherit
	XML_NODE
		rename
			make as make_node
		redefine
			out
		end
creation
	make_from_content
feature
	make_from_content (a_parent: XML_ELEMENT; a_content: CHARACTER_ARRAY) is
			-- create a this object from a object of the type
			-- CHARACTER_ARRAY with `a_parent' as parent element, that holds
			-- this XML-node
		require
			a_content_not_void: a_content /= Void
		do
			make_node (a_parent)
			content := clone (a_content)
		end
feature
	children_allowed: BOOLEAN is
			-- this object must not have children
		do
			Result := False
		end

	content: CHARACTER_ARRAY
			-- the actual character data of this node

	string: STRING is
			-- `content' transformed into a string.
			-- If `content' holds zero-characters
			-- `string' will be trucated at the
			-- first occurence of such a character
		do
			!! Result.make (0)
			Result.append (content.out)
		end

	out: STRING is
			-- formated text representation of
			-- `content'. Mosty needed for
			-- debuging.
			-- If `content' holds zero-characters
			-- `string' will be trucated at the
			-- first occurence of such a character
		do
			!! Result.make (0)
			Result.append ("[")
			Result.append (content.out)
			Result.append ("]")
		end
feature
	append_content (other: like Current) is
			-- append the content of 'other' to 
			-- the content of Current
		require
			other /= Void
		do
			content.append (other.content)
		end

invariant
	content_not_void: content /= Void        
end -- XML_CHARACTER_DATA

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