--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision option button, implementation interface";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_OPTION_BUTTON_IMP

inherit
	EV_OPTION_BUTTON_I
		redefine
			interface
--		select
--			set_text
		end

	EV_MENU_ITEM_LIST_IMP
		rename
			wel_make as wel_menu_make,
			make_by_id as wel_menu_make_by_id
		undefine
			exists,
			destroy_item,
			initialize,
			main_args,
			destroy
		redefine
			interface
		end

	EV_BUTTON_IMP
		rename
--			set_text as internal_set_text,
			add_click_command as add_popup_command
--		undefine
--			align_text_center,
--			align_text_left,
--			align_text_right
		redefine
			on_bn_clicked,
			default_style,
			make,
			interface
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODA_CONSTANTS
		export
			{NONE} all
		end

	WEL_DRAWING_ROUTINES
		rename
			draw_edge as routine_draw_edge
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the option button with `par' as parent.
		do
			{EV_BUTTON_IMP} Precursor (an_interface)
			!! menu_container.make_track
			extra_width := 40
		end

feature -- Access

	menu: EV_MENU
		-- The menu contained in the option button.

feature -- Status report

	selected_item: EV_MENU_ITEM
			-- which menu item is selected.
			-- Void if the selection is the `text' of the menu.

feature -- Status setting

	clear_selection is
			-- Clear the selection by putting the `text'
			-- of the menu on the option button and assigning
			-- Void to selected_item
		local
			m: WEL_MENU
		do
			set_text (menu.text)
				-- Assign `menu.text' back to menu.
			selected_item := Void
				-- No item selected.
		end

feature -- Event association

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
		do
			set_text (sitem.text)
			if sitem.pixmap_imp /= Void then
				set_pixmap (sitem.pixmap)
			end
			selected_item ?= sitem.interface
		end

feature {EV_CONTAINER_IMP} -- Basic operation

 	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
 			-- Called when the system ask to redraw
 			-- the container
 		local
 			action: INTEGER
 			dc: WEL_DC
 		do
 			action := struct.item_action
 			dc := struct.dc
 			if action = Oda_focus then
 				draw_focus (dc)
 			elseif action = Oda_select then
 				dc.fill_rect (client_rect, background_brush)
 				draw_edge (dc)
 				draw_focus (dc)
 				draw_body (dc)
			elseif action = Oda_drawentire then
 				dc.fill_rect (client_rect, background_brush)
 				if struct.item_state = Ods_focus then
 					draw_focus (dc)
 				end
 				draw_edge (dc)
 				draw_body (dc)
			end
 		end

feature {NONE} -- Implementation

	background_brush: WEL_BRUSH is
		do
			!! Result.make_solid (background_color_imp)
		end

	draw_edge (dc: WEL_DC) is
			-- Draw the edge of the button.
		do
			routine_draw_edge (dc, client_rect, Edge_raised, Bf_rect + Bf_soft)
		end

	draw_focus (dc: WEL_DC) is
			-- Draw the focus line around the button.
		local
			rect: WEL_RECT
		do
			!! rect.make (3, 3, width - 3, height - 3)
			draw_focus_rect (dc, rect)
		end

	draw_body (dc: WEL_DC) is
			-- Draw the body of the button : bitmap + text
		local
			tx, ty: INTEGER
			inrect: WEL_RECT
		do
			!! inrect.make (5, 5, width - 5, height - 6)

			-- If sensitive, we draw everything normaly.
			if is_sensitive then
				-- We draw a little rectangle
				!! inrect.make (width - 25, height // 2 - 5, width - 10, height // 2 + 5)
				routine_draw_edge (dc, inrect, Edge_raised, Bf_rect + Bf_soft)
				-- We draw the rest of the button
				inrect.set_rect (5, 5, width - 30, height - 6)
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					dc.draw_text (text, inrect, Dt_singleline + Dt_left + Dt_vcenter)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
				elseif text /= "" then
					dc.draw_text (text, inrect, Dt_singleline + Dt_left + Dt_vcenter)
				end

			-- If insensitive, the text is gray.
			-- We don't set the pixmap gray, because the quality is bad.
			else
				-- We draw a little rectangle
				!! inrect.make (width - 25, height // 2 - 5, width - 10, height // 2 + 5)
				routine_draw_edge (dc, inrect, Edge_raised, Bf_rect + Bf_soft)
				-- We draw the rest
				if pixmap_imp /= Void and text /= "" then
					!! inrect.make (5, 5, width - 30, height - 6)
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					tx := inrect.left 
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2) 
					draw_insensitive_text (dc, text, tx, ty)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
				elseif text /= "" then
					tx := inrect.left
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2)
					draw_insensitive_text (dc, text, tx, ty)
				end
			end
		end	

feature {NONE} -- Implementation

	menu_container: WEL_MENU
			-- Actual WEL container for the menu

	add_menu (menu_imp: EV_MENU) is
			-- Add `a_menu' into container.
		local
			t: STRING
		do
			if menu_imp.text = Void then
				-- If there is no menu text then set one.
				menu_imp.set_text ("")
			end
			{EV_MENU_HOLDER_IMP} Precursor (menu_imp)
			set_text (menu_imp.text)
			menu := menu_imp
		end 

	remove_menu (menu_imp: EV_MENU) is
			-- Remove the menu from the option button.
		do
			{EV_MENU_HOLDER_IMP} Precursor (menu_imp)
			remove_text
		end

	interface: EV_OPTION_BUTTON

feature {NONE} -- WEL implementation

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
						+ Ws_tabstop + Bs_pushbutton
						+ Bs_text + Bs_ownerdraw
		end

	on_bn_clicked is
			-- When the button is pressed
		local
			composite: WEL_COMPOSITE_WINDOW
		do
			composite ?= parent_imp
			menu_container.show_track (absolute_x, absolute_y + height // 2 - 10, composite)
			--| FIXME execute_command (Cmd_click, Void)
		end

end -- class EV_OPTION_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.19  2000/02/19 04:33:40  oconnor
--| added deferred features
--|
--| Revision 1.18  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.8  2000/02/04 19:06:38  rogers
--| Replaced all occurances of pixmap_imp.internal_dc with pixmap_imp.dc.
--|
--| Revision 1.17.6.7  2000/02/03 17:21:37  brendel
--| Small changes since internal_* features have been renamed.
--|
--| Revision 1.17.6.6  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.17.6.5  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.4  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.17.6.3  2000/01/10 19:21:44  king
--| Changed set_*_alignment to align_text_*.
--|
--| Revision 1.17.6.2  1999/12/17 00:36:18  rogers
--| Altered to fit in with the review branch. Basic alterations, redefinitaions of name clashes etc. Make now takes an interface.
--|
--| Revision 1.17.6.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
