note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_METHOD_SIGNATURE

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

feature -- NSMethodSignature

	number_of_arguments: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_arguments (item)
		end

--	get_argument_type_at_index_ (a_idx: NATURAL_64): detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_get_argument_type_at_index_ (item, a_idx)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like get_argument_type_at_index_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like get_argument_type_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	frame_length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_frame_length (item)
		end

	is_oneway: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_oneway (item)
		end

--	method_return_type: detachable UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_method_return_type (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like method_return_type} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like method_return_type} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	method_return_length: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_method_return_length (item)
		end

feature {NONE} -- NSMethodSignature Externals

	objc_number_of_arguments (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMethodSignature *)$an_item numberOfArguments];
			 ]"
		end

--	objc_get_argument_type_at_index_ (an_item: POINTER; a_idx: NATURAL_64): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMethodSignature *)$an_item getArgumentTypeAtIndex:$a_idx];
--			 ]"
--		end

	objc_frame_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMethodSignature *)$an_item frameLength];
			 ]"
		end

	objc_is_oneway (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMethodSignature *)$an_item isOneway];
			 ]"
		end

--	objc_method_return_type (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSMethodSignature *)$an_item methodReturnType];
--			 ]"
--		end

	objc_method_return_length (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSMethodSignature *)$an_item methodReturnLength];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSMethodSignature"
		end

end
