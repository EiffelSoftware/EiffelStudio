note
	description: "Cells that can be linked to another cell."
	author: "Nadia Polikarpova"
	model: item, right
	false_guards: true

class
	V_LINKABLE [G]

inherit
	V_CELL [G]

create
	put

feature -- Access

	right: V_LINKABLE [G]
			-- Next cell.

feature -- Replacement

	put_right (cell: V_LINKABLE [G])
			-- Replace `right' with `cell'.
		note
			explicit: contracts
		require
			wrapped: is_wrapped
			modify_model ("right", Current)
		do
			right := cell
		ensure
			wrapped: is_wrapped
			right_effect: right = cell
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
