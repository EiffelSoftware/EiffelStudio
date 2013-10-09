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

	genereta_all_object_primaries (numbers: LIST[TUPLE[type: PS_TYPE_METADATA; primary_count: INTEGER]]):
				LIST[TUPLE[type: PS_TYPE_METADATA; primaries:INDEXABLE_ITERATION_CURSOR[INTEGER]]]
			-- Generates `count' primary keys for each `type'.
		deferred
		end

	generate_collection_primaries (count: INTEGER): INDEXABLE_ITERATION_CURSOR[INTEGER]
			-- Generate `count' primary keys for collections.
		deferred
		end

feature {PS_EIFFELSTORE_EXPORT} -- Write operations

	frozen write (objects: LIST[TUPLE[PS_RETRIEVED_OBJECT, PS_WRITE_OPERATION]])
			--
		do
			-- Apply plugins first
			internal_write (objects)
		end

	delete (objects: LIST[INTEGER])
		deferred
		end


	write_collections (collections: LIST[TUPLE[PS_RETRIEVED_OBJECT_COLLECTION, PS_WRITE_OPERATION]])
		deferred
		end

	delete_collections (collections: LIST[INTEGER])
		deferred
		end


feature {PS_EIFFELSTORE_EXPORT} -- Implementation

	internal_write (objects: LIST[TUPLE[PS_RETRIEVED_OBJECT, PS_WRITE_OPERATION]])
		deferred
		end

end
