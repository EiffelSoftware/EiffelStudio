note
	description: "Common ancestor for object inspection."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_REFLECTED_OBJECT

feature -- Access

	object: ANY
			-- Associated object for Current.
			-- It might be a copy if Current is expanded.
		deferred
		end

	object_address: POINTER
			-- Unprotected reference to `object'.
		note
			compiler: no_gc
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
