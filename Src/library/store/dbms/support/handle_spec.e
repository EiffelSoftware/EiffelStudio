indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

feature -- Access
	
	Db_spec: G is
			-- Handle to actual database
		do
			!! Result
		end

end -- class HANDLE_SPEC
