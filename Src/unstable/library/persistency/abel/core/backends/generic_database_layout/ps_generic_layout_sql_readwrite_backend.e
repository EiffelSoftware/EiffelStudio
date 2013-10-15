note
	description: "Summary description for {PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND

inherit
	
	PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND

	PS_READ_WRITE_BACKEND

create
	make

feature {PS_EIFFELSTORE_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		do
			check not_implemented: False end
			create Result.make (10)
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_TRANSACTION): HASH_TABLE [LIST[PS_RETRIEVED_OBJECT_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		do
			check not_implemented: False end
			create Result.make (10)
		end


feature {PS_EIFFELSTORE_EXPORT} -- Write operations


	delete (objects: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		do
			check not_implemented: False end
		end


	write_collections (collections: LIST[PS_RETRIEVED_OBJECT_COLLECTION]; transaction: PS_TRANSACTION)
		do
			check not_implemented: False end
		end

	delete_collections (collections: LIST[PS_BACKEND_ENTITY]; transaction: PS_TRANSACTION)
		do
			check not_implemented: False end
		end

	wipe_out
			-- Wipe out everything and initialize new.
		do
			from
				active_connections.start
			until
				active_connections.after
			loop
				active_connections.item.first.commit
				database.release_connection (active_connections.item.first)
				active_connections.remove
				print ("found active transaction")
			end
			management_connection.execute_sql (SQL_Strings.Drop_value_table)
			management_connection.execute_sql (SQL_Strings.Drop_attribute_table)
			management_connection.execute_sql (SQL_Strings.Drop_class_table)
			database.release_connection (management_connection)
				--			database.close_connections
			make (database, SQL_Strings)
		end

feature {PS_READ_WRITE_BACKEND} -- Implementation

	internal_write (objects: LIST[PS_RETRIEVED_OBJECT]; transaction: PS_TRANSACTION)
			-- Write all `objects' to the database.
			-- Only write the attributes present in {PS_RETRIEVED_OBJECT}.attributes.
		do
			check not_implemented: False end
		end


--feature {NONE} -- Initialization

--	make (a_database: PS_SQL_DATABASE; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
--			-- Initialization for `Current'.
--		local
--			initialization_connection: PS_SQL_CONNECTION
--		do
--			precursor (a_database, strings)
--		end

end
