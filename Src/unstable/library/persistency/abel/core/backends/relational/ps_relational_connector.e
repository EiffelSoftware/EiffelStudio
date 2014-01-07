note
	description: "Summary description for {PS_RELATIONAL_CONNECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RELATIONAL_CONNECTOR

inherit

	PS_READ_RELATIONAL_CONNECTOR

	PS_REPOSITORY_CONNECTOR

create
	make

feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- <Precursor>
		do
			fixme ("to implement.")
			check not_implemented: False end
			create Result.make (0)
		end

	generate_collection_primaries (order: HASH_TABLE [INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST [PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- <Precursor>
		do
			check not_supported: False end
			create Result.make (0)
		end

feature {PS_ABEL_EXPORT} -- Write operations


	delete (objects: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			fixme ("to implement.")
			check not_implemented: False end
		end

	write_collections (collections: LIST [PS_BACKEND_COLLECTION]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			check not_supported: False end
		end

	delete_collections (collections: LIST [PS_BACKEND_ENTITY]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			check not_supported: False end
		end

	wipe_out
			-- <Precursor>
		do
			fixme ("to implement.")
			check not_implemented: False end
		end

feature {PS_REPOSITORY_CONNECTOR} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
			fixme ("to implement.")
			check not_implemented: False end
		end

end
