note
	description: "A double hash table to map a [type, primary_key] tuple to an arbitrary value."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_LOOKUP_TABLE [G]

inherit
	HASH_TABLE [HASH_TABLE [G, INTEGER], PS_TYPE_METADATA]

create
	 make

feature -- Constants

	inner_default_capacity: INTEGER = 100

feature -- Access

	lookup (primary_key: INTEGER; type: PS_TYPE_METADATA): detachable G
			-- Try to find an element with primary key `primary_key' and type `type'.
		do
			if attached item (type) as inner then
				Result := inner [primary_key]
			end
		end

feature -- Element change

	add_value (value: G; primary_key: INTEGER; type: PS_TYPE_METADATA)
			-- Add `value' to the lookup table.
		local
			new_inner: like item
		do
			if attached item (type) as inner then
				inner.extend (value, primary_key)
			else
				create new_inner.make (inner_default_capacity)
				new_inner.extend (value, primary_key)
				extend (new_inner, type)
			end
		end

	erase_inner
			-- Remove all objects.
			-- Keep inner hash tables.
		do
			across
				Current as l_cursor
			loop
				l_cursor.item.wipe_out
			end
		end

end
