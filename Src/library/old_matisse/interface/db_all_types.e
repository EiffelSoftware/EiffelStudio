indexing

	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

class DB_ALL_TYPES inherit

	HANDLE_USE

creation

	make

feature -- Initialization

	make is
			-- Create an interface object to register
			-- all types for active base.
		do
			implementation := handle.database.db_all_types_i
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

	implementation: DB_ALL_TYPES_I
		-- Handle reference to specific database implementation

invariant

	implementation_not_void: implementation /= Void

end -- class DB_ALL_TYPES


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
