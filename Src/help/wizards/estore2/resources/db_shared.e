indexing
	description: "Generated class to inherit if the DATABASE_MANAGER class is needed"

class 
	DB_SHARED

inherit
	DB_SPECIFIC_TABLES_ACCESS_USE

feature -- Access

	db_manager: DATABASE_MANAGER [DATABASE] is
			-- Interface with the database.
		once
			create {DATABASE_MANAGER [<FL_HANDLE>]}Result
		end

	db_table_manager: DB_TABLE_MANAGER is
			-- Interface with the database using tables
			-- description.
		once
			create Result.make (db_manager)
		end
		
end -- Class DB_SHARED