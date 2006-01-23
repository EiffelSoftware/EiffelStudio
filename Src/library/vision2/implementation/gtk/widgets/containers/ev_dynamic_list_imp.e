indexing
	description:
		"Eiffel Vision dynamic list. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [reference G -> EV_CONTAINABLE]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end
		
feature -- Initialization

	initialize is
			-- Initialize the dynamic list.
		do
			create child_array.make (5)
			set_is_initialized (True)
		end

feature -- Access

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		do
			if child_array /= Void then
				Result := child_array.i_th (i)
			end	
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			if child_array /= Void then
				Result := child_array.count
			end	
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		deferred
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		deferred
		end

feature {NONE} -- Implementation

	child_array: ARRAYED_LIST [G]

	interface: EV_DYNAMIC_LIST [G]

invariant

	child_array_not_void: is_usable implies child_array /= Void

indexing
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

