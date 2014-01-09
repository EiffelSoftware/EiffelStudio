note
	description: "A simple backend which stores all objects in memory."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_BACKEND

inherit
	PS_REPOSITORY_CONNECTOR

create
	make

feature {PS_ABEL_EXPORT} -- Backend capabilities

	raise_exception: BOOLEAN = False
			-- For testing: Raise transaction aborted error in every function.

	is_generic_collection_supported: BOOLEAN = True
			-- <Precursor>

feature {PS_ABEL_EXPORT} -- Access

	stored_types: ARRAYED_LIST [IMMUTABLE_STRING_8]
			-- <Precursor>
		do
			create Result.make (database.count + collection_database.count)
			across
				database as cursor
			loop
				Result.extend (cursor.key.name)
			end

			across
				collection_database as collection_cursor
			loop
				Result.extend (collection_cursor.key.name)
			end
		end

feature {PS_ABEL_EXPORT} -- Retrieval

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- <Precursor>
		local
			list: ARRAYED_LIST [PS_BACKEND_OBJECT]
			i: INTEGER
		do
			if raise_exception then
				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
				check attached transaction.error as err then
					err.raise
				end
			end

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

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- <Precursor>
		require else
			supported: is_object_type_supported (type)
		do
--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
--				check attached transaction.error as err then err.raise end
--			end
			if raise_exception then
				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
				check attached transaction.error as err then
					err.raise
				end
			end

			if attributes.count < type.attribute_count then
					-- Prevent the QUERY_CURSOR from messing around with our database.
				Result := create_get_inner_database (type).deep_twin.new_cursor
			else
				Result := create_get_inner_database (type).new_cursor
			end
		end

feature {PS_ABEL_EXPORT} -- Collection retrieval


	collection_retrieve (collection_type: PS_TYPE_METADATA; is_root_only: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- <Precursor>
		do
			Result := create_get_inner_collection_database (collection_type).new_cursor
		end

	specific_collection_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- <Precursor>
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
					attached collection_database [types [cursor.item]] as inner
					and then attached inner [primary_keys [cursor.item]] as res
				then
					list.extend (res)
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Transaction handling

	commit (a_transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
		end

	rollback (a_transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
		end

	set_transaction_isolation (settings: PS_TRANSACTION_SETTINGS)
			-- <Precursor>
		do
				-- Do nothing. Transactions are not supported for the in-memory backend.
		end

	close
			-- <Precursor>
		do
		end

feature {PS_ABEL_EXPORT} -- Testing

	success: BOOLEAN
			-- If false, simulate a transaction failure during next retrieval.

	wipe_out, make
			-- Wipe out everything and initialize new.
		do
			create database.make (default_size)
			create collection_database.make (default_size)
			create plugins.make (1)
			max_primary := 0
			batch_retrieval_size := {PS_REPOSITORY}.Infinite_batch_size
		end

feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- <Precursor>
		local
			list: ARRAYED_LIST [PS_BACKEND_OBJECT]
			index: INTEGER
		do
			if raise_exception then
				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
				check attached transaction.error as err then
					err.raise
				end
			end

			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				from
					index := 1
					create list.make (cursor.item)
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
			-- <Precursor>
		local
			list: ARRAYED_LIST [PS_BACKEND_COLLECTION]
			index: INTEGER
		do
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				from
					index := 1
					create list.make (cursor.item)
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
			-- <Precursor>
		do
			across
				objects as cursor
			loop
				if attached database [cursor.item.type] as inner then
					inner.remove (cursor.item.primary_key)
				end
			end
		end


	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			db: HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER]
		do
			across
				collections as cursor
			loop
				db := create_get_inner_collection_database (cursor.item.type)

				if cursor.item.is_update_delta and attached db [cursor.item.primary_key] as old_coll then

					old_coll.set_is_root (cursor.item.is_root)
					across
						cursor.item.meta_information as info
					loop
						old_coll.meta_information.force (info.item, info.key)
					end
					across
						1 |..| cursor.item.count as idx
					loop
						old_coll.put_i_th (cursor.item [idx.item], cursor.item.item_type (idx.item), idx.item)
					end
				else
					db.force (cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
				end
			end
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			across
				collections as cursor
			loop
				if attached collection_database [cursor.item.type] as inner then
					inner.remove (cursor.item.primary_key)
				end
			end
		end


feature {NONE} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			inner: like create_get_inner_database
		do
--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
--				check attached transaction.error as err then err.raise end
--			end

			if raise_exception then
				transaction.set_error (create {PS_TRANSACTION_ABORTED_ERROR})
				check attached transaction.error as err then
					err.raise
				end
			end

			across
				objects as cursor
			loop
				inner := create_get_inner_database (cursor.item.type)

				if attached inner [cursor.item.primary_key] as old_obj then

					check not_new: not cursor.item.is_new end

					across
						cursor.item.attributes as attr
					from
						old_obj.set_is_root (cursor.item.is_root)
					loop
						old_obj.remove_attribute (attr.item)
						old_obj.add_attribute (attr.item, cursor.item.attribute_value (attr.item).value, cursor.item.attribute_value (attr.item).type)
					end

				else
					check new: cursor.item.is_new end
					inner.extend (cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
				end
			end
		end

feature {NONE} -- Implementation

	create_get_inner_database (type: PS_TYPE_METADATA): HASH_TABLE [PS_BACKEND_OBJECT, INTEGER]
			-- Return `database [type]'.
			-- If not present, create a new hash table.
		do
			if attached database [type] as res then
				Result := res
			else
				create Result.make (default_size)
				database.extend (Result, type)
			end
		end

	create_get_inner_collection_database (type: PS_TYPE_METADATA): HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER]
			-- Return `collection_database [type]'.
			-- If not present, create a new hash table.
		do
			if attached collection_database [type] as res then
				Result := res
			else
				create Result.make (default_size)
				collection_database.extend (Result, type)
			end
		end

feature {NONE} -- Data structures

	database: HASH_TABLE [HASH_TABLE [PS_BACKEND_OBJECT, INTEGER], PS_TYPE_METADATA]
		-- First key: Type ID.
		-- Second key: Primary key.

	collection_database: HASH_TABLE [HASH_TABLE [PS_BACKEND_COLLECTION, INTEGER], PS_TYPE_METADATA]
		-- First key: Type ID.
		-- Second key: Primary key.

	max_primary: INTEGER
		-- The maximum generated primary key.

feature {NONE} -- Constants

	default_size: INTEGER = 1

end
