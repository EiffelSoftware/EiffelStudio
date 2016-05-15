note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_ANIMATION_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	animation_should_start_ (a_animation: detachable NS_ANIMATION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		require
			has_animation_should_start_: has_animation_should_start_
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			Result := objc_animation_should_start_ (item, a_animation__item)
		end

	animation_did_stop_ (a_animation: detachable NS_ANIMATION)
			-- Auto generated Objective-C wrapper.
		require
			has_animation_did_stop_: has_animation_did_stop_
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			objc_animation_did_stop_ (item, a_animation__item)
		end

	animation_did_end_ (a_animation: detachable NS_ANIMATION)
			-- Auto generated Objective-C wrapper.
		require
			has_animation_did_end_: has_animation_did_end_
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			objc_animation_did_end_ (item, a_animation__item)
		end

	animation__value_for_progress_ (a_animation: detachable NS_ANIMATION; a_progress: REAL_32): REAL_32
			-- Auto generated Objective-C wrapper.
		require
			has_animation__value_for_progress_: has_animation__value_for_progress_
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			Result := objc_animation__value_for_progress_ (item, a_animation__item, a_progress)
		end

	animation__did_reach_progress_mark_ (a_animation: detachable NS_ANIMATION; a_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		require
			has_animation__did_reach_progress_mark_: has_animation__did_reach_progress_mark_
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			objc_animation__did_reach_progress_mark_ (item, a_animation__item, a_progress)
		end

feature -- Status Report

	has_animation_should_start_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_animation_should_start_ (item)
		end

	has_animation_did_stop_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_animation_did_stop_ (item)
		end

	has_animation_did_end_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_animation_did_end_ (item)
		end

	has_animation__value_for_progress_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_animation__value_for_progress_ (item)
		end

	has_animation__did_reach_progress_mark_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_animation__did_reach_progress_mark_ (item)
		end

feature -- Status Report Externals

	objc_has_animation_should_start_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(animationShouldStart:)];
			 ]"
		end

	objc_has_animation_did_stop_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(animationDidStop:)];
			 ]"
		end

	objc_has_animation_did_end_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(animationDidEnd:)];
			 ]"
		end

	objc_has_animation__value_for_progress_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(animation:valueForProgress:)];
			 ]"
		end

	objc_has_animation__did_reach_progress_mark_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(animation:didReachProgressMark:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_animation_should_start_ (an_item: POINTER; a_animation: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSAnimationDelegate>)$an_item animationShouldStart:$a_animation];
			 ]"
		end

	objc_animation_did_stop_ (an_item: POINTER; a_animation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSAnimationDelegate>)$an_item animationDidStop:$a_animation];
			 ]"
		end

	objc_animation_did_end_ (an_item: POINTER; a_animation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSAnimationDelegate>)$an_item animationDidEnd:$a_animation];
			 ]"
		end

	objc_animation__value_for_progress_ (an_item: POINTER; a_animation: POINTER; a_progress: REAL_32): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSAnimationDelegate>)$an_item animation:$a_animation valueForProgress:$a_progress];
			 ]"
		end

	objc_animation__did_reach_progress_mark_ (an_item: POINTER; a_animation: POINTER; a_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSAnimationDelegate>)$an_item animation:$a_animation didReachProgressMark:$a_progress];
			 ]"
		end

end
