note
	description: "External iteration cursor for {ESA_DATABASE_HANDLER}"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_ITREATION_CURSOR [G]

inherit

	ITERATION_CURSOR [G]

	ITERABLE [G]

create
	make

feature -- Initialization

	make (a_handler: ESA_DATABASE_HANDLER; a_action: like action)
			--  Create an iterator with a `a_handler'
		do
			db_handler := a_handler
			action := a_action
		end

feature -- Access

	item: G
			-- Item at current cursor position.
		do
			Result := action.item ([db_item])
		end

	db_item: detachable DB_TUPLE
			-- Current element
		do
			if attached {DB_TUPLE} db_handler.item as l_item then
				Result := l_item
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
			-- Set the cursor on first element
		do
			db_handler.start
		end

	forth
			-- Move to next position.
		do
			db_handler.forth
		end

feature -- Cursor

	new_cursor: ESA_DATABASE_ITREATION_CURSOR [G]
			-- <Precursor>
		do
			Result := twin
			Result.start
		end

feature -- Action

	action: FUNCTION [ANY,detachable TUPLE[detachable DB_TUPLE],G]
			-- Agent to create a new item of type G.

feature {NONE} -- Implementation

	db_handler: ESA_DATABASE_HANDLER
			-- Associated handler used for iteration
end
