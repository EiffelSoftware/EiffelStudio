indexing
	description: "Generated class to inherit if the DATABASE_MANAGER class is needed"

class 
	DB_SHARED

feature -- Access

	db_manager: DATABASE_MANAGER is
		once
			create Result
		end

end -- Class DB_SHARED