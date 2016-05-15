note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TIMER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSTimer

	timer_with_time_interval__invocation__repeats_ (a_ti: REAL_64; a_invocation: detachable NS_INVOCATION; a_yes_or_no: BOOLEAN): detachable NS_TIMER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_invocation__item: POINTER
		do
			if attached a_invocation as a_invocation_attached then
				a_invocation__item := a_invocation_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_timer_with_time_interval__invocation__repeats_ (l_objc_class.item, a_ti, a_invocation__item, a_yes_or_no)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like timer_with_time_interval__invocation__repeats_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like timer_with_time_interval__invocation__repeats_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scheduled_timer_with_time_interval__invocation__repeats_ (a_ti: REAL_64; a_invocation: detachable NS_INVOCATION; a_yes_or_no: BOOLEAN): detachable NS_TIMER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_invocation__item: POINTER
		do
			if attached a_invocation as a_invocation_attached then
				a_invocation__item := a_invocation_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_scheduled_timer_with_time_interval__invocation__repeats_ (l_objc_class.item, a_ti, a_invocation__item, a_yes_or_no)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scheduled_timer_with_time_interval__invocation__repeats_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scheduled_timer_with_time_interval__invocation__repeats_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	timer_with_time_interval__target__selector__user_info__repeats_ (a_ti: REAL_64; a_target: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_user_info: detachable NS_OBJECT; a_yes_or_no: BOOLEAN): detachable NS_TIMER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_target__item: POINTER
			a_selector__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_timer_with_time_interval__target__selector__user_info__repeats_ (l_objc_class.item, a_ti, a_target__item, a_selector__item, a_user_info__item, a_yes_or_no)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like timer_with_time_interval__target__selector__user_info__repeats_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like timer_with_time_interval__target__selector__user_info__repeats_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scheduled_timer_with_time_interval__target__selector__user_info__repeats_ (a_ti: REAL_64; a_target: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_user_info: detachable NS_OBJECT; a_yes_or_no: BOOLEAN): detachable NS_TIMER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_target__item: POINTER
			a_selector__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_scheduled_timer_with_time_interval__target__selector__user_info__repeats_ (l_objc_class.item, a_ti, a_target__item, a_selector__item, a_user_info__item, a_yes_or_no)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scheduled_timer_with_time_interval__target__selector__user_info__repeats_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scheduled_timer_with_time_interval__target__selector__user_info__repeats_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSTimer Externals

	objc_timer_with_time_interval__invocation__repeats_ (a_class_object: POINTER; a_ti: REAL_64; a_invocation: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timerWithTimeInterval:$a_ti invocation:$a_invocation repeats:$a_yes_or_no];
			 ]"
		end

	objc_scheduled_timer_with_time_interval__invocation__repeats_ (a_class_object: POINTER; a_ti: REAL_64; a_invocation: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object scheduledTimerWithTimeInterval:$a_ti invocation:$a_invocation repeats:$a_yes_or_no];
			 ]"
		end

	objc_timer_with_time_interval__target__selector__user_info__repeats_ (a_class_object: POINTER; a_ti: REAL_64; a_target: POINTER; a_selector: POINTER; a_user_info: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object timerWithTimeInterval:$a_ti target:$a_target selector:$a_selector userInfo:$a_user_info repeats:$a_yes_or_no];
			 ]"
		end

	objc_scheduled_timer_with_time_interval__target__selector__user_info__repeats_ (a_class_object: POINTER; a_ti: REAL_64; a_target: POINTER; a_selector: POINTER; a_user_info: POINTER; a_yes_or_no: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object scheduledTimerWithTimeInterval:$a_ti target:$a_target selector:$a_selector userInfo:$a_user_info repeats:$a_yes_or_no];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTimer"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
