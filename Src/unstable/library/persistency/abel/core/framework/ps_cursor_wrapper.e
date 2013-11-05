note
	description: "Summary description for {PS_CURSOR_WRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CURSOR_WRAPPER

inherit

	ITERATION_CURSOR [PS_RETRIEVED_OBJECT]

	PS_EIFFELSTORE_EXPORT

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
				backend.apply_plugins (i, criterion, attributes, transaction)
			end
		ensure then
			metadata_set: not after implies item.metadata.is_equal (type)
			attributes_present: not after implies attributes.for_all (agent item.has_attribute)
			consistent: not after implies item.is_consistent

--			item_correctly_retrieved: not after implies backend.check_retrieved_object(item, type, attributes)
		end

feature {NONE} -- Impementation

	backend: PS_READ_ONLY_BACKEND

	real_cursor: ITERATION_CURSOR[PS_RETRIEVED_OBJECT]

	type: PS_TYPE_METADATA

	criterion: PS_CRITERION

	attributes: PS_IMMUTABLE_STRUCTURE [STRING]

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
