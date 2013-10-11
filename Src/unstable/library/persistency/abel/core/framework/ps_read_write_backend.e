note
	description: "Summary description for {PS_READ_WRITE_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_READ_WRITE_BACKEND
inherit
	PS_READ_ONLY_BACKEND


feature {PS_EIFFELSTORE_EXPORT} -- Backend capabilities




feature {PS_EIFFELSTORE_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		require
			not_empty: not order.is_empty
			positive_numbers: across order as cursor all cursor.item > 0 end
			-- TODO: activate once the (only) client is sanitized
			--objects_supported: across order as cursor all is_object_type_supported (cursor.key) end
		deferred
		ensure
			same_count: order.count = Result.count
			same_keys: across order as cursor all Result.has(cursor.key) end
			correct_amount_of_objects: across order as cursor all attach (Result[cursor.key]).count = cursor.item end
			type_correct: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT}.has_type (cursor.key)) end
			empty_objects: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT}.is_empty) end
			new_objects: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT}.is_new) end
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		require
			not_empty: not order.is_empty
			positive_numbers: across order as cursor all cursor.item > 0 end
			can_handle_collections: is_generic_collection_supported
		deferred
		ensure
			same_count: order.count = Result.count
			same_keys: across order as cursor all Result.has(cursor.key) end
			correct_amount_of_objects: across order as cursor all attach (Result[cursor.key]).count = cursor.item end
			type_correct: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT_COLLECTION}.has_type (cursor.key)) end
			empty_objects: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT_COLLECTION}.is_empty) end
			new_objects: across Result as cursor all cursor.item.for_all (agent {PS_RETRIEVED_OBJECT_COLLECTION}.is_new) end
		end

feature {PS_EIFFELSTORE_EXPORT} -- Write operations

	frozen write (objects: LIST[PS_RETRIEVED_OBJECT]; transaction: PS_TRANSACTION)
			-- Write all objects in `objecs' to the database.
			-- Only write the attributes present in {PS_RETRIEVED_OBJECT}.attributes.
		require
			attributes_complete: across objects as cursor all
				cursor.item.is_new implies
				(across cursor.item.metadata.attributes as attr_c all cursor.item.has_attribute(attr_c.item) end) end
		do
			-- Apply plugins first
			across
				plug_in_list.new_cursor.reversed as plugin_cursor
			loop
				across
					objects as object_cursor
				loop
					plugin_cursor.item.before_write_new (object_cursor.item, transaction)
				end
			end

			internal_write (objects, transaction)
		end

	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		deferred
		end

	write_collections (collections: LIST[PS_RETRIEVED_OBJECT_COLLECTION]; transaction: PS_TRANSACTION)
		deferred
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		deferred
		end

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end


feature {PS_EIFFELSTORE_EXPORT} -- Implementation

	internal_write (objects: LIST[PS_RETRIEVED_OBJECT]; transaction: PS_TRANSACTION)
		deferred
		end

feature {NONE} -- Contracts


end
