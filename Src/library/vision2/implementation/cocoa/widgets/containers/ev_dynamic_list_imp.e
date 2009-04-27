indexing
	description:
		"Eiffel Vision dynamic list. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_IMP [reference G -> EV_CONTAINABLE, reference G_IMP -> EV_ANY_I]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

feature -- Initialization

	initialize
			-- Initialize the dynamic list.
		do
			create ev_children.make (5)
			set_is_initialized (True)
		end

feature -- Access

	i_th (i: INTEGER): G
			-- Item at `i'-th position.
		do
			if ev_children /= void then
				Result ?= ev_children.i_th (i).interface
				check
					Result /= void
				end
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

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			l_item: G_IMP
		do
			l_item ?= v.implementation
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

	interface: EV_DYNAMIC_LIST [G]

invariant

	ev_children_not_void: is_usable implies ev_children /= Void

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_DYNAMIC_LIST_IMP

