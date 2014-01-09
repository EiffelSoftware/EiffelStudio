note
	description: "[
		This class manages the metadata in the database. 
		It is responsible for reading and writing tables ps_class and ps_attribute, and also for creating all tables.
		It maintains a copy of the current metadata layout, and the backend should access this information only through the key manager, and not by using SQL.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_METADATA_TABLES_MANAGER

inherit
	PS_ABEL_EXPORT

create
	make

feature {PS_ABEL_EXPORT} -- Status report

	has_primary_key_of_class (class_name: IMMUTABLE_STRING_8): BOOLEAN
			-- Does the class `class_name' have a primary key in the database?
		do
			Result := class_name_to_key_map.has (class_name)
		end

	has_primary_key_of_attribute (attribute_name: STRING; class_key: INTEGER): BOOLEAN
			-- Does the attribute `attribute_name' in class `class_key' have a primary key?
		require
			class_key_exists: is_valid_class_key (class_key)
		do
			Result := attached attribute_name_to_key_map [class_key] as inner and then inner.has (attribute_name)
		end

	is_valid_class_key (class_key: INTEGER): BOOLEAN
			-- Is there a class that has the primary key `class_key'?
		do
			Result := class_key_to_name_map.has (class_key)
		end

	is_valid_attribute_key (attribute_key: INTEGER): BOOLEAN
			-- Is there an attribute that has the primary key `attribute_key'?
		do
			Result := attribute_key_to_name_map.has (attribute_key)
		end

feature {PS_ABEL_EXPORT} -- Access - Class

	class_name_of_key (class_key: INTEGER): IMMUTABLE_STRING_8
			-- Get the class name of the class with primary key `class_key'
		require
			class_key_exists: is_valid_class_key (class_key)
		do
			check from_precondition: attached class_key_to_name_map [class_key] as res then
				Result := res
			end
		end

	primary_key_of_class (class_name: IMMUTABLE_STRING_8): INTEGER
			-- Get the primary key of class `class_name'
		require
			class_present_in_database: has_primary_key_of_class (class_name)
		do
			Result := class_name_to_key_map [class_name]
		end

	all_types: ARRAYED_LIST [IMMUTABLE_STRING_8]
			-- Get all types in the database.
		do
			fixme ("This also returns some basic types which are sometimes just present as attributes of other objects.")
			across
				class_name_to_key_map as cursor
			from
				create Result.make (class_name_to_key_map.count)
			loop
				if not cursor.key.is_equal ("NONE") then
					Result.extend (cursor.key)
				end
			end
		end

