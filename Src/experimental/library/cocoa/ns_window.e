note
	description: "Wrapper for NSWindow."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW

inherit
	NS_RESPONDER
		redefine
			dispose
		end

	NS_ANIMATABLE_PROPERTY_CONTAINER [NS_WINDOW]
		undefine
			dispose
		end

	NS_ENVIRONEMENT
		undefine
			copy
		end

create
	make
create {NS_OBJECT}
	share_from_pointer

feature {NONE} -- Creating Windows

	dispose is
			--
		do
			Precursor {NS_RESPONDER}
			print ("NS_WINDOW collcted " + ($Current).out + "%N")
		end

	make (a_rect: NS_RECT; a_style_mask: NATURAL; a_defer: BOOLEAN)
			-- Create a new window
		require
			valid_style_mask: valid_style_mask (a_style_mask)
		do
			make_from_pointer (window_class.create_instance.item)
			item := {NS_WINDOW_API}.init_with_control_rect_style_mask_backing_defer (item, a_rect.item, a_style_mask, a_defer)
		end

	window_class: OBJC_CLASS
		once
			create Result.make_with_name ("EiffelWrapperWindow")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSWindow"))
			Result.add_method ("keyDown:", agent key_down)
			Result.register
		end

	delegate: detachable NS_OBJECT

feature -- Delegate Methods

	init_delegate
		local
			l_delegate: like delegate
		do
			l_delegate := window_delegate_class.create_instance
			if attached l_delegate then
				l_delegate.init
				{NS_WINDOW_API}.set_delegate (item, l_delegate.item)
				callback_marshal.register_object_for_item (Current, l_delegate.item)
				delegate := l_delegate
			end
		end

	window_delegate_class: OBJC_CLASS
			-- An Objective-C class which has the selectors of the delegate
		once
			create Result.make_with_name ("EiffelWrapperWindowDelegate")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			Result.add_method ("windowDidResize:", agent (a_ptr: POINTER) do window_did_resize end)
			Result.add_method ("windowDidMove:", agent (a_ptr: POINTER) do window_did_move end)
			-- windowDidBecomeKey:
			-- windowDidResignKey:
			-- windowShouldClose: / windowWillClose:
			Result.register
		end

	window_did_resize
			-- Sent by the default notification center immediately after an NSWindow object has been moved.
		do
		end

	window_did_move
		do
		end

