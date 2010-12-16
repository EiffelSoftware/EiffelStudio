note
	description: "A class representing an Objective-C selector."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_SELECTOR

inherit
	ANY
		redefine
			is_equal
		end

create
	make_with_name

create {NS_ANY}
	make_with_pointer

feature {NS_ANY} -- Initialization

	make_with_pointer (a_pointer: POINTER)
			-- Initialize `Current' with `a_pointer'.
		do
			item := a_pointer
		ensure
			item_set: item = a_pointer
		end

	make_with_name (a_name: STRING)
			-- Initialize `Current' with `a_name'.
		require
			a_valid_name: not a_name.is_empty
		local
			c_string: C_STRING
		do
			create c_string.make (a_name)
			item := objc_sel_register_name (c_string.item)
		ensure
			item_set: item /= default_pointer
		end

feature -- Access

	name: STRING
			-- Return the name of the method specified by a given selector.
		do
			create Result.make_from_c (objc_sel_get_name (item))
		end

feature -- Comparision

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := objc_sel_is_equal (item, other.item)
		end

feature {OBJC_SELECTOR, NS_ANY} -- Objective-C Pointer

	item: POINTER
			-- Pointer to Objective-C Object.

feature {NONE} -- Externals

	objc_sel_register_name (a_name: POINTER): POINTER
			-- Register a method with the Objective-C runtime system, maps the method name
			-- to a selector, and returns the selector value.
		external
			"C inline"
		alias
			"[
				return sel_registerName($a_name);
			 ]"
		end

	objc_sel_get_name (a_selector: POINTER): POINTER
			-- Return the name of the method specified by a given selector.
		external
			"C inline"
		alias
			"[
				return (EIF_POINTER)sel_getName($a_selector);
			 ]"
		end

	objc_sel_is_equal (lhs: POINTER; rhs: POINTER): BOOLEAN
			-- Objc External.
		external
			"C inline"
		alias
			"[
				return sel_isEqual($lhs, $rhs);
			 ]"
		end

end
