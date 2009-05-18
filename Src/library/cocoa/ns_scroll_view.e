note
	description: "Summary description for {NS_SCROLL_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLL_VIEW

inherit
	NS_VIEW
		redefine
			new
		end
create
	new

feature

	new
		do
			cocoa_object := scroll_view_new
		end

	document_visible_rect: NS_RECT
		do
			create Result.make
			scroll_view_document_visible_rect (cocoa_object, Result.item)
		end

	content_size: NS_SIZE
		do
			create Result.make
			scroll_view_content_size (cocoa_object, Result.item)
		end

	set_document_view (a_view: NS_VIEW)
		do
			scroll_view_set_document_view (cocoa_object, a_view.cocoa_object)
		end

	document_view: NS_VIEW
			-- TODO: Create correct concrete subclass!
		do
			create Result.make_shared (scroll_view_document_view (cocoa_object))
		end

	set_content_view (a_content_view: NS_CLIP_VIEW)
		do
			scroll_view_set_content_view (cocoa_object, a_content_view.cocoa_object)
		end

	content_view: NS_CLIP_VIEW
		do
			create Result.make_shared (scroll_view_content_view (cocoa_object))
		end

--	set_document_cursor (a_an_obj: NS_CURSOR)
--		do
--			scroll_view_set_document_cursor (cocoa_object, a_an_obj.cocoa_object)
--		end

--	document_cursor: NS_CURSOR
--		do
--			create Result.make_shared (scroll_view_document_cursor (cocoa_object))
--		end

	set_border_type (a_type: INTEGER)
		do
			scroll_view_set_border_type (cocoa_object, a_type)
		end

	border_type: INTEGER
		do
			Result := scroll_view_border_type (cocoa_object)
		end

	set_background_color (a_color: NS_COLOR)
		do
			scroll_view_set_background_color (cocoa_object, a_color.cocoa_object)
		end

	background_color: NS_COLOR
		do
			create Result.make_shared (scroll_view_background_color (cocoa_object))
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			scroll_view_set_draws_background (cocoa_object, a_flag)
		end

	draws_background: BOOLEAN
		do
			Result := scroll_view_draws_background (cocoa_object)
		end

	set_has_vertical_scroller (a_flag: BOOLEAN)
		do
			scroll_view_set_has_vertical_scroller (cocoa_object, a_flag)
		end

	has_vertical_scroller: BOOLEAN
		do
			Result := scroll_view_has_vertical_scroller (cocoa_object)
		end

	set_has_horizontal_scroller (a_flag: BOOLEAN)
		do
			scroll_view_set_has_horizontal_scroller (cocoa_object, a_flag)
		end

	has_horizontal_scroller: BOOLEAN
		do
			Result := scroll_view_has_horizontal_scroller (cocoa_object)
		end

	set_vertical_scroller (a_an_object: NS_SCROLLER)
		do
			scroll_view_set_vertical_scroller (cocoa_object, a_an_object.cocoa_object)
		end

	vertical_scroller: NS_SCROLLER
		do
			create Result.make_shared (scroll_view_vertical_scroller (cocoa_object))
		end

	set_horizontal_scroller (a_an_object: NS_SCROLLER)
		do
			scroll_view_set_horizontal_scroller (cocoa_object, a_an_object.cocoa_object)
		end

	horizontal_scroller: NS_SCROLLER
		do
			create Result.make_shared (scroll_view_horizontal_scroller (cocoa_object))
		end

	autohides_scrollers: BOOLEAN
		do
			Result := scroll_view_autohides_scrollers (cocoa_object)
		end

	set_autohides_scrollers (a_flag: BOOLEAN)
		do
			scroll_view_set_autohides_scrollers (cocoa_object, a_flag)
		end

	set_horizontal_line_scroll (a_value: REAL)
		do
			scroll_view_set_horizontal_line_scroll (cocoa_object, a_value)
		end

	set_vertical_line_scroll (a_value: REAL)
		do
			scroll_view_set_vertical_line_scroll (cocoa_object, a_value)
		end

	set_line_scroll (a_value: REAL)
		do
			scroll_view_set_line_scroll (cocoa_object, a_value)
		end

	horizontal_line_scroll: REAL
		do
			Result := scroll_view_horizontal_line_scroll (cocoa_object)
		end

	vertical_line_scroll: REAL
		do
			Result := scroll_view_vertical_line_scroll (cocoa_object)
		end

	line_scroll: REAL
		do
			Result := scroll_view_line_scroll (cocoa_object)
		end

	set_horizontal_page_scroll (a_value: REAL)
		do
			scroll_view_set_horizontal_page_scroll (cocoa_object, a_value)
		end

	set_vertical_page_scroll (a_value: REAL)
		do
			scroll_view_set_vertical_page_scroll (cocoa_object, a_value)
		end

	set_page_scroll (a_value: REAL)
		do
			scroll_view_set_page_scroll (cocoa_object, a_value)
		end

	horizontal_page_scroll: REAL
		do
			Result := scroll_view_horizontal_page_scroll (cocoa_object)
		end

	vertical_page_scroll: REAL
		do
			Result := scroll_view_vertical_page_scroll (cocoa_object)
		end

	page_scroll: REAL
		do
			Result := scroll_view_page_scroll (cocoa_object)
		end

	set_scrolls_dynamically (a_flag: BOOLEAN)
		do
			scroll_view_set_scrolls_dynamically (cocoa_object, a_flag)
		end

	scrolls_dynamically: BOOLEAN
		do
			Result := scroll_view_scrolls_dynamically (cocoa_object)
		end

	tile
		do
			scroll_view_tile (cocoa_object)
		end

	reflect_scrolled_clip_view (a_c_view: NS_CLIP_VIEW)
		do
			scroll_view_reflect_scrolled_clip_view (cocoa_object, a_c_view.cocoa_object)
		end

