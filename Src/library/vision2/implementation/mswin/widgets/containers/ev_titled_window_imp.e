indexing
	description: "Eiffel Vision titled window. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		rename
			maximize as wel_maximize,
			minimize as wel_minimize
		redefine
			destroy,
			make,
			default_style,
			on_show,
			on_size,
			title,
			set_title,
			compute_minimum_height,
			compute_minimum_size,
			interface,
			on_accelerator_command,
			class_name
		end

	EV_ID_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			internal_class_name := new_class_name
			base_make (an_interface)
			make_top ("EV_TITLED_WINDOW")
			create accel_list.make (10)
		end

feature -- Access

	title: STRING is
			-- Application name to be displayed by
			-- the window manager.
		do
			if internal_title /= Void and then internal_title.count /= 0 then
				Result := internal_title
				check
					Result_ok: equal (Result, text)
				end
			end
		end

	internal_title: STRING
			-- Our internal represention of the application
			-- name to be displayed by the window manager.

	icon_name: STRING is
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified.
		do
			if internal_icon_name = Void then
				Result := title
			else
				Result := internal_icon_name
			end
		end

	icon_pixmap: EV_PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon.
		local
			ev_pixmap_imp: EV_PIXMAP_IMP
		do
			if current_icon_pixmap /= Void then
				create Result
				ev_pixmap_imp ?= Result.implementation
				ev_pixmap_imp.set_with_resource (current_icon_pixmap)
			else
					-- Icon is not valid, return the default icon.
				Result := default_pixmaps.Default_window_icon
			end
		end

feature -- Status report

	is_minimized: BOOLEAN is
			-- Is `Current' minimized (iconic state)?
		do
			Result := flag_set (style, Ws_minimize)
		end

	is_maximized: BOOLEAN is
			-- Is `Current' maximized (take the all screen).
		do
			Result := flag_set (style, Ws_maximize)
		end

feature -- Status setting

	raise is
			-- Raise `Current'. ie: put the window on the front
			-- of the screen.
		do
			set_z_order (hwnd_top)
			set_focus
		end

	lower is
			-- Lower `Current'. ie: put the window on the back
			-- of the screen.
		do
			set_z_order (hwnd_bottom)
		end

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			Precursor {EV_WINDOW_IMP}
			
				-- Destroy the icon
			if current_icon_pixmap /= Void then
				current_icon_pixmap.decrement_reference
				current_icon_pixmap := Void
			end
		end

	minimize is
			-- Minimize `Current'
		do
			wel_minimize
		end

	maximize is
			-- Maximize `Current'.
			-- If the window is not shown, it gives it the screen
			-- size, but do not call the precursor otherwise, it
			-- shows the window.
		do
			wel_maximize
		end

feature -- Element change

	set_title (txt: STRING) is
			-- Make `txt' the title of `Current'.            
		do
			internal_title := txt
			if not is_minimized then
				set_text (txt)
			end
		end

	set_icon_name (txt: STRING) is
			-- Make `txt' the new icon name.
		do
			internal_icon_name := txt
			if is_minimized then
				set_text (txt)
			end
		end	

	set_icon_pixmap (a_pixmap: EV_PIXMAP) is
			-- Make `pixmap' the new icon pixmap.
		local
			icon: WEL_ICON
			built_icon: WEL_ICON
			pixmap_imp: EV_PIXMAP_IMP_STATE
			previous_icon_pixmap: WEL_ICON
		do
			pixmap_imp ?= a_pixmap.implementation
			icon := pixmap_imp.icon
			if icon = Void then
				pixmap_imp ?= a_pixmap.implementation
				built_icon := pixmap_imp.build_icon
				built_icon.enable_reference_tracking
				icon := built_icon
			end

				-- Remember the icon
			previous_icon_pixmap := current_icon_pixmap
			current_icon_pixmap := icon
			current_icon_pixmap.increment_reference
				
				-- Set the icon
			set_class_icon (icon)
			set_class_small_icon (icon)

				-- Destroy the old icon
			if previous_icon_pixmap /= Void then
				previous_icon_pixmap.decrement_reference
				previous_icon_pixmap := Void
			end
			
				-- Forget the icon we have just built.
			if built_icon /= Void then
				built_icon.decrement_reference
				built_icon := Void
			end
			pixmap_imp.gdi_compact
		end

