note
	description: "Summary description for {PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY

inherit
	PS_MYSQL_REPOSITORY_FACTORY
		redefine
			new_connector,
			new_repository,
			make_uninitialized
		end

create
	make, make_uninitialized

feature {NONE} -- Initialization

	make_uninitialized
			-- <Precursor>
		do
			Precursor
			create mapping.make
		end

feature -- Access

	mapping: PS_DATABASE_MAPPING
			-- A mapping table to override naming and primary key defaults.

feature -- Factory function

	new_repository: PS_DEFAULT_REPOSITORY
			-- Create a new repository.
		local
			connection: PS_SQL_CONNECTION
			sql: STRING
			primary_ok: HASH_TABLE [BOOLEAN, STRING]
			internal: INTERNAL
			type_id: INTEGER
		do
			check attached {PS_DEFAULT_REPOSITORY } Precursor as res then
				Result := res

				check
						-- Safe because `Precursor' calls `new_connector'.
					attached internal_database as db
						-- Safe because of precondition.
					and then attached database as db_name

				then

						-- Find out which tables don't have a primary key and
						-- thus have to be treated like an expanded type.

					create primary_ok.make (1)
					create internal

					connection := db.acquire_connection
					sql := "[
						SELECT DISTINCT table_name
						FROM information_schema.columns
						WHERE column_key = 'PRI' and table_schema = '
						]"
						+ db_name + "'"

					connection.execute_sql (sql)

					across
						connection as cursor
					loop
						primary_ok.extend (True, cursor.item[1])
					end

					connection.execute_sql ("SHOW TABLES")

					across
						connection as cursor
					loop
						if not primary_ok.has (cursor.item [1]) then

							type_id := internal.dynamic_type_from_string (cursor.item [1].as_upper)

							if type_id > 0 then
								Result.override_expanded_type (type_factory.create_metadata_from_type_id (type_id).type)
							end
						end
					end
					connection.commit
					db.release_connection (connection)
				end
			end
		end


feature {NONE} -- Implementation

	new_connector: PS_RELATIONAL_CONNECTOR
			-- <Precursor>
		local
			l_db: PS_SQL_DATABASE
		do
			l_db := new_internal_database
			internal_database := l_db
			create Result.make (l_db, mapping)
		ensure then
			db_set: attached internal_database
		end

	internal_database: detachable PS_SQL_DATABASE
			-- An internal database.
		note
			option: stable
		attribute
		end

end
