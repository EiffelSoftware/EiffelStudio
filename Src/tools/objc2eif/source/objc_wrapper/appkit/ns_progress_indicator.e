note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PROGRESS_INDICATOR

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

feature -- NSProgressIndicator

	is_indeterminate: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_indeterminate (item)
		end

	set_indeterminate_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_indeterminate_ (item, a_flag)
		end

	is_bezeled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_bezeled (item)
		end

	set_bezeled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bezeled_ (item, a_flag)
		end

	control_tint: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_tint (item)
		end

	set_control_tint_ (a_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_tint_ (item, a_tint)
		end

	control_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_control_size (item)
		end

	set_control_size_ (a_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_control_size_ (item, a_size)
		end

	double_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_double_value (item)
		end

	set_double_value_ (a_double_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_double_value_ (item, a_double_value)
		end

	increment_by_ (a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_increment_by_ (item, a_delta)
		end

	min_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_min_value (item)
		end

	max_value: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_max_value (item)
		end

	set_min_value_ (a_new_minimum: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_value_ (item, a_new_minimum)
		end

	set_max_value_ (a_new_maximum: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_value_ (item, a_new_maximum)
		end

	uses_threaded_animation: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_threaded_animation (item)
		end

	set_uses_threaded_animation_ (a_threaded_animation: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_threaded_animation_ (item, a_threaded_animation)
		end

	start_animation_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_start_animation_ (item, a_sender__item)
		end

	stop_animation_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_stop_animation_ (item, a_sender__item)
		end

	set_style_ (a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_style_ (item, a_style)
		end

	style: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_style (item)
		end

	size_to_fit
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_size_to_fit (item)
		end

	is_displayed_when_stopped: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_displayed_when_stopped (item)
		end

	set_displayed_when_stopped_ (a_is_displayed: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_displayed_when_stopped_ (item, a_is_displayed)
		end

feature {NONE} -- NSProgressIndicator Externals

	objc_is_indeterminate (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item isIndeterminate];
			 ]"
		end

	objc_set_indeterminate_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setIndeterminate:$a_flag];
			 ]"
		end

	objc_is_bezeled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item isBezeled];
			 ]"
		end

	objc_set_bezeled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setBezeled:$a_flag];
			 ]"
		end

	objc_control_tint (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item controlTint];
			 ]"
		end

	objc_set_control_tint_ (an_item: POINTER; a_tint: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setControlTint:$a_tint];
			 ]"
		end

	objc_control_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item controlSize];
			 ]"
		end

	objc_set_control_size_ (an_item: POINTER; a_size: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setControlSize:$a_size];
			 ]"
		end

	objc_double_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item doubleValue];
			 ]"
		end

	objc_set_double_value_ (an_item: POINTER; a_double_value: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setDoubleValue:$a_double_value];
			 ]"
		end

	objc_increment_by_ (an_item: POINTER; a_delta: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item incrementBy:$a_delta];
			 ]"
		end

	objc_min_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item minValue];
			 ]"
		end

	objc_max_value (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item maxValue];
			 ]"
		end

	objc_set_min_value_ (an_item: POINTER; a_new_minimum: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setMinValue:$a_new_minimum];
			 ]"
		end

	objc_set_max_value_ (an_item: POINTER; a_new_maximum: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setMaxValue:$a_new_maximum];
			 ]"
		end

	objc_uses_threaded_animation (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item usesThreadedAnimation];
			 ]"
		end

	objc_set_uses_threaded_animation_ (an_item: POINTER; a_threaded_animation: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setUsesThreadedAnimation:$a_threaded_animation];
			 ]"
		end

	objc_start_animation_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item startAnimation:$a_sender];
			 ]"
		end

	objc_stop_animation_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item stopAnimation:$a_sender];
			 ]"
		end

	objc_set_style_ (an_item: POINTER; a_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setStyle:$a_style];
			 ]"
		end

	objc_style (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item style];
			 ]"
		end

	objc_size_to_fit (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item sizeToFit];
			 ]"
		end

	objc_is_displayed_when_stopped (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSProgressIndicator *)$an_item isDisplayedWhenStopped];
			 ]"
		end

	objc_set_displayed_when_stopped_ (an_item: POINTER; a_is_displayed: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSProgressIndicator *)$an_item setDisplayedWhenStopped:$a_is_displayed];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSProgressIndicator"
		end

end
