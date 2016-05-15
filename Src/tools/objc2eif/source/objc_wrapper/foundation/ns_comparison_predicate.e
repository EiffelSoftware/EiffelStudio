note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMPARISON_PREDICATE

inherit
	NS_PREDICATE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_left_expression__right_expression__modifier__type__options_,
	make_with_left_expression__right_expression__custom_selector_,
	make

feature {NONE} -- Initialization

	make_with_left_expression__right_expression__modifier__type__options_ (a_lhs: detachable NS_EXPRESSION; a_rhs: detachable NS_EXPRESSION; a_modifier: NATURAL_64; a_type: NATURAL_64; a_options: NATURAL_64)
			-- Initialize `Current'.
		local
			a_lhs__item: POINTER
			a_rhs__item: POINTER
		do
			if attached a_lhs as a_lhs_attached then
				a_lhs__item := a_lhs_attached.item
			end
			if attached a_rhs as a_rhs_attached then
				a_rhs__item := a_rhs_attached.item
			end
			make_with_pointer (objc_init_with_left_expression__right_expression__modifier__type__options_(allocate_object, a_lhs__item, a_rhs__item, a_modifier, a_type, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_left_expression__right_expression__custom_selector_ (a_lhs: detachable NS_EXPRESSION; a_rhs: detachable NS_EXPRESSION; a_selector: detachable OBJC_SELECTOR)
			-- Initialize `Current'.
		local
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
			make_with_pointer (objc_init_with_left_expression__right_expression__custom_selector_(allocate_object, a_lhs__item, a_rhs__item, a_selector__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSComparisonPredicate Externals

	objc_init_with_left_expression__right_expression__modifier__type__options_ (an_item: POINTER; a_lhs: POINTER; a_rhs: POINTER; a_modifier: NATURAL_64; a_type: NATURAL_64; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComparisonPredicate *)$an_item initWithLeftExpression:$a_lhs rightExpression:$a_rhs modifier:$a_modifier type:$a_type options:$a_options];
			 ]"
		end

	objc_init_with_left_expression__right_expression__custom_selector_ (an_item: POINTER; a_lhs: POINTER; a_rhs: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComparisonPredicate *)$an_item initWithLeftExpression:$a_lhs rightExpression:$a_rhs customSelector:$a_selector];
			 ]"
		end

	objc_predicate_operator_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSComparisonPredicate *)$an_item predicateOperatorType];
			 ]"
		end

	objc_comparison_predicate_modifier (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSComparisonPredicate *)$an_item comparisonPredicateModifier];
			 ]"
		end

	objc_left_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComparisonPredicate *)$an_item leftExpression];
			 ]"
		end

	objc_right_expression (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComparisonPredicate *)$an_item rightExpression];
			 ]"
		end

	objc_custom_selector (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComparisonPredicate *)$an_item customSelector];
			 ]"
		end

	objc_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSComparisonPredicate *)$an_item options];
			 ]"
		end

feature -- NSComparisonPredicate

	predicate_operator_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_predicate_operator_type (item)
		end

	comparison_predicate_modifier: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_comparison_predicate_modifier (item)
		end

	left_expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_left_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like left_expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like left_expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	right_expression: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_right_expression (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like right_expression} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like right_expression} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	custom_selector: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_custom_selector (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_options (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSComparisonPredicate"
		end

end
