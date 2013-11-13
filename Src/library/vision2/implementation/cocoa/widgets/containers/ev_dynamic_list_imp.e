note
	description: "Eiffel Vision dynamic list. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_IMP [G -> EV_CONTAINABLE, G_IMP -> EV_ANY_I]

inherit
	EV_DYNAMIC_LIST_I [G]

feature -- Initialization

	initialize
			-- Initialize the dynamic list.
		do
			create ev_children.make (5)
			set_is_initialized (True)
		end

feature -- Access

	i_th (i: INTEGER): like item
			-- Item at `i'-th position.
		do
			check attached ev_children.i_th (i) as l_item and then attached {like item} l_item.interface as l_result then
				Result := l_result
			end
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.
		do
			if ev_children /= void then
				Result := ev_children.count
			end
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			check attached {G_IMP} v.implementation as l_item then
				ev_children.go_i_th (i)
				ev_children.put_left (l_item)
			end
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		do
			ev_children.go_i_th (i)
			ev_children.remove
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [G_IMP]

invariant
	ev_children_not_void: is_usable implies ev_children /= Void
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
end -- class EV_DYNAMIC_LIST_IMP
