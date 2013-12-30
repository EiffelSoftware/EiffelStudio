note
	description: "Maps object identifiers to primary keys."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	TODO: "Make the features of this class transaction-aware, similar to the PS_OBJECT_IDENTIFICATION_MANAGER"

class
	PS_PRIMARY_KEY_TABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create primary_hash.make (1)
		end

	primary_hash: HASH_TABLE [INTEGER, NATURAL_64]
			-- Object id to primary key hash.

feature -- Access

	item alias "[]" (identifier: NATURAL_64): INTEGER
			-- Return the primary key of the object with global id `identifier'.
		do
			Result := primary_hash [identifier]
		end

feature -- Element change

	extend (primary_key: INTEGER; identifier: NATURAL_64)
			-- Add `primary_key' to the lookup table.
		do
			primary_hash.extend (primary_key, identifier)
		end

	remove (identifier: NATURAL_64)
			-- Remove the primary key of object `identifier'.
		do
			primary_hash.remove (identifier)
		end

end
