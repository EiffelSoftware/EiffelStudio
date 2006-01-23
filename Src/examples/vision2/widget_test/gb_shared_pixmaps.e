indexing
	description:	"[
		Objects that provide access to information regarding pixmap location.
		This is only required for compilation purposes for the files copied from
		EiffelBuild. Nothing that has access to `png_location' uses it for anything.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PIXMAPS
	
inherit
	EV_STOCK_PIXMAPS
		rename
			implementation as stock_pixmaps_implementation
		end

feature -- Access

	png_location: STRING is
			-- PNG location of images. Not used in the tour, but required
			-- for compilation of the CONSTANTS file.
		do
		end
		
	icon_build_window: ARRAY [EV_PIXMAP] is
			-- Used in the tour, but only by the pixmap and table
			-- children positioners, and not actually visible.
		do
			create Result.make (1, 1)
			Result.put (Default_window_icon, 1)
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


end -- class GB_SHARED_PIXMAPS
