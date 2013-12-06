note
	description: "A simple backend which stores all objects in memory."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_BACKEND

inherit
	PS_BACKEND

	PS_BACKEND_CONVERTER

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
			create {LINKED_LIST [READABLE_STRING_GENERAL]} Result.make
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

feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	collection_retrieve (collection_type: PS_TYPE_METADATA; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			prepare_collection(collection_type)
			Result := attach(collection_database[collection_type.type.type_id]).new_cursor
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		do
			prepare_collection(collection_type)
			Result := attach(collection_database.item (collection_type.type.type_id)).item(collection_primary_key)
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

	transaction_isolation_level: PS_TRANSACTION_ISOLATION_LEVEL
			-- The currently active transaction isolation level.
		do
			create Result
			Result := Result.read_uncommitted
		end

	set_transaction_isolation_level (a_level: PS_TRANSACTION_ISOLATION_LEVEL)
			-- Set the transaction isolation level `a_level' for all future transactions.
		do
		end

feature{PS_READ_ONLY_BACKEND}

	success: BOOLEAN

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		do
--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error(create {PS_TRANSACTION_ABORTED_ERROR})
--				transaction.error.raise
--			end

			prepare(type)
			Result := attach(database[type.type.type_id]).deep_twin.new_cursor
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		do
			prepare(type)
			Result := attach(database.item (type.type.type_id)).item(key)
		end

feature {PS_ABEL_EXPORT} -- Testing

	wipe_out, make
			-- Wipe out everything and initialize new.
		do
			create database.make (50)
			create collection_database.make (1)
			create plugins.make
			plugins.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})
			max_primary := 0
			batch_retrieval_size := {PS_REPOSITORY}.Infinite_batch_size
		end

feature {PS_ABEL_EXPORT} -- Primary key generation

	max_primary: INTEGER

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- Generates `count' primary keys for each `type'.
		local
			list: LINKED_LIST[PS_BACKEND_OBJECT]
			index: INTEGER
		do
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
--				Result.extend ((create {INTEGER_INTERVAL}.make (max_primary, max_primary + cursor.item)).new_cursor, cursor.key)
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

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- Generate `count' primary keys for collections.
		local
			list: LINKED_LIST[PS_BACKEND_COLLECTION]
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
			across objects as cursor
			loop
				prepare (cursor.item.metadata)
				attach (database[cursor.item.metadata.type.type_id]).remove (cursor.item.primary_key)
			end
		end


	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
		local
			db: HASH_TABLE[PS_BACKEND_COLLECTION, INTEGER]
		do
			across
				collections as cursor
			loop
				prepare_collection (cursor.item.metadata)
				db := attach (collection_database[cursor.item.metadata.type.type_id])

				if cursor.item.is_update_delta and attached db[cursor.item.primary_key] as old_coll then

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
					db.force(cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
				end
			end
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
		do
			across collections as cursor
			loop
				prepare_collection (cursor.item.metadata)
				attach (collection_database[cursor.item.metadata.type.type_id]).remove(cursor.item.primary_key)
			end
		end


feature {NONE} -- Implementation

	internal_write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
		local
			old_obj: PS_BACKEND_OBJECT
		do

--			if success then -- Enable transaction conflict simulation
--				success := False
--			else
--				success := True
--				transaction.set_error(create {PS_TRANSACTION_ABORTED_ERROR})
--				transaction.error.raise
--			end

			across objects as cursor
			loop
				if cursor.item.is_new then
					prepare(cursor.item.metadata)
					attach (database[cursor.item.metadata.type.type_id]).extend(cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
--					print(cursor.item)
				else
					old_obj := attach (attach (database[cursor.item.metadata.type.type_id])[cursor.item.primary_key])
					old_obj.set_is_root (cursor.item.is_root)
					across
						cursor.item.attributes as attr
					loop
--						if attr.item /~ cursor.item.root_key then
							old_obj.remove_attribute (attr.item)
							old_obj.add_attribute (attr.item, cursor.item.attribute_value(attr.item).value, cursor.item.attribute_value(attr.item).attribute_class_name)
--						end
					end
				end
			end
		end

	collection_database: HASH_TABLE[HASH_TABLE[PS_BACKEND_COLLECTION, INTEGER], INTEGER]

	database: HASH_TABLE[HASH_TABLE[PS_BACKEND_OBJECT, INTEGER], INTEGER]
		-- First key: Type ID
		-- Second key: unique object identifier


	prepare (type: PS_TYPE_METADATA)
		do
			if not database.has (type.type.type_id) then
				database.extend (create {HASH_TABLE[PS_BACKEND_OBJECT, INTEGER]}.make(100), type.type.type_id)
			end
		end


	prepare_collection (type: PS_TYPE_METADATA)
		do
			if not collection_database.has (type.type.type_id) then
				collection_database.extend (create {HASH_TABLE[PS_BACKEND_COLLECTION, INTEGER]}.make(100), type.type.type_id)
			end
		end

end
