indexing

	Status: "See notice at end of class";
	date: "$Date$"
--	revision: "$Revision$"
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

end -- class DB_ALL_TYPES


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