feature -- Standard window class values

	class_name: STRING is
			-- Window class name to create.
		do
			Result := internal_class_name
		end
	
feature {EV_ANY_I} -- Implementation

	current_icon_pixmap: WEL_ICON
			-- Current icon set. Void if none
			-- Should not be destroyed until the window is destroyed

	internal_class_name: STRING
			-- Window class name.

	new_class_name: STRING is
			-- Standard application icon used to create the
			-- window class.
			-- Can be redefined to return a user-defined icon.
		do
			make_id
			Result := "EV_TITLED_WINDOW_IMP_" + id.out
		end

	internal_icon_name: STRING
			-- Name given by the user. internal representation.

	compute_minimum_height is
			-- Recompute the minimum height of `Current'.
		local
			mh: INTEGER
		do
			if exists then
				mh := extra_minimum_height
				if item_imp /= Void and item_imp.is_show_requested then
					mh := mh + item_imp.minimum_height
				end
				ev_set_minimum_height (mh)
			end
		end

	compute_minimum_size is
			-- Recompute the minimum size of `Current'.
		local
			mw, mh: INTEGER
		do
			if exists then
				mw := extra_minimum_width
				mh := extra_minimum_height
				if item_imp /= Void and item_imp.is_show_requested then
					mw := mw + item_imp.minimum_width
					mh := mh + item_imp.minimum_height
				end
				ev_set_minimum_size (mw, mh)
			end
		end

	extra_minimum_width: INTEGER is
			-- Compute extra minimum width that does not count `item'.
		require
			exists: exists
		do
			if user_can_resize then
				Result := 2 * window_frame_width
			else
				Result := 2 * dialog_window_frame_width
			end
			Result := Result.max (interface.upper_bar.minimum_width).max
				(interface.lower_bar.minimum_width)
		end

	extra_minimum_height: INTEGER is
			-- Compute extra minimum height that does not count `item'.
		require
			exists: exists
		local
			menu_bar_imp: EV_MENU_BAR_IMP
		do
			Result := title_bar_height + window_border_height

				-- Do not count the frame border if the window is not
				-- resizeable
			if user_can_resize then
				Result := Result + 2 * window_frame_height
			else
				Result := Result + 2 * dialog_window_frame_height
			end

			if menu_bar /= Void then
				menu_bar_imp ?= menu_bar.implementation
				check
					menu_imp_not_void: menu_bar_imp /= Void
				end
				if not menu_bar_imp.wel_count_empty then
					Result := Result + menu_bar_height
				end
			end
			if not interface.upper_bar.is_empty then
				Result := Result + interface.upper_bar.minimum_height + 1
			end
			if not interface.lower_bar.is_empty then
				Result := Result + interface.lower_bar.minimum_height + 1
			end
		end

