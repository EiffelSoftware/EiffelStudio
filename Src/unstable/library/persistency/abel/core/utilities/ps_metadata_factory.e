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

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create metadata_cache.make (cache_capacity)
		end

feature {NONE} -- Implementation

	metadata_cache: HASH_TABLE [PS_TYPE_METADATA, INTEGER]
			-- A cache for already generated metadata.

	cache_capacity: INTEGER = 20
			-- An arbitrarily chosen initial capacity for `metadata_cache'.

end
