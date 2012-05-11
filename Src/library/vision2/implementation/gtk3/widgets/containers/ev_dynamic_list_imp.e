note
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST_IMP [G -> EV_CONTAINABLE]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

feature -- Initialization

	make
			-- Initialize the dynamic list.
		do
			create child_array.make (0)
			set_is_initialized (True)
		end

feature -- Access

	i_th (i: INTEGER): like item
			-- Item at `i'-th position.
		do
			Result := child_array.i_th (i)
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.
		do
			Result := child_array.count
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		deferred
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		deferred
		end

feature {NONE} -- Implementation

	child_array: ARRAYED_LIST [G]

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DYNAMIC_LIST [G] note option: stable attribute end

invariant

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_DYNAMIC_LIST_IMP
