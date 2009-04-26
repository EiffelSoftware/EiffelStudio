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

	has_horizontal_scroller : BOOLEAN
		do
			Result := scroll_view_has_horizontal_scroller (cocoa_object)
		end

	has_vertical_scroller : BOOLEAN
		do
			Result := scroll_view_has_vertical_scroller (cocoa_object)
		end

	set_autohides_scrollers (a_flag: BOOLEAN)
		do
			scroll_view_set_autohides_scrollers (cocoa_object, a_flag)
		end

	set_border_type (a_border_type: INTEGER)
			--
		require
			valid_border_type: True -- fixme
		do
			scroll_view_set_border_type (cocoa_object, a_border_type)
		end

	set_document_view (a_view: NS_VIEW)
		do
			scroll_view_set_document_view (cocoa_object, a_view.cocoa_object)
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			scroll_view_set_draws_background (cocoa_object, a_flag)
		end



	set_has_vertical_scroller (flag: BOOLEAN)
		do
			scroll_view_set_has_vertical_scroller (cocoa_object, flag)
		end

	set_has_horizontal_scroller (flag: BOOLEAN)
		do
			scroll_view_set_has_horizontal_scroller (cocoa_object, flag)
		end

feature {NONE} -- Objective-C Implementation

	frozen scroll_view_new: POINTER is
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSScrollView new];"
		end

--+ (NSSize)frameSizeForContentSize:(NSSize)cSize hasHorizontalScroller:(BOOL)hFlag hasVerticalScroller:(BOOL)vFlag borderType:(NSBorderType)aType;
--+ (NSSize)contentSizeForFrameSize:(NSSize)fSize hasHorizontalScroller:(BOOL)hFlag hasVerticalScroller:(BOOL)vFlag borderType:(NSBorderType)aType;

--- (NSRect)documentVisibleRect;
--- (NSSize)contentSize;

	frozen scroll_view_set_document_view (a_scroll_view: POINTER; a_document_view: POINTER)
			--- (void)setDocumentView:(NSView *)aView;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDocumentView: $a_document_view];"
		end
--- (id)documentView;
--- (void)setContentView:(NSClipView *)contentView;
--- (NSClipView *)contentView;
--- (void)setDocumentCursor:(NSCursor *)anObj;
--- (NSCursor *)documentCursor;
	frozen scroll_view_set_border_type (a_scroll_view: POINTER; a_border_type: INTEGER)
			--- (void)setBorderType:(NSBorderType)aType;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBorderType: $a_border_type];"
		end
--- (NSBorderType)borderType;
	frozen scroll_view_set_background_color (a_scroll_view: POINTER; a_color: POINTER)
			--- (void)setBackgroundColor:(NSColor *)color;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setBackgroundColor: $a_color];"
		end
--- (NSColor *)backgroundColor;
	frozen scroll_view_set_draws_background (a_scroll_view: POINTER; flag: BOOLEAN)
			--- (void)setDrawsBackground:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setDrawsBackground: $flag];"
		end
--- (BOOL)drawsBackground;
	frozen scroll_view_set_has_vertical_scroller (a_scroll_view: POINTER; flag: BOOLEAN)
			--- (void)setHasVerticalScroller:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasVerticalScroller: $flag];"
		end

	frozen scroll_view_has_vertical_scroller (a_scroll_view: POINTER) : BOOLEAN
			--- (BOOL)hasVerticalScroller;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasVerticalScroller];"
		end

	frozen scroll_view_set_has_horizontal_scroller (a_scroll_view: POINTER; flag: BOOLEAN)
			--- (void)setHasHorizontalScroller:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setHasHorizontalScroller: $flag];"
		end

	frozen scroll_view_has_horizontal_scroller (a_scroll_view: POINTER) : BOOLEAN
			--- (BOOL)hasHorizontalScroller;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSScrollView*)$a_scroll_view hasHorizontalScroller];"
		end
--- (void)setVerticalScroller:(NSScroller *)anObject;
--- (NSScroller *)verticalScroller;
--- (void)setHorizontalScroller:(NSScroller *)anObject;
--- (NSScroller *)horizontalScroller;
--- (BOOL)autohidesScrollers;
	frozen scroll_view_set_autohides_scrollers (a_scroll_view: POINTER; a_flag: BOOLEAN)
			--- (void)setAutohidesScrollers:(BOOL)flag;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSScrollView*)$a_scroll_view setAutohidesScrollers: $a_flag];"
		end
--- (void)setHorizontalLineScroll:(CGFloat)value;
--- (void)setVerticalLineScroll:(CGFloat)value;
--- (void)setLineScroll:(CGFloat)value;
--- (CGFloat)horizontalLineScroll;
--- (CGFloat)verticalLineScroll;
--- (CGFloat)lineScroll;
--- (void)setHorizontalPageScroll:(CGFloat)value;
--- (void)setVerticalPageScroll:(CGFloat)value;
--- (void)setPageScroll:(CGFloat)value;
--- (CGFloat)horizontalPageScroll;
--- (CGFloat)verticalPageScroll;
--- (CGFloat)pageScroll;
--- (void)setScrollsDynamically:(BOOL)flag;
--- (BOOL)scrollsDynamically;
--- (void)tile;
--- (void)reflectScrolledClipView:(NSClipView *)cView;
--- (void)scrollWheel:(NSEvent *)theEvent;
--@end

--@interface NSScrollView(NSRulerSupport)

--+ (void)setRulerViewClass:(Class)rulerViewClass;
--+ (Class)rulerViewClass;

--- (void)setRulersVisible:(BOOL)flag;
--- (BOOL)rulersVisible;

--- (void)setHasHorizontalRuler:(BOOL)flag;
--- (BOOL)hasHorizontalRuler;
--- (void)setHasVerticalRuler:(BOOL)flag;
--- (BOOL)hasVerticalRuler;

--- (void)setHorizontalRulerView:(NSRulerView *)ruler;
--- (NSRulerView *)horizontalRulerView;
--- (void)setVerticalRulerView:(NSRulerView *)ruler;
--- (NSRulerView *)verticalRulerView;


feature -- Constants

	frozen ns_line_border: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSLineBorder;"
		end

invariant
	cocoa_object_allocated: cocoa_object /= void
end
