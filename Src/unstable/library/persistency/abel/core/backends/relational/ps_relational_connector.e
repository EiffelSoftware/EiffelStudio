note
	description: "Summary description for {PS_RELATIONAL_CONNECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RELATIONAL_CONNECTOR

inherit

	PS_READ_RELATIONAL_CONNECTOR
		redefine
			make
		end

	PS_REPOSITORY_CONNECTOR
		undefine
			is_object_type_supported
		end

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
			connection := database.acquire_connection
			across
				stored_types as cursor
			loop
				connection.execute_sql ("DELETE FROM " + cursor.item.as_lower)
			end
			connection.commit
			database.release_connection (connection)
		end

feature {PS_REPOSITORY_CONNECTOR} -- Implementation

	internal_write (objects: LIST [PS_BACKEND_OBJECT]; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		local
			object: PS_BACKEND_OBJECT
			type: PS_TYPE_METADATA

			sql:STRING
			sql_column_list: STRING
			sql_value_list: STRING
			sql_update_list: STRING

			connection: PS_SQL_CONNECTION

			non_zero_exception: PS_INTERNAL_ERROR
		do
			check no_references: objects.count = 1 end

			object := objects.first
			last_inserted_object := object
			type := object.type

			across
				type.attributes as cursor
			from
					-- Add the previously generated primary key to the object.
				if attached database_mapping.primary_key_column (type.name) as id_column then

					if
						attached object.value_lookup (id_column) as val
						and then (val.to_integer /= 0 and val.to_integer /= object.primary_key)
					then
						create non_zero_exception
						non_zero_exception.set_description (
							"The managed object of type " + object.type.name +
							" contains a user-generated primary key.")
						non_zero_exception.raise
					end

					object.add_attribute (id_column, object.primary_key.out, "INTEGER_32")
				end

				create sql_column_list.make (100)
				create sql_value_list.make (100)
				create sql_update_list.make (200)

				fixme ("This doesn't work for REALs")
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
		end

feature {NONE} -- Implementation

	set_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- Set the generated primary key in `object'.
		local
			index: INTEGER
		do
			if attached database_mapping.primary_key_column (object.type.name) as column_id then
				object.type.attributes.compare_objects
				index := object.type.attributes.index_of (column_id, 1)
				object.reflector.set_integer_32_field (index, object.backend_object.primary_key)
			end
		end

	make (a_database: like database; mapping: like database_mapping; db_name: STRING)
			-- <Precursor>
		do
			Precursor (a_database, mapping, db_name)
			after_write_action := agent set_primary_key
		end

end
