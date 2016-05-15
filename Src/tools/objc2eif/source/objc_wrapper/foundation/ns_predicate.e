note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PREDICATE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSPredicate

	predicate_format: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_predicate_format (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_format} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	predicate_with_substitution_variables_ (a_variables: detachable NS_DICTIONARY): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_variables__item: POINTER
		do
			if attached a_variables as a_variables_attached then
				a_variables__item := a_variables_attached.item
			end
			result_pointer := objc_predicate_with_substitution_variables_ (item, a_variables__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_substitution_variables_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_substitution_variables_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	evaluate_with_object_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_evaluate_with_object_ (item, a_object__item)
		end

	evaluate_with_object__substitution_variables_ (a_object: detachable NS_OBJECT; a_bindings: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
			a_bindings__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_bindings as a_bindings_attached then
				a_bindings__item := a_bindings_attached.item
			end
			Result := objc_evaluate_with_object__substitution_variables_ (item, a_object__item, a_bindings__item)
		end

feature {NONE} -- NSPredicate Externals

	objc_predicate_format (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicate *)$an_item predicateFormat];
			 ]"
		end

	objc_predicate_with_substitution_variables_ (an_item: POINTER; a_variables: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicate *)$an_item predicateWithSubstitutionVariables:$a_variables];
			 ]"
		end

	objc_evaluate_with_object_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPredicate *)$an_item evaluateWithObject:$a_object];
			 ]"
		end

	objc_evaluate_with_object__substitution_variables_ (an_item: POINTER; a_object: POINTER; a_bindings: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSPredicate *)$an_item evaluateWithObject:$a_object substitutionVariables:$a_bindings];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPredicate"
		end

end
