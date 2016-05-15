note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_INVOCATION

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

feature -- NSInvocation

	method_signature: detachable NS_METHOD_SIGNATURE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_method_signature (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like method_signature} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like method_signature} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	retain_arguments
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_retain_arguments (item)
		end

	arguments_retained: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_arguments_retained (item)
		end

	target: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_target (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_set_target_ (item, a_target__item)
		end

	selector: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selector (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_selector_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_selector_ (item, a_selector__item)
		end

--	get_return_value_ (a_ret_loc: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ret_loc__item: POINTER
--		do
--			if attached a_ret_loc as a_ret_loc_attached then
--				a_ret_loc__item := a_ret_loc_attached.item
--			end
--			objc_get_return_value_ (item, a_ret_loc__item)
--		end

--	set_return_value_ (a_ret_loc: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_ret_loc__item: POINTER
--		do
--			if attached a_ret_loc as a_ret_loc_attached then
--				a_ret_loc__item := a_ret_loc_attached.item
--			end
--			objc_set_return_value_ (item, a_ret_loc__item)
--		end

--	get_argument__at_index_ (a_argument_location: UNSUPPORTED_TYPE; a_idx: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_argument_location__item: POINTER
--		do
--			if attached a_argument_location as a_argument_location_attached then
--				a_argument_location__item := a_argument_location_attached.item
--			end
--			objc_get_argument__at_index_ (item, a_argument_location__item, a_idx)
--		end

--	set_argument__at_index_ (a_argument_location: UNSUPPORTED_TYPE; a_idx: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_argument_location__item: POINTER
--		do
--			if attached a_argument_location as a_argument_location_attached then
--				a_argument_location__item := a_argument_location_attached.item
--			end
--			objc_set_argument__at_index_ (item, a_argument_location__item, a_idx)
--		end

	invoke
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invoke (item)
		end

	invoke_with_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_invoke_with_target_ (item, a_target__item)
		end

feature {NONE} -- NSInvocation Externals

	objc_method_signature (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocation *)$an_item methodSignature];
			 ]"
		end

	objc_retain_arguments (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSInvocation *)$an_item retainArguments];
			 ]"
		end

	objc_arguments_retained (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSInvocation *)$an_item argumentsRetained];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocation *)$an_item target];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSInvocation *)$an_item setTarget:$a_target];
			 ]"
		end

	objc_selector (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSInvocation *)$an_item selector];
			 ]"
		end

	objc_set_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSInvocation *)$an_item setSelector:$a_selector];
			 ]"
		end

--	objc_get_return_value_ (an_item: POINTER; a_ret_loc: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSInvocation *)$an_item getReturnValue:];
--			 ]"
--		end

--	objc_set_return_value_ (an_item: POINTER; a_ret_loc: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSInvocation *)$an_item setReturnValue:];
--			 ]"
--		end

--	objc_get_argument__at_index_ (an_item: POINTER; a_argument_location: UNSUPPORTED_TYPE; a_idx: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSInvocation *)$an_item getArgument: atIndex:$a_idx];
--			 ]"
--		end

--	objc_set_argument__at_index_ (an_item: POINTER; a_argument_location: UNSUPPORTED_TYPE; a_idx: INTEGER_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSInvocation *)$an_item setArgument: atIndex:$a_idx];
--			 ]"
--		end

	objc_invoke (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSInvocation *)$an_item invoke];
			 ]"
		end

	objc_invoke_with_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSInvocation *)$an_item invokeWithTarget:$a_target];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSInvocation"
		end

end
