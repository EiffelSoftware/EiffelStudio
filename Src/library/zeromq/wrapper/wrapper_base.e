note
	description: "Abstract ancestor to all opaque ZMQ structures/objects."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WRAPPER_BASE

inherit
	DISPOSABLE

feature -- Initialization

	make (a_item: POINTER)
			-- Create.
		require
			a_item_not_null: a_item /= default_pointer
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature {WRAPPER_BASE} -- Access

	item: POINTER;
			-- Pointer to underlying C object.

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
