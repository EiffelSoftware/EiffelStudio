note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_LOGICAL_TEST

inherit
	NS_SCRIPT_WHOSE_TEST
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_and_test_with_tests_,
	make_or_test_with_tests_,
	make_not_test_with_test_,
	make

feature {NONE} -- Initialization

	make_and_test_with_tests_ (a_sub_tests: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_sub_tests__item: POINTER
		do
			if attached a_sub_tests as a_sub_tests_attached then
				a_sub_tests__item := a_sub_tests_attached.item
			end
			make_with_pointer (objc_init_and_test_with_tests_(allocate_object, a_sub_tests__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_or_test_with_tests_ (a_sub_tests: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_sub_tests__item: POINTER
		do
			if attached a_sub_tests as a_sub_tests_attached then
				a_sub_tests__item := a_sub_tests_attached.item
			end
			make_with_pointer (objc_init_or_test_with_tests_(allocate_object, a_sub_tests__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_not_test_with_test_ (a_sub_test: detachable NS_SCRIPT_WHOSE_TEST)
			-- Initialize `Current'.
		local
			a_sub_test__item: POINTER
		do
			if attached a_sub_test as a_sub_test_attached then
				a_sub_test__item := a_sub_test_attached.item
			end
			make_with_pointer (objc_init_not_test_with_test_(allocate_object, a_sub_test__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSLogicalTest Externals

	objc_init_and_test_with_tests_ (an_item: POINTER; a_sub_tests: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLogicalTest *)$an_item initAndTestWithTests:$a_sub_tests];
			 ]"
		end

	objc_init_or_test_with_tests_ (an_item: POINTER; a_sub_tests: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLogicalTest *)$an_item initOrTestWithTests:$a_sub_tests];
			 ]"
		end

	objc_init_not_test_with_test_ (an_item: POINTER; a_sub_test: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLogicalTest *)$an_item initNotTestWithTest:$a_sub_test];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSLogicalTest"
		end

end
