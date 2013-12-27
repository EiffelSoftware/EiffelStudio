note
	description: "A lookup table to map ANY objects to an identifier using the pointer as a hash code."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IDENTIFIER_TABLE

inherit
	MEMORY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'.
		do
			create lookup_table.make (1)
			create object_store.make (1)

		end


feature -- Access

	item alias "[]" (object: ANY): NATURAL_64
			-- Get the identifier for `object'.
		require
			prepared: is_prepared
		do
			Result := lookup_table [$object]
		ensure
			two_way_mapping: object_store [Result] = object
		end

feature -- Status report

	is_prepared: BOOLEAN

feature -- Element change

	extend (object: ANY)
			-- Add `object' to the identifier set.
		local
			new_id: NATURAL_64
		do
			new_id := new_identifier
			object_store.extend (object, new_id)

			if is_prepared then
				lookup_table.extend (new_id, $object)
			end
		ensure
			inserted: is_prepared implies lookup_table.has ($object)
				and then object_store [lookup_table [$object]] = object
		end

	prepare
			-- Prepare `Current' for access and turn off garbage collection.
		require
			not_prepared: not is_prepared
		local
			object: ANY
		do
			lookup_table.accommodate (object_store.count)

			collection_off

			across
				object_store as cursor
			loop
				object := cursor.item
				lookup_table.extend (cursor.key, $object)
			end
			is_prepared := True
		ensure
			prepared: is_prepared
		end

	release
			-- Free any resources for `Current' and re-enable garbage collection.
		require
			prepared: is_prepared
		do
			lookup_table.wipe_out
			is_prepared := False
			collection_on
		ensure
			not_prepared: not is_prepared
			lookup_empty: lookup_table.is_empty
		end

feature -- Factory functions

	new_identifier: NATURAL_64
			-- Generate a new identifier.
		do
			Result := increment (max_identifier)
		end

feature {NONE} -- Implementation

	max_identifier: separate NATURAL_64_REF
			-- The next identifier.
		once
			create Result
			Result.set_item (1)
		end

	increment (id: separate NATURAL_64_REF): NATURAL_64
			-- Increment `id' and return the new value.
		do
			Result := id.item + 1
			id.set_item (Result)
		end


	object_store: HASH_TABLE [ANY, NATURAL_64]
			-- The internal storage.

	lookup_table: HASH_TABLE [NATURAL_64, POINTER]
			-- The lookup table.
		attribute
		end

invariant
	empty_when_not_prepared: not is_prepared implies lookup_table.is_empty
	full_when_prepared: is_prepared implies lookup_table.count = object_store.count
	garbage_collection_off: is_prepared = not collecting

end
