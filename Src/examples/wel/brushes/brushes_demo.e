class
	BRUSHES_DEMO

inherit
	WEL_APPLICATION
		redefine
			idle_action
		end

creation
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			enable_idle_action
			create Result.make
		end

	idle_action is
		do
			if main_window.rectangle_demo /= Void and then
					main_window.rectangle_demo.exists then
				main_window.rectangle_demo.draw
			end
			if main_window.three_d_demo /= Void and then
					main_window.three_d_demo.exists and then
					main_window.three_d_demo.ready then
				main_window.three_d_demo.go
			end
		end

end -- class BRUSHES_DEMO

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

