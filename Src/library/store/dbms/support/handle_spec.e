indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

feature -- Access

	db_spec: DATABASE is
			-- Handle to actual database
		do
			Result := db_spec_impl.item
		ensure
			not_void: Result /= Void 
		end

feature {NONE} -- Implementation

	update_handle is
			-- Update handle according to current connection.
		local
			obj: G
		do
			create obj
			db_spec_impl.replace (obj)
		end

	db_spec_impl : CELL [DATABASE] is
			-- Unique reference to application database handle.
		local
			obj: G
		once
			create obj
			create Result.put (obj)
		end

end -- class HANDLE_SPEC
