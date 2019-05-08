note
	description: "Eiffel Vision titled window. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			old_make,
			default_style,
			on_show,
			on_size,
			title,
			set_title,
			interface,
			class_name,
			is_displayed,
			execute_resize_actions,
			has_title_bar,
			make,
			title_name
		end

	EV_ID_IMP

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'
		do
			internal_class_name := new_class_name
			create internal_icon_name.make_empty
			Precursor
		end

	title_name: STRING
			-- Title name used for registration.
		do
			Result := "EV_TITLED_WINDOW"
		end

feature -- Access

	title: STRING_32
			-- Application name to be displayed by
			-- the window manager.
		do
			if attached internal_title as l_internal_title then
				Result := l_internal_title.twin
			else
				create Result.make_empty
			end
		end

	internal_title: detachable STRING_32
			-- Our internal represention of the application
			-- name to be displayed by the window manager.

	icon_name: STRING_32
			-- Short form of application name to be
			-- displayed by the window manager when
			-- application is iconified.
		do
			if internal_icon_name /= Void then
				Result := internal_icon_name.twin
			else
				create Result.make_empty
			end
		end

	icon_pixmap: EV_PIXMAP
			-- Bitmap that could be used by the window manager
			-- as the application's icon.
		local
			ev_pixmap_imp: detachable EV_PIXMAP_IMP
		do
			if attached current_icon_pixmap as l_current_icon_pixmap then
				create Result
				ev_pixmap_imp ?= Result.implementation
				check ev_pixmap_imp /= Void then end
				ev_pixmap_imp.set_with_resource (l_current_icon_pixmap)
			else
					-- Icon is not valid, return the default icon.
				Result := default_pixmaps.Default_window_icon
			end
		end

feature -- Status report

	is_minimized: BOOLEAN
			-- Is `Current' minimized (iconic state)?
		do
			Result := flag_set (style, Ws_minimize)
		end

	is_maximized: BOOLEAN
			-- Is `Current' maximized (take the all screen).
		do
			Result := flag_set (style, Ws_maximize)
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on screen?
			-- `Result' is False if `is_minimized'.
		do
			Result := Precursor {EV_WINDOW_IMP} and not is_minimized
		end

	has_title_bar: BOOLEAN
			-- Does current have a title bar?
		do
				-- Not a constant because some descendants do not have a title bar.
			Result := True
		end

feature -- Status setting

	raise
			-- Raise `Current'. ie: put the window on the front
			-- of the screen.
		local
			l_bool: BOOLEAN
		do
			if not is_show_requested then
				show
			end
			if is_minimized then
				restore
			end
			l_bool := {WEL_API}.set_foreground_window (wel_item)
		end

	lower
			-- Lower `Current'. ie: put the window on the back
			-- of the screen.
		do
			set_z_order (hwnd_bottom)
		end

	destroy
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			Precursor {EV_WINDOW_IMP}

				-- Destroy the icon
			if attached current_icon_pixmap as l_current_icon_pixmap then
				l_current_icon_pixmap.decrement_reference
				current_icon_pixmap := Void
			end
		end

	minimize
			-- Minimize `Current'
		do
			wel_minimize
		end

	maximize
			-- Maximize `Current'.
			-- If the window is not shown, it gives it the screen
			-- size, but do not call the precursor otherwise, it
			-- shows the window.
		do
			wel_maximize
		end

feature -- Element change

	set_title (txt: READABLE_STRING_GENERAL)
			-- Make `txt' the title of `Current'.
		do
			internal_title := txt.as_string_32.twin
			if not is_minimized then
				set_text (txt)
			end
		end

	set_icon_name (txt: READABLE_STRING_GENERAL)
			-- Make `txt' the new icon name.
		do
			internal_icon_name := txt.as_string_32.twin
			if is_minimized then
				set_text (txt)
			end
		end

	set_icon_pixmap (a_pixmap: EV_PIXMAP)
			-- Make `pixmap' the new icon pixmap.
		local
			icon: detachable WEL_ICON
			built_icon: detachable WEL_ICON
			pixmap_imp: detachable EV_PIXMAP_IMP_STATE
			previous_icon_pixmap: detachable WEL_ICON
		do
			pixmap_imp ?= a_pixmap.implementation
			check pixmap_imp /= Void then end
			icon := pixmap_imp.icon
			if icon = Void then
				pixmap_imp ?= a_pixmap.implementation
				check pixmap_imp /= Void then end
				built_icon := pixmap_imp.build_icon
				built_icon.enable_reference_tracking
				icon := built_icon
			end
			check icon /= Void then end

				-- Remember the icon

			previous_icon_pixmap := current_icon_pixmap
			current_icon_pixmap := icon
			icon.increment_reference

			set_icon (icon, icon)

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

	class_name: STRING_32
			-- Window class name to create.
		do
			Result := internal_class_name
		end

