note
	description: "Summary description for {CALLBACKS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALLBACKS

inherit
	TESTS_COMMON
		redefine
			run
		end

feature -- Running

	run
			-- Run the tests
		do
			Precursor
			test1
			collect_garbage
			test_callback_arguments
			collect_garbage
			test_callback_without_arguments
			collect_garbage
			test_callback_with_selector_and_class
			collect_garbage
			test_callback_with_structs
			collect_garbage
			test_callbacks_with_expanded_return_types
			collect_garbage
			test_callbacks_returning_selector_and_class_and_objects
			collect_garbage
		end

feature {NONE} -- Tests

	test1
			-- Call a callback that multiplies a number by two and returns the result.
			-- The number is passed and returned in a wrapping object, NS_NUMBER.
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
			selector: OBJC_SELECTOR
			number: NS_NUMBER
		do
			create pool.make
			create my_view.make
			create selector.make_with_name ("multiplyByTwo:")
			create number.make_with_int_ (100)
			check attached {NS_NUMBER} my_view.perform_selector__with_object_ (selector, number) as multiplied_number then
				assert (multiplied_number.int_value = 200)
				-- Assert only two instances of NS_NUMBER for this test are created in total.
				-- This has been checked looking at the outputs of the console when
				-- debug_on in NS_COMMONG is true.
			end
		end

	test_callback_arguments
			-- Test the passing of arguments to callbacks
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			simulate_callback1 (my_view.get_item)
		end

	test_callback_without_arguments
			-- Test a callback without arguments
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			simulate_callback2 (my_view.get_item)
			assert (my_view.data = 12345)
		end

	test_callback_with_selector_and_class
			-- Test a callback with a selector and a class object as arguments.
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			simulate_callback3 (my_view.get_item)
		end

	test_callback_with_structs
			-- Test a callback with some structs.
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			simulate_callback4 (my_view.get_item)
		end

	test_callbacks_with_expanded_return_types
			-- Test callbacks with several expanded return types
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			assert (simulate_callbacks_with_expanded_return_types (my_view.get_item))
		end

	test_callbacks_returning_selector_and_class_and_objects
			-- Test callbacks with selectors, classes and objects as return types
		local
			pool: NS_AUTORELEASE_POOL
			my_view: MY_VIEW
		do
			create pool.make
			create my_view.make
			assert (simulate_callbacks_returning_selector_and_class_and_objects (my_view.get_item))
		end

feature {NONE} -- Externals

	simulate_callback1 (an_item: POINTER)
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
			-- The callback passes different kinds of arguments.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				[(id)$an_item callbackWithBoolean:YES
							 character:'m'
							 integer8:-120
							 natural8:254
							 integer16:-30000
							 natural16:65000
							 integer32:2047483648
							 natural32:4047483648
							 integer64:-1223372036854775808
							 natural64:9223372036854775808ull
							 real32:3.14
							 real64:3.14159265358979
							 ];
			]"
		end

	simulate_callback2 (an_item: POINTER)
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				[(id)$an_item callback2];
			]"
		end

	simulate_callback3 (an_item: POINTER)
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				[(id)$an_item callbackWithSelector:@selector(testSelector:) class:[NSView class]];
			]"
		end

	simulate_callback4 (an_item: POINTER)
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				[(id)$an_item moveRect:CGRectMake(10.5, 7.75, 128, 256) to:CGPointMake(4298.5889227, 9.8)];
			]"
		end

	simulate_callbacks_with_expanded_return_types (an_item: POINTER): BOOLEAN
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				BOOL tests_passed = YES;
				tests_passed &= [(id)$an_item callbackBoolean:119] == YES;
				tests_passed &= [(id)$an_item callbackCharacter8:119] == 'k';
				tests_passed &= [(id)$an_item callbackInteger8:119] == 125;
				tests_passed &= [(id)$an_item callbackNatural8:119] == 255;
				tests_passed &= [(id)$an_item callbackInteger16:119] == 30543;
				tests_passed &= [(id)$an_item callbackNatural16:119] == 65053;
				tests_passed &= [(id)$an_item callbackInteger32:119] == -2094967296;
				tests_passed &= [(id)$an_item callbackNatural32:119] == 4094967296;
				tests_passed &= [(id)$an_item callbackInteger64:119] == -3223372036854775808;
				tests_passed &= [(id)$an_item callbackNatural64:119] == 9223372036854775808ull;
				return tests_passed;
			]"
		end

	simulate_callbacks_returning_selector_and_class_and_objects (an_item: POINTER): BOOLEAN
			-- Simulate a callback to the Objective-C object pointer by `an_item'.
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				BOOL tests_passed = YES;
				tests_passed &= [(id)$an_item callbackReturningSelector] == @selector(testSelector:);
				tests_passed &= [(id)$an_item callbackReturningClass] == [NSView class];
				tests_passed &= [(NSNumber *)[(id)$an_item callbackReturningObject] floatValue] == 3;
				return tests_passed;
			]"
		end

end
