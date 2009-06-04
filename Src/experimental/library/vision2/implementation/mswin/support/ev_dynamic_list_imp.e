note
	description: "[
		Eiffel Vision dynamic list. Mswindows implementation.

		Note: G_IMP denotes the storage type of ev_children.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_IMP [G -> detachable EV_CONTAINABLE, G_IMP -> detachable EV_ANY_I]

inherit
	EV_DYNAMIC_LIST_I [G]

feature -- Access

	i_th (i: INTEGER): detachable like item
			-- Item at `i'-th position.
		local
			l_item: detachable G_IMP
		do
			l_item ?= ev_children.i_th (i)
			check l_item /= Void end
			Result ?= l_item.interface
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.
		do
			Result := ev_children.count
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			l_item: detachable G_IMP
		do
			l_item ?= v.implementation
			check l_item /= Void end
			ev_children.go_i_th (i)
			ev_children.put_left (l_item)
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		do
			ev_children.go_i_th (i)
			ev_children.remove
		end

feature {EV_ANY_I} -- Implementation

	ev_children: ARRAYED_LIST [G_IMP]
			-- Internal list of children.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DYNAMIC_LIST_IMP










