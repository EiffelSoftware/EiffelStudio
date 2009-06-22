note
	description: "Summary description for {NS_TRACKING_AREA}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TRACKING_AREA

inherit
	NS_OBJECT

create
	make

feature -- Initializing the Tracking-Area Object

	make (a_rect: NS_RECT; a_options: INTEGER; a_owner: NS_OBJECT; a_user_info: NS_DICTIONARY)
		require
			options_valid:
		do
			--c_make (a_rect)
		end

feature -- Getting Object Attributes

feature -- Contract Support

	valid_options (a_int: INTEGER): BOOLEAN
		do

		end

feature -- NSTrackingAreaOptions Constants

	frozen tracking_mouse_entered_and_exited: INTEGER
			-- NSTrackingMouseEnteredAndExited
			-- The owner of the tracking area receives mouseEntered: when the mouse cursor enters the area and mouseExited: events when the mouse leaves the area.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTrackingMouseEnteredAndExited"
		end

	frozen tracking_mouse_moved: INTEGER
			-- NSTrackingMouseMoved
			-- The owner of the tracking area receives mouseMoved: messages while the mouse cursor is within the area.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTrackingMouseMoved"
		end

	frozen tracking_cursor_update: INTEGER
			-- NSTrackingCursorUpdate
			-- The owner of the tracking area receives cursorUpdate: messages when the mouse cursor enters the area; when the mouse leaves the area, the cursor is appropriately reset.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTrackingCursorUpdate"
		end

	frozen tracking_in_visible_rect: INTEGER
			-- NSTrackingInVisibleRect
			-- Mouse tracking occurs only in the visible rectangle of the view-in other words, that region of the tracking rectangle that is unobscured.
			-- Otherwise, the entire tracking area is active regardless of overlapping views. The NSTrackingArea object is automatically synchronized with
			-- changes in the view's visible area (visibleRect) and the value returned from rect is ignored.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSTrackingInVisibleRect"
		end



feature {NONE} -- Objective-C implementation

--	c_

end
