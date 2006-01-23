indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

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


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MAIN_WINDOW

