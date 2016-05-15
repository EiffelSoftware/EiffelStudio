note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WHOSE_SPECIFIER

inherit
	NS_SCRIPT_OBJECT_SPECIFIER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_container_class_description__container_specifier__key__test_,
	make_with_container_specifier__key_,
	make_with_container_class_description__container_specifier__key_,
	make

feature {NONE} -- Initialization

	make_with_container_class_description__container_specifier__key__test_ (a_class_desc: detachable NS_SCRIPT_CLASS_DESCRIPTION; a_container: detachable NS_SCRIPT_OBJECT_SPECIFIER; a_property: detachable NS_STRING; a_test: detachable NS_SCRIPT_WHOSE_TEST)
			-- Initialize `Current'.
		local
			a_class_desc__item: POINTER
			a_container__item: POINTER
			a_property__item: POINTER
			a_test__item: POINTER
		do
			if attached a_class_desc as a_class_desc_attached then
				a_class_desc__item := a_class_desc_attached.item
			end
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			if attached a_property as a_property_attached then
				a_property__item := a_property_attached.item
			end
			if attached a_test as a_test_attached then
				a_test__item := a_test_attached.item
			end
			make_with_pointer (objc_init_with_container_class_description__container_specifier__key__test_(allocate_object, a_class_desc__item, a_container__item, a_property__item, a_test__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSWhoseSpecifier Externals

	objc_init_with_container_class_description__container_specifier__key__test_ (an_item: POINTER; a_class_desc: POINTER; a_container: POINTER; a_property: POINTER; a_test: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWhoseSpecifier *)$an_item initWithContainerClassDescription:$a_class_desc containerSpecifier:$a_container key:$a_property test:$a_test];
			 ]"
		end

	objc_test (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWhoseSpecifier *)$an_item test];
			 ]"
		end

	objc_set_test_ (an_item: POINTER; a_test: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSWhoseSpecifier *)$an_item setTest:$a_test];
			 ]"
		end

	objc_start_subelement_identifier (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSWhoseSpecifier *)$an_item startSubelementIdentifier];
			 ]"
		end

	objc_set_start_subelement_identifier_ (an_item: POINTER; a_subelement: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSWhoseSpecifier *)$an_item setStartSubelementIdentifier:$a_subelement];
			 ]"
		end

	objc_start_subelement_index (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSWhoseSpecifier *)$an_item startSubelementIndex];
			 ]"
		end

	objc_set_start_subelement_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSWhoseSpecifier *)$an_item setStartSubelementIndex:$a_index];
			 ]"
		end

	objc_end_subelement_identifier (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSWhoseSpecifier *)$an_item endSubelementIdentifier];
			 ]"
		end

	objc_set_end_subelement_identifier_ (an_item: POINTER; a_subelement: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSWhoseSpecifier *)$an_item setEndSubelementIdentifier:$a_subelement];
			 ]"
		end

	objc_end_subelement_index (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSWhoseSpecifier *)$an_item endSubelementIndex];
			 ]"
		end

	objc_set_end_subelement_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSWhoseSpecifier *)$an_item setEndSubelementIndex:$a_index];
			 ]"
		end

feature -- NSWhoseSpecifier

	test: detachable NS_SCRIPT_WHOSE_TEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_test (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like test} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like test} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_test_ (a_test: detachable NS_SCRIPT_WHOSE_TEST)
			-- Auto generated Objective-C wrapper.
		local
			a_test__item: POINTER
		do
			if attached a_test as a_test_attached then
				a_test__item := a_test_attached.item
			end
			objc_set_test_ (item, a_test__item)
		end

	start_subelement_identifier: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_start_subelement_identifier (item)
		end

	set_start_subelement_identifier_ (a_subelement: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_start_subelement_identifier_ (item, a_subelement)
		end

	start_subelement_index: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_start_subelement_index (item)
		end

	set_start_subelement_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_start_subelement_index_ (item, a_index)
		end

	end_subelement_identifier: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_end_subelement_identifier (item)
		end

	set_end_subelement_identifier_ (a_subelement: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_end_subelement_identifier_ (item, a_subelement)
		end

	end_subelement_index: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_end_subelement_index (item)
		end

	set_end_subelement_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_end_subelement_index_ (item, a_index)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSWhoseSpecifier"
		end

end
