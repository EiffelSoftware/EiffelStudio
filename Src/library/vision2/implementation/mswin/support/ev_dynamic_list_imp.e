indexing
	description: 
		"Eiffel Vision dynamic list. Mswindows implementation."
	note:
		"G_IMP denotes the storage type of ev_children."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_IMP [G -> EV_CONTAINABLE, G_IMP -> EV_ANY_I]

inherit
	EV_DYNAMIC_LIST_I [G]

feature -- Access

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		do
			Result := imp_to_int (ev_children.i_th (i))
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
		do
			ev_children.go_i_th (i)
			ev_children.put_left (int_to_imp (v))
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

	int_to_imp (int: G): G_IMP is
			-- `implementation' of `int'.
		require
			int_not_void: int /= Void
		do
			if g_imp_converter = Void then
				create g_imp_converter
			end
			Result := g_imp_converter.attempt (int.implementation)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	g_imp_converter: ASSIGN_ATTEMPT [G_IMP]

end -- class EV_DYNAMIC_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

