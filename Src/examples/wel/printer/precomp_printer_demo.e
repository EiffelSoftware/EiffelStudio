class
	PRECOMP_PRINTER_DEMO

inherit
	WEL_APPLICATION

creation
	make

feature

	main_window: PRECOMP_MAIN_WINDOW is
			-- Create the application's main window
		once
			create Result.make
		end

end -- class PRECOMP_PRINTER_DEMO

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
