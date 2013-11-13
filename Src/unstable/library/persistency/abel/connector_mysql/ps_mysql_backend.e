note
	description: "Summary description for {PS_MYSQL_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_BACKEND

inherit
	PS_GENERIC_LAYOUT_SQL_READWRITE_BACKEND
		redefine
			generate_all_object_primaries, generate_collection_primaries, make
		end

create
	make

feature {PS_ABEL_EXPORT} -- Primary key generation

	generate_all_object_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_OBJECT], PS_TYPE_METADATA]
			-- For each type `type_key' in `order', generate `order[type_key]' new objects in the database.
		local
			all_primaries: INTEGER
			connection: PS_SQL_CONNECTION
			new_primary_key: INTEGER
			current_list: LINKED_LIST[PS_BACKEND_OBJECT]
--			none_class_key: INTEGER
--			existence_attribute_key: INTEGER
		do
			-- Count the total number of objects to generate
			across
				order as cursor
			from
				all_primaries := 0
			loop
				all_primaries := all_primaries + cursor.item
			end

			-- Invoke the stored procedure to generate the primary keys
			connection := get_connection (transaction)
			connection.execute_sql ("call generateprimaries(" + all_primaries.out + ")")

			-- Distribute the generated numbers among the objects
			across
				order as cursor
			from
				create Result.make (order.count)
			loop
				across
					1 |..| cursor.item as current_count
				from
					create current_list.make
					Result.extend (current_list, cursor.key)
				loop
					-- Get a primary key
					new_primary_key := connection.last_results.first.item.item (1).to_integer
					connection.last_results.first.forth

					-- Create a new object
					current_list.extend (create {PS_BACKEND_OBJECT}.make_fresh (new_primary_key, cursor.key))
				end
			end

			-- Cleanup
--			none_class_key := db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.None_class)
--			existence_attribute_key := db_metadata_manager.create_get_primary_key_of_attribute (SQL_Strings.Existence_attribute, db_metadata_manager.create_get_primary_key_of_class (SQL_Strings.none_class))
--			connection.execute_sql ("DELETE FROM ps_value WHERE attributeid = " + existence_attribute_key.out)

		rescue
			rollback (transaction)
		end

	generate_collection_primaries (order: HASH_TABLE[INTEGER, PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): HASH_TABLE [LIST[PS_BACKEND_COLLECTION], PS_TYPE_METADATA]
			-- For each type `type_key' in the hash table `order', generate `order[type_key]' new collections in the database.
		do
			fixme ("Use a stored procedure, like generate_all_object_primaries")
			Result := Precursor (order, transaction)
		end

feature {NONE} -- Initialization

	make (a_database: PS_SQL_DATABASE; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
			-- Initialization for `Current'.
		local
			none_type: INTEGER
			none_attribute: INTEGER
		do
			Precursor (a_database, strings)

			none_type := db_metadata_manager.create_get_primary_key_of_class ("NONE")
			none_attribute := db_metadata_manager.create_get_primary_key_of_attribute ("ps_existence", none_type)


			management_connection.execute_sql (
			"[
					DROP PROCEDURE IF EXISTS GeneratePrimaries;

					CREATE PROCEDURE GeneratePrimaries (IN primary_count INTEGER)
						BEGIN

							create temporary table primaries (prim INTEGER) ENGINE=MEMORY;
							WHILE primary_count > 0 DO
								INSERT INTO ps_value (attributeid, runtimetype) VALUES (
			]"
				+ none_attribute.out + "," + none_type.out + ");" +
			"[

								INSERT INTO primaries (prim) VALUES (LAST_INSERT_ID());
								SET primary_count = primary_count - 1;
							END WHILE;

							SELECT * FROM primaries;

							DROP TEMPORARY TABLE IF EXISTS primaries;


					    END ;
			]"
			)

		end

end
