note
	description: "Summary description for {DB_SPECIFIC_TABLES_ACCESS}."
	author: ""
	date: "$Date: 2017-02-01 15:21:00 +0100 (Wed, 01 Feb 2017) $"
	revision: "$Revision: 99782 $"

class
	DB_SPECIFIC_TABLES_ACCESS

inherit
	DB_TABLES_ACCESS

create
	make

feature -- Access

	Users: INTEGER = 1

	code_list: ARRAYED_LIST [INTEGER]
			-- Table code list.
		once
			create Result.make (Table_number)
			Result.extend (Users)
		end

	name_list: ARRAYED_LIST [STRING]
			-- Table name list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Table_number)
			Result.extend ("new_users")
		end

	obj (i: INTEGER): DB_TABLE
			-- Return instance of table with code `i'.
		do
			inspect i
				when Users then
					create {NEW_USERS} Result.make
			end
		end

	Table_number: INTEGER = 1

	description (i: INTEGER): DB_TABLE_DESCRIPTION
			-- Return description of table with code `i'.
		do
			inspect i
				when Users then
					Result := users_description
			end
		end

	users_description: USERS_DESCRIPTION
			-- Unique description of table `USERS_DESCRIPTION'.
		once
			create Result.make
		end


end -- class DB_SPECIFIC_TABLES_ACCESS
