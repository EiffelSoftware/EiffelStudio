note
	description: "Implementation of TUPLE"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE

feature

	put (v: detachable SYSTEM_OBJECT; k: INTEGER)
			-- Associate value `v' with key `k'.
		require
--			valid_index: valid_index (k)
--			valid_type_for_index: valid_type_for_index (v, k)
		do
--			native_array.put (k, v)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
