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
		local
			object: PS_BACKEND_OBJECT
			type: PS_TYPE_METADATA
			list: ARRAYED_LIST [PS_BACKEND_OBJECT]

			table: STRING
			connection: PS_SQL_CONNECTION
			primary: INTEGER
		do
			order.start
			type := order.key_for_iteration
			table := type.name.as_lower

			check no_references: order.count = 1 and order.item_for_iteration = 1 end


			fixme ("It would be nicer to insert just once and then update the data structures.")
			if attached database_mapping.primary_key_column (table) as id_column then

				connection := get_connection (transaction)
				connection.execute_sql ("INSERT INTO " + table + " VALUES ()")
				primary := connection.last_primary_key
			else

				bogus_primary := bogus_primary + 1
				primary := bogus_primary
			end

			create object.make_fresh (primary, order.key_for_iteration)

			create list.make (1)
			list.extend (object)
			create Result.make (1)
			Result.extend (list, order.key_for_iteration)
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
		local
			connection: PS_SQL_CONNECTION
		do

			fixme ("to implement.")
			connection := database.acquire_connection
			connection.execute_sql ("DELETE FROM test_person; DELETE FROM flat_class_2;")
			connection.commit
			database.release_connection (connection)
--			check not_implemented: False end
		end

feature {PS_REPOSITORY_CONNECTOR} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			object: PS_BACKEND_OBJECT
			type: PS_TYPE_METADATA

			table: STRING

			sql:STRING
			sql_column_list: STRING
			sql_value_list: STRING
			sql_update_list: STRING

			connection: PS_SQL_CONNECTION
		do
			check no_references: objects.count = 1 end

			object := objects.first
			last_inserted_object := object
			type := object.type
			table := type.name.as_lower

			across
				type.attributes as cursor
			from
					-- Add the previously generated primary key to the object.
				if attached database_mapping.primary_key_column (table) as id_column then
					object.add_attribute (id_column, object.primary_key.out, "INTEGER_32")
				end

				create sql_column_list.make (100)
				create sql_value_list.make (100)
				create sql_update_list.make (200)
			loop

				if attached object.value_lookup (cursor.item) as val then


					sql_column_list.extend (',')
					sql_column_list.extend (' ')
					sql_column_list.append (cursor.item)

					sql_value_list.extend (',')
					sql_value_list.extend (' ')
					if type.builtin_type [cursor.target_index] = {REFLECTOR_CONSTANTS}.reference_type then
						sql_value_list.extend ('%'')
						sql_value_list.append (val)
						sql_value_list.extend ('%'')
					else
						sql_value_list.append (val)
					end

					sql_update_list.extend (',')
					sql_update_list.extend (' ')
					sql_update_list.append (cursor.item)
					sql_update_list.append (" = VALUES (")
					sql_update_list.append (cursor.item)
					sql_update_list.extend (')')
				end
			end

				-- Replace the first comma.
			sql_column_list [1] := '('
			sql_column_list.extend (')')

			sql_value_list [1] := '('
			sql_value_list.extend (')')

			sql_update_list [1] := ' '



			create sql.make (
				sql_column_list.count +
				sql_value_list.count +
				type.name.count +
				sql_update_list.count +
				50)

			sql.append ("INSERT INTO ")
			sql.append (type.name.as_lower)
			sql.extend (' ')
			sql.append (sql_column_list)
			sql.append (" VALUES ")
			sql.append (sql_value_list)


			sql.append (" ON DUPLICATE KEY UPDATE")
			sql.append (sql_update_list)


			connection := get_connection (transaction)
			connection.execute_sql (sql)

			fixme ("Update auto-generated primary key?")
		end

end
