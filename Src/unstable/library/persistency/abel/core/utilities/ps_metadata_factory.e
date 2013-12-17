note
	description: "Creates metadata for objects or type of objects. Caches already generated results for efficiency reasons."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_METADATA_FACTORY

create
	make

feature -- Factory methods

	create_metadata_from_type_id (type_id: INTEGER): PS_TYPE_METADATA
			-- Get the metadata of the type `type_id'.
		local
			reflection: INTERNAL
			type: TYPE [detachable ANY]
		do
			if metadata_cache.has (type_id) then
				check attached metadata_cache [type_id] as res then
					Result := res
				end
			else
				create reflection
				type := reflection.type_of_type (type_id)
				create Result.make (type, Current)
				metadata_cache.extend (Result, type.type_id)
				type_lookup.extend (Result, type.name)
				Result.initialize
			end
		end

	create_metadata_from_type (type: TYPE [detachable ANY]): PS_TYPE_METADATA
			-- Get the metadata of the type `type'.
		do
			if metadata_cache.has (type.type_id) then
				check attached metadata_cache [type.type_id] as res then
					Result := res
				end
			else
				create Result.make (type, Current)
				metadata_cache.extend (Result, type.type_id)
				type_lookup.extend (Result, type.name)
				Result.initialize
			end
		end

	create_metadata_from_object (object: ANY): PS_TYPE_METADATA
			-- Get the metadata of `object'.
		local
			reflection: INTERNAL
		do
			create reflection
			Result := create_metadata_from_type (reflection.type_of_type (reflection.dynamic_type (object)))
		end

	create_metadata_from_string (type_string: IMMUTABLE_STRING_8): PS_TYPE_METADATA
			-- Get the metadata for the type `type_string'.
		local
			reflection: INTERNAL
		do
			if attached type_lookup [type_string] as res then
				Result := res
			else
				create reflection
				Result := create_metadata_from_type_id (reflection.dynamic_type_from_string (type_string))
			end
		end


--	generate_tuple_type (a_type: TYPE [detachable ANY]; projection: ARRAYED_LIST [STRING]): INTEGER_32
--			-- Generate a tuple of correct type and size
--		local
--			type: PS_TYPE_METADATA
--			attribute_type: PS_TYPE_METADATA
--			tuple_string: STRING
--			tuple_type_id: INTEGER
--			index: INTEGER
--		do
--			type := create_metadata_from_type (a_type)
--			check projection_not_empty: projection.count > 0 end

--			tuple_string := "detachable TUPLE ["

--			from index := 1
--			until index > projection.count
--			loop

--				-- NOTE: We cannot just take the runtime type of the attribute, since those types are (for whatever reason)
--				-- always detachable. Instead the generated tuple needs to have the statically declared types as its generic
--				-- attributes. This way object tests like
--				--		check attached TUPLE [STRING, STING, detachable STRING] generated_tuple end
--				--  will succeed for objects having those fields.

--				tuple_string := tuple_string + type.reflection.type_name_of_type (type.reflection.field_static_type_of_type (type.field_index (projection [index]), type.type.type_id))
--				index := index + 1

--				if index <= projection.count then
--					tuple_string := tuple_string + ", "
--				end
--			end

--			tuple_string := tuple_string + "]"
--			Result:= type.reflection.dynamic_type_from_string (tuple_string)
--		end


feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create metadata_cache.make (cache_capacity)
			create type_lookup.make (cache_capacity)
		end

feature {NONE} -- Implementation

	metadata_cache: HASH_TABLE [PS_TYPE_METADATA, INTEGER]
			-- A cache for already generated metadata.

	type_lookup: HASH_TABLE [PS_TYPE_METADATA, IMMUTABLE_STRING_8]

	cache_capacity: INTEGER = 20
			-- An arbitrarily chosen initial capacity for `metadata_cache'.

end
