indexing
	description: "Handle to actual database";
	date: "$Date$";
	revision: "$Revision$"

class
	HANDLE_SPEC [G -> DATABASE create default_create end]

feature -- Access

	db_spec: DATABASE is
			-- Handle to actual database
		local
			db: DATABASE
		do
			db := db_spec_impl.object
			if db = Void then
				change_object
				db := db_spec_impl.object
			end
			Result := db
		ensure
			not_void: Result /= Void 
		end

feature {NONE} -- Implementation

	db_spec_impl : HANDLE_SPEC_IMPL is
		local
			obj: G
		once
			create obj
			create Result.make (obj)
		end

	change_object is
		local
			obj: G
		do
			create obj
			db_spec_impl.change_object (obj)
		end

end -- class HANDLE_SPEC
