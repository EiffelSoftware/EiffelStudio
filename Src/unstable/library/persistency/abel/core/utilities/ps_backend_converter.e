note
	description: "Summary description for {PS_BACKEND_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_BACKEND_CONVERTER

inherit
	PS_ABEL_EXPORT

feature {PS_ABEL_EXPORT}


	internal_specific_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
		local
			struct: PS_IMMUTABLE_STRUCTURE [STRING]
			list: LINKED_LIST [PS_BACKEND_OBJECT]
		do
			across
				order as cursor
			from
				create list.make
				Result := list
			loop
				create struct.make (cursor.item.type.attributes)
				if attached internal_retrieve_by_primary (cursor.item.type, cursor.item.primary_key, struct, transaction) as retrieved_obj then
					list.extend (retrieved_obj)
				end
			end
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
		deferred
		end


	specific_collection_retrieve (order: LIST [TUPLE [type: PS_TYPE_METADATA; primary_key: INTEGER]]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- For every item in `order', retrieve the object with the correct `type' and `primary_key'.
			-- Note: The result does not have to be ordered, and items deleted in the database are not present in the result.
		local
			list: LINKED_LIST [PS_BACKEND_COLLECTION]
		do
			across
				order as cursor
			from
				create list.make
				Result := list
			loop
				if attached retrieve_collection (cursor.item.type, cursor.item.primary_key, transaction) as retrieved_collection then
					list.extend (retrieved_collection)
				end
			end
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		deferred
		end

end
