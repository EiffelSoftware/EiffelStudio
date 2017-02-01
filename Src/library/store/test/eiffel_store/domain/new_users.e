note
	description: "[
				Class which allows EiffelStore to retrieve/store
				the content of a table row from database table USERS
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_USERS

inherit

	DB_TABLE
		undefine
			Tables,
			is_valid_code
		redefine
			out
		end

	DB_SPECIFIC_TABLES_ACCESS_USE
		redefine
			out
		end

create
	make

feature -- Access

	userid: INTEGER

	name: STRING

	username: STRING

	email: STRING

	datetime: DATE_TIME

	table_description: DB_TABLE_DESCRIPTION
			-- Description associated to the users.
		do
			tables.users_description.set_users (Current)
			Result := tables.users_description
		end


feature -- Initialization

	set_default
		do
			userid := 0
			name := ""
			username :=""
			email := ""
			datetime := create {DATE_TIME}.make_now
		end



feature -- Basic operations

	set_userid (a_userid: INTEGER)
		do
			userid := a_userid
		end

	set_name (a_name: STRING)
		do
			name := a_name
		end

	set_username (a_username: STRING)
		do
			username := a_username
		end

	set_email (a_email: STRING)
		do
			email := a_email
		end

	set_datetime (a_datetime: DATE_TIME)
		do
			datetime := a_datetime
		end

feature -- Output

	out: STRING
			-- Printable representation of current object.
		do
			Result := ""

			Result.append ("Userid: " + userid.out + "%N")

			Result.append ("Name: " + name + "%N")

			Result.append ("Username: " + username + "%N")

			Result.append ("Email: " + email + "%N")

			Result.append ("Datetime: " + datetime.out + "%N")
		end

end -- class USER
