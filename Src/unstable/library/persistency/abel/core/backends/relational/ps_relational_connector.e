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
			sql: STRING
		do
			order.start
			type := order.key_for_iteration
			table := type.name.as_lower

			check no_references: order.count = 1 and order.item_for_iteration = 1 end


			fixme ("It would be nicer to insert just once and then update the data structures.")
			if attached managed_type_lookup (type) as id_column then

				connection := get_connection (transaction)
				sql := "INSERT INTO " + table + " VALUES ("
				across
					type.attributes as cursor
				loop
					sql.append ("NULL")
					if not cursor.is_last then
						sql.append (", ")
					else
						sql.extend (')')
					end
				end

				connection.execute_sql (sql)
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

			columns: ARRAYED_LIST [STRING]
			values: ARRAYED_LIST [STRING]

			sql:STRING
			connection: PS_SQL_CONNECTION

			non_zero_exception: PS_INTERNAL_ERROR
			managed: MANAGED_POINTER
		do
			check no_references: objects.count = 1 end

			object := objects.first
			last_inserted_object := object
			type := object.type

			across
				type.attributes as cursor
			from
					-- Add the previously generated primary key to the object.
				if attached managed_type_lookup (type) as id_column then

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

				create columns.make (type.attribute_count)
				create values.make (type.attribute_count)
			loop

				if attached object.value_lookup (cursor.item) as val then

					columns.extend (cursor.item)

					if type.builtin_type [cursor.target_index] = {REFLECTOR_CONSTANTS}.real_32_type then
						create managed.make ({PLATFORM}.real_32_bytes)
						managed.put_integer_32_be (val.to_integer_32, 0)
						values.extend (managed.read_real_32_be (0).out)
					elseif type.builtin_type [cursor.target_index] = {REFLECTOR_CONSTANTS}.real_64_type then
						create managed.make ({PLATFORM}.real_64_bytes)
						managed.put_integer_64_be (val.to_integer_64, 0)
						values.extend (managed.read_real_64_be (0).out)
					elseif type.builtin_type [cursor.target_index] = {REFLECTOR_CONSTANTS}.reference_type then
						if object.type_lookup (cursor.item) ~ "NONE" then
							values.extend ("NULL")
						else
							values.extend ("'" + val + "'")
						end
					else
						values.extend (val)
					end
				end
			end

			sql := strings.assemble_upsert (type.name.as_lower, columns, values)
			connection := get_connection (transaction)
			connection.execute_sql (sql)
		end

feature {NONE} -- Implementation

	set_primary_key (object: PS_OBJECT_WRITE_DATA)
			-- Set the generated primary key in `object'.
		local
			index: INTEGER
		do
			if attached managed_type_lookup (object.type) as column_id then
				object.type.attributes.compare_objects
				index := object.type.attributes.index_of (column_id, 1)
				object.reflector.set_integer_32_field (index, object.backend_object.primary_key)
			end
		end

	make (a_database: like database; a_managed_types: like managed_types; a_strings: like strings)
			-- <Precursor>
		do
			Precursor (a_database, a_managed_types, a_strings)
			after_write_action := agent set_primary_key
		end

end
