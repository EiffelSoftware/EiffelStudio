note
	description: "Summary description for {NS_VALUE}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_VALUE

inherit
	NS_OBJECT
		undefine
			copy
		end

	NS_COPYING

create
	value_with_bytes_obj_ctype,
	value_with_obj_ctype,
	value_with_nonretained_object,
	value_with_pointer
create
	make_from_pointer,
	share_from_pointer

feature -- Creating an NSValue

	init_with_bytes_obj_ctype (a_value: POINTER; a_type: TYPED_POINTER[CHARACTER]): NS_OBJECT
			-- Initializes and returns an `NSValue' object that contains a given value, which is interpreted as being of a given Objective-C type.
		do
			create Result.share_from_pointer ({NS_VALUE_API}.init_with_bytes_obj_ctype (item, a_value, a_type))
		end

	value_with_bytes_obj_ctype (a_value: POINTER; a_type: TYPED_POINTER[CHARACTER])
			-- Creates and returns an `NSValue' object that contains a given value, which is interpreted as being of a given Objective-C type.
		do
			make_from_pointer ({NS_VALUE_API}.value_with_bytes_obj_ctype (a_value.item, a_type))
		end

	value_with_obj_ctype (a_value: POINTER ; a_type: TYPED_POINTER[CHARACTER])
			-- Creates and returns an `NSValue' object that contains a given value which is interpreted as being of a given Objective-C type.
		do
			make_from_pointer ({NS_VALUE_API}.value_with_obj_ctype (a_value.item, a_type))
		end

	value_with_nonretained_object (a_an_object: NS_OBJECT)
			-- Creates and returns an `NSValue' object that contains a given object.
		do
			make_from_pointer ({NS_VALUE_API}.value_with_nonretained_object (a_an_object.item))
		end

	value_with_pointer (a_pointer: POINTER)
			-- Creates and returns an `NSValue' object that contains a given pointer.
		do
			make_from_pointer ({NS_VALUE_API}.value_with_pointer (a_pointer))
		end

-- Error generating valueWithPoint:: Message signature for feature not set
-- Error generating valueWithRange:: Message signature for feature not set
-- Error generating valueWithRect:: Message signature for feature not set
-- Error generating valueWithSize:: Message signature for feature not set

feature -- Accessing Data

	get_value (a_value: POINTER)
			-- Copies the receiver`s value into a given buffer.
		do
			{NS_VALUE_API}.get_value (item, a_value)
		end

	nonretained_object_value: NS_OBJECT
			-- Returns the receiver`s value as an id.
		do
			create Result.share_from_pointer ({NS_VALUE_API}.nonretained_object_value (item))
		end

	obj_ctype: C_STRING
			-- Returns a C string containing the Objective-C type of the data contained in the receiver.
		do
			create Result.make_shared_from_pointer ({NS_VALUE_API}.obj_ctype (item))
		end
-- Error generating pointValue: Message signature for feature not set

	pointer_value: POINTER
			-- Returns the receiver`s value as a pointer to void.
		do
			Result := {NS_VALUE_API}.pointer_value (item)
		end
-- Error generating rangeValue: Message signature for feature not set
-- Error generating rectValue: Message signature for feature not set

--	size_value: NS_SIZE
--			-- Returns the receiver`s value as a pointer to void.
--		do
--			create Result.make
--			{NS_VALUE_API}.size_value (item, Result.item)
--		end

feature -- Comparing Objects

	is_equal_to_value (a_value: NS_VALUE): BOOLEAN
			-- Returns a Boolean value that indicates whether the receiver and another value are equal.
		do
			Result := {NS_VALUE_API}.is_equal_to_value (item, a_value.item)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
