indexing
	description: "Supplier of the application unique default_null_value. "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DEFAULT_NULL_VALUE_SPEC

feature -- Access
	
	db_default_null_value: DB_DEFAULT_NULL_VALUE is
			-- Refers to the application unique default_null_value. 
		once
			create db_default_null_value_impl.make
			Result := db_default_null_value_impl
		end

	feature {NONE} -- Implementation

	db_default_null_value_impl: DB_DEFAULT_NULL_VALUE

end -- class DB_DEFAULT_NULL_VALUE_SPEC

