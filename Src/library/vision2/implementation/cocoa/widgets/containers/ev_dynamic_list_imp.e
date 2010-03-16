note
	description: "Eiffel Vision dynamic list. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_IMP [reference G -> detachable EV_CONTAINABLE, reference G_IMP -> EV_ANY_I]

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

	i_th (i: INTEGER): detachable like item
			-- Item at `i'-th position.
		local
			l_item: detachable G_IMP
		do
			if attached ev_children then
				l_item ?= ev_children.i_th (i)
				check l_item /= Void end
				Result ?= l_item.attached_interface
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

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [G_IMP]

invariant
	ev_children_not_void: is_usable implies ev_children /= Void
end -- class EV_DYNAMIC_LIST_IMP
