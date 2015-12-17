note
	description: "[
		This class generates unique object identifiers, attaches them to objects, and maintains a weak reference to every identified object.
		
		A new identifier is first hidden except for the transaction that has generated it. 
		When this transaction successfully commits, other transactions can see the new identifier.
		
		The class also observes the state of weak references providing a sort of publish-subscribe mechanism if it finds a deleted object.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"


class
	PS_OBJECT_IDENTIFICATION_MANAGER

inherit

	PS_ABEL_EXPORT

create
	make

feature {PS_ABEL_EXPORT} -- Status report

	is_global_pool: BOOLEAN
			-- Does `Current' maintain a global pool of object identifiers?

feature {PS_ABEL_EXPORT} -- Element change

	set_is_global_pool (global_pool: like is_global_pool)
			-- Assign `is_global_pool' with `global_pool'.
		do
			is_global_pool := global_pool
		ensure
			is_global_pool_assigned: is_global_pool = global_pool
		end

feature {PS_ABEL_EXPORT} -- Identification

	is_identified (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `an_object' already identified and thus known to the system?
		do
			if is_registered (transaction) then
				Result:= local_set (transaction).is_identified (an_object) or
				(not local_set (transaction).is_deleted (an_object) and global_set.is_identified (an_object))
			else
				Result:= global_set.is_identified (an_object)
			end
		end

	identify (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Generate an identifier for `an_object' and store it.
		require
			not_identified: not is_identified (an_object, transaction)
			not_expanded: not an_object.generating_type.is_expanded
		local
			temp: WEAK_REFERENCE [ANY]
			pair: PS_PAIR [WEAK_REFERENCE [ANY], INTEGER]
			new_identifier: INTEGER
		do
			--check all other transaction local sets if someone already has the same object.
			across transaction_sets as cursor loop
				if cursor.item.is_identified (an_object) then
					-- if yes, use copy of the same identification
					new_identifier:= cursor.item.identifier (an_object)
				end
			end

				--if not create a new one.
			if new_identifier = 0 then
				new_identifier := new_id
			end

			if transaction.is_readonly then
				-- Readonly transactions are not committed, therefore add those identifiers to the global set
				global_set.add_identifier (an_object, new_identifier)
			else
				local_set (transaction).add_identifier (an_object, new_identifier)
			end

		ensure
			identified: is_identified (an_object, transaction)
		end

	delete_identification (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete the identification.
		require
			identified: is_identified (an_object, transaction)
			not_readonly: not transaction.is_readonly
		do
			local_set (transaction).delete_identifier (an_object)
		ensure
			not_identified: not is_identified (an_object, transaction)
		end

	identifier_wrapper (an_object: ANY; transaction: PS_INTERNAL_TRANSACTION): PS_OBJECT_IDENTIFIER_WRAPPER
			-- Get the identifier of `an_object'.
		require
			identified: is_identified (an_object, transaction)
		local
			found: BOOLEAN
			meta: PS_TYPE_METADATA
		do
					-- first look at the local transaction set, then look at the global set
			meta := metadata_manager.create_metadata_from_object (an_object)

			if local_set (transaction).is_identified (an_object) then
				create Result.make (local_set (transaction).identifier (an_object), an_object, meta)
			else
				create Result.make (global_set.identifier (an_object), an_object, meta)
			end

		ensure
			item_present: Result.item = an_object
		end

feature {PS_ABEL_EXPORT} -- Transaction Status

	can_commit (transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Can `Current' commit the changes in `Transaction'?
		do
			Result := True
		end

	is_registered (transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Is `transaction' known to `Current'?
		do
			Result := registered_transactions.has (transaction)
		end

feature {PS_ABEL_EXPORT} -- Transaction management

	register_transaction (transaction: PS_INTERNAL_TRANSACTION)
			-- Add `transaction' to the pool of active transactions, if not present yet.
		do
			if not is_registered (transaction) then
				registered_transactions.extend (True, transaction)
				transaction_sets.extend (transaction.identifier_set, transaction)
			end
		ensure
			is_registered (transaction)
		end

	commit (transaction: PS_INTERNAL_TRANSACTION)
			-- Commit `transaction', making all identifications permanent
		require
			registered: is_registered (transaction)
		do
			if is_global_pool then
				global_set.merge (local_set (transaction))
			end
			-- That might be a bit misleading, but rollback just does cleanup
			rollback (transaction)
		ensure
			not_registered: not is_registered (transaction)
		end

	rollback (transaction: PS_INTERNAL_TRANSACTION)
			-- Rollback all identifications performed within `transaction'
		require
--			registered: is_registered (transaction)
		do
			transaction_sets.remove (transaction)
			registered_transactions.remove (transaction)
		ensure
			not_registered: not is_registered (transaction)
		end

	registered_transactions: HASH_TABLE [BOOLEAN, PS_INTERNAL_TRANSACTION]

feature {PS_ABEL_EXPORT} -- Deletion management

	cleanup
			-- Remove all entries where the weak reference is Void, i.e. the garbage collector has collected the object
		do
			across global_set.garbage_collected_items as cursor
			loop
				publish_deletion (cursor.item)
			end
		end

	publish_deletion (identifier: INTEGER)
			-- Publish the deletion of the object with identifier `identifier'
		do
			across
				subscribers as cursor
			loop
				cursor.item.call ([identifier])
			end
		end

	register_for_deletion_event (action: PROCEDURE [INTEGER])
			-- Register `action' and call it every time an object gets deleted
		do
			subscribers.extend (action)
		end

	subscribers: LINKED_LIST [PROCEDURE [INTEGER]]
			-- A list of all subscribers interested in deletion events

feature {PS_ABEL_EXPORT} -- Utilities

	metadata_manager: PS_METADATA_FACTORY
			-- A manager to generate metadata

	new_id: INTEGER
			-- Create a new identifier
		do
			last_id := last_id + 1
			Result := last_id
		end

feature {NONE} -- Implementation

	make
			-- Initialize `Current'
		do
			create subscribers.make
			create metadata_manager.make
			last_id := 0
			create registered_transactions.make (1)
			create global_set.make
			create transaction_sets.make (1)
		end

	last_id: INTEGER
			--Tthe last id generated

	global_set: PS_IDENTIFIER_SET
			-- The global set of (committed) identifiers

	transaction_sets: HASH_TABLE [PS_IDENTIFIER_SET, PS_INTERNAL_TRANSACTION]
			-- The transaction-local sets

	local_set (transaction: PS_INTERNAL_TRANSACTION): PS_IDENTIFIER_SET
			-- Get the local set for `transaction'
		require
			registered: is_registered (transaction)
		do
			Result := transaction.identifier_set
--			Result:= global_set
--			across transaction_sets as cursor loop
--				if cursor.item.transaction = transaction then
--					Result:= cursor.item.set
--				end
--			end
		ensure
			not_global: Result /= global_set
		end

end
