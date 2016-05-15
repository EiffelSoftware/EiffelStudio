note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SPECIFIER_TEST

inherit
	NS_SCRIPT_WHOSE_TEST
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_object_specifier__comparison_operator__test_object_,
	make

feature {NONE} -- Initialization

	make_with_object_specifier__comparison_operator__test_object_ (a_obj1: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_comp_op: NATURAL_64; a_obj2: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_obj1__item: POINTER
			a_obj2__item: POINTER
		do
			if attached a_obj1 as a_obj1_attached then
				a_obj1__item := a_obj1_attached.item
			end
			if attached a_obj2 as a_obj2_attached then
				a_obj2__item := a_obj2_attached.item
			end
			make_with_pointer (objc_init_with_object_specifier__comparison_operator__test_object_(allocate_object, a_obj1__item, a_comp_op, a_obj2__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSSpecifierTest Externals

	objc_init_with_object_specifier__comparison_operator__test_object_ (an_item: POINTER; a_obj1: POINTER; a_comp_op: NATURAL_64; a_obj2: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSpecifierTest *)$an_item initWithObjectSpecifier:$a_obj1 comparisonOperator:$a_comp_op testObject:$a_obj2];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSpecifierTest"
		end

end
