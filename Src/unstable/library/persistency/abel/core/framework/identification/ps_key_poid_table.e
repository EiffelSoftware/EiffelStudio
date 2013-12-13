note
	description: "Maps object identifiers to [primary_key, type] tuples."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"
	TODO: "Make the features of this class transaction-aware, similar to the PS_OBJECT_IDENTIFICATION_MANAGER"

class
	PS_KEY_POID_TABLE

inherit

	PS_ABEL_EXPORT

	REFACTORING_HELPER

create
	make

feature {PS_ABEL_EXPORT} -- Status report

	has_primary_key_of (obj: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Has `obj' a primary key?		
		do
			Result := obj_to_key_hash.has (obj.object_identifier)
		end

feature {PS_ABEL_EXPORT} -- Access

--	primary_key_of (obj: PS_OBJECT_IDENTIFIER_WRAPPER; transaction: PS_INTERNAL_TRANSACTION): PS_PAIR [INTEGER, PS_TYPE_METADATA]
--			-- Returns the primary key of object `obj' as stored in the backend.
--		do
--			Result := attach (obj_to_key_hash [obj.object_identifier])
--			fixme ("first check transaction-local set, then global one")
--		ensure
--			same_type: obj.metadata.is_equal (Result.second)
--		end

	quick_translate (a_poid: INTEGER; transaction: PS_INTERNAL_TRANSACTION): INTEGER
			-- Returns the primary key of a_poid, or 0 if a_poid doesn't have a primary key.
		do
			if attached obj_to_key_hash [a_poid] as pair then
				Result := pair.first
			end
			fixme ("first check transaction-local set, then global one")
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_entry (obj: PS_OBJECT_IDENTIFIER_WRAPPER; primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION)
			-- Add a new table entry.
		local
			type_hash: HASH_TABLE [LINKED_LIST [PS_OBJECT_IDENTIFIER_WRAPPER], INTEGER]
			local_list: LINKED_LIST [PS_OBJECT_IDENTIFIER_WRAPPER]
		do
			obj_to_key_hash.extend (create {PS_PAIR [INTEGER, PS_TYPE_METADATA]}.make (primary_key, obj.metadata), obj.object_identifier)
			fixme (" write to transaction-local write set, (and remove delete from transaction-local delete set if there is one)")
		end

	remove_primary_key (primary_key: INTEGER; type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION)
			-- Remove the primary key `primary_key' from the table, alongside all objects associated to it.
		local
			local_list: LINKED_LIST [PS_OBJECT_IDENTIFIER_WRAPPER]
			to_remove: LINKED_LIST [INTEGER]
		do
			create to_remove.make
			across
				obj_to_key_hash as cursor
			loop
				if cursor.item.first = primary_key and cursor.item.second.type.type_id = type.type.type_id then
					to_remove.extend (cursor.key)
				end
			end
			across
				to_remove as cursor
			loop
				obj_to_key_hash.remove (cursor.item)
			end
			fixme (" delete from transaction-local write set, or collect deletes in transaction-local delete set - only delete at commit-time")
		end

feature {PS_ABEL_EXPORT} -- Transaction management

	commit (transaction: PS_INTERNAL_TRANSACTION)
			-- Make the changes done within transaction `transaction' permanent.
		do
			fixme ("TODO")
			fixme ("Call at appropriate location")
		end

	rollback (transaction: PS_INTERNAL_TRANSACTION)
			-- Undo all changes done within transaction `transaction'.
		do
			fixme ("TODO")
			fixme ("Call at appropriate location")
		end

feature {PS_ABEL_EXPORT} -- Cleanup and Memory management

	remove_object (obj: PS_OBJECT_IDENTIFIER_WRAPPER)
			-- Remove `obj' from the table, but keep any other object associated to the same primary key if possible.
		do
			fixme ("TODO: reimplement this feature and add it as an agent to the object identification manager.")
		end

feature {NONE} -- Implementation

	obj_to_key_hash: HASH_TABLE [
							PS_PAIR [INTEGER, PS_TYPE_METADATA], -- the primary key and class
							INTEGER] -- the object_id

	default_size: INTEGER = 100
			-- An arbitrarily chosen default size for the hash tables

	make
			-- Initialization for `Current'.
		do
			create obj_to_key_hash.make (default_size)
		end

end
