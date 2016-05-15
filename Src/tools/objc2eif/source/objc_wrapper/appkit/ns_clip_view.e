note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CLIP_VIEW

inherit
	NS_VIEW
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSClipView

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_draws_background_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_background_ (item, a_flag)
		end

	draws_background: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_background (item)
		end

	set_document_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_document_view_ (item, a_view__item)
		end

	document_view: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_document_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_document_rect (item, Result.item)
		end

	set_document_cursor_ (an_obj: detachable NS_CURSOR)
			-- Auto generated Objective-C wrapper.
		local
			an_obj__item: POINTER
		do
			if attached an_obj as an_obj_attached then
				an_obj__item := an_obj_attached.item
			end
			objc_set_document_cursor_ (item, an_obj__item)
		end

	document_cursor: detachable NS_CURSOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_document_cursor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document_cursor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document_cursor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	document_visible_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_document_visible_rect (item, Result.item)
		end

	view_frame_changed_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_view_frame_changed_ (item, a_notification__item)
		end

	view_bounds_changed_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_view_bounds_changed_ (item, a_notification__item)
		end

	set_copies_on_scroll_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_copies_on_scroll_ (item, a_flag)
		end

	copies_on_scroll: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_copies_on_scroll (item)
		end

	constrain_scroll_point_ (a_new_origin: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_constrain_scroll_point_ (item, Result.item, a_new_origin.item)
		end

	scroll_to_point_ (a_new_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_to_point_ (item, a_new_origin.item)
		end

feature {NONE} -- NSClipView Externals

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSClipView *)$an_item backgroundColor];
			 ]"
		end

	objc_set_draws_background_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item setDrawsBackground:$a_flag];
			 ]"
		end

	objc_draws_background (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSClipView *)$an_item drawsBackground];
			 ]"
		end

	objc_set_document_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item setDocumentView:$a_view];
			 ]"
		end

	objc_document_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSClipView *)$an_item documentView];
			 ]"
		end

	objc_document_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSClipView *)$an_item documentRect];
			 ]"
		end

	objc_set_document_cursor_ (an_item: POINTER; an_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item setDocumentCursor:$an_obj];
			 ]"
		end

	objc_document_cursor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSClipView *)$an_item documentCursor];
			 ]"
		end

	objc_document_visible_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSClipView *)$an_item documentVisibleRect];
			 ]"
		end

	objc_view_frame_changed_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item viewFrameChanged:$a_notification];
			 ]"
		end

	objc_view_bounds_changed_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item viewBoundsChanged:$a_notification];
			 ]"
		end

	objc_set_copies_on_scroll_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item setCopiesOnScroll:$a_flag];
			 ]"
		end

	objc_copies_on_scroll (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSClipView *)$an_item copiesOnScroll];
			 ]"
		end

	objc_constrain_scroll_point_ (an_item: POINTER; result_pointer: POINTER; a_new_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSClipView *)$an_item constrainScrollPoint:*((NSPoint *)$a_new_origin)];
			 ]"
		end

	objc_scroll_to_point_ (an_item: POINTER; a_new_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSClipView *)$an_item scrollToPoint:*((NSPoint *)$a_new_origin)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSClipView"
		end

end
