indexing
	description: "Values used to replace null in the database, following the type"
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DEFAULT_NULL_VALUE

creation
	make

feature -- Creation

	make is
		do
			create datetime_value.make_from_string_default ("01/01/1600 12:00:00.0 PM")			
		ensure
			datetime_not_void: datetime_value /= Void
		end
feature -- Access
	
	value: DOUBLE
		-- Default value set to integer, double or real field instead of NULL.

	datetime_value: DATE_TIME
		-- Default value set to date and time instead of NULL.

feature -- Basic operations

	set_value (a_value: DOUBLE) is
			-- Set `a_value' to value.
		do
			value := a_value
		ensure
			value = a_value
		end

	set_datetime_value (a_datetime_value: DATE_TIME) is
			-- Set `a_date_value' to date_value.
		require
			not_void: a_datetime_value /= Void
		do
			datetime_value := a_datetime_value
		ensure
			datetime_value = a_datetime_value
		end

end -- class DB_DEFAULT_NULL_VALUE
