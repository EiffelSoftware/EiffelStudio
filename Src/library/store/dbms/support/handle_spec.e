indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

feature -- Access
	
	db_spec: G is
			-- Handle to actual database
		do
			if db_spec_impl = Void then
				create	db_spec_impl
			end
			Result := db_spec_impl
		end

	feature {NONE} -- Implementation

	db_spec_impl : G

end -- class HANDLE_SPEC
