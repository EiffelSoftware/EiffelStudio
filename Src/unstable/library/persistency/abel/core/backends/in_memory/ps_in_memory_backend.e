note
	description: "A simple backend which stores all objects in memory."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_BACKEND

inherit
	PS_BACKEND

--	PS_BACKEND_CONVERTER
--		redefine
--			internal_specific_retrieve
--		end

create
	make

feature {PS_ABEL_EXPORT} -- Backend capabilities

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		do
			Result := True
		end

feature {PS_ABEL_EXPORT} -- Access

	stored_types: LIST [READABLE_STRING_GENERAL]
			-- The type string for all objects and collections stored in `Current'.
		local
			reflection: REFLECTOR
		do
			-- Note to implementors: It is highly recommended to cache the result, and
			-- refresh it during a `retrieve' operation (or not at all if the result
			-- is always stable).
			create {ARRAYED_LIST [READABLE_STRING_GENERAL]} Result.make (database.count + collection_database.count)
			create reflection

			across
				database as cursor
			loop
				Result.extend (reflection.type_of_type (cursor.key).name)
			end

			across
				collection_database as collection_cursor
			loop
				Result.extend (reflection.type_of_type (collection_cursor.key).name)
			end
		end

feature {PS_ABEL_EXPORT} -- Retrieval

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- See function `specific_retrieve'.
			-- Use `internal_specific_retrieve' for contracts and other calls within a backend.
		local
			list: ARRAYED_LIST [PS_BACKEND_OBJECT]
			i: INTEGER
		do
			from
				create list.make (primaries.count)
				Result := list
				i := 1
			until
				i > primaries.count
			loop
				if attached create_get_inner_database (types [i]).item (primaries [i]) as retrieved_obj then
					list.extend (retrieved_obj)
				end
				i := i + 1
			variant
				primaries.count + 1 - i
			end
		end

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		require else
			supported: is_object_type_supported (type)
		do
--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
--				transaction.error.raise
--			end

			if attributes.count < type.attribute_count then
					-- Prevent the QUERY_CURSOR from messing around with our database.
				Result := create_get_inner_database (type).deep_twin.new_cursor
			else
				Result := create_get_inner_database (type).new_cursor
			end
		end

feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	collection_retrieve (collection_type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			Result := create_get_inner_collection_database (collection_type).new_cursor
		end

--	specific_collection_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
	specific_collection_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- For every item in `order', retrieve the object with the correct `type' and `primary_key'.
			-- Note: The result does not have to be ordered, and items deleted in the database are not present in the result.
		local
			list: ARRAYED_LIST [PS_BACKEND_COLLECTION]
		do
			across
				1 |..| primary_keys.count as cursor
			from
				create list.make (primary_keys.count)
				Result := list
			loop
				if
					attached collection_database [types [cursor.item].type.type_id] as inner
					and then attached inner [primary_keys [cursor.item]] as res
				then
					list.extend (res)
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		do
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
			-- Aborts `a_transaction' and undoes all changes in the database.
		do
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- Set the transaction isolation level such that all values in `settings' are respected.
		do
				-- Do nothing. Transactions are not supported for the in-memory backend.
		end

feature {PS_ABEL_EXPORT} -- Testing

--	success: BOOLEAN
--			-- If false, simulate a transaction failure during next retrieval.

	wipe_out, make
			-- Wipe out everything and initialize new.
		do
			create database.make (default_size)
			create collection_database.make (default_size)
			create plugins.make
--			plugins.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})
			max_primary := 0
			batch_retrieval_size := {PS_REPOSITORY}.Infinite_batch_size
		end

feature {PS_ABEL_EXPORT} -- Primary key generation

	max_primary: INTEGER

	generate_all_object_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- Generates `count' primary keys for each `type'.
		local
			list: LINKED_LIST [PS_BACKEND_OBJECT]
			index: INTEGER
		do
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				from
					index := 1
					create list.make
				until
					index = cursor.item + 1
				loop
					list.extend (create {PS_BACKEND_OBJECT}.make_fresh (max_primary + index, cursor.key))
					index := index + 1
				variant
					cursor.item - index + 1
				end
				Result.extend (list, cursor.key)
				max_primary := max_primary + cursor.item
			end
		end

	generate_collection_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- Generate `count' primary keys for collections.
		local
			list: LINKED_LIST [PS_BACKEND_COLLECTION]
			index: INTEGER
		do
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				from
					index := 1
					create list.make
				until
					index = cursor.item + 1
				loop
					list.extend (create {PS_BACKEND_COLLECTION}.make_fresh (max_primary + index, cursor.key))
					index := index + 1
				variant
					cursor.item - index + 1
				end
				Result.extend (list, cursor.key)
				max_primary := max_primary + cursor.item
			end
		end

feature {PS_ABEL_EXPORT} -- Write operations

	delete (objects: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
		do
			across
				objects as cursor
			loop
				if attached database [cursor.item.metadata.type.type_id] as inner then
					inner.remove (cursor.item.primary_key)
				end
			end
		end


	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
		local
			db: HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER]
		do
			across
				collections as cursor
			loop
				db := create_get_inner_collection_database (cursor.item.metadata)

				if cursor.item.is_update_delta and attached db [cursor.item.primary_key] as old_coll then

					old_coll.set_is_root (cursor.item.is_root)
					across
						cursor.item.information_descriptions as key
					loop
						old_coll.add_information (key.item, cursor.item.get_information (key.item))
					end
					across
						1 |..| cursor.item.collection_items.count as idx
					loop
						old_coll.collection_items.put_i_th (cursor.item.collection_items.i_th (idx.item), idx.item)
					end
				else
					db.force (cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
				end
			end
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
		do
			across
				collections as cursor
			loop
				if attached collection_database [cursor.item.metadata.type.type_id] as inner then
					inner.remove (cursor.item.primary_key)
				end
			end
		end


feature {NONE} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
		local
			inner: like create_get_inner_database
		do

--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
--				transaction.error.raise
--			end

			across
				objects as cursor
			loop
				inner := create_get_inner_database (cursor.item.metadata)

				if attached inner [cursor.item.primary_key] as old_obj then

					check not_new: not cursor.item.is_new end

					across
						cursor.item.attributes as attr
					from
						old_obj.set_is_root (cursor.item.is_root)
					loop
						old_obj.remove_attribute (attr.item)
						old_obj.add_attribute (attr.item, cursor.item.attribute_value (attr.item).value, cursor.item.attribute_value (attr.item).attribute_class_name)
					end

				else
					check new: cursor.item.is_new end
					inner.extend (cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
				end
			end
		end

	collection_database: HASH_TABLE [HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER], INTEGER]

	database: HASH_TABLE [HASH_TABLE [PS_BACKEND_OBJECT, INTEGER], INTEGER]
		-- First key: Type ID
		-- Second key: unique object identifier

	create_get_inner_database (type: PS_TYPE_METADATA): HASH_TABLE [PS_BACKEND_OBJECT, INTEGER]
			-- Return `database [type]'.
			-- If not present, create a new hash table.
		do
			if attached database [type.type.type_id] as res then
				Result := res
			else
				create Result.make (default_size)
				database.extend (Result, type.type.type_id)
			end
		end

	create_get_inner_collection_database (type: PS_TYPE_METADATA): HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER]
			-- Return `collection_database [type]'.
			-- If not present, create a new hash table.
		do
			if attached collection_database [type.type.type_id] as res then
				Result := res
			else
				create Result.make (default_size)
				collection_database.extend (Result, type.type.type_id)
			end
		end

feature {NONE} -- Constants

	default_size: INTEGER = 1

end
