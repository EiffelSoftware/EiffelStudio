indexing
	description: "[
		Eiffel Vision dynamic list. Mswindows implementation.

		Note: G_IMP denotes the storage type of ev_children.
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [reference G -> EV_CONTAINABLE, reference G_IMP -> EV_ANY_I]

inherit
	EV_DYNAMIC_LIST_I [G]

feature -- Access

	i_th (i: INTEGER): like item is
			-- Item at `i'-th position.
		do
			Result ?= ev_children.i_th (i).interface
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			Result := ev_children.count
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			l_item: G_IMP
		do
			l_item ?= v.implementation
			ev_children.go_i_th (i)
			ev_children.put_left (l_item)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		do
			ev_children.go_i_th (i)
			ev_children.remove
		end

feature {EV_ANY_I} -- Implementation

	ev_children: ARRAYED_LIST [G_IMP] is
			-- Internal list of children.
		deferred
		end

end -- class EV_DYNAMIC_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

