indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create do_nothing end]

feature -- Access
	
	Db_spec: G is
			-- Handle to actual database
		do
			if db_handle = Void then
				!! db_handle.do_nothing
			end
			Result := db_handle
		end

feature {NONE} -- Implementation

	db_handle: G
			-- Actual database handle

end -- class HANDLE_SPEC
