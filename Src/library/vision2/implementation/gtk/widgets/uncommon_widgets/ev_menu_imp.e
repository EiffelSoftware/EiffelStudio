indexing
	description: "Eiffel Vision menu. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent,
			show
		redefine
			interface,
			initialize,
			set_text,
			on_activate
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			list_widget,
			insert_menu_item
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			list_widget := C.gtk_menu_new
			C.gtk_widget_show (list_widget)
			C.gtk_menu_item_set_submenu (
				c_object, list_widget
			)
			Precursor
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			real_text := clone (a_text)
			key := C.gtk_label_parse_uline (text_label,
				eiffel_to_c (u_lined_filter (a_text)))
			C.gtk_widget_show (text_label)
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		local
			pc: EV_COORDINATE
			bw: INTEGER
		do
			pc := (create {EV_SCREEN}).pointer_position
			bw := C.gtk_container_struct_border_width (list_widget)
			if not interface.is_empty then
				C.c_gtk_menu_popup (list_widget, pc.x + bw, pc.y + bw)
			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
			if not interface.is_empty then
				C.c_gtk_menu_popup (list_widget,
					a_widget.screen_x + a_x,
					a_widget.screen_y + a_y)
			end
		end

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_MENU_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		local
			accel_group: POINTER
			menu_imp: EV_MENU_IMP
		do
			Precursor {EV_MENU_ITEM_LIST_IMP} (an_item_imp, pos)
			if an_item_imp.key /= 0 then
				accel_group := C.gtk_menu_ensure_uline_accel_group (list_widget)
				menu_imp ?= an_item_imp
				if menu_imp = Void then
					C.gtk_widget_add_accelerator (an_item_imp.c_object,
						eiffel_to_c ("activate"),
						accel_group,
						an_item_imp.key,
						0,
						0)
				else
					C.gtk_widget_add_accelerator (menu_imp.c_object,
						eiffel_to_c ("activate_item"),
						accel_group,
						menu_imp.key,
						0,
						0)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
		local
			p_imp: EV_MENU_ITEM_LIST_IMP
		do
			p_imp ?= parent_imp
			if p_imp /= Void then
				if p_imp.item_select_actions_internal /= Void then
					p_imp.item_select_actions_internal.call ([interface])
				end
			end
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	list_widget: POINTER

	interface: EV_MENU

end -- class EV_MENU_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.35  2001/06/14 18:25:27  rogers
--| Renamed EV_COORDINATES to EV_COORDINATE.
--|
--| Revision 1.34  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.23.2.3  2001/02/23 17:23:45  king
--| Now redefines `set_text', `insert_menu_item' and `on_activate'.
--|
--| Revision 1.23.2.2  2000/12/15 19:40:03  king
--| Changed .empty to .is_empty
--|
--| Revision 1.23.2.1  2000/05/03 19:08:52  oconnor
--| mergred from HEAD
--|
--| Revision 1.33  2000/04/25 17:57:59  brendel
--| Implemented show_at.
--| Corrected show.
--|
--| Revision 1.32  2000/04/19 16:16:41  brendel
--| Submenu is now always visible again, like on Windows.
--|
--| Revision 1.31  2000/04/14 15:50:18  brendel
--| Corrected removal of submenu.
--|
--| Revision 1.30  2000/04/13 18:56:15  brendel
--| Changed so that submenu arrow is only shown when it has submenu items.
--|
--| Revision 1.29  2000/04/06 23:58:35  brendel
--| Renamed menu_widget to list_widget.
--|
--| Revision 1.28  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.27.2.2  2000/04/05 00:01:41  brendel
--| removed menu_widget.
--| list_widget is now initialized at creation time.
--|
--| Revision 1.27.2.1  2000/04/04 16:27:33  brendel
--| Undefined parent.
--|
--| Revision 1.27  2000/03/23 02:29:13  brendel
--| Implemented `show'.
--|
--| Revision 1.26  2000/03/22 22:57:55  brendel
--| Added show and show_at. Marked as "to be implemented".
--|
--| Revision 1.25  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.24  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.4.6  2000/02/04 19:02:49  brendel
--| Submenu is now set when menu is created.
--|
--| Revision 1.23.4.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.23.4.4  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.23.4.3  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.23.4.2  2000/01/27 19:29:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.4.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.5  1999/11/17 01:53:07  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.22.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.22.2.3  1999/11/04 23:10:31  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
