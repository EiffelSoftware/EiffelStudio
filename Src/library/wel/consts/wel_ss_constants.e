indexing
	description: "Static style (SS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SS_CONSTANTS

feature -- Access

	Ss_left: INTEGER is 0

	Ss_center: INTEGER is 1

	Ss_right: INTEGER is 2

	Ss_icon: INTEGER is 3

	Ss_blackrect: INTEGER is 4

	Ss_grayrect: INTEGER is 5

	Ss_whiterect: INTEGER is 6

	Ss_blackframe: INTEGER is 7

	Ss_grayframe: INTEGER is 8

	Ss_whiteframe: INTEGER is 9

	Ss_useritem: INTEGER is 10

	Ss_simple: INTEGER is 11

	Ss_leftnowordwrap: INTEGER is 12

	Ss_ownerdraw: INTEGER is 13
	
	Ss_bitmap: INTEGER is 14

	Ss_noprefix: INTEGER is 128

	Ss_centerimage: INTEGER is 512

	Ss_notify: INTEGER is 256
	
feature -- Obsolete

	Ss_center_image: INTEGER is 
		obsolete "use `Ss_centerimage' instead"
		do
			Result := Ss_centerimage
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




end -- class WEL_SS_CONSTANTS

