note
	description:
		"[
			Top level window. Contains a single widget.
			`title' is not displayed.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			 _____________
			|____________X|
			|             |
			|    item     |
			|_____________|
		]"
	status: "See notice at end of class."
	keywords: "toplevel, window, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WINDOW

inherit
	EV_CELL
		undefine
			create_implementation
		redefine
			destroy,
			has,
			hide,
			identifier_path_separator,
			implementation,
			initialize,
			is_in_default_state,
			show
		end

	EV_POSITIONABLE
		redefine
			destroy,
			implementation,
			initialize,
			is_in_default_state
		end

	EV_WINDOW_ACTION_SEQUENCES

	EV_SHARED_APPLICATION
		undefine
			copy, default_create, is_equal
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	make_with_title (a_title: READABLE_STRING_GENERAL)
			-- Initialize with `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			default_create
			set_title (a_title)
		end

	initialize
			-- Initialize
		do
			Precursor {EV_CELL}
			accelerators.internal_add_actions.extend
				(agent implementation.connect_accelerator (?))
			accelerators.internal_remove_actions.extend
				(agent implementation.disconnect_accelerator (?))
		end

feature -- Access

	upper_bar: EV_VERTICAL_BOX
			-- Room at top of window. (Example use: toolbars.)
			-- Positioned below menu bar.
		obsolete
			"Drop usage as implementation will ignore this setting. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.upper_bar
		ensure
			bridge_ok: Result = implementation.upper_bar
		end

	lower_bar: EV_VERTICAL_BOX
			-- Room at bottom of window. (Example use: statusbar.)
		obsolete
			"Drop usage as implementation will ignore this setting. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.lower_bar
		ensure
			bridge_ok: Result = implementation.lower_bar
		end

	maximum_width: INTEGER
			-- Upper bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.internal_maximum_width
		ensure
			bridge_ok: (Result = implementation.internal_maximum_width) or
				(Result = implementation.minimum_width)
		end

	maximum_height: INTEGER
			-- Upper bound on `height' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.internal_maximum_height
		ensure
			bridge_ok: (Result = implementation.internal_maximum_height) or
				(Result = implementation.minimum_height)
		end

	title: STRING_32
			-- A textual name used by the window manager.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title
		ensure
			bridge_ok: equal (Result, implementation.title)
			not_void: Result /= Void
			cloned: Result /= implementation.title
		end

	menu_bar: detachable EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.menu_bar
		ensure
			bridge_ok: Result = implementation.menu_bar
		end

	maximum_dimension: INTEGER = 32000
			-- Maximum width/height that a window can be set to.

	accelerators: EV_ACCELERATOR_LIST
			-- Key combination shortcuts associated with this window.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.accelerator_list
		ensure
			bridge_ok: Result = implementation.accelerator_list
			not_void: Result /= Void
		end

feature -- Status report

	has (v: EV_WIDGET): BOOLEAN
			-- Does structure include `v'?
		do
			Result := implementation.has (v)
		end

	user_can_resize: BOOLEAN
			-- Can the user resize?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.user_can_resize
		ensure
			bridge_ok: Result = implementation.user_can_resize
		end

	is_border_enabled: BOOLEAN
			-- Is a border displayed around `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_border_enabled
		end

feature -- Command

	destroy
			-- <Precursor>
		do
			Precursor
			if attached shared_environment.application as application then
				application.unregister_window (Current)
			end
		end

	destroy_and_exit_if_last
			-- Destroy current window and destroy instance of EV_APPLICATION if
			-- no more top level windows remain in the system.
		do
			destroy
			if ev_application.windows.is_empty then
				ev_application.destroy
			end
		end

feature -- Status setting

	enable_user_resize
			-- Allow user to resize.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_user_resize
		ensure
			user_can_resize: user_can_resize
		end

	disable_user_resize
			-- Prevent user from resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_user_resize
		ensure
			not_user_can_resize: not user_can_resize
		end

	enable_border
			-- Ensure a border is displayed around `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_border
		ensure
			is_border_enabled: is_border_enabled
		end

	disable_border
			-- Ensure no border is displayed around `Current'.
			-- Has no immediate effect if `user_can_resize', although
			-- is reflected at next call to `disable_user_resize'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_border
		ensure
			border_disabled: not user_can_resize implies not is_border_enabled
		end

	set_maximum_width (a_maximum_width: INTEGER)
			-- Assign `a_maximum_width' to `maximum_width' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_width_non_negative: a_maximum_width >= 0
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
			a_maximum_width_not_greater_than_maximum_dimension:
				a_maximum_width <= maximum_dimension
		do
			implementation.set_maximum_width (a_maximum_width)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
		end

	set_maximum_height (a_maximum_height: INTEGER)
			-- Assign `a_maximum_height' to `maximum_height' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_height_non_negative: a_maximum_height >= 0
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
			a_maximum_height_not_greater_than_maximum_dimension:
				a_maximum_height <= maximum_dimension
		do
			implementation.set_maximum_height (a_maximum_height)
		ensure
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_maximum_size (a_maximum_width, a_maximum_height: INTEGER)
			-- Assign `a_maximum_width' to `maximum_width'
			-- and `a_maximum_height' to `maximum_height' in pixels.
		require
			not_destroyed: not is_destroyed
			a_maximum_width_not_less_than_minimum_width:
				a_maximum_width >= minimum_width
			a_maximum_height_not_less_than_minimum_height:
				a_maximum_height >= minimum_height
			a_maximum_width_not_greater_than_maximum_dimension:
				a_maximum_width <= maximum_dimension
			a_maximum_height_not_greater_than_maximum_dimension:
				a_maximum_height <= maximum_dimension
		do
			implementation.set_maximum_size (a_maximum_width, a_maximum_height)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
			maximum_height_assigned: maximum_height = a_maximum_height
		end

	set_title (a_title: separate READABLE_STRING_GENERAL)
			-- Assign `a_title' to `title'.
		require
			not_destroyed: not is_destroyed
			a_title_not_void: a_title /= Void
		do
			if attached {READABLE_STRING_GENERAL} a_title as l_title then
				implementation.set_title (l_title)
			else
				implementation.set_title (create {STRING_32}.make_from_separate (a_title))
			end
		ensure
			a_title_assigned: title.same_string_general (create {STRING_32}.make_from_separate (a_title))
			cloned: title /= a_title
		end

	remove_title
			-- Make `title' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_title ("")
		ensure
			title_empty: title.is_empty
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Assign `a_menu_bar' to `menu_bar'.
		require
			not_destroyed: not is_destroyed
			no_menu_bar_assigned: menu_bar = Void
			a_menu_bar_not_void: a_menu_bar /= Void
			a_menu_bar_not_parented: a_menu_bar.parent = Void
		do
			implementation.set_menu_bar (a_menu_bar)
		ensure
			assigned: menu_bar = a_menu_bar
		end

	remove_menu_bar
			-- Make `menu_bar' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_menu_bar
		ensure
			menu_bar_void: menu_bar = Void
		end

	lock_update
			-- Lock drawing updates for this window on certain platforms until
			-- `unlock_update' is called.
			--
			-- Note: - Only one window can be locked at a time.
			--       - The window cannot be moved while update is locked.
		require
			not_destroyed: not is_destroyed
			no_locked_window: ev_application.locked_window = Void
		do
			implementation.lock_update
		ensure
			locked_window_is_current: ev_application.locked_window = Current
		end

	unlock_update
			-- Unlock updates for this widget on certain platforms.
		require
			not_destroyed: not is_destroyed
			locked_window_is_current: ev_application.locked_window = Current
		do
			implementation.unlock_update
		ensure
			no_locked_window: ev_application.locked_window = Void
		end

	show
			-- <Precursor>
		do
			Precursor
			if attached shared_environment.application as application then
				application.register_window (Current)
			end
		end

	show_relative_to_window (a_parent: EV_WINDOW)
			-- Show `Current' with respect to `a_parent'.
		require
			not_void: a_parent /= Void
			not_destroyed: not is_destroyed
			parent_not_destroyed: not a_parent.is_destroyed
			a_window_not_current: a_parent /= Current
		do
			implementation.show_relative_to_window (a_parent)
			if attached shared_environment.application as application then
				application.register_window (Current)
			end
		end

	hide
			-- <Precursor>
		do
			Precursor
			if attached shared_environment.application as application then
				application.unregister_window (Current)
			end
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_WINDOW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and Precursor {EV_POSITIONABLE} and
				user_can_resize = user_can_resize_default_state and
				is_border_enabled = is_border_enabled_default_state and
				menu_bar = Void and maximum_width = maximum_dimension and maximum_height = maximum_dimension
		end

	user_can_resize_default_state: BOOLEAN
			-- Is the default state of `Current' `user_can_resize'?
		do
			Result := True
		end

	is_border_enabled_default_state: BOOLEAN
			-- Is the default state of `Current' `is_border_enabled'?
		do
			Result := True
		end

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_WINDOW_IMP} implementation.make
		end

feature {EV_IDENTIFIABLE} -- Implementation

	identifier_path_separator: CHARACTER
			-- Character used to separate path to children.
		once
			Result := ':'
		end

invariant
	consistent_horizontal_bounds: is_usable implies maximum_width >= minimum_width
	consistent_vertical_bounds: is_usable implies maximum_height >= minimum_height

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
