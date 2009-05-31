note
	description: "Summary description for {UI_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UI_OBJECT

create
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER)
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			item := a_ptr
		ensure
			item_set: item = a_ptr
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

;note
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
