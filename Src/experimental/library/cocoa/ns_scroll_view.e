note
	description: "Wrapper for NSScrollView."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCROLL_VIEW

inherit
	NS_VIEW
		redefine
			make
		end

create
	make,
	make_with_flipped_content_view

feature {NONE} -- Creation

	make
		do
			make_shared ({NS_SCROLL_VIEW_API}.new)
		end

	make_with_flipped_content_view
		local
			l_superclass: POINTER
			l_name: POINTER
			l_class: POINTER
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
			l_new_clip_view: NS_CLIP_VIEW
			l_ret: BOOLEAN
		do
			make
			l_class := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("MyClipView")).item)
			if l_class = {NS_OBJECT}.nil then
				-- If MyClipView doesn't exist yet create it as a new child class of NSClipView and override isFlipped
				l_superclass := {NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("NSClipView")).item)
				l_name := (create {C_STRING}.make ("MyClipView")).item
				l_class := {NS_OBJC_RUNTIME}.objc_allocate_class_pair (l_superclass, l_name, 0)

				l_types := (create {C_STRING}.make ("b@:")).item
				l_sel := {NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make ("isFlipped")).item)
				l_imp := {NS_OBJC_RUNTIME}.class_get_method_implementation ({NS_OBJC_RUNTIME}.objc_get_class ((create {C_STRING}.make ("CustomView")).item), l_sel)
				l_ret := {NS_OBJC_RUNTIME}.class_add_method (l_class, l_sel, l_imp, l_types)

				{NS_OBJC_RUNTIME}.objc_register_class_pair (l_class)
			end
			create l_new_clip_view.make_shared ({NS_OBJC_RUNTIME}.class_create_instance (l_class, 0))
			{NS_VIEW_API}.init (l_new_clip_view.item)
			set_content_view (l_new_clip_view)
		end

feature

	document_visible_rect: NS_RECT
		do
			create Result.make
			{NS_SCROLL_VIEW_API}.document_visible_rect (item, Result.item)
		end

	content_size: NS_SIZE
		do
			create Result.make
			{NS_SCROLL_VIEW_API}.content_size (item, Result.item)
		end

	set_document_view (a_view: NS_VIEW)
		do
			{NS_SCROLL_VIEW_API}.set_document_view (item, a_view.item)
		end

	document_view: NS_VIEW
			-- TODO: Create correct concrete subclass!
		do
			create Result.make_shared ({NS_SCROLL_VIEW_API}.document_view (item))
		end

	set_content_view (a_content_view: NS_CLIP_VIEW)
		do
			{NS_SCROLL_VIEW_API}.set_content_view (item, a_content_view.item)
		end

	content_view: NS_CLIP_VIEW
		do
			create Result.make_shared ({NS_SCROLL_VIEW_API}.content_view (item))
		end

--	set_document_cursor (a_an_obj: NS_CURSOR)
--		do
--			{NS_SCROLL_VIEW_API}.set_document_cursor (cocoa_object, a_an_obj.cocoa_object)
--		end

