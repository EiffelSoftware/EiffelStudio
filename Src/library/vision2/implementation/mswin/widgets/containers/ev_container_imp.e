indexing
	description:
		" EiffelVision container. Allows only one children.%
		% Deferred class, parent of all the containers.%
		% Mswindows implementation."
	note: " This class would be the equivalent of a wel_composite_window%
		% in the wel hierarchy."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I

	EV_SIZEABLE_CONTAINER_IMP

	EV_WIDGET_IMP
		undefine
			internal_set_minimum_width,
			internal_set_minimum_height,
			internal_set_minimum_size,
			internal_resize,
			minimum_width,
			minimum_height
		redefine
			move_and_resize,
			widget_make
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		do
			{EV_WIDGET_IMP} Precursor (an_interface)
			!! menu_items.make (1)
		end

feature -- Access

	client_x: INTEGER is
			-- Left of the client area.
		do
			Result := client_rect.x
		end

	client_y: INTEGER is
			-- Top of the client area.
		do
			Result := client_rect.y
		end

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := client_rect.width
		end

	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
		end

	background_pixmap: EV_PIXMAP
			-- Pixmap used for the background of the widget

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				if parent_imp /= Void then
					parent_imp.remove_child (Current)
				end
				ww ?= par.implementation
				wel_set_parent (ww)
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
				par_imp.add_child (Current)
			elseif parent_imp /= Void then
				parent_imp.remove_child (Current)
				wel_set_parent (default_parent)
			end
		end

	set_background_pixmap (pix: EV_PIXMAP) is
			-- Set the background pixmap and redraw the container.
		do
			background_pixmap := pix
			if exists then
				invalidate
			end
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := is_child (a_child)
		end

feature {EV_MENU_HOLDER_IMP, EV_MENU_ITEM_HOLDER_IMP} -- Implementation

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- It can be only one list by container because
			-- all the ids must be different

feature {NONE} -- WEL Implementation

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			pixcon: EV_OPTION_BUTTON_IMP
		do
			pixcon ?= draw_item.window_item
			if pixcon /= Void then
				pixcon.on_draw (draw_item)
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
		do
			menu_items.item(menu_id).on_activate
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC) is
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox 
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
		local
			brush: WEL_BRUSH
		do
			paint_dc.set_text_color (control.foreground_color)
			paint_dc.set_background_color (control.background_color)
			!! brush.make_solid (control.background_color)
			set_message_return_value (brush.to_integer)
			disable_default_processing
		end

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background  
		local
			pix: EV_PIXMAP_IMP
		do
 			if exists then
				if background_pixmap /= Void then
					pix ?= background_pixmap.implementation
					create Result.make_by_pattern (pix.bitmap)
				elseif background_color_imp /= Void then
					create Result.make_solid (background_color_imp)
				end
 			end
 		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
 			-- Wm_vscroll message.
 			-- Should be implementated in EV_CONTAINER_IMP,
			-- But as we can't implement a deferred feature
 			-- with an external, it is not possible.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := get_wm_vscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge,
 					gauge ?= windows.item (p)
						if gauge /= Void then
	 						check
 							gauge_exists: gauge.exists
 						end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam), get_wm_vscroll_pos (wparam, lparam))
 						gauge.execute_command (Cmd_gauge, Void)
 					end
 				else
 					-- The message comes from a window scroll bar
 					on_vertical_scroll (get_wm_vscroll_code (wparam, lparam),
 						get_wm_vscroll_pos (wparam, lparam))
 				end
			end
 		end
 
 	on_wm_hscroll (wparam, lparam: INTEGER) is
 			-- Wm_hscroll message.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := get_wm_hscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge
	 				gauge ?= windows.item (p)
	 				if gauge /= Void then
	 					check
	 						gauge_exists: gauge.exists
	 					end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam), get_wm_vscroll_pos (wparam, lparam))
	 					gauge.execute_command (Cmd_gauge, Void)
	 				end
				else
 					-- The message comes from a window scroll bar
 					on_horizontal_scroll (get_wm_hscroll_code (wparam, lparam),
						get_wm_hscroll_pos (wparam, lparam))
 				end
			end
 		end

	on_destroy is
			-- Wm_destroy message.
			-- The window is about to be destroyed.
		do
			if background_pixmap /= Void then
				background_pixmap.destroy
			end
		end

feature {NONE} -- Implementation : deferred features

	client_rect: WEL_RECT is
		deferred
		end

	disable_default_processing is
		deferred
		end

	set_message_return_value (v: INTEGER) is
		deferred
		end

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
		deferred
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
		deferred
		end

	on_horizontal_scroll (scroll_code, position: INTEGER) is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

	get_wm_hscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		deferred
		end

	get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		deferred
		end

	get_wm_hscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		deferred
		end

	get_wm_vscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		deferred
		end

	get_wm_vscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		deferred
		end

	get_wm_vscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		deferred
		end

end -- class EV_CONTAINER_IMP

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
