note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EXPRESSION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSExpression

	expression_for_constant_value_ (a_obj: detachable NS_OBJECT): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_constant_value_ (l_objc_class.item, a_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_constant_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_constant_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_evaluated_object: detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_evaluated_object (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_evaluated_object} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_evaluated_object} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_variable_ (a_string: detachable NS_STRING): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_variable_ (l_objc_class.item, a_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_variable_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_variable_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_key_path_ (a_key_path: detachable NS_STRING): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_key_path_ (l_objc_class.item, a_key_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_key_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_key_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_function__arguments_ (a_name: detachable NS_STRING; a_parameters: detachable NS_ARRAY): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_parameters__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_parameters as a_parameters_attached then
				a_parameters__item := a_parameters_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_function__arguments_ (l_objc_class.item, a_name__item, a_parameters__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_function__arguments_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_function__arguments_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_aggregate_ (a_subexpressions: detachable NS_ARRAY): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_subexpressions__item: POINTER
		do
			if attached a_subexpressions as a_subexpressions_attached then
				a_subexpressions__item := a_subexpressions_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_aggregate_ (l_objc_class.item, a_subexpressions__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_aggregate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_aggregate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_union_set__with_ (a_left: detachable NS_EXPRESSION; a_right: detachable NS_EXPRESSION): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_left__item: POINTER
			a_right__item: POINTER
		do
			if attached a_left as a_left_attached then
				a_left__item := a_left_attached.item
			end
			if attached a_right as a_right_attached then
				a_right__item := a_right_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_union_set__with_ (l_objc_class.item, a_left__item, a_right__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_union_set__with_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_union_set__with_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_intersect_set__with_ (a_left: detachable NS_EXPRESSION; a_right: detachable NS_EXPRESSION): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_left__item: POINTER
			a_right__item: POINTER
		do
			if attached a_left as a_left_attached then
				a_left__item := a_left_attached.item
			end
			if attached a_right as a_right_attached then
				a_right__item := a_right_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_intersect_set__with_ (l_objc_class.item, a_left__item, a_right__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_intersect_set__with_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_intersect_set__with_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_minus_set__with_ (a_left: detachable NS_EXPRESSION; a_right: detachable NS_EXPRESSION): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_left__item: POINTER
			a_right__item: POINTER
		do
			if attached a_left as a_left_attached then
				a_left__item := a_left_attached.item
			end
			if attached a_right as a_right_attached then
				a_right__item := a_right_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_minus_set__with_ (l_objc_class.item, a_left__item, a_right__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_minus_set__with_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_minus_set__with_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_subquery__using_iterator_variable__predicate_ (a_expression: detachable NS_EXPRESSION; a_variable: detachable NS_STRING; a_predicate: detachable NS_OBJECT): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_expression__item: POINTER
			a_variable__item: POINTER
			a_predicate__item: POINTER
		do
			if attached a_expression as a_expression_attached then
				a_expression__item := a_expression_attached.item
			end
			if attached a_variable as a_variable_attached then
				a_variable__item := a_variable_attached.item
			end
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_subquery__using_iterator_variable__predicate_ (l_objc_class.item, a_expression__item, a_variable__item, a_predicate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_subquery__using_iterator_variable__predicate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_subquery__using_iterator_variable__predicate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	expression_for_function__selector_name__arguments_ (a_target: detachable NS_EXPRESSION; a_name: detachable NS_STRING; a_parameters: detachable NS_ARRAY): detachable NS_EXPRESSION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_target__item: POINTER
			a_name__item: POINTER
			a_parameters__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_parameters as a_parameters_attached then
				a_parameters__item := a_parameters_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_expression_for_function__selector_name__arguments_ (l_objc_class.item, a_target__item, a_name__item, a_parameters__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like expression_for_function__selector_name__arguments_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like expression_for_function__selector_name__arguments_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	expression_for_block__arguments_ (a_block: UNSUPPORTED_TYPE; a_arguments: detachable NS_ARRAY): detachable NS_EXPRESSION
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			l_objc_class: OBJC_CLASS
--			a_arguments__item: POINTER
--		do
--			if attached a_arguments as a_arguments_attached then
--				a_arguments__item := a_arguments_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			result_pointer := objc_expression_for_block__arguments_ (l_objc_class.item, , a_arguments__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like expression_for_block__arguments_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like expression_for_block__arguments_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSExpression Externals

	objc_expression_for_constant_value_ (a_class_object: POINTER; a_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForConstantValue:$a_obj];
			 ]"
		end

	objc_expression_for_evaluated_object (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForEvaluatedObject];
			 ]"
		end

	objc_expression_for_variable_ (a_class_object: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForVariable:$a_string];
			 ]"
		end

	objc_expression_for_key_path_ (a_class_object: POINTER; a_key_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForKeyPath:$a_key_path];
			 ]"
		end

	objc_expression_for_function__arguments_ (a_class_object: POINTER; a_name: POINTER; a_parameters: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForFunction:$a_name arguments:$a_parameters];
			 ]"
		end

	objc_expression_for_aggregate_ (a_class_object: POINTER; a_subexpressions: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForAggregate:$a_subexpressions];
			 ]"
		end

	objc_expression_for_union_set__with_ (a_class_object: POINTER; a_left: POINTER; a_right: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForUnionSet:$a_left with:$a_right];
			 ]"
		end

	objc_expression_for_intersect_set__with_ (a_class_object: POINTER; a_left: POINTER; a_right: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForIntersectSet:$a_left with:$a_right];
			 ]"
		end

	objc_expression_for_minus_set__with_ (a_class_object: POINTER; a_left: POINTER; a_right: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForMinusSet:$a_left with:$a_right];
			 ]"
		end

	objc_expression_for_subquery__using_iterator_variable__predicate_ (a_class_object: POINTER; a_expression: POINTER; a_variable: POINTER; a_predicate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForSubquery:$a_expression usingIteratorVariable:$a_variable predicate:$a_predicate];
			 ]"
		end

	objc_expression_for_function__selector_name__arguments_ (a_class_object: POINTER; a_target: POINTER; a_name: POINTER; a_parameters: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object expressionForFunction:$a_target selectorName:$a_name arguments:$a_parameters];
			 ]"
		end

--	objc_expression_for_block__arguments_ (a_class_object: POINTER; a_block: UNSUPPORTED_TYPE; a_arguments: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(Class)$a_class_object expressionForBlock: arguments:$a_arguments];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSExpression"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
