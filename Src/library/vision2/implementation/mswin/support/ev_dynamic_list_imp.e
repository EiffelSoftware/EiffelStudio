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

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.6  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.5  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.2.2  2000/05/13 00:51:26  king
--| Integrated with change to EV_DYNAMIC_LIST
--|
--| Revision 1.3.2.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.2.4.3  2000/04/05 19:51:28  brendel
--| Now uses g_imp_converter to cast without checking.
--|
--| Revision 1.2.4.2  2000/04/03 18:18:23  brendel
--| Added second generic parameter for storage type in ev_children.
--| Added features imp_to_int and int_to_imp. To be implemented.
--|
--| Revision 1.2.4.1  2000/04/01 00:43:58  brendel
--| Revised.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
