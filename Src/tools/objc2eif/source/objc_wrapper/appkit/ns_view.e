note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VIEW

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature {NONE} -- Initialization

	make_with_frame_ (a_frame_rect: NS_RECT)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_frame_(allocate_object, a_frame_rect.item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSView Externals

	objc_init_with_frame_ (an_item: POINTER; a_frame_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item initWithFrame:*((NSRect *)$a_frame_rect)];
			 ]"
		end

	objc_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item window];
			 ]"
		end

	objc_superview (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item superview];
			 ]"
		end

	objc_subviews (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item subviews];
			 ]"
		end

	objc_is_descendant_of_ (an_item: POINTER; a_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isDescendantOf:$a_view];
			 ]"
		end

	objc_ancestor_shared_with_view_ (an_item: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item ancestorSharedWithView:$a_view];
			 ]"
		end

	objc_opaque_ancestor (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item opaqueAncestor];
			 ]"
		end

	objc_set_hidden_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setHidden:$a_flag];
			 ]"
		end

	objc_is_hidden (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isHidden];
			 ]"
		end

	objc_is_hidden_or_has_hidden_ancestor (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isHiddenOrHasHiddenAncestor];
			 ]"
		end

--	objc_get_rects_being_drawn__count_ (an_item: POINTER; a_rects: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item getRectsBeingDrawn: count:];
--			 ]"
--		end

	objc_needs_to_draw_rect_ (an_item: POINTER; a_rect: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item needsToDrawRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_wants_default_clipping (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item wantsDefaultClipping];
			 ]"
		end

	objc_view_did_hide (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewDidHide];
			 ]"
		end

	objc_view_did_unhide (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewDidUnhide];
			 ]"
		end

	objc_set_subviews_ (an_item: POINTER; a_new_subviews: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setSubviews:$a_new_subviews];
			 ]"
		end

	objc_add_subview_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item addSubview:$a_view];
			 ]"
		end

	objc_add_subview__positioned__relative_to_ (an_item: POINTER; a_view: POINTER; a_place: INTEGER_64; a_other_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item addSubview:$a_view positioned:$a_place relativeTo:$a_other_view];
			 ]"
		end

