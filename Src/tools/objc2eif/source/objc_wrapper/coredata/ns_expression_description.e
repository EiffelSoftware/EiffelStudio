note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EXPRESSION_DESCRIPTION

inherit
	NS_PROPERTY_DESCRIPTION
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSExpressionDescription

	expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_expression_ (a_expression: detachable NS_EXPRESSION)
			-- Auto generated Objective-C wrapper.
		local
			a_expression__item: POINTER
		do
			if attached a_expression as a_expression_attached then
				a_expression__item := a_expression_attached.item
			end
			objc_set_expression_ (item, a_expression__item)
		end

	expression_result_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_expression_result_type (item)
		end

	set_expression_result_type_ (a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_expression_result_type_ (item, a_type)
		end

feature {NONE} -- NSExpressionDescription Externals

	objc_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(NSExpressionDescription *)$an_item expression];
			 ]"
		end

	objc_set_expression_ (an_item: POINTER; a_expression: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSExpressionDescription *)$an_item setExpression:$a_expression];
			 ]"
		end

	objc_expression_result_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return [(NSExpressionDescription *)$an_item expressionResultType];
			 ]"
		end

	objc_set_expression_result_type_ (an_item: POINTER; a_type: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				[(NSExpressionDescription *)$an_item setExpressionResultType:$a_type];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSExpressionDescription"
		end

end
