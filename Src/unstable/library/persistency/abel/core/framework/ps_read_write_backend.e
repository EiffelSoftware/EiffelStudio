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

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [INDEXABLE_ITERATION_CURSOR[INTEGER], PS_TYPE_METADATA]
			-- Generates `count' primary keys for each `type'.
		deferred
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [INDEXABLE_ITERATION_CURSOR[INTEGER], PS_TYPE_METADATA]
			-- Generate `count' primary keys for collections.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Write operations

	frozen write (objects: LIST[TUPLE[obj: PS_RETRIEVED_OBJECT; op: PS_WRITE_OPERATION]]; transaction: PS_TRANSACTION)
			--
		require
			attributes_complete: across objects as cursor all
				cursor.item.op = cursor.item.op.insert implies
				(across cursor.item.obj.metadata.attributes as attr_c all cursor.item.obj.has_attribute(attr_c.item) end) end
		do
			-- Apply plugins first

			across
				plug_in_list.new_cursor.reversed as plugin_cursor
			loop
				across
					objects as object_cursor
				loop
					plugin_cursor.item.before_write_new (object_cursor.item.obj, object_cursor.item.op, transaction)
				end
			end

			internal_write (objects, transaction)
		end

	delete (objects: LIST[TUPLE[PS_TYPE_METADATA, INTEGER]]; transaction: PS_TRANSACTION)
		deferred
		end


	write_collections (collections: LIST[TUPLE[PS_RETRIEVED_OBJECT_COLLECTION, PS_WRITE_OPERATION]]; transaction: PS_TRANSACTION)
		deferred
		end

	delete_collections (collections: LIST[TUPLE[type: PS_TYPE_METADATA; key: INTEGER]]; transaction: PS_TRANSACTION)
		deferred
		end

	wipe_out
			-- Wipe out everything and initialize new.
		deferred
		end


feature {PS_EIFFELSTORE_EXPORT} -- Implementation

	internal_write (objects: LIST[TUPLE[PS_RETRIEVED_OBJECT, PS_WRITE_OPERATION]]; transaction: PS_TRANSACTION)
		deferred
		end

end