--	objc_sort_subviews_using_function__context_ (an_item: POINTER; a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item sortSubviewsUsingFunction: context:];
--			 ]"
--		end

	objc_view_will_move_to_window_ (an_item: POINTER; a_new_window: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewWillMoveToWindow:$a_new_window];
			 ]"
		end

	objc_view_did_move_to_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewDidMoveToWindow];
			 ]"
		end

	objc_view_will_move_to_superview_ (an_item: POINTER; a_new_superview: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewWillMoveToSuperview:$a_new_superview];
			 ]"
		end

	objc_view_did_move_to_superview (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewDidMoveToSuperview];
			 ]"
		end

	objc_did_add_subview_ (an_item: POINTER; a_subview: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item didAddSubview:$a_subview];
			 ]"
		end

	objc_will_remove_subview_ (an_item: POINTER; a_subview: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item willRemoveSubview:$a_subview];
			 ]"
		end

	objc_remove_from_superview (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeFromSuperview];
			 ]"
		end

	objc_replace_subview__with_ (an_item: POINTER; a_old_view: POINTER; a_new_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item replaceSubview:$a_old_view with:$a_new_view];
			 ]"
		end

	objc_remove_from_superview_without_needing_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeFromSuperviewWithoutNeedingDisplay];
			 ]"
		end

	objc_set_posts_frame_changed_notifications_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setPostsFrameChangedNotifications:$a_flag];
			 ]"
		end

	objc_posts_frame_changed_notifications (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item postsFrameChangedNotifications];
			 ]"
		end

	objc_resize_subviews_with_old_size_ (an_item: POINTER; a_old_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item resizeSubviewsWithOldSize:*((NSSize *)$a_old_size)];
			 ]"
		end

	objc_resize_with_old_superview_size_ (an_item: POINTER; a_old_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item resizeWithOldSuperviewSize:*((NSSize *)$a_old_size)];
			 ]"
		end

	objc_set_autoresizes_subviews_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setAutoresizesSubviews:$a_flag];
			 ]"
		end

	objc_autoresizes_subviews (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item autoresizesSubviews];
			 ]"
		end

	objc_set_autoresizing_mask_ (an_item: POINTER; a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setAutoresizingMask:$a_mask];
			 ]"
		end

	objc_autoresizing_mask (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item autoresizingMask];
			 ]"
		end

	objc_set_frame_origin_ (an_item: POINTER; a_new_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFrameOrigin:*((NSPoint *)$a_new_origin)];
			 ]"
		end

	objc_set_frame_size_ (an_item: POINTER; a_new_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFrameSize:*((NSSize *)$a_new_size)];
			 ]"
		end

	objc_set_frame_ (an_item: POINTER; a_frame_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFrame:*((NSRect *)$a_frame_rect)];
			 ]"
		end

	objc_frame (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item frame];
			 ]"
		end

	objc_set_frame_rotation_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFrameRotation:$a_angle];
			 ]"
		end

	objc_frame_rotation (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item frameRotation];
			 ]"
		end

	objc_set_frame_center_rotation_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFrameCenterRotation:$a_angle];
			 ]"
		end

	objc_frame_center_rotation (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item frameCenterRotation];
			 ]"
		end

	objc_set_bounds_origin_ (an_item: POINTER; a_new_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setBoundsOrigin:*((NSPoint *)$a_new_origin)];
			 ]"
		end

	objc_set_bounds_size_ (an_item: POINTER; a_new_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setBoundsSize:*((NSSize *)$a_new_size)];
			 ]"
		end

	objc_set_bounds_rotation_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setBoundsRotation:$a_angle];
			 ]"
		end

	objc_bounds_rotation (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item boundsRotation];
			 ]"
		end

	objc_translate_origin_to_point_ (an_item: POINTER; a_translation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item translateOriginToPoint:*((NSPoint *)$a_translation)];
			 ]"
		end

	objc_scale_unit_square_to_size_ (an_item: POINTER; a_new_unit_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item scaleUnitSquareToSize:*((NSSize *)$a_new_unit_size)];
			 ]"
		end

	objc_rotate_by_angle_ (an_item: POINTER; a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rotateByAngle:$a_angle];
			 ]"
		end

	objc_set_bounds_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setBounds:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item bounds];
			 ]"
		end

	objc_is_flipped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isFlipped];
			 ]"
		end

	objc_is_rotated_from_base (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isRotatedFromBase];
			 ]"
		end

	objc_is_rotated_or_scaled_from_base (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isRotatedOrScaledFromBase];
			 ]"
		end

	objc_is_opaque (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isOpaque];
			 ]"
		end

	objc_convert_point__from_view_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSView *)$an_item convertPoint:*((NSPoint *)$a_point) fromView:$a_view];
			 ]"
		end

	objc_convert_point__to_view_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSView *)$an_item convertPoint:*((NSPoint *)$a_point) toView:$a_view];
			 ]"
		end

	objc_convert_size__from_view_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSView *)$an_item convertSize:*((NSSize *)$a_size) fromView:$a_view];
			 ]"
		end

	objc_convert_size__to_view_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSView *)$an_item convertSize:*((NSSize *)$a_size) toView:$a_view];
			 ]"
		end

	objc_convert_rect__from_view_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item convertRect:*((NSRect *)$a_rect) fromView:$a_view];
			 ]"
		end

	objc_convert_rect__to_view_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item convertRect:*((NSRect *)$a_rect) toView:$a_view];
			 ]"
		end

	objc_center_scan_rect_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item centerScanRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_convert_point_to_base_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSView *)$an_item convertPointToBase:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_convert_point_from_base_ (an_item: POINTER; result_pointer: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSView *)$an_item convertPointFromBase:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_convert_size_to_base_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSView *)$an_item convertSizeToBase:*((NSSize *)$a_size)];
			 ]"
		end

	objc_convert_size_from_base_ (an_item: POINTER; result_pointer: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSView *)$an_item convertSizeFromBase:*((NSSize *)$a_size)];
			 ]"
		end

	objc_convert_rect_to_base_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item convertRectToBase:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_convert_rect_from_base_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item convertRectFromBase:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_can_draw_concurrently (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item canDrawConcurrently];
			 ]"
		end

	objc_set_can_draw_concurrently_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setCanDrawConcurrently:$a_flag];
			 ]"
		end

	objc_can_draw (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item canDraw];
			 ]"
		end

	objc_set_needs_display_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setNeedsDisplay:$a_flag];
			 ]"
		end

	objc_set_needs_display_in_rect_ (an_item: POINTER; a_invalid_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setNeedsDisplayInRect:*((NSRect *)$a_invalid_rect)];
			 ]"
		end

	objc_needs_display (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item needsDisplay];
			 ]"
		end

	objc_lock_focus (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item lockFocus];
			 ]"
		end

	objc_unlock_focus (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item unlockFocus];
			 ]"
		end

	objc_lock_focus_if_can_draw (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item lockFocusIfCanDraw];
			 ]"
		end

	objc_lock_focus_if_can_draw_in_context_ (an_item: POINTER; a_context: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item lockFocusIfCanDrawInContext:$a_context];
			 ]"
		end

	objc_visible_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item visibleRect];
			 ]"
		end

	objc_display (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item display];
			 ]"
		end

	objc_display_if_needed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayIfNeeded];
			 ]"
		end

	objc_display_if_needed_ignoring_opacity (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayIfNeededIgnoringOpacity];
			 ]"
		end

	objc_display_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_display_if_needed_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayIfNeededInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_display_rect_ignoring_opacity_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayRectIgnoringOpacity:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_display_if_needed_in_rect_ignoring_opacity_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayIfNeededInRectIgnoringOpacity:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_draw_rect_ (an_item: POINTER; a_dirty_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item drawRect:*((NSRect *)$a_dirty_rect)];
			 ]"
		end

	objc_display_rect_ignoring_opacity__in_context_ (an_item: POINTER; a_rect: POINTER; a_context: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item displayRectIgnoringOpacity:*((NSRect *)$a_rect) inContext:$a_context];
			 ]"
		end

	objc_bitmap_image_rep_for_caching_display_in_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item bitmapImageRepForCachingDisplayInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_cache_display_in_rect__to_bitmap_image_rep_ (an_item: POINTER; a_rect: POINTER; a_bitmap_image_rep: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item cacheDisplayInRect:*((NSRect *)$a_rect) toBitmapImageRep:$a_bitmap_image_rep];
			 ]"
		end

	objc_view_will_draw (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewWillDraw];
			 ]"
		end

	objc_g_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item gState];
			 ]"
		end

	objc_allocate_g_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item allocateGState];
			 ]"
		end

	objc_release_g_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item releaseGState];
			 ]"
		end

	objc_set_up_g_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setUpGState];
			 ]"
		end

	objc_renew_g_state (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item renewGState];
			 ]"
		end

	objc_scroll_point_ (an_item: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item scrollPoint:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_scroll_rect_to_visible_ (an_item: POINTER; a_rect: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item scrollRectToVisible:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_autoscroll_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item autoscroll:$a_the_event];
			 ]"
		end

	objc_adjust_scroll_ (an_item: POINTER; result_pointer: POINTER; a_new_visible: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item adjustScroll:*((NSRect *)$a_new_visible)];
			 ]"
		end

	objc_scroll_rect__by_ (an_item: POINTER; a_rect: POINTER; a_delta: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item scrollRect:*((NSRect *)$a_rect) by:*((NSSize *)$a_delta)];
			 ]"
		end

	objc_translate_rects_needing_display_in_rect__by_ (an_item: POINTER; a_clip_rect: POINTER; a_delta: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item translateRectsNeedingDisplayInRect:*((NSRect *)$a_clip_rect) by:*((NSSize *)$a_delta)];
			 ]"
		end

	objc_hit_test_ (an_item: POINTER; a_point: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item hitTest:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_mouse__in_rect_ (an_item: POINTER; a_point: POINTER; a_rect: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item mouse:*((NSPoint *)$a_point) inRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_view_with_tag_ (an_item: POINTER; a_tag: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item viewWithTag:$a_tag];
			 ]"
		end

	objc_tag (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item tag];
			 ]"
		end

	objc_accepts_first_mouse_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item acceptsFirstMouse:$a_the_event];
			 ]"
		end

	objc_should_delay_window_ordering_for_event_ (an_item: POINTER; a_the_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item shouldDelayWindowOrderingForEvent:$a_the_event];
			 ]"
		end

	objc_needs_panel_to_become_key (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item needsPanelToBecomeKey];
			 ]"
		end

	objc_mouse_down_can_move_window (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item mouseDownCanMoveWindow];
			 ]"
		end

	objc_set_accepts_touch_events_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setAcceptsTouchEvents:$a_flag];
			 ]"
		end

	objc_accepts_touch_events (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item acceptsTouchEvents];
			 ]"
		end

	objc_set_wants_resting_touches_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setWantsRestingTouches:$a_flag];
			 ]"
		end

	objc_wants_resting_touches (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item wantsRestingTouches];
			 ]"
		end

	objc_add_cursor_rect__cursor_ (an_item: POINTER; a_rect: POINTER; an_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item addCursorRect:*((NSRect *)$a_rect) cursor:$an_obj];
			 ]"
		end

	objc_remove_cursor_rect__cursor_ (an_item: POINTER; a_rect: POINTER; an_obj: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeCursorRect:*((NSRect *)$a_rect) cursor:$an_obj];
			 ]"
		end

	objc_discard_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item discardCursorRects];
			 ]"
		end

	objc_reset_cursor_rects (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item resetCursorRects];
			 ]"
		end

--	objc_add_tracking_rect__owner__user_data__assume_inside_ (an_item: POINTER; a_rect: POINTER; an_object: POINTER; a_data: UNSUPPORTED_TYPE; a_flag: BOOLEAN): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSView *)$an_item addTrackingRect:*((NSRect *)$a_rect) owner:$an_object userData: assumeInside:$a_flag];
--			 ]"
--		end

	objc_remove_tracking_rect_ (an_item: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeTrackingRect:$a_tag];
			 ]"
		end

	objc_make_backing_layer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item makeBackingLayer];
			 ]"
		end

	objc_layer_contents_redraw_policy (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item layerContentsRedrawPolicy];
			 ]"
		end

	objc_set_layer_contents_redraw_policy_ (an_item: POINTER; a_new_policy: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setLayerContentsRedrawPolicy:$a_new_policy];
			 ]"
		end

	objc_layer_contents_placement (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item layerContentsPlacement];
			 ]"
		end

	objc_set_layer_contents_placement_ (an_item: POINTER; a_new_placement: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setLayerContentsPlacement:$a_new_placement];
			 ]"
		end

	objc_set_wants_layer_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setWantsLayer:$a_flag];
			 ]"
		end

	objc_wants_layer (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item wantsLayer];
			 ]"
		end

	objc_set_layer_ (an_item: POINTER; a_new_layer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setLayer:$a_new_layer];
			 ]"
		end

	objc_layer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item layer];
			 ]"
		end

	objc_set_alpha_value_ (an_item: POINTER; a_view_alpha: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setAlphaValue:$a_view_alpha];
			 ]"
		end

	objc_alpha_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item alphaValue];
			 ]"
		end

	objc_set_background_filters_ (an_item: POINTER; a_filters: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setBackgroundFilters:$a_filters];
			 ]"
		end

	objc_background_filters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item backgroundFilters];
			 ]"
		end

