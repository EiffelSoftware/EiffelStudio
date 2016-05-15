note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_THREAD_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSThread

	current_thread: detachable NS_THREAD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_current_thread (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like current_thread} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like current_thread} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	detach_new_thread_selector__to_target__with_object_ (a_selector: detachable OBJC_SELECTOR; a_target: detachable NS_OBJECT; a_argument: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_selector__item: POINTER
			a_target__item: POINTER
			a_argument__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_argument as a_argument_attached then
				a_argument__item := a_argument_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_detach_new_thread_selector__to_target__with_object_ (l_objc_class.item, a_selector__item, a_target__item, a_argument__item)
		end

	is_multi_threaded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_is_multi_threaded (l_objc_class.item)
		end

	sleep_until_date_ (a_date: detachable NS_DATE)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_date__item: POINTER
		do
			if attached a_date as a_date_attached then
				a_date__item := a_date_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_sleep_until_date_ (l_objc_class.item, a_date__item)
		end

	sleep_for_time_interval_ (a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_sleep_for_time_interval_ (l_objc_class.item, a_ti)
		end

	exit
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			objc_exit (l_objc_class.item)
		end

	thread_priority: REAL_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_thread_priority (l_objc_class.item)
		end

	set_thread_priority_ (a_p: REAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_set_thread_priority_ (l_objc_class.item, a_p)
		end

	call_stack_return_addresses: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_call_stack_return_addresses (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like call_stack_return_addresses} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like call_stack_return_addresses} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	call_stack_symbols: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_call_stack_symbols (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like call_stack_symbols} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like call_stack_symbols} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	main_thread: detachable NS_THREAD
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_main_thread (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like main_thread} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like main_thread} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSThread Externals

	objc_current_thread (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object currentThread];
			 ]"
		end

	objc_detach_new_thread_selector__to_target__with_object_ (a_class_object: POINTER; a_selector: POINTER; a_target: POINTER; a_argument: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object detachNewThreadSelector:$a_selector toTarget:$a_target withObject:$a_argument];
			 ]"
		end

	objc_is_multi_threaded (a_class_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object isMultiThreaded];
			 ]"
		end

	objc_sleep_until_date_ (a_class_object: POINTER; a_date: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object sleepUntilDate:$a_date];
			 ]"
		end

	objc_sleep_for_time_interval_ (a_class_object: POINTER; a_ti: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object sleepForTimeInterval:$a_ti];
			 ]"
		end

	objc_exit (a_class_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(Class)$a_class_object exit];
			 ]"
		end

	objc_thread_priority (a_class_object: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object threadPriority];
			 ]"
		end

	objc_set_thread_priority_ (a_class_object: POINTER; a_p: REAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object setThreadPriority:$a_p];
			 ]"
		end

	objc_call_stack_return_addresses (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object callStackReturnAddresses];
			 ]"
		end

	objc_call_stack_symbols (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object callStackSymbols];
			 ]"
		end

	objc_main_thread (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object mainThread];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSThread"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
