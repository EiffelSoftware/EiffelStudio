indexing
	description: "Items stored in database"

class
	DATABASE_ITEM
alias
	"RegistrationService.DataBaseItem"

inherit
	SHARED_DATA
		export
			{NONE} all
		end
	
feature -- Access

	identifier: INTEGER
			-- Database item identifier

	error_message: STRING
			-- Initialization error message

feature -- Status Report

	initialized: BOOLEAN
			-- Is item ready to be stored in database?

end -- class DATABASE_ITEM