--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision window. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

	--| FIXME (Christophe Bonnard)
	--| When closing main window, `dispose' tries to unreference the c_object
	--| while ref_count is already 0.

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			set_default_colors,
			x_position,
			y_position,
			replace
		redefine
			minimum_width,
			minimum_height,
			set_minimum_size,
			interface,
			initialize,
			destroy,
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- create the untitled window.
			-- FIXME better comment
		do
			base_make (an_interface)

			set_c_object (C.gtk_window_new (C.Gtk_window_popup_enum))

			-- set the events to be handled by the window
			C.c_gtk_widget_set_all_events (c_object)

			set_title ("")
			-- set title also realizes the window.
		end

feature  -- Access

	item: EV_WIDGET is
			-- Current item
		local
			p: POINTER
			o: EV_ANY_IMP
		do
			p := C.gtk_container_children (hbox)
			if p /= NULL then
				p := C.g_list_nth_data (p, 0)
				if p /= NULL then
					o := eif_object_from_c (p)
					Result ?= o.interface
				end
			end
		end

	x_position: INTEGER is
			-- Horizontal position relative to parent
		local
			a_x: INTEGER
		do
			if is_show_requested then
				C.gdk_window_get_position (
					C.gtk_widget_struct_window (c_object),
					$a_x,
					NULL
				)
				Result := a_x
			else
				Result := -1
			end
			
		end

	y_position: INTEGER is
			-- Vertical position relative to parent
		local
			a_y: INTEGER
		do
			if is_show_requested then
				C.gdk_window_get_position (
					C.gtk_widget_struct_window (c_object),
					NULL,
					$a_y
				)
				Result := a_y
			else
				Result := -1
			end
			
		end

 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have

	minimum_width: INTEGER	
	
	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have

	minimum_height: INTEGER

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		local
			p : POINTER
		do
			p := C.gtk_window_struct_title (c_object)
			if p /= NULL then
				create Result.make_from_c (p)
			else
				create Result.make (0)
			end
		end

        widget_group: EV_WIDGET is
                        -- Widget with wich current widget is associated.
                        -- By convention this widget is the "leader" of a group
                        -- widgets. Window manager will treat all widgets in
                        -- a group in some way; for example, it may move or
                        -- iconify them together
		do
			check
					not_yet_implemented: False
			end
		end

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

	is_modal: BOOLEAN is
			-- Must the window be closed before application continues?
		do
			Result := C.gtk_window_struct_modal (c_object) = 1
		end

	blocking_window: EV_WINDOW
			-- Window that `Current' is a transient for.

