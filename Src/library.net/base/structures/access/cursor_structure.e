indexing
	description: "[
					Active structures, which always have a current position
					accessible through a cursor.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.CursorStructure"

deferred class
	CURSOR_STRUCTURE [G]

inherit
	ACTIVE [G]

feature -- Access

	cursor: CURSOR is
		indexing
			description: "Current cursor position"
		deferred
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
		deferred
		end

feature -- Cursor movement

	go_to (p: CURSOR) is
		indexing
			description: "Move cursor to position `p'."
		require
			cursor_position_valid: valid_cursor (p)
		deferred
		end

end -- class CURSOR_STRUCTURE



