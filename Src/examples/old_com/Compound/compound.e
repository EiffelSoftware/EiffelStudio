indexing
	description: "Root class for compound file viewer";
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOUND_FILE_VIEWER
	
inherit
	WEL_APPLICATION

create
	make

feature
		
	main_window: MAIN_WINDOW is
			-- Application's main window
		once
			create Result.make
		end

	dummy: EOLE_CALL_DISPATCHER

end -- class APPLICATION

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
