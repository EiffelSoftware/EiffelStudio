indexing
	description: "Objects that enables to set default values%
			%for DB_TABLE_COMPONENT without creating an instance%
			%of the class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_DATABASE_HANDLE

create
	make_for_settings

feature -- Initialization

	make_for_settings is
			-- Give access.
		do
		end

feature -- Status report

	database_handler_set: BOOLEAN is
			-- Is a database handler set?
		do
			Result := database_handler_cell.item /= Void
		end

feature -- Access

	database_handler: ABSTRACT_DB_TABLE_MANAGER is
			-- Interface with the database.
		do
			Result := database_handler_cell.item
		end

	basic_message_handler (message: STRING) is
			-- Display `message' on standard output.
		do
			io.putstring (message)
		end

	basic_confirmation_handler (message: STRING; action_to_confirm: PROCEDURE [ANY, TUPLE]) is
			-- Execute `action_to_confirm' without confirmation.
		do
			action_to_confirm.call ([])
		end

feature -- Basic operations

	set_database_handler (db_handler: ABSTRACT_DB_TABLE_MANAGER) is
			-- Set `db_handler' to
			-- `database_handler'.
		do
			database_handler_cell.put (db_handler)
		end

feature {NONE} -- Implementation

	database_handler_cell: CELL [ABSTRACT_DB_TABLE_MANAGER] is
			-- Default Interface with the database.
		once
			create Result.put (Void)
		ensure
			Result /= Void
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_DATABASE_HANDLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

