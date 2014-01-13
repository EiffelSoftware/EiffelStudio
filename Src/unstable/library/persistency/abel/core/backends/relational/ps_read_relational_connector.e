note
	description: "A repository connector for a relational database with an existing layout."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_READ_RELATIONAL_CONNECTOR

inherit
	PS_RDBMS_CONNECTOR
		redefine
			is_object_type_supported
		end

create
	make

feature {PS_ABEL_EXPORT} -- Access

	stored_types: HASH_TABLE [IMMUTABLE_STRING_8, IMMUTABLE_STRING_8]
			-- The type string for all objects and collections stored in `Current'.

--	primary_key_columns: STRING_TABLE [ARRAYED_LIST [STRING]]
			-- The primary key columns for each table, if any.
			-- Note that the key is stored in upper case.

feature {PS_ABEL_EXPORT} -- Status report

	is_generic_collection_supported: BOOLEAN = False
			-- Are collections supported by this connector?

	is_object_type_supported (type: PS_TYPE_METADATA): BOOLEAN
			-- <Precursor>
		do
			Result := stored_types.has (type.name)
		end

feature {PS_ABEL_EXPORT} -- Collection retrieval

	collection_retrieve (type: PS_TYPE_METADATA; is_root: BOOLEAN; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_COLLECTION]
			-- <Precursor>
		do
			check not_supported: False end
			Result := (create {LINKED_LIST [PS_BACKEND_COLLECTION]}.make).new_cursor
		end

	specific_collection_retrieve (primary_keys: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_COLLECTION]
			-- <Precursor>
		do
			check not_supported: False end
			Result := create {LINKED_LIST [PS_BACKEND_COLLECTION]}.make
		end


feature {PS_READ_REPOSITORY_CONNECTOR} -- Implementation

	internal_retrieve (type: PS_TYPE_METADATA; criteria: PS_CRITERION; is_root_only: BOOLEAN; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction: PS_INTERNAL_TRANSACTION): ITERATION_CURSOR [PS_BACKEND_OBJECT]
			-- <Precursor>
		local
			cursor: PS_RELATIONAL_RESULT_CURSOR
		do
			create cursor.make (type, criteria, attributes, transaction, Current)
			Result := cursor
		end

	internal_specific_retrieve (primaries: ARRAYED_LIST [INTEGER]; types: ARRAYED_LIST [PS_TYPE_METADATA]; transaction: PS_INTERNAL_TRANSACTION): READABLE_INDEXABLE [PS_BACKEND_OBJECT]
			-- <Precursor>
		local
			list: ARRAYED_LIST [PS_BACKEND_OBJECT]
		do

			fixme ("This is a hack to make writes work. %
				%The `internal_specific_retrieve' isn't actually needed for flat objects.")
			create list.make (primaries.count)
			Result := list

			if attached last_inserted_object as ret and then ret.primary_key = primaries.first then
				list.extend (ret)
			end
		end

feature {PS_ABEL_EXPORT} -- Primary key handling

	new_primary: INTEGER
			-- Create a new unique primary key.
		do
			Result := bogus_primary + 1
			bogus_primary := Result
		end

	managed_type_lookup (type: PS_TYPE_METADATA): detachable STRING
			-- If `type' is managed, return the primary key column.
		do
			Result := managed_types [type]
		end

feature {NONE} -- Initialization

	make (a_database: like database; a_managed_types: like managed_types; a_strings: like strings)
			-- Initialization for `Current'.
		do
			initialize (a_database)
			managed_types := a_managed_types
			strings := a_strings
			load_layout
		end

	managed_types: HASH_TABLE [STRING, PS_TYPE_METADATA]
			-- The managed types and their primary key column.

	strings: PS_RELATIONAL_SQL_STRINGS
			-- The SQL strings for `Current'.

	bogus_primary: INTEGER

	last_inserted_object: detachable PS_BACKEND_OBJECT

	load_layout
			-- Initialize information about the layout.
		local
			connection: PS_SQL_CONNECTION
			internal: INTERNAL

			sql: STRING
			type_name: STRING
			column_name: STRING
			column_key: STRING
			list: ARRAYED_LIST [STRING]
		do
			fixme ("Support for SQLite.")

			create stored_types.make (1)
--			create primary_key_columns.make (1)
			create internal


			connection := database.acquire_connection
			sql := strings.show_tables
--			sql := "[
--				SELECT table_name, column_name, column_key
--				FROM information_schema.columns
--				WHERE table_schema = '
--				]"
--				+ db_name + "'"

			connection.execute_sql (sql)

			across
				connection as cursor
			loop
				type_name := cursor.item [1].as_upper
--				column_name := cursor.item [2]
--				column_key := cursor.item [3]

				if internal.dynamic_type_from_string (type_name) > 0 then

					if not stored_types.has (type_name) then
						stored_types.extend (type_name, type_name)
					end

--					if column_key.is_case_insensitive_equal ("PRI") then
--						if attached primary_key_columns [type_name] as inner then
--							inner.extend (column_name)
--						else
--							create list.make (1)
--							list.extend (column_name)
--							primary_key_columns.extend (list, type_name)
--						end
--					end
				end
			end

			connection.commit
			database.release_connection (connection)
		end
end
