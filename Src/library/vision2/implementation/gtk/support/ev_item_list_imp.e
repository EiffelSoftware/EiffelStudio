indexing
	description:
		"Eiffel Vision item list. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [G]
		redefine
			interface
		end

feature {NONE} -- Implementation

	--| FIXME VB: I would like to have all EV_ITEM_LIST_IMP
	--| objects to only use insert_i_th and remove_i_th.
	--| gtk_reorder_child may only call once C function.
	--| add_to_container will be removed.
	--| When that is done remove insert_i_th and remove_i_th.

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			--imp: EV_ANY_I
		do
			add_to_container (v)
			if i < count then
				reorder_child (v, i)
			end

		--	imp ?= v.implementation
		--	check
		--		imp_not_void: imp /= Void
		--	end
			on_new_item (v)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			p: POINTER
			--w_imp: EV_WIDGET_IMP
		do
			p := C.g_list_nth_data (
				C.gtk_container_children (list_widget),
				i - 1)

		--	w_imp ?= eif_object_from_c (p)
		--	check
		--		w_imp_not_void: w_imp /= Void
		--	end
		--	remove_item_actions.call ([w_imp])

			C.gtk_widget_ref (p)
			C.gtk_container_remove (list_widget, p)
			C.gtk_widget_unref (p)
		end

feature {NONE} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		deferred
		end

feature {NONE} -- Obsolete

	add_to_container (v: like item) is
			-- Add `v' to end of list.
			--| FIXME VB Will be obsolete
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			C.gtk_container_add (list_widget, v_imp.c_object)
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			gtk_reorder_child (list_widget, v_imp.c_object, a_position - 1)
		end

feature -- Event handling

	on_new_item (an_item: G) is
			-- Called after `an_item' is added.
		do
		end

	on_removed_item (an_item: G) is
			-- Called just before `an_item' is removed.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.1  2000/10/09 19:22:20  oconnor
--| Renamed ev_item_holder_imp.e to ev_item_list_imp.e
--|
--| Revision 1.8.4.3  2000/08/04 19:19:27  oconnor
--| Optimised radio button management by using a polymorphic call
--| instaed of using agents.
--|
--| Revision 1.8.4.2  2000/07/31 18:57:25  king
--| Removed unused local variables
--|
--| Revision 1.8.4.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/05/02 17:28:48  king
--| Added *_item_actions
--|
--| Revision 1.23  2000/04/06 20:09:31  brendel
--| Fixed bug in insert_i_th.
--|
--| Revision 1.22  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.21.2.3  2000/04/05 19:01:35  brendel
--| Clarified implementation.
--|
--| Revision 1.21.2.2  2000/04/04 23:44:11  brendel
--| Now tries to match implementation to EV_ANY_I, since EV_MULTI_COLUMN_LIST
--| _ROW does not inherit from EV_ANY_IMP.
--|
--| Revision 1.21.2.1  2000/04/04 16:17:58  brendel
--| Redefined `remove_i_th' and `insert_i_th' to use `add_to_container' and
--| `reorder_child'. This is because of the fact that a lot of classes rely on
--| these features. These features will be removed so we have to modify those
--| classes.
--|
--| Revision 1.21  2000/03/16 22:16:45  king
--| Fixed prune, now passes all regression tests
--|
--| Revision 1.20  2000/03/16 21:09:24  king
--| Corrected prune
--|
--| Revision 1.19  2000/03/16 20:31:56  king
--| Corrected list test bugs by comparing to widget list
--|
--| Revision 1.18  2000/03/15 17:07:50  brendel
--| Before every put/extend/replace, removes item from its old parent, if
--| not Void.
--|
--| Revision 1.17  2000/03/15 00:54:48  king
--| Indenting
--|
--| Revision 1.16  2000/03/13 22:06:55  king
--| Added position preconditions, reference handling on item reordering
--|
--| Revision 1.15  2000/03/13 19:04:22  king
--| Added valid_position precondition to remove_item_at_position
--|
--| Revision 1.14  2000/03/08 21:36:56  king
--| Corrected comment on remove
--|
--| Revision 1.13  2000/02/22 19:52:47  brendel
--| Added feature `item_from_c_object' to be able to retreive the Eiffel object
--| in redefined gtk_reorder_child functions. See: EV_MENU_ITEM_LIST_IMP.
--|
--| Revision 1.12  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/17 21:48:34  king
--| Corrected reorder_child functions, reimplemented prune
--|
--| Revision 1.10  2000/02/16 20:25:05  king
--| Abstracted a remove_item_from_position to avoid a lot of redefinition in mclist
--|
--| Revision 1.9  2000/02/14 11:40:30  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.16  2000/02/14 11:03:23  oconnor
--| protect count from accessing C when is_destroyed
--|
--| Revision 1.8.6.15  2000/02/04 04:53:00  oconnor
--| released
--|
--| Revision 1.8.6.14  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.8.6.13  2000/02/03 23:30:09  brendel
--| Added feature `remove_from_container' that gets called everytime an item is
--| removed.
--|
--| Revision 1.8.6.12  2000/02/02 00:45:24  king
--| Tidied up code by abstracting assignment attempts and external calling in to single eiffel functions (for adding, reordering)
--|
--| Revision 1.8.6.11  2000/01/31 18:56:59  king
--| Altered item feature to use assign_attempt
--|
--| Revision 1.8.6.10  2000/01/28 19:01:38  king
--| Made to be generically constrained to ev_item
--|
--| Revision 1.8.6.9  2000/01/27 19:29:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.8  2000/01/26 23:45:29  king
--| Altered item to be of type ev_item and not ev_list_item
--|
--| Revision 1.8.6.7  2000/01/26 16:54:08  oconnor
--| moved features from EV_LIST to EV_ITEM_LIST
--|
--| Revision 1.8.6.6  1999/12/01 18:55:05  oconnor
--| moved item_by_data into _I
--|
--| Revision 1.8.6.5  1999/12/01 18:50:26  oconnor
--| use self instead of ev_children since we inherit DYNAMIC_LIST
--|
--| Revision 1.8.6.4  1999/12/01 17:47:53  oconnor
--| renamed class name in comment
--|
--| Revision 1.8.6.3  1999/12/01 01:02:32  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.8.6.2  1999/11/30 22:59:21  oconnor
--| change to DYNAMIC_LIST implementation
--|
--| Revision 1.8.6.1  1999/11/24 17:29:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/04 23:10:27  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