feature -- Configuring windows

	style_mask: NATURAL
			-- Returns the window`s style mask, indicating what kinds of control items it displays.
		do
			Result := {NS_WINDOW_API}.style_mask (item)
		end

	set_style_mask (a_style_mask: NATURAL)
			-- Sets the window`s style mask to the given value.
		do
			{NS_WINDOW_API}.set_style_mask (item, a_style_mask)
		end

	works_when_modal: BOOLEAN
			-- Indicates whether the window is able to receive keyboard and mouse events even when some other window is being run modally.
		do
			Result := {NS_WINDOW_API}.works_when_modal (item)
		end

	alpha_value: REAL
			-- Returns the window`s alpha value.
		do
			Result := {NS_WINDOW_API}.alpha_value (item)
		end

	set_alpha_value (a_window_alpha: REAL)
			-- Applies a given alpha value to the entire window.
		do
			{NS_WINDOW_API}.set_alpha_value (item, a_window_alpha)
		end

	background_color: NS_COLOR
			-- Returns the color of the window`s background.
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.background_color (item))
		end

	set_background_color (a_color: NS_COLOR)
			-- Sets the window`s background color to the given color.
		do
			{NS_WINDOW_API}.set_background_color (item, a_color.item)
		end

-- Error generating colorSpace: Message signature for feature not set

	set_color_space (a_color_space: NS_COLOR_SPACE)
			-- Sets the window`s color space.
		do
			{NS_WINDOW_API}.set_color_space (item, a_color_space.item)
		end

	content_view: NS_VIEW
			-- Returns the window's content view, the highest accessible NS_VIEW object in the window's view hierarchy.
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.content_view (item))
		end

	set_content_view (a_view: NS_VIEW)
			-- Makes a given view the window's content view.
			-- The view object is resized to fit precisely within the content area of the window.
			-- You can modify the content view's coordinate system through its bounds rectangle,
			-- but can't alter its frame rectangle (that is, its size or location) directly.
		do
			{NS_WINDOW_API}.set_content_view (item, a_view.item)
		ensure
			content_view_set: a_view.item = content_view.item -- content_view.is_equal (a_view)
		end

	can_hide: BOOLEAN
			-- Indicates whether the window can be hidden when its application becomes hidden (during execution of the `NSApplication' `hide:' method).
		do
			Result := {NS_WINDOW_API}.can_hide (item)
		end

	set_can_hide (a_flag: BOOLEAN)
			-- Specifies whether the window can be hidden when its application becomes hidden (during execution of the `NSApplication' `hide:' method).
		do
			{NS_WINDOW_API}.set_can_hide (item, a_flag)
		end

-- Error generating isOnActiveSpace: Message signature for feature not set

	hides_on_deactivate: BOOLEAN
			-- Indicates whether the window is removed from the screen when its application becomes inactive.
		do
			Result := {NS_WINDOW_API}.hides_on_deactivate (item)
		end

	set_hides_on_deactivate (a_flag: BOOLEAN)
			-- Specifies whether the window is removed from the screen when the application is inactive.
		do
			{NS_WINDOW_API}.set_hides_on_deactivate (item, a_flag)
		end

	collection_behavior: NATURAL
			-- Identifies the window`s behavior in window collections.
		do
			Result := {NS_WINDOW_API}.collection_behavior (item)
		end

	set_collection_behavior (a_behavior: NATURAL)
			-- Specifies the window`s behavior in window collections.
		do
			{NS_WINDOW_API}.set_collection_behavior (item, a_behavior)
		end

	is_opaque: BOOLEAN
			-- Indicates whether the window is opaque.
		do
			Result := {NS_WINDOW_API}.is_opaque (item)
		end

	set_opaque (a_is_opaque: BOOLEAN)
			-- Specifies whether the window is opaque.
		do
			{NS_WINDOW_API}.set_opaque (item, a_is_opaque)
		end

	has_shadow: BOOLEAN
			-- Indicates whether the window has a shadow.
		do
			Result := {NS_WINDOW_API}.has_shadow (item)
		end

	set_has_shadow (a_has_shadow: BOOLEAN)
			-- Specifies whether the window has a shadow.
		do
			{NS_WINDOW_API}.set_has_shadow (item, a_has_shadow)
		end

	invalidate_shadow
			-- Invalidates the window shadow so that it is recomputed based on the current window shape.
		do
			{NS_WINDOW_API}.invalidate_shadow (item)
		end

--	autorecalculates_content_border_thickness_for_edge (a_edge: NS_RECT_EDGE): BOOLEAN
--			-- Indicates whether the window calculates the thickness of a given border automatically.
--		do
--			Result := {NS_WINDOW_API}.autorecalculates_content_border_thickness_for_edge (item, a_edge.item)
--		end

--	set_autorecalculates_content_border_thickness_for_edge (a_flag: BOOLEAN; a_edge: NS_RECT_EDGE)
--			-- Specifies whether the window calculates the thickness of a given border automatically.
--		do
--			{NS_WINDOW_API}.set_autorecalculates_content_border_thickness_for_edge (item, a_flag, a_edge.item)
--		end

--	content_border_thickness_for_edge (a_edge: NS_RECT_EDGE): REAL
--			-- Indicates the thickness of a given border of the window.
--		do
--			Result := {NS_WINDOW_API}.content_border_thickness_for_edge (item, a_edge.item)
--		end

--	set_content_border_thickness_for_edge (a_thickness: REAL; a_edge: NS_RECT_EDGE)
--			-- Specifies the thickness of a given border of the window.
--		do
--			{NS_WINDOW_API}.set_content_border_thickness_for_edge (item, a_thickness, a_edge.item)
--		end

	prevents_application_termination_when_modal: BOOLEAN
			-- Indicates whether the window prevents application termination when modal.
		do
			Result := {NS_WINDOW_API}.prevents_application_termination_when_modal (item)
		end

	set_prevents_application_termination_when_modal (a_flag: BOOLEAN)
			-- Specifies whether the window prevents application termination when modal.
		do
			{NS_WINDOW_API}.set_prevents_application_termination_when_modal (item, a_flag)
		end

feature -- Drawing Windows

	display
			-- Passes a display message down the window's view hierarchy, thus redrawing all views within the window,
			-- including the frame view that draws the border, title bar, and other peripheral elements.
			-- You rarely need to invoke this method. NSWindow objects normally record which of their views need display and
			-- display them automatically on each pass through the event loop.
		do
			{NS_WINDOW_API}.display (item)
		end

feature -- Sizing

	frame: NS_RECT
			-- Returns the window's frame rectangle in screen coordinates.
		do
			create Result.make
			{NS_WINDOW_API}.frame (item, Result.item)
		end

	set_frame (a_rect: NS_RECT; a_display: BOOLEAN)
			-- Sets the origin and size of the window's frame rectangle according to a given frame rectangle, thereby setting its position and size onscreen.
		do
			{NS_WINDOW_API}.set_frame (item, a_rect.item, a_display)
		end

	set_frame_top_left_point (a_point: NS_POINT)
			-- Positions the top-left corner of the window's frame rectangle at a given point in screen coordinates.
		do
			{NS_WINDOW_API}.set_frame_top_left_point (item, a_point.item)
		end

	set_frame_top_left_point_flipped (a_point: NS_POINT)
			-- Positions the top-left corner of the window's frame rectangle at a given point in screen coordinates.
			-- XXX
		do
			a_point.y := zero_screen.frame.size.height - a_point.y
			{NS_WINDOW_API}.set_frame_top_left_point (item, a_point.item)
		end

feature -- Managing Title Bars

	standard_window_button (a_window_button_kind: INTEGER): detachable NS_BUTTON
			-- Returns the window button of a given window button kind in the window's view hierarchy.
			-- `Void' when such a button is not in the window's view hierarchy.
		local
			l_ptr: POINTER
		do
			l_ptr := {NS_WINDOW_API}.standdard_window_button (item, a_window_button_kind)
			if l_ptr /= default_pointer then
				create Result.share_from_pointer (l_ptr)
			end
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

feature -- Handling Mouse Events

	set_accepts_mouse_moved_events (a_flag: BOOLEAN)
			-- Specifies whether the window is to accept mouse-moved events.
		do
			{NS_WINDOW_API}.set_accepts_mouse_moved_events (item, a_flag)
		end

feature -- Managing Default Buttons

	set_default_button_cell (a_button_cell: detachable NS_CELL)
			-- Makes the key equivalent of button cell the Return (or Enter) key, so when the user presses Return that button performs as if clicked.
			-- void => no default button
		do
			if a_button_cell = void then
				{NS_WINDOW_API}.set_default_button_cell (item, default_pointer)
			else
				{NS_WINDOW_API}.set_default_button_cell (item, a_button_cell.item)
			end
		ensure
			default_button_cell_set: equal (a_button_cell, default_button_cell)
		end

	default_button_cell: detachable NS_CELL
			-- Returns the button cell that performs as if clicked when the window receives a Return (or Enter) key event.
			-- This cell draws itself as the focal element for keyboard interface control, unless another button cell is focused on,
			-- in which case the default button cell temporarily draws itself as normal and disables its key equivalent.
			-- The window receives a Return key event if no responder in its responder chain claims it, or if the user presses the Control key along with the Return key.
		local
			l_button_cell: POINTER
		do
			l_button_cell := {NS_WINDOW_API}.default_button_cell (item)
			if l_button_cell /= default_pointer then
				create Result.share_from_pointer (l_button_cell)
			end
		end

feature -- Managing Titles

	title: NS_STRING
			-- Returns either the string that appears in the title bar of the window, or the path to the represented file.
			-- If the title has been set using setTitleWithRepresentedFilename:, this method returns the file's path.
		local
			c_title: POINTER
		do
			c_title := {NS_WINDOW_API}.title (item)
			if c_title /= default_pointer then
				create Result.share_from_pointer (c_title)
			else
				create Result.make_empty
			end
		end

	set_title (a_title: NS_STRING)
			-- Sets the string that appears in the window's title bar (if it has one) to a given string and displays the title.
			-- Also sets the title of the window's miniaturized window.
		do
			{NS_WINDOW_API}.set_title (item, a_title.item)
		ensure
		--	title_set: title.is_equal (a_title.to_string_32) -- Does not hold in all cases! (why?)
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
			{NS_WINDOW_API}.set_delegate (item, a_delegate.delegate_item)
		end

	convert_base_to_screen (a_point: NS_POINT): NS_POINT
			-- Converts a given point from the window's base coordinate system to the screen coordinate system.
		do
			create Result.make
			{NS_WINDOW_API}.convert_base_to_screen (item, a_point.item, Result.item)
		end

	convert_base_to_screen_top_left (a_point: NS_POINT): NS_POINT
			-- Same as convert_base_to_screen but using screen-coordinates with origin at the top left and
		do
			create Result.make
			{NS_WINDOW_API}.convert_base_to_screen (item, a_point.item, Result.item)
			Result.y := zero_screen.frame.size.height - Result.y
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

	screen: detachable NS_SCREEN
			-- Returns the screen the window is on. Void if the window is offscreen.
		local
			res: POINTER
		do
			res := {NS_WINDOW_API}.screen (item)
			if res /= default_pointer then
				create Result.share_from_pointer (res)
			end
		end

	deepest_screen: NS_SCREEN
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.deepest_screen (item))
		end

	miniaturize
		do
			{NS_WINDOW_API}.miniaturize (item, default_pointer)
		end

	deminiaturize
		do
			{NS_WINDOW_API}.deminiaturize (item, default_pointer)
		end

	is_zoomed: BOOLEAN
		do
			Result := {NS_WINDOW_API}.is_zoomed (item)
		end

	zoom
		do
			{NS_WINDOW_API}.zoom (item, default_pointer)
		end

	is_miniaturized: BOOLEAN
		do
			Result := {NS_WINDOW_API}.is_miniaturized (item)
		end

	order_front
		do
			{NS_WINDOW_API}.order_front (item, default_pointer)
		end

	order_back
		do
			{NS_WINDOW_API}.order_back (item, default_pointer)
		end

	order_out
		do
			{NS_WINDOW_API}.order_out (item, default_pointer)
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
			create Result.share_from_pointer ({NS_WINDOW_API}.child_windows (item))
		end

	parent_window: NS_WINDOW
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.parent_window (item))
		end

	set_parent_window (a_window: NS_WINDOW)
		do
			{NS_WINDOW_API}.set_parent_window (item, a_window.item)
		end

feature -- Managing Key Status

	is_key_window: BOOLEAN
			-- Indicates whether the window is the key window for the application.
		do
			Result := {NS_WINDOW_API}.is_key_window (item)
		end

	can_become_key_window: BOOLEAN
			-- Indicates whether the window can become the key window.
		do
			Result := {NS_WINDOW_API}.can_become_key_window (item)
		end

	make_key_window
			-- Makes the window the key window.
		do
			{NS_WINDOW_API}.make_key_window (item)
		end

	make_key_and_order_front (a_sender: NS_OBJECT)
			-- Moves the window to the front of the screen list, within its level, and makes it the key window; that is, it shows the window.
		do
			{NS_WINDOW_API}.make_key_and_order_front (item, a_sender.item)
		end

	become_key_window
			-- Invoked automatically to inform the window that it has become the key window; never invoke this method directly.
		do
			{NS_WINDOW_API}.become_key_window (item)
		end

	resign_key_window
			-- Invoked automatically when the window resigns key window status; never invoke this method directly.
		do
			{NS_WINDOW_API}.resign_key_window (item)
		end

feature -- Managing Responders

	initial_first_responder: NS_VIEW
			-- Returns view that`s made first responder the first time the window is placed onscreen.
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.initial_first_responder (item))
		end

	first_responder: NS_RESPONDER
			-- Returns the window`s first responder.
		do
			create Result.share_from_pointer ({NS_WINDOW_API}.first_responder (item))
		end

	set_initial_first_responder (a_view: NS_VIEW)
			-- Sets a given view as the one that`s made first responder (also called the key view) the first time the window is placed onscreen.
		do
			{NS_WINDOW_API}.set_initial_first_responder (item, a_view.item)
		end

	make_first_responder (a_responder: NS_RESPONDER): BOOLEAN
			-- Attempts to make a given responder the first responder for the window.
		do
			Result := {NS_WINDOW_API}.make_first_responder (item, a_responder.item)
		end

feature -- Moving Windows

	is_movable_by_window_background: BOOLEAN
			-- Indicates whether the window is movable by clicking and dragging anywhere in its background.
		do
			Result := {NS_WINDOW_API}.is_movable_by_window_background (item)
		end

	set_movable_by_window_background (a_flag: BOOLEAN)
			-- Sets whether the window is movable by clicking and dragging anywhere in its background.
		do
			{NS_WINDOW_API}.set_movable_by_window_background (item, a_flag)
		end

	is_movable: BOOLEAN
			-- Indicates whether the window can be moved by clicking in its title bar or background.
		do
			Result := {NS_WINDOW_API}.is_movable (item)
		end

	set_movable (a_flag: BOOLEAN)
			-- Specifies whether the window can be dragged by clicking in its title bar or background.
		do
			{NS_WINDOW_API}.set_movable (item, a_flag)
		end

	center
			-- Sets the window`s location to the center of the screen.
		do
			{NS_WINDOW_API}.center (item)
		end

feature -- Contract support

	valid_style_mask (a_natural: NATURAL): BOOLEAN
			-- True iff a_natural is a valid style-mask
		local
			all_flags: NATURAL
		do
			if a_natural = borderless_window_mask then
				Result := True
			else
				all_flags := titled_window_mask | closable_window_mask | miniaturizable_window_mask | resizable_window_mask
				Result := all_flags.bit_or (a_natural) = all_flags
			end
		end

feature -- Style Mask Constants

	frozen borderless_window_mask: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSBorderlessWindowMask;"
		end

	frozen titled_window_mask: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTitledWindowMask;"
		end

	frozen closable_window_mask: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSClosableWindowMask;"
		end

	frozen miniaturizable_window_mask: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMiniaturizableWindowMask;"
		end

	frozen resizable_window_mask: NATURAL
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSResizableWindowMask;"
		end

feature -- Window Levels

	frozen normal_window_level: INTEGER
			-- The default level for NSWindow objects.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSNormalWindowLevel"
		end

	frozen floating_window_level: INTEGER
			-- Useful for floating palettes.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFloatingWindowLevel"
		end

	frozen modal_panel_window_level: INTEGER
			-- The level for a modal panel.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSModalPanelWindowLevel"
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

feature -- NSWindowButton - Accessing Standard Title Bar Buttons

	frozen window_close_button: INTEGER
			-- The close button.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowCloseButton"
		end

	frozen window_minimize_button: INTEGER
			-- The minimize button.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowMiniaturizeButton"
		end

	frozen window_zoom_button: INTEGER
			-- The zoom button.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowZoomButton"
		end

	frozen window_toolbar_button: INTEGER
			-- The toolbar button.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowToolbarButton"
		end

	frozen window_document_icon_button: INTEGER
			-- The document icon button.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSWindowDocumentIconButton"
		end
end
