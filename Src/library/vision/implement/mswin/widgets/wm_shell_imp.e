indexing
	description: "A shell under the control %
		%of the Window manager - always %
		%so for Windows"
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	WM_SHELL_IMP

inherit
	WM_SHELL_I

	SHELL_IMP
		redefine
			default_style,
			on_menu_command,
			on_accelerator_command,
			on_paint,
			on_size,
			on_get_min_max_info,
			realize,
			class_name
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WM_CONTROL_WINDOWS

feature -- Initialization

	realize is
			-- Realize current widget
		do
			if not realized then
				realize_current
				realize_children
				set_enclosing_size
			end
		end

feature -- Access

	bar: BAR_IMP
			-- Menu bar
 
feature -- Status setting

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		do
			if exists then
				wel_set_text (a_title)
			end
			private_title := clone (a_title)
		end

	associate_bar (new_bar: BAR_IMP) is
			-- Associate a menu bar to the widget.
		require
			bar_exists: new_bar /= Void
		do
			if bar = Void then
				shell_height := shell_height + menu_bar_height
			end
			bar := new_bar
			if exists then
				wel_set_menu (bar)
			end
		end

feature -- Removal

	remove_bar is
			-- Remove the menu bar from the widget.
		require
			bar_present: bar /= Void
		do
			bar := Void
			if exists then
				unset_menu
			end
			shell_height := shell_height - menu_bar_height
		ensure
			bar_void: bar = Void
		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- The invalid rectangle of the client area,
			-- `invalid_rect', needs repainting.
		local
			pixmap_windows: PIXMAP_IMP
			wel_dib: WEL_DIB
			wel_icon: WEL_ICON
			wel_bitmap: WEL_BITMAP
			draw_x, draw_y, h, w: INTEGER
		do
			if minimized then
				if icon_pixmap /= Void then
					pixmap_windows ?= icon_pixmap.implementation
					wel_dib := pixmap_windows.dib
					if wel_dib /= Void then
						!! wel_bitmap.make_by_dib (paint_dc, wel_dib, dib_rgb_colors)
						h := icon_height - wel_dib.height
						if h > 0 then
							draw_y := h // 2
							h := wel_dib.height
						else
							h := icon_height
						end
						w := icon_width - wel_dib.width
						if w > 0 then
							draw_x := w // 2
							w := wel_dib.width
						else
							w := icon_width
						end
						paint_dc.draw_bitmap (wel_bitmap, draw_x, draw_y, w, h)
					else 
						wel_icon := pixmap_windows.icon
						if wel_icon /= Void then
							paint_dc.draw_icon (wel_icon, 0, 0)
						end
					end
				end
			else
				expose_actions.execute (Current, Void)
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
		do
			if popup_menu /= Void then
				popup_menu.execute (menu_id)
			else
				bar.execute (menu_id)
			end
		end

	on_accelerator_command (accelerator_id: INTEGER) is
			-- The `acelerator_id' has been activated.
		do
			on_menu_command (accelerator_id)
		end

	on_size (size_type: INTEGER; a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			resize_shell_children (a_width, a_height)
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
		 	track: WEL_POINT
		do
			!! track.make (min_width + shell_width, min_height + shell_height)
			min_max_info.set_min_track_size (track)
			!! track.make (max_width + shell_width, max_height + shell_height)
			min_max_info.set_max_track_size (track)
			Precursor (min_max_info)
		end


	default_style: INTEGER is
			-- Default style for creation
		once
			Result := Ws_overlappedwindow + ws_visible
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionWmShell"
		end

end -- class WM_SHELL_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

