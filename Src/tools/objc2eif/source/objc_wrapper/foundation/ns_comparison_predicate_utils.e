note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMPARISON_PREDICATE_UTILS

inherit
	NS_PREDICATE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSComparisonPredicate

	predicate_with_left_expression__right_expression__modifier__type__options_ (a_lhs: detachable NS_EXPRESSION; a_rhs: detachable NS_EXPRESSION; a_modifier: NATURAL_64; a_type: NATURAL_64; a_options: NATURAL_64): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_lhs__item: POINTER
			a_rhs__item: POINTER
		do
			if attached a_lhs as a_lhs_attached then
				a_lhs__item := a_lhs_attached.item
			end
			if attached a_rhs as a_rhs_attached then
				a_rhs__item := a_rhs_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_predicate_with_left_expression__right_expression__modifier__type__options_ (l_objc_class.item, a_lhs__item, a_rhs__item, a_modifier, a_type, a_options)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_left_expression__right_expression__modifier__type__options_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_left_expression__right_expression__modifier__type__options_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	predicate_with_left_expression__right_expression__custom_selector_ (a_lhs: detachable NS_EXPRESSION; a_rhs: detachable NS_EXPRESSION; a_selector: detachable OBJC_SELECTOR): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_lhs__item: POINTER
			a_rhs__item: POINTER
			a_selector__item: POINTER
		do
			if attached a_lhs as a_lhs_attached then
				a_lhs__item := a_lhs_attached.item
			end
			if attached a_rhs as a_rhs_attached then
				a_rhs__item := a_rhs_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_predicate_with_left_expression__right_expression__custom_selector_ (l_objc_class.item, a_lhs__item, a_rhs__item, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_left_expression__right_expression__custom_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_left_expression__right_expression__custom_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSComparisonPredicate Externals

	objc_predicate_with_left_expression__right_expression__modifier__type__options_ (a_class_object: POINTER; a_lhs: POINTER; a_rhs: POINTER; a_modifier: NATURAL_64; a_type: NATURAL_64; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object predicateWithLeftExpression:$a_lhs rightExpression:$a_rhs modifier:$a_modifier type:$a_type options:$a_options];
			 ]"
		end

	objc_predicate_with_left_expression__right_expression__custom_selector_ (a_class_object: POINTER; a_lhs: POINTER; a_rhs: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object predicateWithLeftExpression:$a_lhs rightExpression:$a_rhs customSelector:$a_selector];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSComparisonPredicate"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
