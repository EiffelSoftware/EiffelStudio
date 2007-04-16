indexing
	description: "Handle to actual database"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HANDLE_SPEC


