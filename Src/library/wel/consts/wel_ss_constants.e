note
	description: "Static style (SS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SS_CONSTANTS

feature -- Access

	Ss_left: INTEGER = 0

	Ss_center: INTEGER = 1

	Ss_right: INTEGER = 2

	Ss_icon: INTEGER = 3

	Ss_blackrect: INTEGER = 4

	Ss_grayrect: INTEGER = 5

	Ss_whiterect: INTEGER = 6

	Ss_blackframe: INTEGER = 7

	Ss_grayframe: INTEGER = 8

	Ss_whiteframe: INTEGER = 9

	Ss_useritem: INTEGER = 10

	Ss_simple: INTEGER = 11

	Ss_leftnowordwrap: INTEGER = 12

	Ss_ownerdraw: INTEGER = 13
	
	Ss_bitmap: INTEGER = 14

	Ss_noprefix: INTEGER = 128

	Ss_centerimage: INTEGER = 512

	Ss_notify: INTEGER = 256
	
feature -- Obsolete

	Ss_center_image: INTEGER 
		obsolete "use `Ss_centerimage' instead"
		do
			Result := Ss_centerimage
		end
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SS_CONSTANTS

