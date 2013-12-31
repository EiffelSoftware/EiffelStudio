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

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
		local
			struct: PS_IMMUTABLE_STRUCTURE [STRING]
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
				create struct.make (types [i].attributes)
				if attached internal_retrieve_by_primary (types [i], primaries [i], struct, transaction) as retrieved_obj then
					list.extend (retrieved_obj)
				end
				i := i + 1
			variant
				primaries.count + 1 - i
			end
		end

	internal_retrieve_by_primary (type: PS_TYPE_METADATA; key: INTEGER; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_OBJECT
		deferred
		end


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
				if attached retrieve_collection (types [cursor.item], primary_keys [cursor.item], transaction) as retrieved_collection then
					list.extend (retrieved_collection)
				end
			end
		end

	retrieve_collection (collection_type: PS_TYPE_METADATA; collection_primary_key: INTEGER; transaction: PS_INTERNAL_TRANSACTION): detachable PS_BACKEND_COLLECTION
			-- Retrieves the object-oriented collection of type `collection_type' and with primary key `collection_primary_key'.
		deferred
		end

end
