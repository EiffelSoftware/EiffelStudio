indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_LINE

inherit
--	LINKED_LIST[EDITOR_TOKEN]
--		rename
--			previous as previous_token,
--			next as next_token,
--			index as index_token
--		end

	TREE_ITEM
		rename
			tree as paragraph
		redefine
			paragraph
		end

create
	make

feature -- Access

	paragraph: PARAGRAPH

	first_token: EDITOR_TOKEN
		-- First token in the
	
	end_token: EDITOR_TOKEN
		-- Last token of the line. It is ALWAYS
		-- of type EDITOR_TOKEN_EOL

feature -- Element change

	set_width(a_width: INTEGER) is
		do
			width := a_width
		end

feature -- Status Report

	image: STRING
		-- string representation of the line.

	width: INTEGER
		-- x position of last pixel of the string

end -- class EDITOR_LINE