feature {PS_ABEL_EXPORT} -- Access - Attribute

	attribute_name_of_key (attribute_key: INTEGER): STRING
			-- Get the attribute name of the attribute with primary key `class_key'
		require
			attribute_key_exists: is_valid_attribute_key (attribute_key)
		do
			check from_precondition: attached attribute_key_to_name_map [attribute_key] as res then
				Result := res
			end
		end

	primary_key_of_attribute (attribute_name: STRING; class_key: INTEGER): INTEGER
			-- Get the primary key of attribute `attribute_name' in class `class_key'.
		require
			class_key_exists: is_valid_class_key (class_key)
			attribute_present_in_database: has_primary_key_of_attribute (attribute_name, class_key)
		do
			check from_precondition: attached attribute_name_to_key_map [class_key] as inner then
				Result := inner.item (attribute_name)
			end
		end

	attribute_keys_of_class (class_key: INTEGER): ARRAYED_LIST [INTEGER]
			-- Get all the primary keys of attributes defined in class `class_id'
		require
			class_key_exists: is_valid_class_key (class_key)
		do
			check from_precondition: attached attribute_name_to_key_map [class_key] as inner then
				across
					inner as cursor
				from
					create Result.make (inner.count)
				loop
					Result.extend (cursor.item)
				end
			end
		end

feature {PS_GENERIC_LAYOUT_SQL_READONLY_BACKEND} -- Key creation

	create_get_primary_key_of_class (class_name: IMMUTABLE_STRING_8): INTEGER
			-- Get the primary key of class `class_name'. Create a table entry if not present yet.
		do
			if not has_primary_key_of_class (class_name) then
				create_primary_key_of_class (class_name)
			end
			Result := primary_key_of_class (class_name)
		ensure
			present_in_database: has_primary_key_of_class (class_name)
		end

	create_get_primary_key_of_attribute (attribute_name: STRING; class_key: INTEGER): INTEGER
			-- Get the primary key of attribute `attribute_name' in class `class_key'. Create a table entry if not present yet.
		require
			class_key_exists: is_valid_class_key (class_key)
		do
			if not has_primary_key_of_attribute (attribute_name, class_key) then
				create_primary_key_of_attribute (attribute_name, class_key)
			end
			Result := primary_key_of_attribute (attribute_name, class_key)
		ensure
			present_in_database: has_primary_key_of_attribute (attribute_name, class_key)
		end

	create_primary_key_of_class (class_name: IMMUTABLE_STRING_8)
			-- Insert `class_name' to the database and get the new (auto-incremented) primary key.
		require
			not_present_in_database: not has_primary_key_of_class (class_name)
		local
			new_primary_key: INTEGER
		do
				-- Insert the new class, implicitly using auto-increment for the primary key
			management_connection.execute_sql (SQL_Strings.Insert_class_use_autoincrement (class_name))
				-- Retrieve the generated primary key
			management_connection.execute_sql (SQL_Strings.Query_new_id_of_class (class_name))
			new_primary_key := management_connection.last_result.item.item (1).to_integer
				-- Add the class and its primary key to the local copy
			add_class_key (class_name, new_primary_key)
		ensure
			present_in_database: has_primary_key_of_class (class_name)
		end

	create_primary_key_of_attribute (attribute_name: STRING; class_key: INTEGER)
			-- Insert `attribute_name' to the database and retrieve the new (auto-incremented) primary key
		require
			class_key_exists: is_valid_class_key (class_key)
			not_present_in_database: not has_primary_key_of_attribute (attribute_name, class_key)
		local
			new_primary_key: INTEGER
		do
				-- Insert the new attribute, implicitly using auto-increment for the primary key
			management_connection.execute_sql (SQL_Strings.Insert_attribute_use_autoincrement (attribute_name, class_key))
				-- Retrieve the generated primary key
			management_connection.execute_sql (SQL_Strings.Query_new_id_of_attribute (attribute_name, class_key))
			new_primary_key := management_connection.last_result.item [1].to_integer
				-- Add the attribute and its new primary key to the local copy
			add_attribute_key (attribute_name, new_primary_key, class_key)
		ensure
			present_in_database: has_primary_key_of_attribute (attribute_name, class_key)
		end

feature {NONE} -- Implementation - Local copy

	class_key_to_name_map: HASH_TABLE [IMMUTABLE_STRING_8, INTEGER]
			-- A hash table that maps class primary keys to their names

	class_name_to_key_map: HASH_TABLE [INTEGER, IMMUTABLE_STRING_8]
			-- A hash table that maps class names to their primary key

	add_class_key (class_name: IMMUTABLE_STRING_8; new_primary_key: INTEGER)
			-- Add a new mapping from `class_name' to `new_primary_key' and vice-versa.
		do
			class_name_to_key_map.extend (new_primary_key, class_name)
			class_key_to_name_map.extend (class_name, new_primary_key)
				-- Also create an empty hash table in the attribute_name_to_key_map for later inserts of attributes of this class.
			attribute_name_to_key_map.extend (create {HASH_TABLE [INTEGER, STRING]}.make (20), new_primary_key)
		end

	attribute_key_to_name_map: HASH_TABLE [STRING, INTEGER]
			-- A hash table that maps attribute primary keys to their names.

	attribute_name_to_key_map: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER]
			-- A double hash table that first maps a class primary key to the secondary table, which maps attribute names to their primary key

	add_attribute_key (attribute_name: STRING; attribute_key: INTEGER; class_key: INTEGER)
			-- Add a new mapping for `attribute_name' and its primary key `attribute_key' in class `class_key'
		require
			class_present: attribute_name_to_key_map.has (class_key)
		do
			check from_precondition: attached attribute_name_to_key_map [class_key] as inner_hash then
				inner_hash.extend (attribute_key, attribute_name)
				attribute_key_to_name_map.extend (attribute_name, attribute_key)
			end
		end

	management_connection: PS_SQL_CONNECTION
			-- An auto-commited connection to manipulate the tables ps_class and ps_attribute

