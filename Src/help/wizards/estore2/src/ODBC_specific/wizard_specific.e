indexing
	description: "Specific information for the ODBC wizard."
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIFIC

feature -- access

	handle_name: STRING is "ODBC"

	handle_b: EV_RADIO_BUTTON

	is_odbc: BOOLEAN is TRUE

	is_oracle: BOOLEAN is FALSE

	database_type: STRING is "odbc"

	db_manager: DATABASE_MANAGER [ODBC] is
		once
			create Result
		ensure
			exists: Result /= Void
		end

	set_database (s: STRING) is
		do

		end

	type: DATABASE_REPOSITORY [ODBC] is
		once
			create Result.make
		end

	types: TYPES [ODBC] is
		once
			create Result
		end

end -- class WIZARD_SPECIFIC
