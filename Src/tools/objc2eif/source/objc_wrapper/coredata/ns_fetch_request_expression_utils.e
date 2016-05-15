note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FETCH_REQUEST_EXPRESSION_UTILS

inherit
	NS_EXPRESSION_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSFetchRequestExpression

	expression_for_fetch__context__count_only_ (a_fetch: detachable NS_EXPRESSION; a_context: detachable NS_EXPRESSION; a_count_flag: BOOLEAN): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_fetch__item: POINTER
			a_context__item: POINTER
		do
			if attached a_fetch as a_fetch_attached then
				a_fetch__item := a_fetch_attached.item
			end
			if attached a_context as a_context_attached then
				a_context__item := a_context_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_fetch__context__count_only_ (l_objc_class.item, a_fetch__item, a_context__item, a_count_flag)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_fetch__context__count_only_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_fetch__context__count_only_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFetchRequestExpression Externals

	objc_expression_for_fetch__context__count_only_ (a_class_object: POINTER; a_fetch: POINTER; a_context: POINTER; a_count_flag: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <CoreData/CoreData.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForFetch:$a_fetch context:$a_context countOnly:$a_count_flag];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFetchRequestExpression"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
