indexing
	description: "Objects that give the interface for%
			  %database operation."
	author: "Lionel Moro"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_OPERATION

inherit

	ROW_TABLE

	INTERNAL

feature -- Access

	store (object: ANY) is
		require
			object_exists: object /= Void
			known_object: rows.has (class_name (object))
		local
			row: DB_ROW
		do
			row := rows.item (class_name (object))
			row.store (object)
		end


end -- class DATABASE_OPERATION
