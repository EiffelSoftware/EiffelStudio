indexing
	description: "Cursors for hash table traversal"
	external_name: "ISE.Base.HashTableCursor"

class 
	HASH_TABLE_CURSOR

inherit

	CURSOR

create

	make

feature {NONE} -- Initialization

	make (pos: INTEGER) is
		indexing
			description: "Create a new cursor."
		do
			position := pos
		ensure
			position_set: position = pos
		end

feature {HASH_TABLE} -- Access

	position: INTEGER
		indexing
			description: "Cursor position"
		end

end -- class HASH_TABLE_CURSOR


