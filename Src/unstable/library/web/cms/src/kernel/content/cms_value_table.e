note
	description: "[
			Object containing a collection of values.
			It is typically used by `{CMS_RESPONSE}.values' .
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_VALUE_TABLE

inherit
	TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create table.make (nb)
		end

feature -- Access

	count: INTEGER
			-- Number of items.
		do
			Result := table.count
		end

	item (key: READABLE_STRING_GENERAL): detachable ANY
			-- Item associated with `key', if present
			-- otherwise default value of type `G'.
		note
			option: stable
		do
			Result := table.item (key)
		end

	has (key: READABLE_STRING_GENERAL): BOOLEAN
			-- Has item associated with key `key'?
		do
			Result := table.has (key)
		end

	new_cursor: TABLE_ITERATION_CURSOR [detachable ANY, READABLE_STRING_GENERAL]
			-- <Precursor>
		do
			Result := table.new_cursor
		end

feature -- Element change

	put (new: detachable ANY; key: READABLE_STRING_GENERAL)
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
		do
			table.put (new, key)
		end

	force (new: detachable ANY; key: READABLE_STRING_GENERAL)
			-- Update table so that `new' will be the item associated
			-- with `key'.
		do
			table.force (new, key)
		end

	remove (key: READABLE_STRING_GENERAL)
		do
			table.remove (key)
		end

feature {NONE} -- Duplication

	table: STRING_TABLE [detachable ANY]

invariant
	table_set: table /= Void

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
