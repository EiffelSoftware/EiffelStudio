indexing
	description: "Specific information for the Oracle wizard."
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPECIFIC

feature -- access

	handle_name: STRING is "Oracle"

	handle_b: EV_RADIO_BUTTON

	is_odbc: BOOLEAN is FALSE

	is_oracle: BOOLEAN is TRUE

	database_type: STRING is "oracle"

	db_manager: DATABASE_MANAGER [ORACLE] is
		once
			create Result
		ensure
			exists: Result /= Void
		end

	set_database (s: STRING) is
		do

		end

	type: DATABASE_REPOSITORY [ORACLE] is
		once
			create Result.make
		end

	types: TYPES [ORACLE] is
		once
			create Result
		end

end -- class WIZARD_SPECIFIC