--	objc_set_compositing_filter_ (an_item: POINTER; a_filter: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item setCompositingFilter:$a_filter];
--			 ]"
--		end

--	objc_compositing_filter (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSView *)$an_item compositingFilter];
--			 ]"
--		end

	objc_set_content_filters_ (an_item: POINTER; a_filters: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setContentFilters:$a_filters];
			 ]"
		end

	objc_content_filters (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item contentFilters];
			 ]"
		end

	objc_set_shadow_ (an_item: POINTER; a_shadow: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setShadow:$a_shadow];
			 ]"
		end

	objc_shadow (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item shadow];
			 ]"
		end

	objc_add_tracking_area_ (an_item: POINTER; a_tracking_area: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item addTrackingArea:$a_tracking_area];
			 ]"
		end

	objc_remove_tracking_area_ (an_item: POINTER; a_tracking_area: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeTrackingArea:$a_tracking_area];
			 ]"
		end

	objc_tracking_areas (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item trackingAreas];
			 ]"
		end

	objc_update_tracking_areas (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item updateTrackingAreas];
			 ]"
		end

	objc_should_draw_color (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item shouldDrawColor];
			 ]"
		end

	objc_set_posts_bounds_changed_notifications_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setPostsBoundsChangedNotifications:$a_flag];
			 ]"
		end

	objc_posts_bounds_changed_notifications (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item postsBoundsChangedNotifications];
			 ]"
		end

	objc_enclosing_scroll_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item enclosingScrollView];
			 ]"
		end

	objc_menu_for_event_ (an_item: POINTER; a_event: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item menuForEvent:$a_event];
			 ]"
		end

	objc_set_tool_tip_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setToolTip:$a_string];
			 ]"
		end

	objc_tool_tip (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item toolTip];
			 ]"
		end

--	objc_add_tool_tip_rect__owner__user_data_ (an_item: POINTER; a_rect: POINTER; an_object: POINTER; a_data: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSView *)$an_item addToolTipRect:*((NSRect *)$a_rect) owner:$an_object userData:];
--			 ]"
--		end

	objc_remove_tool_tip_ (an_item: POINTER; a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeToolTip:$a_tag];
			 ]"
		end

	objc_remove_all_tool_tips (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item removeAllToolTips];
			 ]"
		end

	objc_view_will_start_live_resize (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewWillStartLiveResize];
			 ]"
		end

	objc_view_did_end_live_resize (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item viewDidEndLiveResize];
			 ]"
		end

	objc_in_live_resize (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item inLiveResize];
			 ]"
		end

	objc_preserves_content_during_live_resize (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item preservesContentDuringLiveResize];
			 ]"
		end

	objc_rect_preserved_during_live_resize (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item rectPreservedDuringLiveResize];
			 ]"
		end

--	objc_get_rects_exposed_during_live_resize__count_ (an_item: POINTER; a_exposed_rects: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item getRectsExposedDuringLiveResize: count:];
--			 ]"
--		end

	objc_input_context (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item inputContext];
			 ]"
		end

