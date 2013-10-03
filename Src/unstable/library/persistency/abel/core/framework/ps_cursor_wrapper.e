note
	description: "Summary description for {PS_CURSOR_WRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CURSOR_WRAPPER [G]

inherit
	ITERATION_CURSOR [G]

create {PS_NEW_BACKEND}
	make

feature -- Access

	item: G
			-- Item at current cursor position.
		do
			Result := real_cursor.item
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := real_cursor.after
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			real_cursor.forth
			if not after and attached {PS_RETRIEVED_OBJECT} item as i then
				backend.apply_plugins (i, transaction)
			end
		end

feature {NONE} -- Impementation

	backend: PS_NEW_BACKEND

	real_cursor: ITERATION_CURSOR[G]

	transaction: PS_TRANSACTION

feature {NONE} -- Initialization

	make (a_backend: PS_NEW_BACKEND; a_cursor: ITERATION_CURSOR[G]; a_transaction: PS_TRANSACTION)
		do
			backend := a_backend
			real_cursor := a_cursor
			transaction := a_transaction
		end

end
