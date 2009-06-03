note
	description: "Summary description for {NS_SCROLL_VIEW_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLL_VIEW_API

feature

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScrollView new];"
		end

	frozen document_visible_rect (a_scroll_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSRect frame = [(NSScrollView*)$a_scroll_view documentVisibleRect]; memcpy($res, &frame, sizeof(NSRect));"
		end

	frozen content_size (a_scroll_view: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSScrollView*)$a_scroll_view contentSize]; memcpy($res, &size, sizeof(NSSize));"
		end

	frozen set_document_view (a_scroll_view: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDocumentView: $a_view];"
		end

	frozen document_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view documentView];"
		end

	frozen set_content_view (a_scroll_view: POINTER; a_content_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setContentView: $a_content_view];"
		end

	frozen content_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view contentView];"
		end

	frozen set_document_cursor (a_scroll_view: POINTER; a_an_obj: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDocumentCursor: $a_an_obj];"
		end

	frozen document_cursor (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view documentCursor];"
		end

	frozen set_border_type (a_scroll_view: POINTER; a_type: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBorderType: $a_type];"
		end

	frozen border_type (a_scroll_view: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view borderType];"
		end

	frozen set_background_color (a_scroll_view: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBackgroundColor: $a_color];"
		end

	frozen background_color (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view backgroundColor];"
		end

	frozen set_draws_background (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDrawsBackground: $a_flag];"
		end

	frozen draws_background (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view drawsBackground];"
		end

	frozen set_has_vertical_scroller (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasVerticalScroller: $a_flag];"
		end

	frozen has_vertical_scroller (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasVerticalScroller];"
		end

	frozen set_has_horizontal_scroller (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasHorizontalScroller: $a_flag];"
		end

	frozen has_horizontal_scroller (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasHorizontalScroller];"
		end

	frozen set_vertical_scroller (a_scroll_view: POINTER; a_an_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalScroller: $a_an_object];"
		end

	frozen vertical_scroller (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalScroller];"
		end

	frozen set_horizontal_scroller (a_scroll_view: POINTER; a_an_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalScroller: $a_an_object];"
		end

	frozen horizontal_scroller (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalScroller];"
		end

	frozen autohides_scrollers (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view autohidesScrollers];"
		end

	frozen set_autohides_scrollers (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setAutohidesScrollers: $a_flag];"
		end

	frozen set_horizontal_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalLineScroll: $a_value];"
		end

	frozen set_vertical_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalLineScroll: $a_value];"
		end

	frozen set_line_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setLineScroll: $a_value];"
		end

	frozen horizontal_line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalLineScroll];"
		end

	frozen vertical_line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalLineScroll];"
		end

	frozen line_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view lineScroll];"
		end

	frozen set_horizontal_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalPageScroll: $a_value];"
		end

	frozen set_vertical_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalPageScroll: $a_value];"
		end

	frozen set_page_scroll (a_scroll_view: POINTER; a_value: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setPageScroll: $a_value];"
		end

	frozen horizontal_page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalPageScroll];"
		end

	frozen vertical_page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalPageScroll];"
		end

	frozen page_scroll (a_scroll_view: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view pageScroll];"
		end

	frozen set_scrolls_dynamically (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setScrollsDynamically: $a_flag];"
		end

	frozen scrolls_dynamically (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view scrollsDynamically];"
		end

	frozen tile (a_scroll_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view tile];"
		end

	frozen reflect_scrolled_clip_view (a_scroll_view: POINTER; a_c_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view reflectScrolledClipView: $a_c_view];"
		end

	frozen scroll_wheel (a_scroll_view: POINTER; a_the_event: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view scrollWheel: $a_the_event];"
		end

	frozen set_rulers_visible (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setRulersVisible: $a_flag];"
		end

	frozen rulers_visible (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view rulersVisible];"
		end

	frozen set_has_horizontal_ruler (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasHorizontalRuler: $a_flag];"
		end

	frozen has_horizontal_ruler (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasHorizontalRuler];"
		end

	frozen set_has_vertical_ruler (a_scroll_view: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasVerticalRuler: $a_flag];"
		end

	frozen has_vertical_ruler (a_scroll_view: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasVerticalRuler];"
		end

	frozen set_horizontal_ruler_view (a_scroll_view: POINTER; a_ruler: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHorizontalRulerView: $a_ruler];"
		end

	frozen horizontal_ruler_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view horizontalRulerView];"
		end

	frozen set_vertical_ruler_view (a_scroll_view: POINTER; a_ruler: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setVerticalRulerView: $a_ruler];"
		end

	frozen vertical_ruler_view (a_scroll_view: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view verticalRulerView];"
		end
end
