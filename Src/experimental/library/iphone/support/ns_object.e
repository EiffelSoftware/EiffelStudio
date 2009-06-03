note
	description: "Summary description for {UI_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

inherit
	DISPOSABLE

create
	share_from_pointer

create {NS_OBJECT}
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER)
			-- Initialize Current assuming the Eiffel code initialized `a_ptr' via an external call.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
			proper_reference_counting: c_retain_count (a_ptr) = 1
		end

	share_from_pointer (a_ptr: POINTER)
			-- Initialize Current using `a_ptr' assuming `a_ptr' was not created by the Eiffel code.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
			c_retain (a_ptr)
		ensure
			item_set: item = a_ptr
			proper_reference_counting: c_retain_count (a_ptr) = old c_retain_count (a_ptr) + 1
		end

feature -- Access

	item: POINTER
			-- Underlying UI object.

feature -- Status report

	exists: BOOLEAN
			-- Does current still have its underlying object and thus is usable?
		do
			Result := item /= default_pointer
		end

feature -- Removal

	dispose
			-- <Precursor>
		local
			l_null: POINTER
		do
			if item /= l_null then
				c_release (item)
				item := l_null
			end
		end

feature {NONE} -- Externals

	c_retain_count (a_item_ptr: POINTER):  NATURAL_64
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"return [(NSObject *) $a_item_ptr retainCount];"
		end

	c_release (a_item_ptr: POINTER)
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"[(NSObject *) $a_item_ptr release];"
		end

	c_retain (a_item_ptr: POINTER)
		require
			a_item_ptr_not_null: a_item_ptr /= default_pointer
		external
			"C inline use <Foundation/NSObject.h>"
		alias
			"[(NSObject *) $a_item_ptr retain];"
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
