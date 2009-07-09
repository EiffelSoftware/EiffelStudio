note
	description: "Representation of an objective C method at runtime."
	status: "Not completed"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_METHOD

create
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current from an objective C Method `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
		end

feature -- Access

	name: STRING
			-- Name of routine
		require
			exists: exists
		local
			l_ptr: POINTER
		do
			l_ptr := {NS_OBJC_RUNTIME}.method_name (item)
			if l_ptr /= default_pointer then
				Result := (create {C_STRING}.make_shared_from_pointer (l_ptr)).string
			else
				Result := ""
			end
		end

	argument_count: NATURAL_32
			-- Number of arguments of Current
		require
			exists: exists
		do
			Result := {NS_OBJC_RUNTIME}.method_argument_count (item)
		end

	return_type: STRING
			-- Return type of Current method as an objective C encoding.
			-- Use `OBJC_TYPE_ENCODING' to decode type
		require
			exists: exists
		local
			l_cstr: C_STRING
		do
			create l_cstr.make_empty (1024)
			{NS_OBJC_RUNTIME}.method_return_type (item, l_cstr.item, l_cstr.capacity.as_natural_32)
			Result := l_cstr.string
		end

	argument_type (i: NATURAL_32): STRING
			-- Type of `i'-th argument of Current method as an objective C encoding.
			-- Use `OBJC_TYPE_ENCODING' to decode type
		require
			exists: exists
			valid_index: i >= 1 and i <= argument_count
		local
			l_cstr: C_STRING
		do
			create l_cstr.make_empty (1024)
			{NS_OBJC_RUNTIME}.method_argument_type (item, i - 1, l_cstr.item, l_cstr.capacity.as_natural_32)
			Result := l_cstr.string
		end

feature -- Status Report

	exists: BOOLEAN
			-- Can current be used?
		do
			Result := item /= default_pointer
		end

feature {NONE} -- Implementation: Access

	item: POINTER;
			-- Underlying Method pointer.

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

