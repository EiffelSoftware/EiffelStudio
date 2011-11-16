note
	description: "Cursors for {CONSTRUCT}"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRUCT_CURSOR

inherit
	TWO_WAY_TREE_CURSOR [detachable CONSTRUCT]
		redefine
			active
		end

create
	make

feature {CONSTRUCT} -- Access

	active: detachable CONSTRUCT
			-- Current node

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
