indexing
	description: "Values used to replace null in the database, following the type"
	author: "Cedric Reduron"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DEFAULT_NULL_VALUE

feature -- Access
	
	value: DOUBLE
		-- Default value set to integer, double or real field instead of NULL.

feature -- Basic operations

	set_value (a_value: DOUBLE) is
			-- Set `a_value' to value.
		do
			value := a_value
		ensure
			value = a_value
		end

end -- class DB_DEFAULT_NULL_VALUE
