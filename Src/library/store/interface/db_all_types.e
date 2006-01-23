indexing

	status: "See notice at end of class.";
	date: "$Date$"
--	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

class DB_ALL_TYPES inherit

	HANDLE_USE

create

	make

feature -- Initialization

	make is
			-- Create an interface object to register
			-- all types for active base.
		do
			implementation := handle.database.db_all_types
			implementation.register_all
		end

feature -- Access
		
	db_type (object: ANY): DB_TYPE is
			-- DB_TYPE instance of `object'
		require
			object_not_void: object /= Void
			object_is_register: is_registered (object)
		do
			Result := implementation.db_type (object)
		ensure
			Result = implementation.db_type (object)
		end

feature -- Status report

	is_registered (object: ANY): BOOLEAN is
			-- Is `object' type registered?
		require
			object_not_void: object /= Void
		do
			Result := implementation.is_registered (object)
		ensure
			Result = implementation.is_registered (object)
		end

feature {NONE} -- Implementation

	implementation: DATABASE_ALL_TYPES [DATABASE]
		-- Handle reference to specific database implementation

invariant

	implementation_not_void: implementation /= Void

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




end -- class DB_ALL_TYPES



