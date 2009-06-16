note
	description: "Wrapper for NSWindow."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW

inherit
	NS_OBJECT

	NS_ANIMATION

create
	make
create {NS_OBJECT}
	make_shared

feature -- Creating Windows

	make (a_rect: NS_RECT; a_style_mask: INTEGER; a_defer: BOOLEAN)
			-- Create a new window
		do
			item := {NS_WINDOW_API}.init_with_control_rect_style_mask_backing_defer (a_rect.item, a_style_mask, a_defer)
		end

feature -- Configuring Windows

feature -- Drawing Windows

	display
			-- Passes a display message down the window's view hierarchy, thus redrawing all views within the window,
			-- including the frame view that draws the border, title bar, and other peripheral elements.
			-- You rarely need to invoke this method. NSWindow objects normally record which of their views need display and
			-- display them automatically on each pass through the event loop.
		do
			{NS_WINDOW_API}.display (item)
		end

feature -- Configuring Windows

	set_content_view (a_view: NS_VIEW)
			-- Makes a given view the window's content view.
			-- The view object is resized to fit precisely within the content area of the window.
			-- You can modify the content view's coordinate system through its bounds rectangle,
			-- but can't alter its frame rectangle (that is, its size or location) directly.
		do
			{NS_WINDOW_API}.set_content_view (item, a_view.item)
		ensure
			content_view_set: content_view = a_view
		end

	content_view: NS_VIEW
			-- Returns the window's content view, the highest accessible NS_VIEW object in the window's view hierarchy.
		do
			create Result.make_shared ({NS_WINDOW_API}.content_view (item))
		end

feature -- Sizing

	frame: NS_RECT
			-- Returns the window's frame rectangle in screen coordinates.
		do
			create Result.make
			{NS_WINDOW_API}.frame (item, Result.item)
		end

