indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint,
			class_icon,
			on_destroy
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING) is
		local
			file: RAW_FILE
			dc: WEL_CLIENT_DC
			dib: WEL_DIB
		do
			mdi_child_window_make (a_parent, a_name)
			create file.make_open_read (a_name)
			create dib.make_by_file (file)
			create dc.make (Current)
			dc.get
			create bitmap.make_by_dib (dc, dib, Dib_rgb_colors)
			dc.release
			create scroller.make (Current, bitmap.width, bitmap.height, 1, 20)
		end

feature -- Access

	bitmap: WEL_BITMAP
			-- Bitmap selected by the user

feature -- Basic operations

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap
		do
			paint_dc.draw_bitmap (bitmap, 0, 0,
				bitmap.width, bitmap.height)
		end
		
	on_destroy is
			-- Notify `parent' that `Current' is being destroyed.
		local
			main_window: MAIN_WINDOW
		do
			main_window ?= parent
			check
				parent_of_correct_type: main_window /= Void
			end
			main_window.remove_child_reference (Current)
		end
		

feature {NONE} -- Implementation

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_child_window)
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


end -- class CHILD_WINDOW

