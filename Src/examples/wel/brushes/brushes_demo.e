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
