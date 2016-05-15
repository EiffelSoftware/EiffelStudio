note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_THREAD

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make,
	make_with_target__selector__object_

feature -- NSThread

	thread_dictionary: detachable NS_MUTABLE_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_thread_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like thread_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like thread_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_name_ (a_n: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_n__item: POINTER
		do
			if attached a_n as a_n_attached then
				a_n__item := a_n_attached.item
			end
			objc_set_name_ (item, a_n__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	stack_size: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_stack_size (item)
		end

	set_stack_size_ (a_s: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_stack_size_ (item, a_s)
		end

	is_main_thread: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_main_thread (item)
		end

	is_executing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_executing (item)
		end

	is_finished: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_finished (item)
		end

	is_cancelled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_cancelled (item)
		end

	cancel
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_cancel (item)
		end

	start
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start (item)
		end

	main
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_main (item)
		end

feature {NONE} -- NSThread Externals

	objc_thread_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSThread *)$an_item threadDictionary];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_n: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSThread *)$an_item setName:$a_n];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSThread *)$an_item name];
			 ]"
		end

	objc_stack_size (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSThread *)$an_item stackSize];
			 ]"
		end

	objc_set_stack_size_ (an_item: POINTER; a_s: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSThread *)$an_item setStackSize:$a_s];
			 ]"
		end

	objc_is_main_thread (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSThread *)$an_item isMainThread];
			 ]"
		end

	objc_init_with_target__selector__object_ (an_item: POINTER; a_target: POINTER; a_selector: POINTER; a_argument: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSThread *)$an_item initWithTarget:$a_target selector:$a_selector object:$a_argument];
			 ]"
		end

	objc_is_executing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSThread *)$an_item isExecuting];
			 ]"
		end

	objc_is_finished (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSThread *)$an_item isFinished];
			 ]"
		end

	objc_is_cancelled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSThread *)$an_item isCancelled];
			 ]"
		end

	objc_cancel (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSThread *)$an_item cancel];
			 ]"
		end

	objc_start (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSThread *)$an_item start];
			 ]"
		end

	objc_main (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSThread *)$an_item main];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_target__selector__object_ (a_target: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_argument: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_target__item: POINTER
			a_selector__item: POINTER
			a_argument__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_argument as a_argument_attached then
				a_argument__item := a_argument_attached.item
			end
			make_with_pointer (objc_init_with_target__selector__object_(allocate_object, a_target__item, a_selector__item, a_argument__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSThread"
		end

end