feature {EV_ANY_I} -- Implementation

	current_icon_pixmap: detachable WEL_ICON
			-- Current icon set. Void if none
			-- Should not be destroyed until the window is destroyed

	internal_class_name: STRING_32
			-- Window class name.

	new_class_name: STRING_32
			-- Standard application icon used to create the
			-- window class.
			-- Can be redefined to return a user-defined icon.
		do
			make_id
			Result := {STRING_32} "EV_TITLED_WINDOW_IMP"
		end

	internal_icon_name: STRING_32
			-- Name given by the user. internal representation.

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- default style of `Current'.
			-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_overlapped + Ws_dlgframe + Ws_thickframe
					+ Ws_clipchildren + Ws_clipsiblings
					+ Ws_minimizebox + Ws_maximizebox
					+ Ws_border + Ws_sysmenu
		end

	on_show
			-- When `Current' receives the on_show message,
			-- it resizes to the size of the child and sends
			-- a message to the child.
		local
			l_rect: WEL_RECT
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
				elseif attached item_imp as l_item_imp then

						-- When there is an item that is bigger than minimum_size
						-- we try to stretch window as much as we can (ie not bigger
						-- than the maximum size).
					l_rect := extra_minimum_rect
					wel_resize (
						(l_item_imp.width + l_rect.width).min (maximum_width),
						(l_item_imp.height + l_rect.height).min (maximum_height))
				end
			end
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- Called when `Current' is resized.
			-- Resize the child if it exists.
		do
			if size_type = Wel_window_constants.Size_minimized then
				if icon_name.is_empty then
					set_text (internal_title)
				else
					set_text (icon_name)
				end
				if minimize_actions_internal /= Void then
					minimize_actions_internal.call (Void)
				end
			elseif size_type = Wel_window_constants.Size_maximized then
				if maximize_actions_internal /= Void then
					maximize_actions_internal.call (Void)
				end
					-- We must now override restore_actions if we are changing state
					-- from minimimzed to maximized. This is not considered a restore.
				if fire_restore_actions = True then
					fire_restore_actions := False
				end
			elseif size_type = Wel_window_constants.Size_restored then
				set_text (internal_title)
			end
			Precursor {EV_WINDOW_IMP} (size_type, a_width, a_height)

				 -- We now set our internal flag, as it must be set after we
				 -- call `execute_resize_actions'.

			if size_type = Wel_window_constants.Size_minimized or
			size_type = Wel_window_constants.Size_maximized then
					-- If we are now maximized or minimized then we
					-- must assign True to `fire_restore_actions', so that
					-- the next time we resize, we know to fire them.
				fire_restore_actions := True
			end
		end

	execute_resize_actions (a_width, a_height: INTEGER)
			-- execute `resize_actions_internal' if not Void.
		do
			trigger_resize_actions (a_width, a_height)
				-- We must only fire restore actions if
				-- `fire_restore_actions'.
			if fire_restore_actions then
				if restore_actions_internal /= Void then
					restore_actions.call (Void)
				end
				fire_restore_actions := False
			end
		end

	fire_restore_actions: BOOLEAN
		-- If `True' then restore_actions must be fired.
		-- We have to have this flag, as Windows does not provide a message
		-- which distinguishes between a normal resize or a restore.

	copy_box_attributes (original_box, new_box: EV_VERTICAL_BOX)
			-- Copy all widgets from `original_box' to `new_box'
			-- and set attributes.
		require
			original_box_not_void: original_box /= Void
			new_box_not_void: new_box /= Void
			new_box_empty: new_box.is_empty
		local
			current_widget: EV_WIDGET
			l_or_imp, l_ub_imp: detachable EV_VERTICAL_BOX_IMP
		do
			fixme (once "[We should copy all attributes and action sequences.]")
			l_ub_imp ?= new_box.implementation
			check l_ub_imp /= Void then end
			if l_ub_imp.wel_item /= default_pointer then
				from
					l_or_imp ?= original_box.implementation
					check l_or_imp /= Void then end
						-- We remove `original_box' from Current as otherwise we would
						-- be violating the `parent_contains_current' invariant.
					l_or_imp.set_parent_imp (Void)
					original_box.start
				until
					original_box.is_empty
				loop
					current_widget := original_box.item
					original_box.remove
					new_box.extend (current_widget)
				end
				new_box.set_padding (original_box.padding)
				new_box.set_border_width (original_box.border_width)
				check
					ub_imp_not_void: l_ub_imp /= Void then
				end
				l_ub_imp.on_parented
				l_ub_imp.wel_set_parent (Current)
				l_ub_imp.set_top_level_window_imp (Current)
			end
		ensure
			old_and_new_counts_consistent: old original_box.count = new_box.count
			original_box_empty: original_box.is_empty
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TITLED_WINDOW note option: stable attribute end

feature {NONE} -- Constants

	Wel_icon_constants: WEL_ICON_CONSTANTS
			-- Icon constants (Icon_Big & Icon_small)
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TITLED_WINDOW_IMP










