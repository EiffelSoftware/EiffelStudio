note

	status: "See notice at end of class.";
	date: "$Date$"
--	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

class DB_ALL_TYPES inherit

	HANDLE_USE

create
	make

feature {NONE} -- Initialization

	make
			-- Create an interface object to register
			-- all types for active base.
		require
			database_set: is_database_set
		do
			implementation := handle.database.db_all_types
			implementation.register_all
		end

feature -- Access

	db_type (object: ANY): DB_TYPE
			-- DB_TYPE instance of `object'
		require
			object_not_void: object /= Void
			object_is_register: is_registered (object)
		do
				-- implied by precondition `object_is_register'
			check attached implementation.db_type (object) as l_result then
				Result := l_result
			end
		ensure
			Result = implementation.db_type (object)
		end

feature -- Status report

	is_registered (object: ANY): BOOLEAN
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

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_ALL_TYPES



