note
	description: "Summary description for {PS_CURSOR_WRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CURSOR_WRAPPER

inherit
	ITERATION_CURSOR [PS_RETRIEVED_OBJECT]

create {PS_READ_ONLY_BACKEND}
	make

feature -- Access

	item: PS_RETRIEVED_OBJECT
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
		ensure then
			item_correctly_retrieved: not after implies backend.check_retrieved_object(item, type, attributes, transaction)
		end

feature {NONE} -- Impementation

	backend: PS_READ_ONLY_BACKEND

	real_cursor: ITERATION_CURSOR[PS_RETRIEVED_OBJECT]

	type: PS_TYPE_METADATA

	criterion: PS_CRITERION

	attributes: LIST [STRING]

	transaction: PS_TRANSACTION

feature {NONE} -- Initialization

	make (
			a_backend: PS_READ_ONLY_BACKEND;
			a_cursor: ITERATION_CURSOR[PS_RETRIEVED_OBJECT];
			a_type: like type;
			a_criterion: like criterion
			attr_list: like attributes
			a_transaction: like transaction)
		do
			backend := a_backend
			real_cursor := a_cursor
			type := a_type
			criterion := a_criterion
			attributes := attr_list
			transaction := a_transaction
		end

end