feature -- ..

	is_visible: BOOLEAN
			-- Indicates whether the window is visible onscreen (even when it's obscured by other windows)
		do
			Result := {NS_WINDOW_API}.is_visible (item)
		end

	set_content_min_size (a_width, a_height: INTEGER)
		do
			{NS_WINDOW_API}.set_content_min_size (item, a_width, a_height)
		ensure
			content_min_size_set: --
		end

	set_default_button_cell (a_button_cell: NS_CELL)
			-- void => no default button
		do
			if a_button_cell = void then
				{NS_WINDOW_API}.set_default_button_cell (item, nil)
			else
				{NS_WINDOW_API}.set_default_button_cell (item, a_button_cell.item)
			end
		end

	set_frame (a_rect: NS_RECT)
		do
			{NS_WINDOW_API}.set_frame (item, a_rect.item)
		end

	title: STRING_32
		local
			c_title: POINTER
		do
			c_title := {NS_WINDOW_API}.title (item)
			if c_title /= nil then
				Result := (create {NS_STRING}.make_shared (c_title)).to_string
			else
				create Result.make_empty
			end
		end

	set_title (a_title: STRING_GENERAL)
			--
		do
			{NS_WINDOW_API}.set_title (item, (create {NS_STRING}.make_with_string (a_title)).item)
		ensure
			title_set: title = a_title
		end

	set_min_size (a_width, a_height: INTEGER)
		do
			{NS_WINDOW_API}.set_min_size (item, a_width, a_height)
		end

	set_shows_resize_indicator (a_flag: BOOLEAN)
		do
			{NS_WINDOW_API}.set_shows_resize_indicator (item, a_flag)
		end

	content_rect_for_frame_rect (a_rect: NS_RECT): NS_RECT
		do
			create Result.make
			{NS_WINDOW_API}.content_rect_for_frame_rect (item, a_rect.item, Result.item)
		end

	frame_rect_for_content_rect (a_rect: NS_RECT): NS_RECT
		do
			create Result.make
			{NS_WINDOW_API}.frame_rect_for_content_rect (item, a_rect.item, Result.item)
		end

	set_delegate (a_delegate: NS_WINDOW_DELEGATE)
		do
			{NS_WINDOW_API}.set_delegate (item, a_delegate.item)
		end

	convert_base_to_screen (a_point: NS_POINT): NS_POINT
		do
			create Result.make
			{NS_WINDOW_API}.convert_base_to_screen (item, a_point.item, Result.item)
		end

	set_alpha_value (a_window_alpha: REAL)
		do
			{NS_WINDOW_API}.set_alpha_value (item, a_window_alpha)
		end

	alpha_value: REAL
		do
			Result := {NS_WINDOW_API}.alpha_value (item)
		end

	set_background_color (a_color: NS_COLOR)
		do
			{NS_WINDOW_API}.set_background_color (item, a_color.item)
		end

	background_color: NS_COLOR
		do
			create Result.make_shared ({NS_WINDOW_API}.background_color (item))
		end

	set_ignores_mouse_events (a_flag: BOOLEAN)
		do
			{NS_WINDOW_API}.set_ignores_mouse_events (item, a_flag)
		end

	ignores_mouse_events: BOOLEAN
		do
			Result := {NS_WINDOW_API}.ignores_mouse_events (item)
		end

	set_level (a_new_level: INTEGER)
		do
			{NS_WINDOW_API}.set_level (item, a_new_level)
		end

	level: INTEGER
		do
			Result := {NS_WINDOW_API}.level (item)
		end

	screen: NS_SCREEN
		local
			res: POINTER
		do
			res := {NS_WINDOW_API}.screen (item)
			if res /= nil then
				create Result.make_shared (res)
			end
		end

	deepest_screen: NS_SCREEN
		do
			create Result.make_shared ({NS_WINDOW_API}.deepest_screen (item))
		end

	miniaturize
		do
			{NS_WINDOW_API}.miniaturize (item, nil)
		end

	deminiaturize
		do
			{NS_WINDOW_API}.deminiaturize (item, nil)
		end

	is_zoomed: BOOLEAN
		do
			Result := {NS_WINDOW_API}.is_zoomed (item)
		end

	zoom
		do
			{NS_WINDOW_API}.zoom (item, nil)
		end

	is_miniaturized: BOOLEAN
		do
			Result := {NS_WINDOW_API}.is_miniaturized (item)
		end

	make_key_and_order_front
		do
			{NS_WINDOW_API}.make_key_and_order_front (item, nil)
		end

	order_front
		do
			{NS_WINDOW_API}.order_front (item, nil)
		end

	order_back
		do
			{NS_WINDOW_API}.order_back (item, nil)
		end

	order_out
		do
			{NS_WINDOW_API}.order_out (item, nil)
		end

	order_window_relative_to (a_place: INTEGER; a_other_win: INTEGER)
		do
			{NS_WINDOW_API}.order_window_relative_to (item, a_place, a_other_win)
		end

	order_front_regardless
		do
			{NS_WINDOW_API}.order_front_regardless (item)
		end

feature -- Managing Attached Windows

	add_child_window_ordered (a_child_win: NS_WINDOW; a_place: INTEGER)
		do
			{NS_WINDOW_API}.add_child_window_ordered (item, a_child_win.item, a_place)
		end

	remove_child_window (a_child_win: NS_WINDOW)
		do
			{NS_WINDOW_API}.remove_child_window (item, a_child_win.item)
		end

	child_windows: NS_ARRAY [NS_WINDOW]
		do
			create Result.make_shared ({NS_WINDOW_API}.child_windows (item))
		end

	parent_window: NS_WINDOW
		do
			create Result.make_shared ({NS_WINDOW_API}.parent_window (item))
		end

	set_parent_window (a_window: NS_WINDOW)
		do
			{NS_WINDOW_API}.set_parent_window (item, a_window.item)
		end

feature -- Animation

	animator: NS_WINDOW
		do
			create Result.make_shared (animation_animator (item))
		end

feature -- Style Mask Constants

	frozen borderless_window_mask: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBorderlessWindowMask;"
		end

	frozen titled_window_mask: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTitledWindowMask;"
		end

	frozen closable_window_mask: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTitledWindowMask;"
		end

	frozen miniaturizable_window_mask: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMiniaturizableWindowMask;"
		end

	frozen resizable_window_mask: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSResizableWindowMask;"
		end

feature -- Window Levels

	frozen floating_window_level: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFloatingWindowLevel"
		end

feature -- Window Ordering Mode

	frozen window_above: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowAbove"
		end

	frozen window_below: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowBelow"
		end

	frozen window_out: INTEGER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowOut"
		end

feature -- Display Device Descriptions

	frozen device_resolution: POINTER
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDeviceResolution"
		end

end