--	document_cursor: NS_CURSOR
--		do
--			create Result.make_shared ({NS_SCROLL_VIEW_API}.document_cursor (cocoa_object))
--		end

	set_border_type (a_type: INTEGER)
		do
			{NS_SCROLL_VIEW_API}.set_border_type (item, a_type)
		end

	border_type: INTEGER
		do
			Result := {NS_SCROLL_VIEW_API}.border_type (item)
		end

	set_background_color (a_color: NS_COLOR)
		do
			{NS_SCROLL_VIEW_API}.set_background_color (item, a_color.item)
		end

	background_color: NS_COLOR
		do
			create Result.make_shared ({NS_SCROLL_VIEW_API}.background_color (item))
		end

	set_draws_background (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_draws_background (item, a_flag)
		end

	draws_background: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.draws_background (item)
		end

	set_has_vertical_scroller (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_has_vertical_scroller (item, a_flag)
		end

	has_vertical_scroller: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.has_vertical_scroller (item)
		end

	set_has_horizontal_scroller (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_has_horizontal_scroller (item, a_flag)
		end

	has_horizontal_scroller: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.has_horizontal_scroller (item)
		end

	set_vertical_scroller (a_an_object: NS_SCROLLER)
		do
			{NS_SCROLL_VIEW_API}.set_vertical_scroller (item, a_an_object.item)
		end

	vertical_scroller: NS_SCROLLER
		do
			create Result.make_shared ({NS_SCROLL_VIEW_API}.vertical_scroller (item))
		end

	set_horizontal_scroller (a_an_object: NS_SCROLLER)
		do
			{NS_SCROLL_VIEW_API}.set_horizontal_scroller (item, a_an_object.item)
		end

	horizontal_scroller: NS_SCROLLER
		do
			create Result.make_shared ({NS_SCROLL_VIEW_API}.horizontal_scroller (item))
		end

	autohides_scrollers: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.autohides_scrollers (item)
		end

	set_autohides_scrollers (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_autohides_scrollers (item, a_flag)
		end

	set_horizontal_line_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_horizontal_line_scroll (item, a_value)
		end

	set_vertical_line_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_vertical_line_scroll (item, a_value)
		end

	set_line_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_line_scroll (item, a_value)
		end

	horizontal_line_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.horizontal_line_scroll (item)
		end

	vertical_line_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.vertical_line_scroll (item)
		end

	line_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.line_scroll (item)
		end

	set_horizontal_page_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_horizontal_page_scroll (item, a_value)
		end

	set_vertical_page_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_vertical_page_scroll (item, a_value)
		end

	set_page_scroll (a_value: REAL)
		do
			{NS_SCROLL_VIEW_API}.set_page_scroll (item, a_value)
		end

	horizontal_page_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.horizontal_page_scroll (item)
		end

	vertical_page_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.vertical_page_scroll (item)
		end

	page_scroll: REAL
		do
			Result := {NS_SCROLL_VIEW_API}.page_scroll (item)
		end

	set_scrolls_dynamically (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_scrolls_dynamically (item, a_flag)
		end

	scrolls_dynamically: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.scrolls_dynamically (item)
		end

	tile
		do
			{NS_SCROLL_VIEW_API}.tile (item)
		end

	reflect_scrolled_clip_view (a_c_view: NS_CLIP_VIEW)
		do
			{NS_SCROLL_VIEW_API}.reflect_scrolled_clip_view (item, a_c_view.item)
		end

	scroll_wheel (a_the_event: NS_EVENT)
		do
			{NS_SCROLL_VIEW_API}.scroll_wheel (item, a_the_event.item)
		end

	set_rulers_visible (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_rulers_visible (item, a_flag)
		end

	rulers_visible: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.rulers_visible (item)
		end

	set_has_horizontal_ruler (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_has_horizontal_ruler (item, a_flag)
		end

	has_horizontal_ruler: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.has_horizontal_ruler (item)
		end

	set_has_vertical_ruler (a_flag: BOOLEAN)
		do
			{NS_SCROLL_VIEW_API}.set_has_vertical_ruler (item, a_flag)
		end

	has_vertical_ruler: BOOLEAN
		do
			Result := {NS_SCROLL_VIEW_API}.has_vertical_ruler (item)
		end

--	set_horizontal_ruler_view (a_ruler: NS_RULER_VIEW)
--		do
--			{NS_SCROLL_VIEW_API}.set_horizontal_ruler_view (cocoa_object, a_ruler.cocoa_object)
--		end

--	horizontal_ruler_view: NS_RULER_VIEW
--		do
--			create Result.make_shared ({NS_SCROLL_VIEW_API}.horizontal_ruler_view (cocoa_object))
--		end

--	set_vertical_ruler_view (a_ruler: NS_RULER_VIEW)
--		do
--			{NS_SCROLL_VIEW_API}.set_vertical_ruler_view (cocoa_object, a_ruler.cocoa_object)
--		end

--	vertical_ruler_view: NS_RULER_VIEW
--		do
--			create Result.make_shared ({NS_SCROLL_VIEW_API}.vertical_ruler_view (cocoa_object))
--		end

feature -- Constants

	frozen ns_line_border: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSLineBorder;"
		end

end
