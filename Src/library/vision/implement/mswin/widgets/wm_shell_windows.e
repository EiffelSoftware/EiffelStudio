indexing 
	description: "A shell under the control %
		%of the Window manager - always %
		%so for Windows"
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	WM_SHELL_WINDOWS
  
inherit 

	WM_SHELL_I

	SHELL_WINDOWS
		redefine
			default_style,
			on_menu_command,
			on_paint,
			on_size,
			realize,
			class_name
		end

	WEL_DIB_COLORS_CONSTANTS

	WM_CONTROL_WINDOWS

feature -- Initialization

	realize is
			-- Realize current widget
		do
			if not realized then
				realize_current
				realize_children
				set_enclosing_size
				show
			end
		end
feature -- Access

	bar: BAR_WINDOWS
 
feature -- Status setting

	associate_bar (new_bar: BAR_WINDOWS) is
		require
			bar_exists: new_bar /= Void
		do
			bar := new_bar
			if exists then
				adding_menu := true
				wel_set_menu (bar)
				adding_menu := false
			end
		end

	remove_bar is
		do
			bar := Void
			if exists then
				adding_menu := true
				unset_menu
				adding_menu := false
			end
		end

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		local
			ext_text: ANY
		do
			if exists then
				wel_set_text (a_title)
			end
			private_title := clone (a_title);
		end;

	default_style: INTEGER is
		once
			Result := Ws_overlappedwindow + ws_visible
		end

feature -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			pixmap_windows: PIXMAP_WINDOWS
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

	on_size (size_type: INTEGER; a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			if adding_menu then
				private_attributes.set_height (a_height)
				private_attributes.set_width (a_width)				
			else
				resize_shell_children (a_width, a_height)
			end
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionWmShell"
		end

	adding_menu: BOOLEAN
		-- Are we currently adding a menu
		--| do not resize children at this time as forms will
		--| be further resized


end -- class WM_SHELL_WINDOWS
 
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