feature -- Status setting

	block is
			-- Wait until window is closed by the user.
		local
			dummy: INTEGER
		do
			from
			until
				is_destroyed or else not is_show_requested
			loop
				dummy := C.gtk_main_iteration_do (True)
			end
		end

	enable_modal is
			-- Set `is_modal' to `True'.
		do
			C.gtk_window_set_modal (c_object, True)
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
			C.gtk_window_set_modal (c_object, False)
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
		do
			blocking_window := a_window
			win_imp ?= a_window.implementation
			C.gtk_window_set_transient_for (c_object, win_imp.c_object)
		end


	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		do
			set_position (a_x, y_position)
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		do
			set_position (x_position, a_y)
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			C.gtk_widget_set_uposition (c_object, a_x, a_y)
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		do
			set_size (a_width, height)
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		do
			set_size (width, a_height)
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			set_bounds (x_position, y_position, a_width, a_height)
		end

	forbid_resize is
			-- Forbid the resize of the window.
		do
			C.gtk_window_set_policy (c_object, 0, 0, 0)
		end

	allow_resize is
			-- Allow the resize of the window.
		do
			C.gtk_window_set_policy (c_object, 1, 1, 0)
		end

	destroy is
			-- Render `Current' unuseable.
		do
			interface.close_actions.call ([])
			Precursor
		end

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
			i: EV_WIDGET
		do
			i := item
			if i /= Void then
				remove_item_actions.call ([i])
				w ?= i.implementation
				check
					item_has_implementation: w /= Void
				end
				C.gtk_container_remove (hbox, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_box_pack_end (hbox, w.c_object, True, True, 0)
				new_item_actions.call ([v])
			end
		end

	set_maximum_width (max_width: INTEGER) is
			-- Set `maximum_width' to `max_width'.
		do
			-- to be tested
			C.gdk_window_set_hints (
				C.gtk_widget_struct_window (c_object),
				x_position,
				y_position,
				minimum_width,
				minimum_height,
				max_width,
				maximum_height,
				1
			)
			maximum_width := max_width
		end 

	set_maximum_height (max_height: INTEGER) is
			-- Set `maximum_height' to `max_height'.
		do
			-- to be tested
			C.gdk_window_set_hints (
				C.gtk_widget_struct_window (c_object),
				x_position,
				y_position,
				minimum_width,
				minimum_height,
				maximum_width,
				max_height,
				1
			)
			maximum_height := max_height
		end

	set_minimum_size (a_minimum_width, a_minimum_height: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		do
			minimum_width := a_minimum_width
			minimum_height := a_minimum_height
			C.gtk_widget_set_usize (c_object, a_minimum_width, a_minimum_height)
		end

	set_title (new_title: STRING) is
			-- Set `title' to `new_title'.
		do
			C.gtk_window_set_title (c_object, eiffel_to_c (new_title))

			-- Give the gtk window a corresponding gdk window
			C.gtk_widget_realize (c_object)
		end

	set_widget_group (group_widget: EV_WIDGET) is
			-- Set `widget_group' to `group_widget'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR) is
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			C.gtk_box_pack_start (vbox, mb_imp.list_widget, False, True, 0)
			C.gtk_box_reorder_child (vbox, mb_imp.list_widget, 0)
		end

	remove_menu_bar is
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
				C.gtk_container_remove (vbox, mb_imp.list_widget)
			end
			menu_bar := Void
		end

feature {NONE} -- Implementation

	initialize is
			-- Create the vertical box `vbox' and horizontal box `hbox'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `hbox'
			-- and the status bar.
			-- The `hbox' will contain the child of the window.
		local
			scr: EV_SCREEN
			bar_imp: EV_VERTICAL_BOX_IMP
		do
			Precursor
			vbox := C.gtk_vbox_new (False, 0)
			C.gtk_widget_show (vbox)
			C.gtk_container_add (c_object, vbox)
			hbox := C.gtk_hbox_new (False, 0)
			C.gtk_widget_show (hbox)

			bar_imp ?= interface.upper_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end
			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			C.gtk_box_pack_start (vbox, hbox, True, True, 0)

			bar_imp ?= interface.lower_bar.implementation
			check
				bar_imp_not_void: bar_imp /= Void
			end
			C.gtk_box_pack_start (vbox, bar_imp.c_object, False, True, 0)

			enable_motion_notify (c_object)

			create scr
			set_maximum_width (scr.width)
			set_maximum_height (scr.height)

			connect_signal_to_actions (
					"destroy",
					interface.close_actions,
					Void
			)
		end

	vbox: POINTER
			-- Vertical_box to have a possibility for a menu on the
			-- top and a status bar at the bottom.

	hbox: POINTER
			-- Horizontal box for the child

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW

end -- class EV_WINDOW_IMP

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
--| Revision 1.22  2000/06/07 17:27:38  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.12.4.9  2000/05/25 00:36:22  king
--| Removed redundant code
--|
--| Revision 1.12.4.8  2000/05/09 16:39:40  brendel
--| Added FIXME.
--|
--| Revision 1.12.4.7  2000/05/05 22:25:39  brendel
--| Switched upper and lower bar.
--|
--| Revision 1.12.4.6  2000/05/05 20:41:12  brendel
--| Fixed bug in `block'.
--|
--| Revision 1.12.4.5  2000/05/04 19:00:23  brendel
--| Implemented lower_bar and upper_bar.
--|
--| Revision 1.12.4.4  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.21  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.20  2000/04/28 22:02:37  brendel
--| A status bar can now be any widget.
--|
--| Revision 1.19  2000/04/04 20:52:28  oconnor
--| formatting
--|
--| Revision 1.18  2000/02/29 02:24:02  brendel
--| Improved implementation of `block'.
--| `is_modal' is now directly looked up from GTK.
--|
--| Revision 1.17  2000/02/26 01:29:02  brendel
--| Added calls to action sequences when adding/removing an item.
--|
--| Revision 1.16  2000/02/24 18:50:19  king
--| Implemented set_minimum_size to avoid post-condition violation
--|
--| Revision 1.15  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.4.2.2.28  2000/02/08 09:32:23  oconnor
--| replaced put with replace
--|
--| Revision 1.12.4.2.2.27  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.12.4.2.2.26  2000/02/07 23:42:05  oconnor
--| fixed ordering bug in set_menu_bar
--|
--| Revision 1.12.4.2.2.25  2000/02/04 21:24:54  king
--| Added status bar features, removed old features add_static_menu and
--| add_status_bar
--|
--| Revision 1.12.4.2.2.24  2000/02/04 04:48:03  oconnor
--| released
--|
--| Revision 1.12.4.2.2.23  2000/02/03 22:57:17  brendel
--| Added and implemented *menu_bar features.
--|
--| Revision 1.12.4.2.2.22  2000/01/28 17:41:21  oconnor
--| removed obsolete features
--|
--| Revision 1.12.4.2.2.21  2000/01/27 19:29:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.4.2.2.20  2000/01/26 18:13:10  brendel
--| Removed modal-related features.
--|
--| Revision 1.12.4.2.2.19  2000/01/25 00:19:44  oconnor
--| removed old command stuff, use action sequences
--|
--| Revision 1.12.4.2.2.18  2000/01/22 01:34:51  oconnor
--| added assignement attemt checks and null pointer checks
--|
--| Revision 1.12.4.2.2.17  2000/01/18 01:08:20  king
--| Altered setting of max and min dimensions, needs redoing/omitting as hints
--| are not definite
--|
--| Revision 1.12.4.2.2.16  1999/12/17 23:19:54  oconnor
--| removed obsolete features from redefine
--|
--| Revision 1.12.4.2.2.15  1999/12/16 09:18:28  oconnor
--| removed connect_to_application, added is_modal
--|
--| Revision 1.12.4.2.2.14  1999/12/15 23:48:09  oconnor
--| redefine put to correctly put child inside hbox
--|
--| Revision 1.12.4.2.2.13  1999/12/13 20:01:49  oconnor
--| commented out old command stuff
--|
--| Revision 1.12.4.2.2.12  1999/12/09 18:13:19  oconnor
--| rename widget -> c_object
--|
--| Revision 1.12.4.2.2.11  1999/12/09 02:33:16  oconnor
--| king: added enable_motion_notify call to initiailize
--|
--| Revision 1.12.4.2.2.10  1999/12/08 17:42:31  oconnor
--| removed more inherited externals
--|
--| Revision 1.12.4.2.2.9  1999/12/07 19:16:04  brendel
--| Ignore previous log message.
--| Changed implementation of set_size to use set_bounds.
--|
--| Revision 1.12.4.2.2.8  1999/12/07 18:56:16  brendel
--| Changed implementation of width and height to make it more compact.
--| Improved contracts on set_bounds.
--|
--| Revision 1.12.4.2.2.7  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.12.4.2.2.6  1999/12/03 00:51:12  brendel
--| Changed c_gtk_widget_set_uposition to gtk_widget_set_uposition.
--|
--| Revision 1.12.4.2.2.5  1999/12/02 22:24:01  brendel
--| Commented out features that are redefined in EV_WINDOW_IMP.
--|
--| Revision 1.12.4.2.2.4  1999/12/01 20:28:39  oconnor
--| x is now x_position
--|
--| Revision 1.12.4.2.2.3  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.12.4.2.2.2  1999/11/30 23:15:34  oconnor
--| commented out set_parent, parent is now done through GTK introspection
--|
--| Revision 1.12.4.2.2.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.7  1999/11/23 22:58:31  oconnor
--| added _enum suffix
--|
--| Revision 1.12.2.6  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.12.2.5  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.12.2.4  1999/11/04 23:10:30  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.3  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