--	scroll_wheel (a_the_event: NS_EVENT)
--		do
--			scroll_view_scroll_wheel (cocoa_object, a_the_event.cocoa_object)
--		end

	set_rulers_visible (a_flag: BOOLEAN)
		do
			scroll_view_set_rulers_visible (cocoa_object, a_flag)
		end

	rulers_visible: BOOLEAN
		do
			Result := scroll_view_rulers_visible (cocoa_object)
		end

	set_has_horizontal_ruler (a_flag: BOOLEAN)
		do
			scroll_view_set_has_horizontal_ruler (cocoa_object, a_flag)
		end

	has_horizontal_ruler: BOOLEAN
		do
			Result := scroll_view_has_horizontal_ruler (cocoa_object)
		end

	set_has_vertical_ruler (a_flag: BOOLEAN)
		do
			scroll_view_set_has_vertical_ruler (cocoa_object, a_flag)
		end

	has_vertical_ruler: BOOLEAN
		do
			Result := scroll_view_has_vertical_ruler (cocoa_object)
		end

--	set_horizontal_ruler_view (a_ruler: NS_RULER_VIEW)
--		do
--			scroll_view_set_horizontal_ruler_view (cocoa_object, a_ruler.cocoa_object)
--		end

--	horizontal_ruler_view: NS_RULER_VIEW
--		do
--			create Result.make_shared (scroll_view_horizontal_ruler_view (cocoa_object))
--		end

--	set_vertical_ruler_view (a_ruler: NS_RULER_VIEW)
--		do
--			scroll_view_set_vertical_ruler_view (cocoa_object, a_ruler.cocoa_object)
--		end

--	vertical_ruler_view: NS_RULER_VIEW
--		do
--			create Result.make_shared (scroll_view_vertical_ruler_view (cocoa_object))
--		end

