note
	description: "Summary description for {PS_READ_WRITE_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_WRITE_BACKEND
inherit
	PS_READ_ONLY_BACKEND


feature {PS_ABEL_EXPORT} -- Backend capabilities




feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		require
			not_empty: not order.is_empty
			positive_numbers: across order as cursor all cursor.item > 0 end
			types_supported: across order as cursor all is_object_type_supported (cursor.key) end
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		deferred
		ensure
			same_count: order.count = Result.count
			same_keys: across order as cursor all Result.has(cursor.key) end
			correct_amount_of_objects: across order as cursor all attach (Result[cursor.key]).count = cursor.item end
			type_correct: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_OBJECT}.has_type (cursor.key)) end
			empty_objects: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_OBJECT}.is_empty) end
			new_objects: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_OBJECT}.is_new) end
			transaction_unchanged: transaction.is_active
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		require
			not_empty: not order.is_empty
			positive_numbers: across order as cursor all cursor.item > 0 end
			collection_supported: is_generic_collection_supported
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		deferred
		ensure
			same_count: order.count = Result.count
			same_keys: across order as cursor all Result.has(cursor.key) end
			correct_amount_of_objects: across order as cursor all attach (Result[cursor.key]).count = cursor.item end
			type_correct: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_COLLECTION}.has_type (cursor.key)) end
			empty_objects: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_COLLECTION}.is_empty) end
			new_objects: across Result as cursor all cursor.item.for_all (agent {PS_BACKEND_COLLECTION}.is_new) end
			transaction_unchanged: transaction.is_active
		end

feature {PS_ABEL_EXPORT} -- Write operations

	frozen write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- Write every item in `objecs' to the database.
		require
			not_empty: not objects.is_empty
			types_supported: across objects as cursor all is_object_type_supported (cursor.item.metadata)  end
--			no_additional_attributes: across objects as cursor all across cursor.item.attributes as attr all cursor.item.metadata.attributes.has(attr.item) end end
			new_attributes_complete: across objects as cursor all cursor.item.is_new implies cursor.item.is_complete end
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		do
			-- Apply plugins first
			across
				plug_in_list.new_cursor.reversed as plugin_cursor
			loop
				across
					objects as object_cursor
				loop
					plugin_cursor.item.before_write (object_cursor.item, transaction)
				end
			end

			internal_write (objects, transaction)
		ensure
			transaction_unchanged: transaction.is_active
		end

	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete every item in `objects' from the database
		require
			not_empty: not objects.is_empty
			types_supported: across objects as cursor all is_object_type_supported (cursor.item.metadata)  end
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		deferred
		ensure
			deleted: enable_expensive_contracts implies objects.for_all (agent check_delete (?, transaction))
			transaction_unchanged: transaction.is_active
		end

	write_collections (collections: LIST[PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
			-- Write every item in `collections' to the database
		require
			not_empty: not collections.is_empty
			collection_supported: is_generic_collection_supported
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		deferred
		ensure
			correct: enable_expensive_contracts implies collections.for_all (agent check_collection_write (?, transaction))
			transaction_unchanged: transaction.is_active
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- Delete every item in `collections' from the database
		require
			not_empty: not collections.is_empty
			collection_supported: is_generic_collection_supported
			active_transaction: transaction.is_active
			not_readonly: not transaction.is_readonly
		deferred
		ensure
			deleted: enable_expensive_contracts implies collections.for_all (agent check_collection_delete (?, transaction))
			transaction_unchanged: transaction.is_active
		end

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end


feature {PS_READ_WRITE_BACKEND} -- Implementation

	internal_write (objects: LIST[PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- Write all `objects' to the database.
			-- Only write the attributes present in {PS_BACKEND_OBJECT}.attributes.
		deferred
		ensure
			correct: enable_expensive_contracts implies objects.for_all (agent check_write (?, transaction))
			transaction_unchanged: transaction.is_active
		end

feature {NONE} -- Agents for contracts


	check_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if a write was successful
		do
			Result := object.is_subset_of (internal_retrieve_by_primary (object.metadata, object.primary_key, object.attributes, transaction))
		end

	check_delete (object: PS_BACKEND_ENTITY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if a delete was successful
		do
			Result := internal_retrieve_by_primary (object.metadata, object.primary_key, object.metadata.attributes, transaction) = Void
		end

	check_collection_write (collection: PS_BACKEND_COLLECTION; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if a delete was successful
		do
			Result := equal (collection, retrieve_collection (collection.metadata, collection.primary_key, transaction))
		end

	check_collection_delete (collection: PS_BACKEND_ENTITY; transaction: PS_INTERNAL_TRANSACTION): BOOLEAN
			-- Check if a delete was successful
		do
			Result := retrieve_collection (collection.metadata, collection.primary_key, transaction) = Void
		end

end
