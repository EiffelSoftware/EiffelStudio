indexing
	description: "Items stored in database"

class
	DATABASE_ITEM
alias
	"RegistrationService.DataBaseItem"

inherit
	SHARED_DATA
		export
			{NONE} all
		end
	
feature -- Access

	identifier: INTEGER
			-- Database item identifier

	error_message: STRING
			-- Initialization error message

feature -- Status Report

	initialized: BOOLEAN
			-- Is item ready to be stored in database?

end -- class DATABASE_ITEM
--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
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

