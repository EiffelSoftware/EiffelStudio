note
	description: "Summary description for {PS_EVEN_SIMPLER_IN_MEMORY_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EVEN_SIMPLER_IN_MEMORY_BACKEND
inherit
	PS_READ_WRITE_BACKEND

create
	wipe_out

feature {PS_EIFFELSTORE_EXPORT} -- Backend capabilities

	is_generic_collection_supported: BOOLEAN
			-- Can the current backend support collections in general,
			-- i.e. is there a default strategy?
		do
			Result := True
		end

feature {PS_RETRIEVAL_MANAGER} -- Collection retrieval


	retrieve_all_collections (collection_type: PS_TYPE_METADATA; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- Retrieves all collections of type `collection_type'.
		do
			prepare_collection(collection_type)
			Result := attach(collection_database[collection_type.type.type_id]).new_cursor
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		do
			prepare_collection(collection_type)
			Result := attach(collection_database.item (collection_type.type.type_id)).item(collection_primary_key)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Transaction handling

	commit (a_transaction: PS_TRANSACTION)
			-- Tries to commit `a_transaction'. As with every other error, a failed commit will result in a new exception and the error will be placed inside `a_transaction'.
		do
		end

	rollback (a_transaction: PS_TRANSACTION)
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

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- See function `retrieve'.
			-- Use `internal_retrieve' for contracts and other calls within a backend.
		do
			prepare(type)
			Result := attach(database[type.type.type_id]).deep_twin.new_cursor
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_TRANSACTION): detachable PS_BACKEND_OBJECT
			-- See function `retrieve_by_primary'.
			-- Use `internal_retrieve_by_primary' for contracts and other calls within a backend.
		do
			prepare(type)
			Result := attach(database.item (type.type.type_id)).item(key)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Testing

	wipe_out
			-- Wipe out everything and initialize new.
		do
			create database.make (50)
			create collection_database.make (1)
			create plug_in_list.make
			plug_in_list.extend (create {PS_AGENT_CRITERION_ELIMINATOR_PLUGIN})
		end

feature {PS_EIFFELSTORE_EXPORT} -- Primary key generation

	max_primary: INTEGER

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
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

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
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

feature {PS_EIFFELSTORE_EXPORT} -- Write operations

	delete (objects: LIST [PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		do
			across objects as cursor
			loop
				prepare (cursor.item.metadata)
				attach (database[cursor.item.metadata.type.type_id]).remove (cursor.item.primary_key)
			end
		end


	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_TRANSACTION)
		do
			across collections as cursor
			loop
				prepare_collection (cursor.item.metadata)
				attach (collection_database[cursor.item.metadata.type.type_id]).force(cursor.item, cursor.item.primary_key)
				cursor.item.declare_as_old
			end
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		do
			across collections as cursor
			loop
				prepare_collection (cursor.item.metadata)
				attach (collection_database[cursor.item.metadata.type.type_id]).remove(cursor.item.primary_key)
			end
		end


feature {NONE} -- Implementation

	internal_write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_TRANSACTION)
		local
			old_obj: PS_BACKEND_OBJECT
		do

			across objects as cursor
			loop
				if cursor.item.is_new then
					prepare(cursor.item.metadata)
					attach (database[cursor.item.metadata.type.type_id]).extend(cursor.item, cursor.item.primary_key)
					cursor.item.declare_as_old
--					print(cursor.item)
				else
					old_obj := attach (attach (database[cursor.item.metadata.type.type_id])[cursor.item.primary_key])
					across cursor.item.attributes as attr
					loop
						old_obj.remove_attribute (attr.item)
						old_obj.add_attribute (attr.item, cursor.item.attribute_value(attr.item).value, cursor.item.attribute_value(attr.item).attribute_class_name)
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
