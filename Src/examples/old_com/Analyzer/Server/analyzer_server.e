indexing
	description: "Automation server"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ANALYZER_SERVER

inherit
	EOLE_LOCAL_AUTOMATION_SERVER
	
creation
	init

feature -- Access

	main_window: MAIN_WINDOW is
			-- Server main window
		once
			!! Result.make
		end
		
	dispatch_interface: ANALYZER_DISPATCH is
		local
			ref_counter: INTEGER
		once
			!! Result.make (Current)
		end
		
end -- class ANALYZER_SERVER

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------