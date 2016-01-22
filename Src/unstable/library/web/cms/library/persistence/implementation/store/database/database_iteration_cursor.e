note
	description: "External iteration cursor for {DATABASE_HANDLER}"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_ITERATION_CURSOR [G]

inherit

	ITERATION_CURSOR [G]

	ITERABLE [G]

create
	make

feature -- Initialization

	make (a_handler: DATABASE_HANDLER; a_action: like action)
			--  Create an iterator and set  `db_handlet' to `a_handler'
			--  `action' to `a_action'
		do
			db_handler := a_handler
			action := a_action
		ensure
			db_handler_set: db_handler = a_handler
			action_set: action = a_action
		end

feature -- Access

	item: G
			-- Item at current cursor position.
		do
			Result := action.item ([db_item])
		end

	db_item: DB_TUPLE
			-- Current element.
		do
			if attached {DB_TUPLE} db_handler.item as l_item then
				Result := l_item
			else
				check False then
				end
			end
		end

feature -- Status report

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := db_handler.after
		end

feature -- Cursor movement

	start
			-- Set the cursor on first element.
		do
			db_handler.start
		end

	forth
			-- Move to next position.
		do
			db_handler.forth
		end

feature -- Cursor

	new_cursor: DATABASE_ITERATION_CURSOR [G]
			-- <Precursor>
		do
			Result := twin
			Result.start
		end

feature -- Action

	action: FUNCTION [DB_TUPLE, G]
			-- Agent to create a new item of type G.

feature {NONE} -- Implementation

	db_handler: DATABASE_HANDLER
			-- Associated handler used for iteration.

end