feature {EV_ANY, EV_ANY_I} -- Accelerators

	on_accelerator_command (an_accel_id: INTEGER) is
			-- Accelerator with `an_accel_id' has just been pressed.
		do
			check
				accel_list_has_an_accel_id: accel_list.has (an_accel_id)
			end
			accel_list.item (an_accel_id).actions.call ([])
		end

	accel_list: HASH_TABLE [EV_ACCELERATOR, INTEGER]
			-- List of accelerators connected to `Current' indexed by
			-- their `id'.

	accelerators: WEL_ACCELERATORS
			-- List of accelerators connected to this window.

	wel_acc_size: INTEGER is
			-- Used to initialize WEL_ARRAY.
		local
			wel_acc: WEL_ACCELERATOR
		once
			wel_acc ?= (create {EV_ACCELERATOR}).implementation
			Result := wel_acc.structure_size
		end

	create_accelerators is
			-- Recreate the accelerators.
		local
			wel_array: WEL_ARRAY [WEL_ACCELERATOR]
			acc: WEL_ACCELERATOR
			n: INTEGER
		do
			if accel_list.is_empty then
				accelerators := Void
			else
	 			from
	 				accel_list.start
		 			create wel_array.make (accel_list.count, wel_acc_size)
					n := 0
				until
					accel_list.after
				loop
					acc ?= accel_list.item_for_iteration.implementation
					wel_array.put (acc, n)
					accel_list.forth
					n := n + 1
	 			end
	 			create accelerators.make_with_array (wel_array)
			end
		end

	connect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Connect key combination `an_accel' to `Current'.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			check
				acc_imp_not_void: acc_imp /= Void
			end
			accel_list.put (an_accel, acc_imp.id)
			create_accelerators
		end

	disconnect_accelerator (an_accel: EV_ACCELERATOR) is
			-- Disconnect key combination `an_accel' from `Current'.
		local
			acc_imp: EV_ACCELERATOR_IMP
		do
			acc_imp ?= an_accel.implementation
			check
				acc_imp_not_void: acc_imp /= Void
			end
			accel_list.remove (acc_imp.id)
			create_accelerators
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_overlapped + Ws_dlgframe + Ws_thickframe
					+ Ws_clipchildren + Ws_clipsiblings
					+ Ws_minimizebox + Ws_maximizebox
					+ Ws_border + Ws_sysmenu 
		end

	on_show is
			-- When `Current' receives the on_show message,
			-- it resizes to the size of the child and sends
			-- a message to the child.
		do
			-- We check if there is a menu
			if has_menu then
				draw_menu
			end

			-- Different behaviors if the window was maximized or not.
			if is_maximized then
				wel_maximize
			elseif is_minimized then
				wel_minimize
			else
					-- Position window if needed.
				if child_cell.is_positioned then
					wel_move (child_cell.x, child_cell.y)
				end
				if item_imp = Void or else child_cell.is_size_specified then
					wel_resize (
						width.min (maximum_width),
						height.min (maximum_height))
				else
						-- When there is an item that is bigger than minimum_size
						-- we try to stretch window as much as we can (ie not bigger
						-- than the maximum size).
					wel_resize (
						(item_imp.width + extra_minimum_width).min (maximum_width),
						(item_imp.height + extra_minimum_height).min (maximum_height))
				end
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
			-- Resize the child if it exists.
		do
			if size_type = Wel_window_constants.Size_minimized then
				set_text (icon_name)
			elseif size_type = Wel_window_constants.Size_restored or
			       size_type = Wel_window_constants.Size_maximized
			then
				set_text (internal_title)
			end
			Precursor {EV_WINDOW_IMP} (size_type, a_width, a_height)
		end

feature {EV_WINDOW_IMP} -- Implementation

	interface: EV_TITLED_WINDOW

feature {NONE} -- Constants

	Wel_icon_constants: WEL_ICON_CONSTANTS is
			-- Icon constants (Icon_Big & Icon_small)
		once
			create Result
		end

end -- class EV_TITLED_WINDOW_IMP

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
--| Revision 1.73  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.49.4.32  2001/05/25 17:12:36  rogers
--| Exported interface to EV_WINDOW_IMP.
--|
--| Revision 1.49.4.31  2001/05/24 17:52:35  pichery
--| Fixed `extra_minimum_width' and `extra_minimum_height'  for
--| non-resizeable windows
--|
--| Revision 1.49.4.30  2001/05/18 20:53:15  pichery
--| - Optimized `title'
--| - Fixed bug in `extra_minimum_width' and `extra_minimum_height': the size
--|   of the frame border was added even when the window is not resizeable
--|   (in this case Windows does not display any frame border)
--|
--| Revision 1.49.4.29  2001/05/15 22:41:23  rogers
--| Removed undefinition of `last_call_was_destroy'.
--|
--| Revision 1.49.4.28  2001/04/19 22:12:19  pichery
--| Fixed `set_icon_pixmap' problem. The WEL_ICON attached to the
--| window was destroyed at the end of the feature but should not be
--| destroyed before the window is destroyed.
--| A consequence of this bug was a disturbing behaviour of the TaskManager
--| under Windows2000
--|
--| Revision 1.49.4.27  2001/03/21 22:36:11  rogers
--| Fixed `extra_minimum_height'. We now only include the menu_bar height if
--| the menu_bar is not empty.
--|
--| Revision 1.49.4.26  2001/02/04 19:10:02  pichery
--| Changed implementation export clause due to the use of a state
--| pattern in EV_DIALOG_IMP.
--|
--| Revision 1.49.4.25  2001/02/03 18:36:21  pichery
--| Exported accelerators to all Vision2 classes.
--|
--| Revision 1.49.4.24  2001/01/21 22:43:22  pichery
--| Added `lock_update' and `unlock_update' to lock graphical updates.
--|
--| Revision 1.49.4.23  2001/01/10 15:14:09  pichery
--| Cosmetics
--|
--| Revision 1.49.4.22  2000/12/14 17:31:11  rogers
--| Made title into a function to allow for returning Void when the string
--| is empty. Added internal title which is used internally instead of the
--| old version of title.
--|
--| Revision 1.49.4.21  2000/11/28 21:35:20  manus
--| Renamed call to `empty' into `is_empty' as now defined in CONTAINER.
--|
--| Revision 1.49.4.20  2000/11/09 23:38:15  manus
--| Modified export clause status and feature clauses so that `class_name',
--| `new_class_name' and `internal_class_name' are where they should be.
--|
--| Revision 1.49.4.19  2000/11/09 18:34:44  manus
--| Cosmetics on `class_name' we generate for Windows.
--|
--| Revision 1.49.4.18  2000/11/04 04:29:36  manus
--| Redefined `class_name' so that we can set a different icon for every window
--| that is created by Vision2.
--|
--| Revision 1.49.4.17  2000/11/01 01:29:20  rogers
--| Accelerator implementation moved here from EV_WINDOW_IMP as accelerators
--| are only on EV_TITLED_WINDOW's.
--|
--| Revision 1.49.4.16  2000/10/25 17:08:09  manus
--| New flag `is_size_specified' which is set when user specifies the size of a widget.
--| When this is set, we have to take the `width' that we have and set the window with it
--| before showing it.
--|
--| Revision 1.49.4.15  2000/10/20 18:14:00  manus
--| Added positioning of Window when set by user before showing the window.
--|
--| Revision 1.49.4.14  2000/10/18 16:20:34  rogers
--| Compute_minimum_width and compute_minimum_Size now both take into account
--| if the child is hidden.
--|
--| Revision 1.49.4.13  2000/10/12 15:50:25  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.49.4.12  2000/09/26 03:54:52  manus
--| Now we displays the window for the first time at the possible maximum size.
--|
--| Revision 1.49.4.11  2000/08/08 17:00:48  manus
--| No need for compute_minimum_size when showing the window. This will be done automatically
--| by `on_show' before showing the window.
--|
--| Revision 1.49.4.10  2000/08/08 16:03:47  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--|
--| Revision 1.49.4.9  2000/07/17 16:52:27  rogers
--| On_show now uses internal_width and internal_height. This fixes bug when
--| calling hide followed by show.
--|
--| Revision 1.49.4.8  2000/06/13 20:31:13  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.49.4.7  2000/05/30 16:10:40  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.49.4.6  2000/05/05 00:15:23  brendel
--| Fixed minimum height.
--|
--| Revision 1.49.4.5  2000/05/04 04:21:40  pichery
--| Removed local variable `default_pixmap'. Is it
--| now a once function.
--|
--| Revision 1.49.4.4  2000/05/04 01:10:07  brendel
--| Uses lower_bar and upper_bar.
--|
--| Revision 1.49.4.3  2000/05/03 22:16:28  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.49.4.2  2000/05/03 19:09:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.70  2000/05/03 04:35:46  pichery
--| Fixed bug in feature `set_icon_pixmap'
--|
--| Revision 1.69  2000/05/03 00:34:35  pichery
--| Removed `icon_mask' & related features
--| Implemented `icon_pixmap' and `set_icon_pixmap'.
--| It does not work yet.
--|
--| Revision 1.68  2000/04/29 03:29:34  pichery
--| Fixed bug.
--|
--| Revision 1.67  2000/04/29 03:27:57  pichery
--| Protected `compute_minimum_size' with
--| test on `exists'.
--|
--| Revision 1.66  2000/04/29 00:44:47  brendel
--| Changed to take minimum width of status bar into account.
--|
--| Revision 1.65  2000/04/28 23:41:27  brendel
--| Uses status bar's minimum height instead of height.
--|
--| Revision 1.64  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.63  2000/04/20 16:31:03  brendel
--| Moved accelerator code into EV_WINDOW_IMP.
--|
--| Revision 1.62  2000/04/19 00:44:24  brendel
--| Revised. Moved some stuff into EV_WINDOW_IMP. Will also be needed for
--| accelerator features.
--|
--| Revision 1.61  2000/04/13 19:40:26  brendel
--| Added 2 FIXME's and removed 1.
--|
--| Revision 1.60  2000/04/03 16:39:10  rogers
--| Redefined destroy from EV_WINDOW_IMP. Added `destroy_feature'.
--|
--| Revision 1.59  2000/03/21 20:21:09  brendel
--| Fixed initialization of WEL_ARRAY [WEL_ACCELERATOR].
--|
--| Revision 1.58  2000/03/21 02:27:49  brendel
--| First implementation of accelerators.
--|
--| Revision 1.57  2000/03/16 17:20:59  brendel
--| Calling {EV_APPLICATION_IMP}.add_root_window immediately instead of
--| through interface.
--|
--| Revision 1.56  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.55.2.1  2000/03/11 00:19:16  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.55  2000/02/29 22:18:27  rogers
--| Redefined initialize, to add the window to the root windows list and to
--| also extend the close_actions with destroy.
--|
--| Revision 1.54  2000/02/29 17:55:24  rogers
--| Undefined last_call_was_destroy  inherited from EV_TITLED_WINDOW_I as
--| last_call_from_destroy is now re-defined in EV_WINDOW_IMP. Needs fixing.
--|
--| Revision 1.53  2000/02/28 19:39:07  rogers
--| During creation, the window is now added to the root_windows list
--| (Still used for windows implementation).
--|
--| Revision 1.52  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.51  2000/02/14 22:26:34  oconnor
--| merged from HACK-O-RAMA
--|
--| Revision 1.49.6.7  2000/02/04 19:08:03  rogers
--| Removed make_with_owner.
--|
--| Revision 1.49.6.6  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.49.6.5  2000/01/27 19:30:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.49.6.4  2000/01/25 23:33:02  brendel
--| Added (dis)connect_accelerator.
--|
--| Revision 1.49.6.3  2000/01/18 00:17:39  rogers
--| Undefined propatae_foreground_color and propagate_background_color from
--| EV_WINDOW_I.
--|
--| Revision 1.49.6.2  1999/12/17 00:44:22  rogers
--| Altered to fit in with the review branch. Some redefinitions required,
--| make now takes an interface. is_show_requested replaces shown.
--|
--| Revision 1.49.6.1  1999/11/24 17:30:30  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.49.2.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
