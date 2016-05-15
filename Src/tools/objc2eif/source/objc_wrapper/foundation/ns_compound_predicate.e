note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMPOUND_PREDICATE

inherit
	NS_PREDICATE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_type__subpredicates_,
	make

feature {NONE} -- Initialization

	make_with_type__subpredicates_ (a_type: NATURAL_64; a_subpredicates: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_subpredicates__item: POINTER
		do
			if attached a_subpredicates as a_subpredicates_attached then
				a_subpredicates__item := a_subpredicates_attached.item
			end
			make_with_pointer (objc_init_with_type__subpredicates_(allocate_object, a_type, a_subpredicates__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSCompoundPredicate Externals

	objc_init_with_type__subpredicates_ (an_item: POINTER; a_type: NATURAL_64; a_subpredicates: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCompoundPredicate *)$an_item initWithType:$a_type subpredicates:$a_subpredicates];
			 ]"
		end

	objc_compound_predicate_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSCompoundPredicate *)$an_item compoundPredicateType];
			 ]"
		end

	objc_subpredicates (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCompoundPredicate *)$an_item subpredicates];
			 ]"
		end

feature -- NSCompoundPredicate

	compound_predicate_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_compound_predicate_type (item)
		end

	subpredicates: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subpredicates (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subpredicates} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subpredicates} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCompoundPredicate"
		end

end
