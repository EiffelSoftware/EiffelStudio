note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RUN_LOOP

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSRunLoop

	current_mode: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_current_mode (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_mode} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_mode} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_cf_run_loop: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_get_cf_run_loop (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like get_cf_run_loop} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like get_cf_run_loop} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	add_timer__for_mode_ (a_timer: detachable NS_TIMER; a_mode: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_timer__item: POINTER
			a_mode__item: POINTER
		do
			if attached a_timer as a_timer_attached then
				a_timer__item := a_timer_attached.item
			end
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			objc_add_timer__for_mode_ (item, a_timer__item, a_mode__item)
		end

--	add_port__for_mode_ (a_port: UNSUPPORTED_TYPE; a_mode: detachable NS_STRING)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_port__item: POINTER
--			a_mode__item: POINTER
--		do
--			if attached a_port as a_port_attached then
--				a_port__item := a_port_attached.item
--			end
--			if attached a_mode as a_mode_attached then
--				a_mode__item := a_mode_attached.item
--			end
--			objc_add_port__for_mode_ (item, a_port__item, a_mode__item)
--		end

--	remove_port__for_mode_ (a_port: UNSUPPORTED_TYPE; a_mode: detachable NS_STRING)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_port__item: POINTER
--			a_mode__item: POINTER
--		do
--			if attached a_port as a_port_attached then
--				a_port__item := a_port_attached.item
--			end
--			if attached a_mode as a_mode_attached then
--				a_mode__item := a_mode_attached.item
--			end
--			objc_remove_port__for_mode_ (item, a_port__item, a_mode__item)
--		end

	limit_date_for_mode_ (a_mode: detachable NS_STRING): detachable NS_DATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_mode__item: POINTER
		do
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			result_pointer := objc_limit_date_for_mode_ (item, a_mode__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like limit_date_for_mode_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like limit_date_for_mode_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accept_input_for_mode__before_date_ (a_mode: detachable NS_STRING; a_limit_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_mode__item: POINTER
			a_limit_date__item: POINTER
		do
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			if attached a_limit_date as a_limit_date_attached then
				a_limit_date__item := a_limit_date_attached.item
			end
			objc_accept_input_for_mode__before_date_ (item, a_mode__item, a_limit_date__item)
		end

feature {NONE} -- NSRunLoop Externals

	objc_current_mode (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunLoop *)$an_item currentMode];
			 ]"
		end

--	objc_get_cf_run_loop (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSRunLoop *)$an_item getCFRunLoop];
--			 ]"
--		end

	objc_add_timer__for_mode_ (an_item: POINTER; a_timer: POINTER; a_mode: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item addTimer:$a_timer forMode:$a_mode];
			 ]"
		end

--	objc_add_port__for_mode_ (an_item: POINTER; a_port: POINTER; a_mode: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSRunLoop *)$an_item addPort:$a_port forMode:$a_mode];
--			 ]"
--		end

--	objc_remove_port__for_mode_ (an_item: POINTER; a_port: POINTER; a_mode: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSRunLoop *)$an_item removePort:$a_port forMode:$a_mode];
--			 ]"
--		end

	objc_limit_date_for_mode_ (an_item: POINTER; a_mode: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRunLoop *)$an_item limitDateForMode:$a_mode];
			 ]"
		end

	objc_accept_input_for_mode__before_date_ (an_item: POINTER; a_mode: POINTER; a_limit_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item acceptInputForMode:$a_mode beforeDate:$a_limit_date];
			 ]"
		end

feature -- NSRunLoopConveniences

	run
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_run (item)
		end

	run_until_date_ (a_limit_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			a_limit_date__item: POINTER
		do
			if attached a_limit_date as a_limit_date_attached then
				a_limit_date__item := a_limit_date_attached.item
			end
			objc_run_until_date_ (item, a_limit_date__item)
		end

	run_mode__before_date_ (a_mode: detachable NS_STRING; a_limit_date: detachable NS_DATE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_mode__item: POINTER
			a_limit_date__item: POINTER
		do
			if attached a_mode as a_mode_attached then
				a_mode__item := a_mode_attached.item
			end
			if attached a_limit_date as a_limit_date_attached then
				a_limit_date__item := a_limit_date_attached.item
			end
			Result := objc_run_mode__before_date_ (item, a_mode__item, a_limit_date__item)
		end

feature {NONE} -- NSRunLoopConveniences Externals

	objc_run (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item run];
			 ]"
		end

	objc_run_until_date_ (an_item: POINTER; a_limit_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item runUntilDate:$a_limit_date];
			 ]"
		end

	objc_run_mode__before_date_ (an_item: POINTER; a_mode: POINTER; a_limit_date: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSRunLoop *)$an_item runMode:$a_mode beforeDate:$a_limit_date];
			 ]"
		end

feature -- NSOrderedPerform

	perform_selector__target__argument__order__modes_ (a_selector: detachable OBJC_SELECTOR; a_target: detachable NS_OBJECT; a_arg: detachable NS_OBJECT; a_order: NATURAL_64; a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_target__item: POINTER
			a_arg__item: POINTER
			a_modes__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_perform_selector__target__argument__order__modes_ (item, a_selector__item, a_target__item, a_arg__item, a_order, a_modes__item)
		end

	cancel_perform_selector__target__argument_ (a_selector: detachable OBJC_SELECTOR; a_target: detachable NS_OBJECT; a_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_target__item: POINTER
			a_arg__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			objc_cancel_perform_selector__target__argument_ (item, a_selector__item, a_target__item, a_arg__item)
		end

	cancel_perform_selectors_with_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_cancel_perform_selectors_with_target_ (item, a_target__item)
		end

feature {NONE} -- NSOrderedPerform Externals

	objc_perform_selector__target__argument__order__modes_ (an_item: POINTER; a_selector: POINTER; a_target: POINTER; a_arg: POINTER; a_order: NATURAL_64; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item performSelector:$a_selector target:$a_target argument:$a_arg order:$a_order modes:$a_modes];
			 ]"
		end

	objc_cancel_perform_selector__target__argument_ (an_item: POINTER; a_selector: POINTER; a_target: POINTER; a_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item cancelPerformSelector:$a_selector target:$a_target argument:$a_arg];
			 ]"
		end

	objc_cancel_perform_selectors_with_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSRunLoop *)$an_item cancelPerformSelectorsWithTarget:$a_target];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRunLoop"
		end

end
