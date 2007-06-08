indexing
	description: "Objects that ..."

deferred class
	EV_CARBON_WINDOW_IMP

inherit
	EV_CARBON_WIDGET_IMP
		undefine
			width,
			height
		redefine
			show,
			x_position,
			y_position,
			screen_x,
			screen_y
		end

	MACWINDOWS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of `Current', always Void as windows cannot be parented
		do
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		do

		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		do
		end

	internal_blocking_window: EV_WINDOW
			-- Window that `Current' is relative to.
			-- Implementation

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			set_width ( a_width )
			set_height ( a_height )
		end

	width: INTEGER is
			-- Horizontal size measured in pixels.
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)
			Result := ( a_rect.right - a_rect.left ).abs
		end

	height: INTEGER is
			-- Vertical size measured in pixels.
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)
			Result := ( a_rect.bottom - a_rect.top ).abs
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)
			a_rect.set_right(a_rect.left + a_width)
			ret := set_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item) -- kWindowContentRgn
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)

			a_rect.set_bottom(a_rect.top + a_height)
			ret := set_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item) -- kWindowContentRgn
		end

	default_width, default_height: INTEGER
			-- Default width and height for the window if set, -1 otherwise.

	x_position: INTEGER is
			-- X coordinate of `Current'
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)
			Result := a_rect.left
		end

	y_position: INTEGER is
			-- Y coordinate of `Current'
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := get_window_bounds_external(c_object, {MACWINDOWS_ANON_ENUMS}.kwindowcontentrgn, a_rect.item)
			Result := a_rect.top
		end

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		local
			a_rect: RECT_STRUCT
			ret: INTEGER
		do
			positioned_by_user := True
			move_window_external(c_object, a_x, x_position, 0)
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		do
			positioned_by_user := True
			move_window_external(c_object, y_position, a_y, 0)
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		do
			positioned_by_user := True
			move_window_external(c_object, a_x, a_y, 0)
		end

	positioned_by_user: BOOLEAN
		-- Has `Current' been positioned by the user?

	screen_x: INTEGER is
			-- Horizontal position of the window on screen,
		do
		end

	screen_y: INTEGER is
			-- Vertical position of the window on screen,
		do
		end

	default_wm_decorations: INTEGER is
			-- Default WM decorations of `Current'.
		do
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		do
		end

	hide is
			-- Hide `Current'.
		do
		end

	is_modal: BOOLEAN
		-- Is `Current' modal?

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		do
		end

feature -- Basic operations

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		do
--			set_blocking_window (a_window)
			show
				-- This extra call is needed otherwise the Window will not be transient.
--			set_blocking_window (a_window)
		end


feature {EV_ANY_I} -- Implementation

	enable_modal is
			-- Set `is_modal' to `True'.
		do
		end

	disable_modal is
			-- Set `is_modal' to `False'.
		do
		end

	forbid_resize is
			-- Forbid the resize of the window.
		do
		end

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end
