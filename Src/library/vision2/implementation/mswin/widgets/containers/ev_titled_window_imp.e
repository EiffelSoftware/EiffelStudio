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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

