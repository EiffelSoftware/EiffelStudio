note
	description: "Wrapper for NSClipView."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CLIP_VIEW

inherit
	NS_VIEW

create {NS_OBJECT}
	make_shared

feature -- Working with Background Color

	set_background_color (a_color: NS_COLOR)
		do
			clip_view_set_background_color (item, a_color.item)
		end

	background_color: NS_COLOR
		do
			create Result.make_shared (clip_view_background_color (item))
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			clip_view_set_draws_background (item, a_flag)
		end

	draws_background: BOOLEAN
		do
			Result := clip_view_draws_background (item)
		end

feature -- Setting the Document View

	set_document_view (a_view: NS_VIEW)
		do
			clip_view_set_document_view (item, a_view.item)
		end

	document_view: NS_VIEW
			-- FIXME according to the header this may return type NS_OBJECT
		do
			create Result.make_shared (clip_view_document_view (item))
		end

feature -- Getting the Visible Portion

	document_rect: NS_RECT
		do
			create Result.make
			clip_view_document_rect (item, Result.item)
		end

	document_visible_rect: NS_RECT
		do
			create Result.make
			clip_view_document_visible_rect (item, Result.item)
		end

feature -- Setting the Document Cursor

--	set_document_cursor (a_an_obj: NS_CURSOR)
--		do
--			clip_view_set_document_cursor (cocoa_object, a_an_obj.cocoa_object)
--		end

--	document_cursor: NS_CURSOR
--		do
--			create Result.make_shared (clip_view_document_cursor (cocoa_object))
--		end

feature -- Overriding NSView Methods
--	
--	view_frame_changed (a_notification: NS_NOTIFICATION)
--		do
--			clip_view_view_frame_changed (cocoa_object, a_notification.cocoa_object)
--		end

--	view_bounds_changed (a_notification: NS_NOTIFICATION)
--		do
--			clip_view_view_bounds_changed (cocoa_object, a_notification.cocoa_object)
--		end

feature -- Determining Scrolling Efficiency

	set_copies_on_scroll (a_flag: BOOLEAN)
		do
			clip_view_set_copies_on_scroll (item, a_flag)
		end

	copies_on_scroll: BOOLEAN
		do
			Result := clip_view_copies_on_scroll (item)
		end

feature -- Scrolling

--	autoscroll (a_the_event: NS_EVENT): BOOLEAN
--		do
--			Result := clip_view_autoscroll (cocoa_object, a_the_event.cocoa_object)
--		end

	constrain_scroll_point (a_new_origin: NS_POINT): NS_POINT
		do
			create Result.make
			clip_view_constrain_scroll_point (item, a_new_origin.item, Result.item)
		end

	scroll_to_point (a_new_origin: NS_POINT)
		do
			clip_view_scroll_to_point (item, a_new_origin.item)
		end

feature {NONE} -- Objective-C implementation

	frozen clip_view_set_background_color (a_clip_view: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view setBackgroundColor: $a_color];"
		end

	frozen clip_view_background_color (a_clip_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view backgroundColor];"
		end

	frozen clip_view_set_draws_background (a_clip_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view setDrawsBackground: $a_flag];"
		end

	frozen clip_view_draws_background (a_clip_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view drawsBackground];"
		end

	frozen clip_view_set_document_view (a_clip_view: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view setDocumentView: $a_view];"
		end

	frozen clip_view_document_view (a_clip_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view documentView];"
		end

	frozen clip_view_document_rect (a_clip_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSClipView*)$a_clip_view documentRect]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen clip_view_set_document_cursor (a_clip_view: POINTER; a_an_obj: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view setDocumentCursor: $a_an_obj];"
		end

	frozen clip_view_document_cursor (a_clip_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view documentCursor];"
		end

	frozen clip_view_document_visible_rect (a_clip_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect rect = [(NSClipView*)$a_clip_view documentVisibleRect]; memcpy($res, &rect, sizeof(NSRect));"
		end

	frozen clip_view_view_frame_changed (a_clip_view: POINTER; a_notification: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view viewFrameChanged: $a_notification];"
		end

	frozen clip_view_view_bounds_changed (a_clip_view: POINTER; a_notification: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view viewBoundsChanged: $a_notification];"
		end

	frozen clip_view_set_copies_on_scroll (a_clip_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view setCopiesOnScroll: $a_flag];"
		end

	frozen clip_view_copies_on_scroll (a_clip_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view copiesOnScroll];"
		end

	frozen clip_view_autoscroll (a_clip_view: POINTER; a_the_event: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSClipView*)$a_clip_view autoscroll: $a_the_event];"
		end

	frozen clip_view_constrain_scroll_point (a_clip_view: POINTER; a_new_origin: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSPoint point = [(NSClipView*)$a_clip_view constrainScrollPoint: *(NSPoint*)$a_new_origin]; memcpy($res, &point, sizeof(NSPoint));"
		end

	frozen clip_view_scroll_to_point (a_clip_view: POINTER; a_new_origin: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSClipView*)$a_clip_view scrollToPoint: *(NSPoint*)$a_new_origin];"
		end
end
