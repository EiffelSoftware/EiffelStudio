note
	description: "Summary description for {MY_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_VIEW

inherit
	NS_VIEW
		redefine
			make
		end

	TESTS_COMMON
		undefine
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			add_objc_callback ("multiplyByTwo:", agent multiply_by_two)
			add_objc_callback ("callbackWithBoolean:character:integer8:natural8:integer16:natural16:integer32:natural32:integer64:natural64:real32:real64:", agent callback_1)
			add_objc_callback ("callback2", agent callback_2)
			add_objc_callback ("callbackWithSelector:class:", agent callback_3)
			add_objc_callback ("moveRect:to:", agent callback_4)
			add_objc_callback ("callbackBoolean:", agent callback_boolean)
			add_objc_callback ("callbackCharacter8:", agent callback_character_8)
			add_objc_callback ("callbackInteger8:", agent callback_integer_8)
			add_objc_callback ("callbackNatural8:", agent callback_natural_8)
			add_objc_callback ("callbackInteger16:", agent callback_integer_16)
			add_objc_callback ("callbackNatural16:", agent callback_natural_16)
			add_objc_callback ("callbackInteger32:", agent callback_integer_32)
			add_objc_callback ("callbackNatural32:", agent callback_natural_32)
			add_objc_callback ("callbackInteger64:", agent callback_integer_64)
			add_objc_callback ("callbackNatural64:", agent callback_natural_64)
			add_objc_callback ("callbackReturningSelector", agent callback_returning_selector)
			add_objc_callback ("callbackReturningClass", agent callback_returning_class)
			add_objc_callback ("callbackReturningObject", agent callback_returning_object)
			Precursor
		end

feature -- Callbacks

	multiply_by_two (a_number: detachable NS_NUMBER): detachable NS_NUMBER
			-- Multiply by two `a_number'.
		do
			check attached a_number as attached_number then
				create Result.make_with_int_ (2 * attached_number.int_value)
			end
		end

	callback_1 (a_boolean: BOOLEAN;
			   a_character: CHARACTER_8;
			   an_integer_8: INTEGER_8;
			   a_natural_8: NATURAL_8;
			   an_integer_16: INTEGER_16;
			   a_natural_16: NATURAL_16;
			   an_integer_32: INTEGER_32;
			   a_natural_32: NATURAL_32;
			   an_integer_64: INTEGER_64;
			   a_natural_64: NATURAL_64;
			   a_real_32: REAL_32;
			   a_real_64: REAL_64)
			-- Assert the value of the passed arguments.
		do
			assert (a_boolean)
			assert (a_character.is_equal ('m'))
			assert (an_integer_8 = -120)
			assert (a_natural_8 = 254)
			assert (an_integer_16 = -30000)
			assert (a_natural_16 = 65000)
			assert (an_integer_32 = 2047483648)
			assert (a_natural_32 = 4047483648)
			assert (an_integer_64 = -1223372036854775808)
			assert (a_natural_64 = 9223372036854775808)
			assert (a_real_32 = 3.14)
			assert (a_real_64 = 3.14159265358979)
		end

	callback_2
			-- Change the value of `data'.
		do
			data := 12345
		end

	callback_3 (a_selector: OBJC_SELECTOR; a_class: OBJC_CLASS)
			-- Check whether the passed arguments are correct
		do
			assert (a_selector.name.is_equal ("testSelector:"))
			assert (a_class.name.is_equal ("NSView"))
		end

	callback_4 (a_rect: NS_RECT; a_point: NS_POINT)
			-- Move `a_rect' to `a_point'.
		do
			assert (a_rect.origin.x = 10.5)
			assert (a_rect.origin.y = 7.75)
			assert (a_rect.size.width = 128)
			assert (a_rect.size.height = 256)
			a_rect.origin := a_point
			assert (a_rect.origin.x = a_point.x)
			assert (a_rect.origin.y = a_point.y)
		end

	callback_boolean (an_integer: INTEGER_8): BOOLEAN
			-- Return a BOOLEAN.
		do
			assert (an_integer = 119)
			Result := True
		end

	callback_character_8 (an_integer: INTEGER_8): CHARACTER_8
			-- Return a CHARACTER_8.
		do
			assert (an_integer = 119)
			Result := 'k'
		end

	callback_integer_8 (an_integer: INTEGER_8): INTEGER_8
			-- Return an INTEGER_8.
		do
			assert (an_integer = 119)
			Result := 125
		end

	callback_natural_8 (an_integer: INTEGER_8): NATURAL_8
			-- Return a NATURAL_8.
		do
			assert (an_integer = 119)
			Result := 255
		end

	callback_integer_16 (an_integer: INTEGER_8): INTEGER_16
			-- Return a INTEGER_16.
		do
			assert (an_integer = 119)
			Result := 30543
		end

	callback_natural_16 (an_integer: INTEGER_8): NATURAL_16
			-- Return a NATURAL_16.
		do
			assert (an_integer = 119)
			Result := 65053
		end

	callback_integer_32 (an_integer: INTEGER_8): INTEGER_32
			-- Return a INTEGER_32.
		do
			assert (an_integer = 119)
			Result := -2094967296
		end

	callback_natural_32 (an_integer: INTEGER_8): NATURAL_32
			-- Return a NATURAL_32.
		do
			assert (an_integer = 119)
			Result := 4094967296
		end

	callback_integer_64 (an_integer: INTEGER_8): INTEGER_64
			-- Return a INTEGER_64.
		do
			assert (an_integer = 119)
			Result := -3223372036854775808
		end

	callback_natural_64 (an_integer: INTEGER_8): NATURAL_64
			-- Return a NATURAL_64.
		do
			assert (an_integer = 119)
			Result := 9223372036854775808
		end

	callback_returning_selector: OBJC_SELECTOR
			-- Return an OBJC_SELECTOR
		do
			create Result.make_with_name ("testSelector:")
		end

	callback_returning_class: OBJC_CLASS
			-- Return an OBJC_CLASS
		do
			create Result.make_with_name ("NSView")
		end

	callback_returning_object: NS_NUMBER
			-- Return an Objective-C NS_NUMBER object
		do
			create Result.make_with_float_ (3)
		end

feature -- Access

	get_item: POINTER
			-- Return a pointer to the associated Objective-C object.
			-- This is usually not needed. We need this to simulate the callback.
		do
			Result := item
		end

	data: INTEGER

end
