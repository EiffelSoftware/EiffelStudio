indexing
	description: "Eiffel Vision widget list. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_LIST_IMP
	
inherit
	EV_WIDGET_LIST_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET]
		undefine
			destroy
		redefine
			interface,
			list_widget
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ANY_IMP
		do
			
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			C.gtk_container_add (list_widget, v_imp.c_object)
			if i < count then
				gtk_reorder_child (list_widget, v_imp.c_object, i - 1)
			end
			update_child_requisition (v_imp.c_object)
			on_new_item (v)
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			p: POINTER
			v_imp: EV_WIDGET_IMP
		do
			p := C.g_list_nth_data (
				C.gtk_container_children (list_widget),
				i - 1)
			v_imp ?= eif_object_from_c (p)
			check
				v_imp_not_void: v_imp /= Void
			end
			on_removed_item (v_imp.interface)
			--| FIXME VB To be checked by Sam.
			--| ref comes from item list and not in widget list?
			--| Is it necessary?
			C.gtk_widget_ref (p)
			C.gtk_container_remove (list_widget, p)
			C.set_gtk_widget_struct_parent (p, NULL)
			C.gtk_widget_unref (p)
		end
	
--| FIXME Direct implementation of extend.
--| This is faster than the cutrrent implementation but propper
--| benchmarks should be done prior to its inclusion. - Sam
--|	extend (v: EV_WIDGET) is
--|			-- Add `v' to end. Do not move cursor.
--|		local
--|			v_imp: EV_ANY_IMP
--|		do
--|			v_imp ?= v.implementation
--|			if index > count then
--|				index := index + 1
--|			end
--|			check
--|				v_imp_not_void: v_imp /= Void
--|			end
--|			C.gtk_container_add (list_widget, v_imp.c_object)
--|			on_new_item (v)
--|		end

feature {NONE} -- Implementation

	list_widget: POINTER is
			-- Pointer to the actual widget list container.
		do
			Result := container_widget
		end

	interface: EV_WIDGET_LIST
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_WIDGET_LIST_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.21  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.20  2001/06/21 22:35:29  king
--| Added call to update_child_requisition
--|
--| Revision 1.19  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.2.10  2000/10/27 16:54:42  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.17.2.9  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.17.2.8  2000/08/30 16:21:35  oconnor
--| Redefined destroy to remove children before destroying.
--|
--| Revision 1.17.2.7  2000/08/08 00:03:14  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.17.2.6  2000/08/04 19:19:28  oconnor
--| Optimised radio button management by using a polymorphic call
--| instaed of using agents.
--|
--| Revision 1.17.2.5  2000/06/22 00:29:44  king
--| Removed unnecessary calling of reset_minimum_size
--|
--| Revision 1.17.2.4  2000/06/21 22:46:47  king
--| Resetting minimum size, should perhaps be in fixed only, but here saves 1 A.A.
--|
--| Revision 1.17.2.3  2000/06/14 00:05:31  king
--| Redefining list_widget to return container_widget instead of c_object
--|
--| Revision 1.17.2.2  2000/05/04 19:00:56  brendel
--| Correction.
--|
--| Revision 1.17.2.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.16  2000/05/02 17:33:17  king
--| Added *_i_th implementation that was made deferred in dyn_list_imp
--|
--| Revision 1.15  2000/04/06 20:27:55  brendel
--| Removed initialize.
--|
--| Revision 1.14  2000/04/05 21:16:09  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.13.2.2  2000/04/04 23:45:03  brendel
--| Added initialize that sets list_widget to c_object.
--|
--| Revision 1.13.2.1  2000/04/04 16:23:40  brendel
--| Now inherits from EV_DYNAMIC_LIST_IMP.
--|
--| Revision 1.13  2000/03/20 18:15:12  brendel
--| Fixed bug in `item'.
--|
--| Revision 1.12  2000/03/03 19:28:53  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.11  2000/03/03 18:38:54  brendel
--| Implemented `put_left'.
--|
--| Revision 1.10  2000/03/02 21:38:54  brendel
--| Consistently added checks after every assignment attempt.
--| Formatted for 80 columns.
--|
--| Revision 1.9  2000/03/02 01:34:52  brendel
--| Instead of the interface, now this version of `prune' checks whether the
--| item is present. Cursor does not move, unless it was on the removed item,
--| then it is moved to the right neighbour, if any, or after.
--|
--| Revision 1.8  2000/03/01 23:39:30  brendel
--| Improved previous fix of `extend'.
--| Fixed bug in `put_front'.
--|
--| Revision 1.7  2000/03/01 23:10:14  brendel
--| Fixed bug in `extend'.
--|
--| Revision 1.6  2000/02/26 06:27:46  oconnor
--| adjust index after prune to ensure it is not too big
--|
--| Revision 1.5  2000/02/26 02:02:14  brendel
--| Formatting.
--|
--| Revision 1.4  2000/02/26 01:29:02  brendel
--| Added calls to action sequences when adding/removing an item.
--|
--| Revision 1.3  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.15  2000/02/14 11:03:37  oconnor
--| protect count from accessing C when is_destroyed
--|
--| Revision 1.1.4.14  2000/02/08 09:33:54  oconnor
--| fixed child /= Void to child /= NULL
--|
--| Revision 1.1.4.13  2000/02/08 00:19:38  king
--| Changed inheritence to deal with changes in ev_dynamic_list
--|
--| Revision 1.1.4.12  2000/02/07 23:51:26  oconnor
--| remove newly inserted items from possible old parent
--|
--| Revision 1.1.4.11  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.1.4.10  2000/02/03 00:02:28  oconnor
--| added is_useable to invariant
--|
--| Revision 1.1.4.9  2000/02/02 20:19:31  oconnor
--| added ACTION_SEQUENCE new_item_actions
--|
--| Revision 1.1.4.8  2000/01/27 19:29:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.7  2000/01/18 19:36:50  oconnor
--| improved checks in item
--|
--| Revision 1.1.4.6  2000/01/18 17:53:36  oconnor
--| Added EV_WIDGET_LIST.gtk_reorder_child deferred.
--| Defined in ev_notebook_imp.e and ev_box_imp.e.
--| GTK is missing a GtkMultiContainer class so there is no way
--| to polymorphicaly call gtk_box_reorder_child and gtk_notebook_reorder_child.
--|
--| Revision 1.1.4.5  1999/12/15 23:48:45  oconnor
--| redefine put to be same as replace
--|
--| Revision 1.1.4.4  1999/12/15 17:03:40  oconnor
--| formatting
--|
--| Revision 1.1.4.3  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.1.4.2  1999/11/30 23:15:48  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.1.4.1  1999/11/24 17:29:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.2  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.1.2.1  1999/11/05 22:37:14  oconnor
--| initial
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
