class
	CONTROLS_DEMO

inherit
	WEL_APPLICATION
		redefine
			accelerators
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			create Result.make
		end

	accelerators: WEL_ACCELERATORS is
			-- Application's accelerators
		once
			create Result.make_by_id (Id_acc_application)
		end

end -- class CONTROLS_DEMO

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

