note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMPOUND_PREDICATE_UTILS

inherit
	NS_PREDICATE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSCompoundPredicate

	and_predicate_with_subpredicates_ (a_subpredicates: detachable NS_ARRAY): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_subpredicates__item: POINTER
		do
			if attached a_subpredicates as a_subpredicates_attached then
				a_subpredicates__item := a_subpredicates_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_and_predicate_with_subpredicates_ (l_objc_class.item, a_subpredicates__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like and_predicate_with_subpredicates_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like and_predicate_with_subpredicates_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	or_predicate_with_subpredicates_ (a_subpredicates: detachable NS_ARRAY): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_subpredicates__item: POINTER
		do
			if attached a_subpredicates as a_subpredicates_attached then
				a_subpredicates__item := a_subpredicates_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_or_predicate_with_subpredicates_ (l_objc_class.item, a_subpredicates__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like or_predicate_with_subpredicates_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like or_predicate_with_subpredicates_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	not_predicate_with_subpredicate_ (a_predicate: detachable NS_PREDICATE): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_not_predicate_with_subpredicate_ (l_objc_class.item, a_predicate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like not_predicate_with_subpredicate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like not_predicate_with_subpredicate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSCompoundPredicate Externals

	objc_and_predicate_with_subpredicates_ (a_class_object: POINTER; a_subpredicates: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object andPredicateWithSubpredicates:$a_subpredicates];
			 ]"
		end

	objc_or_predicate_with_subpredicates_ (a_class_object: POINTER; a_subpredicates: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object orPredicateWithSubpredicates:$a_subpredicates];
			 ]"
		end

	objc_not_predicate_with_subpredicate_ (a_class_object: POINTER; a_predicate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object notPredicateWithSubpredicate:$a_predicate];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCompoundPredicate"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