feature {NONE} -- Initialization

	make (a_connection: PS_SQL_CONNECTION; strings: PS_GENERIC_LAYOUT_SQL_STRINGS)
			-- Read existing database entries and initialize local copy with them.
			-- If necessary, create missing tables.
		local
			existing_tables: ARRAYED_LIST [STRING]
		do
			fixme ("As the metadata is basically cached from the database, find a way to avoid inconsistencies.")

				-- Initialize `Current'
			SQL_Strings := strings
			create class_name_to_key_map.make (20)
			create attribute_name_to_key_map.make (20)
			create class_key_to_name_map.make (20)
			create attribute_key_to_name_map.make (20)
			management_connection := a_connection
				-- Create all tables if they do not yet exist
			management_connection.execute_sql (SQL_Strings.Show_tables)
			create existing_tables.make (10)
			across
				management_connection as cursor
			loop
				existing_tables.extend (cursor.item.item (1))
			end
			if not existing_tables.there_exists (agent {STRING}.is_case_insensitive_equal (SQL_Strings.Class_table)) then
				management_connection.execute_sql (SQL_Strings.Create_class_table)
			end
			if not existing_tables.there_exists (agent {STRING}.is_case_insensitive_equal (SQL_Strings.Attribute_table)) then
				management_connection.execute_sql (SQL_Strings.Create_attribute_table)
			end
			if not existing_tables.there_exists (agent {STRING}.is_case_insensitive_equal (SQL_Strings.Value_table)) then
				management_connection.execute_sql (SQL_Strings.Create_value_table)
			end
			if not existing_tables.there_exists (agent {STRING}.is_case_insensitive_equal (SQL_Strings.Collection_table)) then
				management_connection.execute_sql (SQL_Strings.create_collections_table)
			end
			if not existing_tables.there_exists (agent {STRING}.is_case_insensitive_equal (SQL_Strings.Collection_info_table)) then
				management_connection.execute_sql (SQL_Strings.create_collection_info_table)
			end
				-- Get the needed information from ps_class and ps_attribute table
			management_connection.execute_sql (SQL_Strings.Query_class_table)
			across
				a_connection as row_cursor
			loop
				add_class_key (row_cursor.item.at (SQL_Strings.Class_table_name_column), row_cursor.item.at (SQL_Strings.Class_table_id_column).to_integer)
			end
			management_connection.execute_sql (SQL_Strings.Query_attribute_table)
			across
				a_connection as row_cursor
			loop
				add_attribute_key (row_cursor.item.at (SQL_Strings.Attribute_table_name_column), row_cursor.item.at (SQL_Strings.Attribute_table_id_column).to_integer, row_cursor.item.at (SQL_Strings.Attribute_table_class_column).to_integer)
			end
		end

	SQL_Strings: PS_GENERIC_LAYOUT_SQL_STRINGS

feature {NONE} -- Consistency checks

	check_two_way_class_mapping: BOOLEAN
			-- See if class mappings are identical in both hash tables
		do
			Result := across class_key_to_name_map as name all class_name_to_key_map.has (name.item) end and across class_name_to_key_map as key all class_key_to_name_map.has (key.item) end
		end

	check_attribute_hash_initialized: BOOLEAN
			-- See if there is a hash table for attributes for every class
		do
			Result := across class_name_to_key_map as key all attribute_name_to_key_map.has (key.item) end
		end

	check_two_way_attribute_mapping: BOOLEAN
			-- See if attribute mappings are identical in both hash tables
		do
			Result := across attribute_name_to_key_map as attr_keys_per_class all across attr_keys_per_class.item as key all attribute_key_to_name_map.has (key.item) end end and across attribute_key_to_name_map as names all across attribute_name_to_key_map as attr_keys_per_class some attr_keys_per_class.item.has (names.item) end end
		end

invariant
	two_way_class_mapping: check_two_way_class_mapping
	every_class_has_attribute_hash: check_attribute_hash_initialized
	two_way_attribute_mapping: check_two_way_attribute_mapping

end
