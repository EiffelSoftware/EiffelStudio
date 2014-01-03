note
	description: "A factory class for creating a SQLite repository."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Access

	database: detachable STRING
			-- The path to a database file.
		note
			option: stable
		attribute
		end

feature -- Status report

	is_buildable: BOOLEAN
			-- <Precursor>
		do
			Result := attached database
		end

feature -- Element change

	set_database (value: STRING)
			-- Set `database' to `value'.
		require
			not_empty: not value.is_empty
		do
			database := value
		ensure
			database_set: database ~ value
		end

feature {NONE}

	new_connector: PS_REPOSITORY_CONNECTOR
			-- <Precursor>
		local
			l_sqlite_database: PS_SQLITE_DATABASE
		do
			check from_precondition: attached database as l_database then
				create l_sqlite_database.make (l_database)
				create {PS_GENERIC_LAYOUT_SQL_BACKEND} Result.make (l_sqlite_database, create {PS_SQLITE_STRINGS})
			end
		end

end
