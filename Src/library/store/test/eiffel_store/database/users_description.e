note
	description: "Description of class USERS"
	date: "$Date$"
	revision: "$Revision$"

class
	USERS_DESCRIPTION

inherit
	DB_TABLE_DESCRIPTION
		undefine
			Tables,
			is_valid_code
		redefine
			make
		end

	DB_SPECIFIC_TABLES_ACCESS_USE

create
	{DB_SPECIFIC_TABLES_ACCESS} make

feature {NONE} -- Initialization

	make
			--<Precursor>
		do
			Precursor
			create users.make
		end

feature -- Access

	Table_name: STRING = "NEW_USERS"

	Table_code: INTEGER = 1

	Attribute_number: INTEGER = 5
			-- Number of attributes in the table.

	Id_code: INTEGER
			-- Table ID attribute code.
		do
			Result := Userid
		end

	Userid: INTEGER = 1

	Name: INTEGER = 2

	Username: INTEGER = 3

	Email: INTEGER = 4

	Datetime: INTEGER = 5

	attribute_code_list: ARRAYED_LIST [INTEGER]
			-- Feature code list
		once
			create Result.make (Attribute_number)
			Result.extend (Userid)
			Result.extend (Name)
			Result.extend (Username)
			Result.extend (Email)
			Result.extend (Datetime)
		end

	description_list: ARRAYED_LIST [STRING]
			-- Feature name list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Attribute_number)
			Result.extend ("Userid")
			Result.extend ("Name")
			Result.extend ("Username")
			Result.extend ("Email")
			Result.extend ("Datetime")
		end

	type_list: ARRAYED_LIST [INTEGER]
			-- Feature type list. Can be interpreted as a list
			-- or a hash-table.
		once
			create Result.make (Attribute_number)
			Result.extend (Integer_type)
			Result.extend (String_type)
			Result.extend (String_type)
			Result.extend (String_type)
			Result.extend (Date_time_type)
		end

	to_delete_fkey_from_table: HASH_TABLE [INTEGER, INTEGER]
			-- List of tables depending on this one and their
			-- foreign key for this table.
			-- Deletion on this table may imply deletions on
			-- depending tables.
			--| Example: an A table is related to a B table (described by this class)
			--| with a b_id foreign key:
			--| Adding this relation to the hash-table will be:
			--| Result.extend (tables.a_description.B_id, tables.A)
		once
			create Result.make (0)
		end

	to_create_fkey_from_table: HASH_TABLE [INTEGER, INTEGER]
			-- List of associated necessary tables and the
			-- linking foreign keys.
			-- Creation on this table may imply creations on
			-- associated necessary tables.
			--| Example: an A table (described by this class) is related to a B table
			--| with a b_id foreign key:
			--| Adding this relation to the hash-table will be:
			--| Result.extend (B_id, tables.B)
		once
			create Result.make (0)
		end

	attribute_value (i: INTEGER): ANY
			-- Get feature value of feature whose code is 'i'.
		do
			inspect i
				when Userid then
					Result := users.userid
				when Name then
					Result := users.name
				when Username then
					Result := users.username
				when Email then
					Result := users.email
				when Datetime then
					Result := users.datetime
			end
		end

	set_attribute (i: INTEGER; value: ANY)
			-- Set feature value of feature whose code is `i' to `value'.
			-- `value' must be of type STRING, INTEGER, BOOLEAN, CHARACTER,
			-- DOUBLE or DATE_TIME. References are made automatically from
			-- expanded types.
		local
			integer_value: INTEGER_REF
			date_time_value: DATE_TIME
			string_value: STRING
		do
			inspect i
				when Name then
					string_value ?= value
					if attached string_value as l_string then
						users.set_name (string_value)
					end
				when Username then
					string_value ?= value
					if attached string_value as l_string then
						users.set_username (string_value)
					end
				when Email then
					string_value ?= value
					if attached string_value as l_string then
						users.set_email (string_value)
					end
				when Userid then
					integer_value ?= value
					if integer_value /= Void then
						users.set_userid (integer_value.item)
					else
						users.set_userid (0)
					end
				when Datetime then
					date_time_value ?= value
					if attached date_time_value as l_value then
						users.set_datetime (l_value)
					end
			end
		end

feature {NEW_USERS} -- Basic operations

	set_users (a_users: NEW_USERS)
			-- Associate the description to a piece of USERS.
		require
			not_void: a_users /= Void
		do
			users := a_users
		ensure
			users = a_users
		end

feature {NONE} -- Implementation

	users: NEW_USERS
			-- Piece of user associated with the description	

end -- class USERS_DESCRIPTION
