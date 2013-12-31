note
	description: "Creates metadata for objects or type of objects. Caches already generated results for efficiency reasons."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_METADATA_FACTORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initializion for `Current'.
		do
			create metadata_cache.make (default_capacity)
			create type_lookup.make (default_capacity)
			create reflection
		end

feature -- Factory methods

	create_metadata_from_type_id (type_id: INTEGER): PS_TYPE_METADATA
			-- Get the metadata of the type `type_id'.
		local
			type: TYPE [detachable ANY]
		do
			if metadata_cache.has (type_id) then
				check attached metadata_cache [type_id] as res then
					Result := res
				end
			else
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
		do
			Result := create_metadata_from_type (reflection.type_of_type (reflection.dynamic_type (object)))
		end

	create_metadata_from_string (type_string: IMMUTABLE_STRING_8): PS_TYPE_METADATA
			-- Get the metadata for the type `type_string'.
		do
			if attached type_lookup [type_string] as res then
				Result := res
			else
				Result := create_metadata_from_type_id (reflection.dynamic_type_from_string (type_string))
			end
		end

feature {NONE} -- Implementation

	metadata_cache: HASH_TABLE [PS_TYPE_METADATA, INTEGER]
			-- A lookup table for already generated metadata based on a type id.

	type_lookup: HASH_TABLE [PS_TYPE_METADATA, IMMUTABLE_STRING_8]
			-- A lookup table for already generated metadata based on a type name.

	default_capacity: INTEGER = 20
			-- A default capacity.

	reflection: INTERNAL
			-- An INTERNAL instance for reflection.

end
