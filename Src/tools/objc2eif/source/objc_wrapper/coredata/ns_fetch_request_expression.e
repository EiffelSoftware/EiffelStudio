note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FETCH_REQUEST_EXPRESSION

inherit
	NS_EXPRESSION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_expression_type_,
	make

feature -- NSFetchRequestExpression

	request_expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_request_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like request_expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like request_expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	context_expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_context_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like context_expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like context_expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_count_only_request: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_count_only_request (item)
		end

feature {NONE} -- NSFetchRequestExpression Externals

	objc_request_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFetchRequestExpression *)$an_item requestExpression];
			 ]"
		end

	objc_context_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFetchRequestExpression *)$an_item contextExpression];
			 ]"
		end

	objc_is_count_only_request (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSFetchRequestExpression *)$an_item isCountOnlyRequest];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFetchRequestExpression"
		end

end
