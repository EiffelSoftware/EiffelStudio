
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the main window.
		local
			control_site: CONTROL_SITE
			bull_eye: BULLS_EYE_PROXY
			a_client_rect: WEL_RECT
		do
			make_top ("Control container")
			resize (600, 400)
			a_client_rect := client_rect
			create control_site.make (Current, "control site")
			control_site.resize (a_client_rect.width, a_client_rect.height)
			
			create bull_eye.make
			
			control_site.attach_control (bull_eye)

			show
		end


end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
