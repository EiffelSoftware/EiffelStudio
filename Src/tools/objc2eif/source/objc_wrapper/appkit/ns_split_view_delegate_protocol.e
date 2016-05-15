note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_SPLIT_VIEW_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	split_view__can_collapse_subview_ (a_split_view: detachable NS_SPLIT_VIEW; a_subview: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__can_collapse_subview_: has_split_view__can_collapse_subview_
		local
			a_split_view__item: POINTER
			a_subview__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			if attached a_subview as a_subview_attached then
				a_subview__item := a_subview_attached.item
			end
			Result := objc_split_view__can_collapse_subview_ (item, a_split_view__item, a_subview__item)
		end

	split_view__should_collapse_subview__for_double_click_on_divider_at_index_ (a_split_view: detachable NS_SPLIT_VIEW; a_subview: detachable NS_VIEW; a_divider_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__should_collapse_subview__for_double_click_on_divider_at_index_: has_split_view__should_collapse_subview__for_double_click_on_divider_at_index_
		local
			a_split_view__item: POINTER
			a_subview__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			if attached a_subview as a_subview_attached then
				a_subview__item := a_subview_attached.item
			end
			Result := objc_split_view__should_collapse_subview__for_double_click_on_divider_at_index_ (item, a_split_view__item, a_subview__item, a_divider_index)
		end

	split_view__constrain_min_coordinate__of_subview_at_ (a_split_view: detachable NS_SPLIT_VIEW; a_proposed_minimum_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__constrain_min_coordinate__of_subview_at_: has_split_view__constrain_min_coordinate__of_subview_at_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			Result := objc_split_view__constrain_min_coordinate__of_subview_at_ (item, a_split_view__item, a_proposed_minimum_position, a_divider_index)
		end

	split_view__constrain_max_coordinate__of_subview_at_ (a_split_view: detachable NS_SPLIT_VIEW; a_proposed_maximum_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__constrain_max_coordinate__of_subview_at_: has_split_view__constrain_max_coordinate__of_subview_at_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			Result := objc_split_view__constrain_max_coordinate__of_subview_at_ (item, a_split_view__item, a_proposed_maximum_position, a_divider_index)
		end

	split_view__constrain_split_position__of_subview_at_ (a_split_view: detachable NS_SPLIT_VIEW; a_proposed_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__constrain_split_position__of_subview_at_: has_split_view__constrain_split_position__of_subview_at_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			Result := objc_split_view__constrain_split_position__of_subview_at_ (item, a_split_view__item, a_proposed_position, a_divider_index)
		end

	split_view__resize_subviews_with_old_size_ (a_split_view: detachable NS_SPLIT_VIEW; a_old_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__resize_subviews_with_old_size_: has_split_view__resize_subviews_with_old_size_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			objc_split_view__resize_subviews_with_old_size_ (item, a_split_view__item, a_old_size.item)
		end

	split_view__should_adjust_size_of_subview_ (a_split_view: detachable NS_SPLIT_VIEW; a_view: detachable NS_VIEW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__should_adjust_size_of_subview_: has_split_view__should_adjust_size_of_subview_
		local
			a_split_view__item: POINTER
			a_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			Result := objc_split_view__should_adjust_size_of_subview_ (item, a_split_view__item, a_view__item)
		end

	split_view__should_hide_divider_at_index_ (a_split_view: detachable NS_SPLIT_VIEW; a_divider_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__should_hide_divider_at_index_: has_split_view__should_hide_divider_at_index_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			Result := objc_split_view__should_hide_divider_at_index_ (item, a_split_view__item, a_divider_index)
		end

	split_view__effective_rect__for_drawn_rect__of_divider_at_index_ (a_split_view: detachable NS_SPLIT_VIEW; a_proposed_effective_rect: NS_RECT; a_drawn_rect: NS_RECT; a_divider_index: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__effective_rect__for_drawn_rect__of_divider_at_index_: has_split_view__effective_rect__for_drawn_rect__of_divider_at_index_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			create Result.make
			objc_split_view__effective_rect__for_drawn_rect__of_divider_at_index_ (item, Result.item, a_split_view__item, a_proposed_effective_rect.item, a_drawn_rect.item, a_divider_index)
		end

	split_view__additional_effective_rect_of_divider_at_index_ (a_split_view: detachable NS_SPLIT_VIEW; a_divider_index: INTEGER_64): NS_RECT
			-- Auto generated Objective-C wrapper.
		require
			has_split_view__additional_effective_rect_of_divider_at_index_: has_split_view__additional_effective_rect_of_divider_at_index_
		local
			a_split_view__item: POINTER
		do
			if attached a_split_view as a_split_view_attached then
				a_split_view__item := a_split_view_attached.item
			end
			create Result.make
			objc_split_view__additional_effective_rect_of_divider_at_index_ (item, Result.item, a_split_view__item, a_divider_index)
		end

	split_view_will_resize_subviews_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_split_view_will_resize_subviews_: has_split_view_will_resize_subviews_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_split_view_will_resize_subviews_ (item, a_notification__item)
		end

	split_view_did_resize_subviews_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_split_view_did_resize_subviews_: has_split_view_did_resize_subviews_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_split_view_did_resize_subviews_ (item, a_notification__item)
		end

feature -- Status Report

	has_split_view__can_collapse_subview_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__can_collapse_subview_ (item)
		end

	has_split_view__should_collapse_subview__for_double_click_on_divider_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__should_collapse_subview__for_double_click_on_divider_at_index_ (item)
		end

	has_split_view__constrain_min_coordinate__of_subview_at_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__constrain_min_coordinate__of_subview_at_ (item)
		end

	has_split_view__constrain_max_coordinate__of_subview_at_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__constrain_max_coordinate__of_subview_at_ (item)
		end

	has_split_view__constrain_split_position__of_subview_at_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__constrain_split_position__of_subview_at_ (item)
		end

	has_split_view__resize_subviews_with_old_size_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__resize_subviews_with_old_size_ (item)
		end

	has_split_view__should_adjust_size_of_subview_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__should_adjust_size_of_subview_ (item)
		end

	has_split_view__should_hide_divider_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__should_hide_divider_at_index_ (item)
		end

	has_split_view__effective_rect__for_drawn_rect__of_divider_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__effective_rect__for_drawn_rect__of_divider_at_index_ (item)
		end

	has_split_view__additional_effective_rect_of_divider_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view__additional_effective_rect_of_divider_at_index_ (item)
		end

	has_split_view_will_resize_subviews_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view_will_resize_subviews_ (item)
		end

	has_split_view_did_resize_subviews_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_split_view_did_resize_subviews_ (item)
		end

feature -- Status Report Externals

	objc_has_split_view__can_collapse_subview_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:canCollapseSubview:)];
			 ]"
		end

	objc_has_split_view__should_collapse_subview__for_double_click_on_divider_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:shouldCollapseSubview:forDoubleClickOnDividerAtIndex:)];
			 ]"
		end

	objc_has_split_view__constrain_min_coordinate__of_subview_at_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:constrainMinCoordinate:ofSubviewAt:)];
			 ]"
		end

	objc_has_split_view__constrain_max_coordinate__of_subview_at_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:constrainMaxCoordinate:ofSubviewAt:)];
			 ]"
		end

	objc_has_split_view__constrain_split_position__of_subview_at_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:constrainSplitPosition:ofSubviewAt:)];
			 ]"
		end

	objc_has_split_view__resize_subviews_with_old_size_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:resizeSubviewsWithOldSize:)];
			 ]"
		end

	objc_has_split_view__should_adjust_size_of_subview_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:shouldAdjustSizeOfSubview:)];
			 ]"
		end

	objc_has_split_view__should_hide_divider_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:shouldHideDividerAtIndex:)];
			 ]"
		end

	objc_has_split_view__effective_rect__for_drawn_rect__of_divider_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:effectiveRect:forDrawnRect:ofDividerAtIndex:)];
			 ]"
		end

	objc_has_split_view__additional_effective_rect_of_divider_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitView:additionalEffectiveRectOfDividerAtIndex:)];
			 ]"
		end

	objc_has_split_view_will_resize_subviews_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitViewWillResizeSubviews:)];
			 ]"
		end

	objc_has_split_view_did_resize_subviews_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(splitViewDidResizeSubviews:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_split_view__can_collapse_subview_ (an_item: POINTER; a_split_view: POINTER; a_subview: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view canCollapseSubview:$a_subview];
			 ]"
		end

	objc_split_view__should_collapse_subview__for_double_click_on_divider_at_index_ (an_item: POINTER; a_split_view: POINTER; a_subview: POINTER; a_divider_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view shouldCollapseSubview:$a_subview forDoubleClickOnDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_split_view__constrain_min_coordinate__of_subview_at_ (an_item: POINTER; a_split_view: POINTER; a_proposed_minimum_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view constrainMinCoordinate:$a_proposed_minimum_position ofSubviewAt:$a_divider_index];
			 ]"
		end

	objc_split_view__constrain_max_coordinate__of_subview_at_ (an_item: POINTER; a_split_view: POINTER; a_proposed_maximum_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view constrainMaxCoordinate:$a_proposed_maximum_position ofSubviewAt:$a_divider_index];
			 ]"
		end

	objc_split_view__constrain_split_position__of_subview_at_ (an_item: POINTER; a_split_view: POINTER; a_proposed_position: REAL_64; a_divider_index: INTEGER_64): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view constrainSplitPosition:$a_proposed_position ofSubviewAt:$a_divider_index];
			 ]"
		end

	objc_split_view__resize_subviews_with_old_size_ (an_item: POINTER; a_split_view: POINTER; a_old_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view resizeSubviewsWithOldSize:*((NSSize *)$a_old_size)];
			 ]"
		end

	objc_split_view__should_adjust_size_of_subview_ (an_item: POINTER; a_split_view: POINTER; a_view: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view shouldAdjustSizeOfSubview:$a_view];
			 ]"
		end

	objc_split_view__should_hide_divider_at_index_ (an_item: POINTER; a_split_view: POINTER; a_divider_index: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view shouldHideDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_split_view__effective_rect__for_drawn_rect__of_divider_at_index_ (an_item: POINTER; result_pointer: POINTER; a_split_view: POINTER; a_proposed_effective_rect: POINTER; a_drawn_rect: POINTER; a_divider_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view effectiveRect:*((NSRect *)$a_proposed_effective_rect) forDrawnRect:*((NSRect *)$a_drawn_rect) ofDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_split_view__additional_effective_rect_of_divider_at_index_ (an_item: POINTER; result_pointer: POINTER; a_split_view: POINTER; a_divider_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(id <NSSplitViewDelegate>)$an_item splitView:$a_split_view additionalEffectiveRectOfDividerAtIndex:$a_divider_index];
			 ]"
		end

	objc_split_view_will_resize_subviews_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSplitViewDelegate>)$an_item splitViewWillResizeSubviews:$a_notification];
			 ]"
		end

	objc_split_view_did_resize_subviews_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSSplitViewDelegate>)$an_item splitViewDidResizeSubviews:$a_notification];
			 ]"
		end

end