feature {NONE} -- Objective-C implementation

	frozen scroll_view_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScrollView new];"
		end

	frozen scroll_view_document_visible_rect (a_scroll_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSScrollView*)$a_scroll_view documentVisibleRect]; memcpy($res, &frame, sizeof(NSRect));"
		end

	frozen scroll_view_content_size (a_scroll_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSScrollView*)$a_scroll_view contentSize]; memcpy($res, &size, sizeof(NSSize));"
		end

	frozen scroll_view_set_document_view (a_scroll_view: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDocumentView: $a_view];"
		end

	frozen scroll_view_document_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view documentView];"
		end

	frozen scroll_view_set_content_view (a_scroll_view: POINTER; a_content_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setContentView: $a_content_view];"
		end

	frozen scroll_view_content_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view contentView];"
		end

	frozen scroll_view_set_document_cursor (a_scroll_view: POINTER; a_an_obj: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDocumentCursor: $a_an_obj];"
		end

	frozen scroll_view_document_cursor (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view documentCursor];"
		end

	frozen scroll_view_set_border_type (a_scroll_view: POINTER; a_type: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBorderType: $a_type];"
		end

	frozen scroll_view_border_type (a_scroll_view: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view borderType];"
		end

	frozen scroll_view_set_background_color (a_scroll_view: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBackgroundColor: $a_color];"
		end

	frozen scroll_view_background_color (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view backgroundColor];"
		end

	frozen scroll_view_set_draws_background (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDrawsBackground: $a_flag];"
		end

	frozen scroll_view_draws_background (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view drawsBackground];"
		end

	frozen scroll_view_set_has_vertical_scroller (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasVerticalScroller: $a_flag];"
		end

	frozen scroll_view_has_vertical_scroller (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasVerticalScroller];"
		end

	frozen scroll_view_set_has_horizontal_scroller (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasHorizontalScroller: $a_flag];"
		end

	frozen scroll_view_has_horizontal_scroller (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasHorizontalScroller];"
		end

	frozen scroll_view_set_vertical_scroller (a_scroll_view: POINTER; a_an_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalScroller: $a_an_object];"
		end

	frozen scroll_view_vertical_scroller (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalScroller];"
		end

	frozen scroll_view_set_horizontal_scroller (a_scroll_view: POINTER; a_an_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalScroller: $a_an_object];"
		end

	frozen scroll_view_horizontal_scroller (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalScroller];"
		end

	frozen scroll_view_autohides_scrollers (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view autohidesScrollers];"
		end

	frozen scroll_view_set_autohides_scrollers (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setAutohidesScrollers: $a_flag];"
		end

	frozen scroll_view_set_horizontal_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalLineScroll: $a_value];"
		end

	frozen scroll_view_set_vertical_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalLineScroll: $a_value];"
		end

	frozen scroll_view_set_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setLineScroll: $a_value];"
		end

	frozen scroll_view_horizontal_line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalLineScroll];"
		end

	frozen scroll_view_vertical_line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalLineScroll];"
		end

	frozen scroll_view_line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view lineScroll];"
		end

	frozen scroll_view_set_horizontal_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalPageScroll: $a_value];"
		end

	frozen scroll_view_set_vertical_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalPageScroll: $a_value];"
		end

	frozen scroll_view_set_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setPageScroll: $a_value];"
		end

	frozen scroll_view_horizontal_page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalPageScroll];"
		end

	frozen scroll_view_vertical_page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalPageScroll];"
		end

	frozen scroll_view_page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view pageScroll];"
		end

	frozen scroll_view_set_scrolls_dynamically (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setScrollsDynamically: $a_flag];"
		end

	frozen scroll_view_scrolls_dynamically (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view scrollsDynamically];"
		end

	frozen scroll_view_tile (a_scroll_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view tile];"
		end

	frozen scroll_view_reflect_scrolled_clip_view (a_scroll_view: POINTER; a_c_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view reflectScrolledClipView: $a_c_view];"
		end

	frozen scroll_view_scroll_wheel (a_scroll_view: POINTER; a_the_event: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view scrollWheel: $a_the_event];"
		end

	frozen scroll_view_set_rulers_visible (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setRulersVisible: $a_flag];"
		end

	frozen scroll_view_rulers_visible (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view rulersVisible];"
		end

	frozen scroll_view_set_has_horizontal_ruler (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasHorizontalRuler: $a_flag];"
		end

	frozen scroll_view_has_horizontal_ruler (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasHorizontalRuler];"
		end

	frozen scroll_view_set_has_vertical_ruler (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasVerticalRuler: $a_flag];"
		end

	frozen scroll_view_has_vertical_ruler (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasVerticalRuler];"
		end

	frozen scroll_view_set_horizontal_ruler_view (a_scroll_view: POINTER; a_ruler: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalRulerView: $a_ruler];"
		end

	frozen scroll_view_horizontal_ruler_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalRulerView];"
		end

	frozen scroll_view_set_vertical_ruler_view (a_scroll_view: POINTER; a_ruler: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalRulerView: $a_ruler];"
		end

	frozen scroll_view_vertical_ruler_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalRulerView];"
		end

feature -- Constants

	frozen ns_line_border: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSLineBorder;"
		end

end
