indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DB_DEFAULT_NULL_VALUE_SPEC

feature -- Access
	
	db_default_null_value: DB_DEFAULT_NULL_VALUE is
			-- Handle to actual database
		once
		--	if db_default_null_value_impl = Void then
				create	db_default_null_value_impl
		--	end
			Result := db_default_null_value_impl
		end

	feature {NONE} -- Implementation

	db_default_null_value_impl: DB_DEFAULT_NULL_VALUE

end -- class DB_DEFAULT_NULL_VALUE_SPEC

