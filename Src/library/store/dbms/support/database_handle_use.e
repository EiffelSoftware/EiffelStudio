indexing
	description: "Specific handle use";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_HANDLE_USE [G -> DATABASE]

inherit
	
	HANDLE_SPEC [G]

feature {NONE} -- Status report

	database_handle: DATABASE_HANDLE [DATABASE]  is
			-- Shared handle reference
		once
			!! Result
			Result := db_spec.database_handle
		end

end -- class DATABASE_HANDLE_USE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
