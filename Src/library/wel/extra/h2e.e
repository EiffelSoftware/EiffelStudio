class
	H2E

inherit
	WEL_APPLICATION

creation
	make

feature

	main_window: H2E_DIALOG is
			-- Create the application's main window
		once
			!! Result.make
		end

end -- class H2E

--|---------------------------------------------------------------- 
--| Copyright (C) 1995-1997, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
