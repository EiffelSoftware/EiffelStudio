note
	description: "A wrapper to the cursor provided by the backend. %
				% Used to apply plugins on retrieved objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CURSOR_WRAPPER

inherit

	ITERATION_CURSOR [PS_BACKEND_OBJECT]

	PS_ABEL_EXPORT

create {PS_READ_REPOSITORY_CONNECTOR}
	make

feature -- Access

	item: PS_BACKEND_OBJECT
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
			if not after and not connector.plugins.is_empty and then attached {PS_BACKEND_OBJECT} item as i then
				connector.apply_plugins (i, transaction)
			end
		ensure then
			metadata_set: not after implies item.type.is_equal (type)
			attributes_present: not after implies attributes.for_all (agent item.has_attribute)
			consistent: not after implies item.is_consistent
		end

feature {NONE} -- Impementation

	connector: PS_READ_REPOSITORY_CONNECTOR

	real_cursor: ITERATION_CURSOR [PS_BACKEND_OBJECT]

	type: PS_TYPE_METADATA

	attributes: PS_IMMUTABLE_STRUCTURE [STRING]

	transaction: PS_INTERNAL_TRANSACTION

feature {NONE} -- Initialization

	make (a_connector: like connector; a_cursor: like real_cursor; a_type: like type;
			attr_list: like attributes; a_transaction: like transaction)
			-- Initialization fo `Current'.
		do
			connector := a_connector
			real_cursor := a_cursor
			type := a_type
			attributes := attr_list
			transaction := a_transaction
		end

end