feature -- NSView

	window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	superview: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_superview (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like superview} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like superview} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	subviews: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subviews (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subviews} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subviews} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_descendant_of_ (a_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			Result := objc_is_descendant_of_ (item, a_view__item)
		end

	ancestor_shared_with_view_ (a_view: detachable NS_VIEW): detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_ancestor_shared_with_view_ (item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ancestor_shared_with_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ancestor_shared_with_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	opaque_ancestor: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_opaque_ancestor (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like opaque_ancestor} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like opaque_ancestor} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_hidden_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hidden_ (item, a_flag)
		end

	is_hidden: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden (item)
		end

	is_hidden_or_has_hidden_ancestor: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_hidden_or_has_hidden_ancestor (item)
		end

--	get_rects_being_drawn__count_ (a_rects: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_rects__item: POINTER
--			a_count__item: POINTER
--		do
--			if attached a_rects as a_rects_attached then
--				a_rects__item := a_rects_attached.item
--			end
--			if attached a_count as a_count_attached then
--				a_count__item := a_count_attached.item
--			end
--			objc_get_rects_being_drawn__count_ (item, a_rects__item, a_count__item)
--		end

	needs_to_draw_rect_ (a_rect: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_to_draw_rect_ (item, a_rect.item)
		end

	wants_default_clipping: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_default_clipping (item)
		end

	view_did_hide
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_did_hide (item)
		end

	view_did_unhide
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_did_unhide (item)
		end

	set_subviews_ (a_new_subviews: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_subviews__item: POINTER
		do
			if attached a_new_subviews as a_new_subviews_attached then
				a_new_subviews__item := a_new_subviews_attached.item
			end
			objc_set_subviews_ (item, a_new_subviews__item)
		end

	add_subview_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_add_subview_ (item, a_view__item)
		end

	add_subview__positioned__relative_to_ (a_view: detachable NS_VIEW; a_place: INTEGER_64; a_other_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
			a_other_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_other_view as a_other_view_attached then
				a_other_view__item := a_other_view_attached.item
			end
			objc_add_subview__positioned__relative_to_ (item, a_view__item, a_place, a_other_view__item)
		end

--	sort_subviews_using_function__context_ (a_compare: UNSUPPORTED_TYPE; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_compare__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_compare as a_compare_attached then
--				a_compare__item := a_compare_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_sort_subviews_using_function__context_ (item, a_compare__item, a_context__item)
--		end

	view_will_move_to_window_ (a_new_window: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_new_window__item: POINTER
		do
			if attached a_new_window as a_new_window_attached then
				a_new_window__item := a_new_window_attached.item
			end
			objc_view_will_move_to_window_ (item, a_new_window__item)
		end

	view_did_move_to_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_did_move_to_window (item)
		end

	view_will_move_to_superview_ (a_new_superview: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_new_superview__item: POINTER
		do
			if attached a_new_superview as a_new_superview_attached then
				a_new_superview__item := a_new_superview_attached.item
			end
			objc_view_will_move_to_superview_ (item, a_new_superview__item)
		end

	view_did_move_to_superview
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_did_move_to_superview (item)
		end

	did_add_subview_ (a_subview: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_subview__item: POINTER
		do
			if attached a_subview as a_subview_attached then
				a_subview__item := a_subview_attached.item
			end
			objc_did_add_subview_ (item, a_subview__item)
		end

	will_remove_subview_ (a_subview: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_subview__item: POINTER
		do
			if attached a_subview as a_subview_attached then
				a_subview__item := a_subview_attached.item
			end
			objc_will_remove_subview_ (item, a_subview__item)
		end

	remove_from_superview
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_from_superview (item)
		end

	replace_subview__with_ (a_old_view: detachable NS_VIEW; a_new_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_old_view__item: POINTER
			a_new_view__item: POINTER
		do
			if attached a_old_view as a_old_view_attached then
				a_old_view__item := a_old_view_attached.item
			end
			if attached a_new_view as a_new_view_attached then
				a_new_view__item := a_new_view_attached.item
			end
			objc_replace_subview__with_ (item, a_old_view__item, a_new_view__item)
		end

	remove_from_superview_without_needing_display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_from_superview_without_needing_display (item)
		end

	set_posts_frame_changed_notifications_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_posts_frame_changed_notifications_ (item, a_flag)
		end

	posts_frame_changed_notifications: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_posts_frame_changed_notifications (item)
		end

	resize_subviews_with_old_size_ (a_old_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resize_subviews_with_old_size_ (item, a_old_size.item)
		end

	resize_with_old_superview_size_ (a_old_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_resize_with_old_superview_size_ (item, a_old_size.item)
		end

	set_autoresizes_subviews_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoresizes_subviews_ (item, a_flag)
		end

	autoresizes_subviews: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autoresizes_subviews (item)
		end

	set_autoresizing_mask_ (a_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_autoresizing_mask_ (item, a_mask)
		end

	autoresizing_mask: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_autoresizing_mask (item)
		end

	set_frame_origin_ (a_new_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_origin_ (item, a_new_origin.item)
		end

	set_frame_size_ (a_new_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_size_ (item, a_new_size.item)
		end

	set_frame_ (a_frame_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_ (item, a_frame_rect.item)
		end

	frame: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_frame (item, Result.item)
		end

	set_frame_rotation_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_rotation_ (item, a_angle)
		end

	frame_rotation: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_frame_rotation (item)
		end

	set_frame_center_rotation_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_center_rotation_ (item, a_angle)
		end

	frame_center_rotation: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_frame_center_rotation (item)
		end

	set_bounds_origin_ (a_new_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bounds_origin_ (item, a_new_origin.item)
		end

	set_bounds_size_ (a_new_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bounds_size_ (item, a_new_size.item)
		end

	set_bounds_rotation_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bounds_rotation_ (item, a_angle)
		end

	bounds_rotation: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bounds_rotation (item)
		end

	translate_origin_to_point_ (a_translation: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_translate_origin_to_point_ (item, a_translation.item)
		end

	scale_unit_square_to_size_ (a_new_unit_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scale_unit_square_to_size_ (item, a_new_unit_size.item)
		end

	rotate_by_angle_ (a_angle: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_rotate_by_angle_ (item, a_angle)
		end

	set_bounds_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bounds_ (item, a_rect.item)
		end

	bounds: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_bounds (item, Result.item)
		end

	is_flipped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_flipped (item)
		end

	is_rotated_from_base: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_rotated_from_base (item)
		end

	is_rotated_or_scaled_from_base: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_rotated_or_scaled_from_base (item)
		end

	is_opaque: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_opaque (item)
		end

	convert_point__from_view_ (a_point: NS_POINT; a_view: detachable NS_VIEW): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_point__from_view_ (item, Result.item, a_point.item, a_view__item)
		end

	convert_point__to_view_ (a_point: NS_POINT; a_view: detachable NS_VIEW): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_point__to_view_ (item, Result.item, a_point.item, a_view__item)
		end

	convert_size__from_view_ (a_size: NS_SIZE; a_view: detachable NS_VIEW): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_size__from_view_ (item, Result.item, a_size.item, a_view__item)
		end

	convert_size__to_view_ (a_size: NS_SIZE; a_view: detachable NS_VIEW): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_size__to_view_ (item, Result.item, a_size.item, a_view__item)
		end

	convert_rect__from_view_ (a_rect: NS_RECT; a_view: detachable NS_VIEW): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_rect__from_view_ (item, Result.item, a_rect.item, a_view__item)
		end

	convert_rect__to_view_ (a_rect: NS_RECT; a_view: detachable NS_VIEW): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_convert_rect__to_view_ (item, Result.item, a_rect.item, a_view__item)
		end

	center_scan_rect_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_center_scan_rect_ (item, Result.item, a_rect.item)
		end

	convert_point_to_base_ (a_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_point_to_base_ (item, Result.item, a_point.item)
		end

	convert_point_from_base_ (a_point: NS_POINT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_point_from_base_ (item, Result.item, a_point.item)
		end

	convert_size_to_base_ (a_size: NS_SIZE): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_size_to_base_ (item, Result.item, a_size.item)
		end

	convert_size_from_base_ (a_size: NS_SIZE): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_size_from_base_ (item, Result.item, a_size.item)
		end

	convert_rect_to_base_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_rect_to_base_ (item, Result.item, a_rect.item)
		end

	convert_rect_from_base_ (a_rect: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_convert_rect_from_base_ (item, Result.item, a_rect.item)
		end

	can_draw_concurrently: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_draw_concurrently (item)
		end

	set_can_draw_concurrently_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_draw_concurrently_ (item, a_flag)
		end

	can_draw: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_draw (item)
		end

	set_needs_display_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_ (item, a_flag)
		end

	set_needs_display_in_rect_ (a_invalid_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_needs_display_in_rect_ (item, a_invalid_rect.item)
		end

	needs_display: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_display (item)
		end

	lock_focus
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_lock_focus (item)
		end

	unlock_focus
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unlock_focus (item)
		end

	lock_focus_if_can_draw: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_lock_focus_if_can_draw (item)
		end

	lock_focus_if_can_draw_in_context_ (a_context: detachable NS_GRAPHICS_CONTEXT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			Result := objc_lock_focus_if_can_draw_in_context_ (item, a_context__item)
		end

	visible_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_visible_rect (item, Result.item)
		end

	display
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display (item)
		end

	display_if_needed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed (item)
		end

	display_if_needed_ignoring_opacity
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed_ignoring_opacity (item)
		end

	display_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_rect_ (item, a_rect.item)
		end

	display_if_needed_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed_in_rect_ (item, a_rect.item)
		end

	display_rect_ignoring_opacity_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_rect_ignoring_opacity_ (item, a_rect.item)
		end

	display_if_needed_in_rect_ignoring_opacity_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_display_if_needed_in_rect_ignoring_opacity_ (item, a_rect.item)
		end

	draw_rect_ (a_dirty_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_rect_ (item, a_dirty_rect.item)
		end

	display_rect_ignoring_opacity__in_context_ (a_rect: NS_RECT; a_context: detachable NS_GRAPHICS_CONTEXT)
			-- Auto generated Objective-C wrapper.
		local
			a_context__item: POINTER
		do
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			objc_display_rect_ignoring_opacity__in_context_ (item, a_rect.item, a_context__item)
		end

	bitmap_image_rep_for_caching_display_in_rect_ (a_rect: NS_RECT): detachable NS_BITMAP_IMAGE_REP
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_bitmap_image_rep_for_caching_display_in_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like bitmap_image_rep_for_caching_display_in_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like bitmap_image_rep_for_caching_display_in_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	cache_display_in_rect__to_bitmap_image_rep_ (a_rect: NS_RECT; a_bitmap_image_rep: detachable NS_BITMAP_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		local
			a_bitmap_image_rep__item: POINTER
		do
			if attached a_bitmap_image_rep as a_bitmap_image_rep_attached then
				a_bitmap_image_rep__item := a_bitmap_image_rep_attached.item
			end
			objc_cache_display_in_rect__to_bitmap_image_rep_ (item, a_rect.item, a_bitmap_image_rep__item)
		end

	view_will_draw
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_will_draw (item)
		end

	g_state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_g_state (item)
		end

	allocate_g_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_allocate_g_state (item)
		end

	release_g_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_release_g_state (item)
		end

	set_up_g_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_up_g_state (item)
		end

	renew_g_state
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_renew_g_state (item)
		end

	scroll_point_ (a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_point_ (item, a_point.item)
		end

	scroll_rect_to_visible_ (a_rect: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_scroll_rect_to_visible_ (item, a_rect.item)
		end

	autoscroll_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_autoscroll_ (item, a_the_event__item)
		end

	adjust_scroll_ (a_new_visible: NS_RECT): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_adjust_scroll_ (item, Result.item, a_new_visible.item)
		end

	scroll_rect__by_ (a_rect: NS_RECT; a_delta: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_rect__by_ (item, a_rect.item, a_delta.item)
		end

	translate_rects_needing_display_in_rect__by_ (a_clip_rect: NS_RECT; a_delta: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_translate_rects_needing_display_in_rect__by_ (item, a_clip_rect.item, a_delta.item)
		end

	hit_test_ (a_point: NS_POINT): detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_hit_test_ (item, a_point.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like hit_test_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like hit_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mouse__in_rect_ (a_point: NS_POINT; a_rect: NS_RECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mouse__in_rect_ (item, a_point.item, a_rect.item)
		end

	view_with_tag_ (a_tag: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_view_with_tag_ (item, a_tag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like view_with_tag_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like view_with_tag_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	tag: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_tag (item)
		end

	accepts_first_mouse_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_accepts_first_mouse_ (item, a_the_event__item)
		end

	should_delay_window_ordering_for_event_ (a_the_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_the_event__item: POINTER
		do
			if attached a_the_event as a_the_event_attached then
				a_the_event__item := a_the_event_attached.item
			end
			Result := objc_should_delay_window_ordering_for_event_ (item, a_the_event__item)
		end

	needs_panel_to_become_key: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_needs_panel_to_become_key (item)
		end

	mouse_down_can_move_window: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_mouse_down_can_move_window (item)
		end

	set_accepts_touch_events_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_accepts_touch_events_ (item, a_flag)
		end

	accepts_touch_events: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accepts_touch_events (item)
		end

	set_wants_resting_touches_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_wants_resting_touches_ (item, a_flag)
		end

	wants_resting_touches: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_resting_touches (item)
		end

	add_cursor_rect__cursor_ (a_rect: NS_RECT; an_obj: detachable NS_CURSOR)
			-- Auto generated Objective-C wrapper.
		local
			an_obj__item: POINTER
		do
			if attached an_obj as an_obj_attached then
				an_obj__item := an_obj_attached.item
			end
			objc_add_cursor_rect__cursor_ (item, a_rect.item, an_obj__item)
		end

	remove_cursor_rect__cursor_ (a_rect: NS_RECT; an_obj: detachable NS_CURSOR)
			-- Auto generated Objective-C wrapper.
		local
			an_obj__item: POINTER
		do
			if attached an_obj as an_obj_attached then
				an_obj__item := an_obj_attached.item
			end
			objc_remove_cursor_rect__cursor_ (item, a_rect.item, an_obj__item)
		end

	discard_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_discard_cursor_rects (item)
		end

	reset_cursor_rects
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reset_cursor_rects (item)
		end

--	add_tracking_rect__owner__user_data__assume_inside_ (a_rect: NS_RECT; an_object: detachable NS_OBJECT; a_data: UNSUPPORTED_TYPE; a_flag: BOOLEAN): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--			an_object__item: POINTER
--			a_data__item: POINTER
--		do
--			if attached an_object as an_object_attached then
--				an_object__item := an_object_attached.item
--			end
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			Result := objc_add_tracking_rect__owner__user_data__assume_inside_ (item, a_rect.item, an_object__item, a_data__item, a_flag)
--		end

	remove_tracking_rect_ (a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_tracking_rect_ (item, a_tag)
		end

	make_backing_layer: detachable CA_LAYER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_make_backing_layer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like make_backing_layer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like make_backing_layer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	layer_contents_redraw_policy: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_layer_contents_redraw_policy (item)
		end

	set_layer_contents_redraw_policy_ (a_new_policy: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_layer_contents_redraw_policy_ (item, a_new_policy)
		end

	layer_contents_placement: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_layer_contents_placement (item)
		end

	set_layer_contents_placement_ (a_new_placement: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_layer_contents_placement_ (item, a_new_placement)
		end

	set_wants_layer_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_wants_layer_ (item, a_flag)
		end

	wants_layer: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_wants_layer (item)
		end

	set_layer_ (a_new_layer: detachable CA_LAYER)
			-- Auto generated Objective-C wrapper.
		local
			a_new_layer__item: POINTER
		do
			if attached a_new_layer as a_new_layer_attached then
				a_new_layer__item := a_new_layer_attached.item
			end
			objc_set_layer_ (item, a_new_layer__item)
		end

	layer: detachable CA_LAYER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_layer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like layer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like layer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_alpha_value_ (a_view_alpha: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_alpha_value_ (item, a_view_alpha)
		end

	alpha_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_alpha_value (item)
		end

	set_background_filters_ (a_filters: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_filters__item: POINTER
		do
			if attached a_filters as a_filters_attached then
				a_filters__item := a_filters_attached.item
			end
			objc_set_background_filters_ (item, a_filters__item)
		end

	background_filters: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_filters (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_filters} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_filters} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	set_compositing_filter_ (a_filter: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--		do
--			objc_set_compositing_filter_ (item, )
--		end

--	compositing_filter: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_compositing_filter (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like compositing_filter} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like compositing_filter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_content_filters_ (a_filters: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_filters__item: POINTER
		do
			if attached a_filters as a_filters_attached then
				a_filters__item := a_filters_attached.item
			end
			objc_set_content_filters_ (item, a_filters__item)
		end

	content_filters: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content_filters (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content_filters} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content_filters} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_shadow_ (a_shadow: detachable NS_SHADOW)
			-- Auto generated Objective-C wrapper.
		local
			a_shadow__item: POINTER
		do
			if attached a_shadow as a_shadow_attached then
				a_shadow__item := a_shadow_attached.item
			end
			objc_set_shadow_ (item, a_shadow__item)
		end

	shadow: detachable NS_SHADOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_shadow (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shadow} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shadow} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_tracking_area_ (a_tracking_area: detachable NS_TRACKING_AREA)
			-- Auto generated Objective-C wrapper.
		local
			a_tracking_area__item: POINTER
		do
			if attached a_tracking_area as a_tracking_area_attached then
				a_tracking_area__item := a_tracking_area_attached.item
			end
			objc_add_tracking_area_ (item, a_tracking_area__item)
		end

	remove_tracking_area_ (a_tracking_area: detachable NS_TRACKING_AREA)
			-- Auto generated Objective-C wrapper.
		local
			a_tracking_area__item: POINTER
		do
			if attached a_tracking_area as a_tracking_area_attached then
				a_tracking_area__item := a_tracking_area_attached.item
			end
			objc_remove_tracking_area_ (item, a_tracking_area__item)
		end

	tracking_areas: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tracking_areas (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tracking_areas} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tracking_areas} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	update_tracking_areas
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_tracking_areas (item)
		end

	should_draw_color: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_draw_color (item)
		end

	set_posts_bounds_changed_notifications_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_posts_bounds_changed_notifications_ (item, a_flag)
		end

	posts_bounds_changed_notifications: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_posts_bounds_changed_notifications (item)
		end

	enclosing_scroll_view: detachable NS_SCROLL_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_enclosing_scroll_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like enclosing_scroll_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like enclosing_scroll_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	menu_for_event_ (a_event: detachable NS_EVENT): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_event__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			result_pointer := objc_menu_for_event_ (item, a_event__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like menu_for_event_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like menu_for_event_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_tool_tip_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_tool_tip_ (item, a_string__item)
		end

	tool_tip: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_tool_tip (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like tool_tip} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like tool_tip} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	add_tool_tip_rect__owner__user_data_ (a_rect: NS_RECT; an_object: detachable NS_OBJECT; a_data: UNSUPPORTED_TYPE): INTEGER_64
--			-- Auto generated Objective-C wrapper.
--		local
--			an_object__item: POINTER
--			a_data__item: POINTER
--		do
--			if attached an_object as an_object_attached then
--				an_object__item := an_object_attached.item
--			end
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			Result := objc_add_tool_tip_rect__owner__user_data_ (item, a_rect.item, an_object__item, a_data__item)
--		end

	remove_tool_tip_ (a_tag: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_tool_tip_ (item, a_tag)
		end

	remove_all_tool_tips
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_tool_tips (item)
		end

	view_will_start_live_resize
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_will_start_live_resize (item)
		end

	view_did_end_live_resize
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_view_did_end_live_resize (item)
		end

	in_live_resize: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_in_live_resize (item)
		end

	preserves_content_during_live_resize: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preserves_content_during_live_resize (item)
		end

	rect_preserved_during_live_resize: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_preserved_during_live_resize (item, Result.item)
		end

--	get_rects_exposed_during_live_resize__count_ (a_exposed_rects: UNSUPPORTED_TYPE; a_count: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_exposed_rects__item: POINTER
--			a_count__item: POINTER
--		do
--			if attached a_exposed_rects as a_exposed_rects_attached then
--				a_exposed_rects__item := a_exposed_rects_attached.item
--			end
--			if attached a_count as a_count_attached then
--				a_count__item := a_count_attached.item
--			end
--			objc_get_rects_exposed_during_live_resize__count_ (item, a_exposed_rects__item, a_count__item)
--		end

	input_context: detachable NS_TEXT_INPUT_CONTEXT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_input_context (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like input_context} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like input_context} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSKeyboardUI

	set_next_key_view_ (a_next: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_next__item: POINTER
		do
			if attached a_next as a_next_attached then
				a_next__item := a_next_attached.item
			end
			objc_set_next_key_view_ (item, a_next__item)
		end

	next_key_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_key_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_key_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_key_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	previous_key_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_previous_key_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like previous_key_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like previous_key_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	next_valid_key_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_next_valid_key_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like next_valid_key_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like next_valid_key_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	previous_valid_key_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_previous_valid_key_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like previous_valid_key_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like previous_valid_key_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	can_become_key_view: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_become_key_view (item)
		end

	set_keyboard_focus_ring_needs_display_in_rect_ (a_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_keyboard_focus_ring_needs_display_in_rect_ (item, a_rect.item)
		end

	set_focus_ring_type_ (a_focus_ring_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_focus_ring_type_ (item, a_focus_ring_type)
		end

	focus_ring_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_focus_ring_type (item)
		end

feature {NONE} -- NSKeyboardUI Externals

	objc_set_next_key_view_ (an_item: POINTER; a_next: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setNextKeyView:$a_next];
			 ]"
		end

	objc_next_key_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item nextKeyView];
			 ]"
		end

	objc_previous_key_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item previousKeyView];
			 ]"
		end

	objc_next_valid_key_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item nextValidKeyView];
			 ]"
		end

	objc_previous_valid_key_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item previousValidKeyView];
			 ]"
		end

	objc_can_become_key_view (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item canBecomeKeyView];
			 ]"
		end

	objc_set_keyboard_focus_ring_needs_display_in_rect_ (an_item: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setKeyboardFocusRingNeedsDisplayInRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_set_focus_ring_type_ (an_item: POINTER; a_focus_ring_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item setFocusRingType:$a_focus_ring_type];
			 ]"
		end

	objc_focus_ring_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item focusRingType];
			 ]"
		end

feature -- NSPrinting

	write_eps_inside_rect__to_pasteboard_ (a_rect: NS_RECT; a_pasteboard: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			objc_write_eps_inside_rect__to_pasteboard_ (item, a_rect.item, a_pasteboard__item)
		end

	data_with_eps_inside_rect_ (a_rect: NS_RECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_with_eps_inside_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_eps_inside_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_eps_inside_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_pdf_inside_rect__to_pasteboard_ (a_rect: NS_RECT; a_pasteboard: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			objc_write_pdf_inside_rect__to_pasteboard_ (item, a_rect.item, a_pasteboard__item)
		end

	data_with_pdf_inside_rect_ (a_rect: NS_RECT): detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_with_pdf_inside_rect_ (item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_with_pdf_inside_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_with_pdf_inside_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	print_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_print_ (item, a_sender__item)
		end

--	knows_page_range_ (a_range: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_range__item: POINTER
--		do
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			Result := objc_knows_page_range_ (item, a_range__item)
--		end

	height_adjust_limit: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_height_adjust_limit (item)
		end

	width_adjust_limit: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_width_adjust_limit (item)
		end

--	adjust_page_width_new__left__right__limit_ (a_new_right: UNSUPPORTED_TYPE; a_old_left: REAL_64; a_old_right: REAL_64; a_right_limit: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_new_right__item: POINTER
--		do
--			if attached a_new_right as a_new_right_attached then
--				a_new_right__item := a_new_right_attached.item
--			end
--			objc_adjust_page_width_new__left__right__limit_ (item, a_new_right__item, a_old_left, a_old_right, a_right_limit)
--		end

--	adjust_page_height_new__top__bottom__limit_ (a_new_bottom: UNSUPPORTED_TYPE; a_old_top: REAL_64; a_old_bottom: REAL_64; a_bottom_limit: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_new_bottom__item: POINTER
--		do
--			if attached a_new_bottom as a_new_bottom_attached then
--				a_new_bottom__item := a_new_bottom_attached.item
--			end
--			objc_adjust_page_height_new__top__bottom__limit_ (item, a_new_bottom__item, a_old_top, a_old_bottom, a_bottom_limit)
--		end

	rect_for_page_ (a_page: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_rect_for_page_ (item, Result.item, a_page)
		end

	location_of_print_rect_ (a_rect: NS_RECT): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_location_of_print_rect_ (item, Result.item, a_rect.item)
		end

	draw_page_border_with_size_ (a_border_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_page_border_with_size_ (item, a_border_size.item)
		end

	page_header: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_page_header (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like page_header} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like page_header} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	page_footer: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_page_footer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like page_footer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like page_footer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_sheet_border_with_size_ (a_border_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_sheet_border_with_size_ (item, a_border_size.item)
		end

	print_job_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_print_job_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_job_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_job_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	begin_document
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_document (item)
		end

	end_document
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_document (item)
		end

	begin_page_in_rect__at_placement_ (a_rect: NS_RECT; a_location: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_page_in_rect__at_placement_ (item, a_rect.item, a_location.item)
		end

	end_page
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_page (item)
		end

feature {NONE} -- NSPrinting Externals

	objc_write_eps_inside_rect__to_pasteboard_ (an_item: POINTER; a_rect: POINTER; a_pasteboard: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item writeEPSInsideRect:*((NSRect *)$a_rect) toPasteboard:$a_pasteboard];
			 ]"
		end

	objc_data_with_eps_inside_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item dataWithEPSInsideRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_write_pdf_inside_rect__to_pasteboard_ (an_item: POINTER; a_rect: POINTER; a_pasteboard: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item writePDFInsideRect:*((NSRect *)$a_rect) toPasteboard:$a_pasteboard];
			 ]"
		end

	objc_data_with_pdf_inside_rect_ (an_item: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item dataWithPDFInsideRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_print_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item print:$a_sender];
			 ]"
		end

--	objc_knows_page_range_ (an_item: POINTER; a_range: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSView *)$an_item knowsPageRange:];
--			 ]"
--		end

	objc_height_adjust_limit (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item heightAdjustLimit];
			 ]"
		end

	objc_width_adjust_limit (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item widthAdjustLimit];
			 ]"
		end

--	objc_adjust_page_width_new__left__right__limit_ (an_item: POINTER; a_new_right: UNSUPPORTED_TYPE; a_old_left: REAL_64; a_old_right: REAL_64; a_right_limit: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item adjustPageWidthNew: left:$a_old_left right:$a_old_right limit:$a_right_limit];
--			 ]"
--		end

--	objc_adjust_page_height_new__top__bottom__limit_ (an_item: POINTER; a_new_bottom: UNSUPPORTED_TYPE; a_old_top: REAL_64; a_old_bottom: REAL_64; a_bottom_limit: REAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item adjustPageHeightNew: top:$a_old_top bottom:$a_old_bottom limit:$a_bottom_limit];
--			 ]"
--		end

	objc_rect_for_page_ (an_item: POINTER; result_pointer: POINTER; a_page: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSView *)$an_item rectForPage:$a_page];
			 ]"
		end

	objc_location_of_print_rect_ (an_item: POINTER; result_pointer: POINTER; a_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSView *)$an_item locationOfPrintRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_draw_page_border_with_size_ (an_item: POINTER; a_border_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item drawPageBorderWithSize:*((NSSize *)$a_border_size)];
			 ]"
		end

	objc_page_header (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item pageHeader];
			 ]"
		end

	objc_page_footer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item pageFooter];
			 ]"
		end

	objc_draw_sheet_border_with_size_ (an_item: POINTER; a_border_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item drawSheetBorderWithSize:*((NSSize *)$a_border_size)];
			 ]"
		end

	objc_print_job_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item printJobTitle];
			 ]"
		end

	objc_begin_document (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item beginDocument];
			 ]"
		end

	objc_end_document (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item endDocument];
			 ]"
		end

	objc_begin_page_in_rect__at_placement_ (an_item: POINTER; a_rect: POINTER; a_location: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item beginPageInRect:*((NSRect *)$a_rect) atPlacement:*((NSPoint *)$a_location)];
			 ]"
		end

	objc_end_page (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item endPage];
			 ]"
		end

feature -- NSDrag

	drag_image__at__offset__event__pasteboard__source__slide_back_ (an_image: detachable NS_IMAGE; a_view_location: NS_POINT; a_initial_offset: NS_SIZE; a_event: detachable NS_EVENT; a_pboard: detachable NS_PASTEBOARD; a_source_obj: detachable NS_OBJECT; a_slide_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			an_image__item: POINTER
			a_event__item: POINTER
			a_pboard__item: POINTER
			a_source_obj__item: POINTER
		do
			if attached an_image as an_image_attached then
				an_image__item := an_image_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_pboard as a_pboard_attached then
				a_pboard__item := a_pboard_attached.item
			end
			if attached a_source_obj as a_source_obj_attached then
				a_source_obj__item := a_source_obj_attached.item
			end
			objc_drag_image__at__offset__event__pasteboard__source__slide_back_ (item, an_image__item, a_view_location.item, a_initial_offset.item, a_event__item, a_pboard__item, a_source_obj__item, a_slide_flag)
		end

	registered_dragged_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_registered_dragged_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like registered_dragged_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like registered_dragged_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	register_for_dragged_types_ (a_new_types: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_new_types__item: POINTER
		do
			if attached a_new_types as a_new_types_attached then
				a_new_types__item := a_new_types_attached.item
			end
			objc_register_for_dragged_types_ (item, a_new_types__item)
		end

	unregister_dragged_types
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_unregister_dragged_types (item)
		end

	drag_file__from_rect__slide_back__event_ (a_filename: detachable NS_STRING; a_rect: NS_RECT; a_flag: BOOLEAN; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_filename__item: POINTER
			a_event__item: POINTER
		do
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_drag_file__from_rect__slide_back__event_ (item, a_filename__item, a_rect.item, a_flag, a_event__item)
		end

	drag_promised_files_of_types__from_rect__source__slide_back__event_ (a_type_array: detachable NS_ARRAY; a_rect: NS_RECT; a_source_object: detachable NS_OBJECT; a_flag: BOOLEAN; a_event: detachable NS_EVENT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_type_array__item: POINTER
			a_source_object__item: POINTER
			a_event__item: POINTER
		do
			if attached a_type_array as a_type_array_attached then
				a_type_array__item := a_type_array_attached.item
			end
			if attached a_source_object as a_source_object_attached then
				a_source_object__item := a_source_object_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			Result := objc_drag_promised_files_of_types__from_rect__source__slide_back__event_ (item, a_type_array__item, a_rect.item, a_source_object__item, a_flag, a_event__item)
		end

feature {NONE} -- NSDrag Externals

	objc_drag_image__at__offset__event__pasteboard__source__slide_back_ (an_item: POINTER; an_image: POINTER; a_view_location: POINTER; a_initial_offset: POINTER; a_event: POINTER; a_pboard: POINTER; a_source_obj: POINTER; a_slide_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item dragImage:$an_image at:*((NSPoint *)$a_view_location) offset:*((NSSize *)$a_initial_offset) event:$a_event pasteboard:$a_pboard source:$a_source_obj slideBack:$a_slide_flag];
			 ]"
		end

	objc_registered_dragged_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item registeredDraggedTypes];
			 ]"
		end

	objc_register_for_dragged_types_ (an_item: POINTER; a_new_types: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item registerForDraggedTypes:$a_new_types];
			 ]"
		end

	objc_unregister_dragged_types (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item unregisterDraggedTypes];
			 ]"
		end

	objc_drag_file__from_rect__slide_back__event_ (an_item: POINTER; a_filename: POINTER; a_rect: POINTER; a_flag: BOOLEAN; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item dragFile:$a_filename fromRect:*((NSRect *)$a_rect) slideBack:$a_flag event:$a_event];
			 ]"
		end

	objc_drag_promised_files_of_types__from_rect__source__slide_back__event_ (an_item: POINTER; a_type_array: POINTER; a_rect: POINTER; a_source_object: POINTER; a_flag: BOOLEAN; a_event: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item dragPromisedFilesOfTypes:$a_type_array fromRect:*((NSRect *)$a_rect) source:$a_source_object slideBack:$a_flag event:$a_event];
			 ]"
		end

feature -- NSFullScreenMode

	enter_full_screen_mode__with_options_ (a_screen: detachable NS_SCREEN; a_options: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_screen__item: POINTER
			a_options__item: POINTER
		do
			if attached a_screen as a_screen_attached then
				a_screen__item := a_screen_attached.item
			end
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			Result := objc_enter_full_screen_mode__with_options_ (item, a_screen__item, a_options__item)
		end

	exit_full_screen_mode_with_options_ (a_options: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_options__item: POINTER
		do
			if attached a_options as a_options_attached then
				a_options__item := a_options_attached.item
			end
			objc_exit_full_screen_mode_with_options_ (item, a_options__item)
		end

	is_in_full_screen_mode: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_in_full_screen_mode (item)
		end

feature {NONE} -- NSFullScreenMode Externals

	objc_enter_full_screen_mode__with_options_ (an_item: POINTER; a_screen: POINTER; a_options: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item enterFullScreenMode:$a_screen withOptions:$a_options];
			 ]"
		end

	objc_exit_full_screen_mode_with_options_ (an_item: POINTER; a_options: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item exitFullScreenModeWithOptions:$a_options];
			 ]"
		end

	objc_is_in_full_screen_mode (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item isInFullScreenMode];
			 ]"
		end

feature -- NSDefinition

	show_definition_for_attributed_string__at_point_ (a_attr_string: detachable NS_ATTRIBUTED_STRING; a_text_baseline_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_string__item: POINTER
		do
			if attached a_attr_string as a_attr_string_attached then
				a_attr_string__item := a_attr_string_attached.item
			end
			objc_show_definition_for_attributed_string__at_point_ (item, a_attr_string__item, a_text_baseline_origin.item)
		end

--	show_definition_for_attributed_string__range__options__baseline_origin_provider_ (a_attr_string: detachable NS_ATTRIBUTED_STRING; a_target_range: NS_RANGE; a_options: detachable NS_DICTIONARY; a_origin_provider: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_attr_string__item: POINTER
--			a_options__item: POINTER
--		do
--			if attached a_attr_string as a_attr_string_attached then
--				a_attr_string__item := a_attr_string_attached.item
--			end
--			if attached a_options as a_options_attached then
--				a_options__item := a_options_attached.item
--			end
--			objc_show_definition_for_attributed_string__range__options__baseline_origin_provider_ (item, a_attr_string__item, a_target_range.item, a_options__item, )
--		end

feature {NONE} -- NSDefinition Externals

	objc_show_definition_for_attributed_string__at_point_ (an_item: POINTER; a_attr_string: POINTER; a_text_baseline_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item showDefinitionForAttributedString:$a_attr_string atPoint:*((NSPoint *)$a_text_baseline_origin)];
			 ]"
		end

--	objc_show_definition_for_attributed_string__range__options__baseline_origin_provider_ (an_item: POINTER; a_attr_string: POINTER; a_target_range: POINTER; a_options: POINTER; a_origin_provider: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSView *)$an_item showDefinitionForAttributedString:$a_attr_string range:*((NSRange *)$a_target_range) options:$a_options baselineOriginProvider:];
--			 ]"
--		end

feature -- NSClipViewSuperview

	reflect_scrolled_clip_view_ (a_clip_view: detachable NS_CLIP_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_clip_view__item: POINTER
		do
			if attached a_clip_view as a_clip_view_attached then
				a_clip_view__item := a_clip_view_attached.item
			end
			objc_reflect_scrolled_clip_view_ (item, a_clip_view__item)
		end

	scroll_clip_view__to_point_ (a_clip_view: detachable NS_CLIP_VIEW; a_point: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
			a_clip_view__item: POINTER
		do
			if attached a_clip_view as a_clip_view_attached then
				a_clip_view__item := a_clip_view_attached.item
			end
			objc_scroll_clip_view__to_point_ (item, a_clip_view__item, a_point.item)
		end

feature {NONE} -- NSClipViewSuperview Externals

	objc_reflect_scrolled_clip_view_ (an_item: POINTER; a_clip_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item reflectScrolledClipView:$a_clip_view];
			 ]"
		end

	objc_scroll_clip_view__to_point_ (an_item: POINTER; a_clip_view: POINTER; a_point: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item scrollClipView:$a_clip_view toPoint:*((NSPoint *)$a_point)];
			 ]"
		end

feature -- NSViewEnclosingMenuItem

	enclosing_menu_item: detachable NS_MENU_ITEM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_enclosing_menu_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like enclosing_menu_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like enclosing_menu_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSViewEnclosingMenuItem Externals

	objc_enclosing_menu_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSView *)$an_item enclosingMenuItem];
			 ]"
		end

feature -- NSRulerMarkerClientViewDelegation

	ruler_view__should_move_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			Result := objc_ruler_view__should_move_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__will_move_marker__to_location_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER; a_location: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			Result := objc_ruler_view__will_move_marker__to_location_ (item, a_ruler__item, a_marker__item, a_location)
		end

	ruler_view__did_move_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER)
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			objc_ruler_view__did_move_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__should_remove_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			Result := objc_ruler_view__should_remove_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__did_remove_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER)
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			objc_ruler_view__did_remove_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__should_add_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			Result := objc_ruler_view__should_add_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__will_add_marker__at_location_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER; a_location: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			Result := objc_ruler_view__will_add_marker__at_location_ (item, a_ruler__item, a_marker__item, a_location)
		end

	ruler_view__did_add_marker_ (a_ruler: detachable NS_RULER_VIEW; a_marker: detachable NS_RULER_MARKER)
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_marker__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_marker as a_marker_attached then
				a_marker__item := a_marker_attached.item
			end
			objc_ruler_view__did_add_marker_ (item, a_ruler__item, a_marker__item)
		end

	ruler_view__handle_mouse_down_ (a_ruler: detachable NS_RULER_VIEW; a_event: detachable NS_EVENT)
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_event__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			objc_ruler_view__handle_mouse_down_ (item, a_ruler__item, a_event__item)
		end

	ruler_view__will_set_client_view_ (a_ruler: detachable NS_RULER_VIEW; a_new_client: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_ruler__item: POINTER
			a_new_client__item: POINTER
		do
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			if attached a_new_client as a_new_client_attached then
				a_new_client__item := a_new_client_attached.item
			end
			objc_ruler_view__will_set_client_view_ (item, a_ruler__item, a_new_client__item)
		end

feature {NONE} -- NSRulerMarkerClientViewDelegation Externals

	objc_ruler_view__should_move_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item rulerView:$a_ruler shouldMoveMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__will_move_marker__to_location_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER; a_location: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item rulerView:$a_ruler willMoveMarker:$a_marker toLocation:$a_location];
			 ]"
		end

	objc_ruler_view__did_move_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rulerView:$a_ruler didMoveMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__should_remove_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item rulerView:$a_ruler shouldRemoveMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__did_remove_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rulerView:$a_ruler didRemoveMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__should_add_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item rulerView:$a_ruler shouldAddMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__will_add_marker__at_location_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER; a_location: REAL_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSView *)$an_item rulerView:$a_ruler willAddMarker:$a_marker atLocation:$a_location];
			 ]"
		end

	objc_ruler_view__did_add_marker_ (an_item: POINTER; a_ruler: POINTER; a_marker: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rulerView:$a_ruler didAddMarker:$a_marker];
			 ]"
		end

	objc_ruler_view__handle_mouse_down_ (an_item: POINTER; a_ruler: POINTER; a_event: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rulerView:$a_ruler handleMouseDown:$a_event];
			 ]"
		end

	objc_ruler_view__will_set_client_view_ (an_item: POINTER; a_ruler: POINTER; a_new_client: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSView *)$an_item rulerView:$a_ruler willSetClientView:$a_new_client];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSView"
		end

end
