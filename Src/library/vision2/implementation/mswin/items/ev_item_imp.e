--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: "EiffelVision base item, mswindows implementation"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
	
	EV_EVENT_HANDLER_IMP

	EV_ITEM_EVENTS_CONSTANTS_IMP

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			if parent_imp /= Void then
				parent_imp.prune (interface)
			end
			destroy_just_called := True
			is_destroyed := True
		end

	set_parent (a_parent: like parent) is
			-- Make `a_parent' the parent of the menu-item.
		deferred
		ensure
			assigned: parent = a_parent
		end

	align_text_center is
			-- Set text alignment of current label to center.
		do
           end

	align_text_right is
			-- Set text alignment of current label to right.
		do
		end

	align_text_left is
			-- Set text alignment of current label to left.
		do
		end
	
	destroyed: BOOLEAN is
		do
		end

	set_pointer_style (c: EV_CURSOR) is
		do
			check
				to_be_implemented: FALSE	
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
		do
			check
				to_be_implemented: FALSE	
			end
		end

feature {NONE} -- Implementation

	invalidate is
			-- Should invalidate the top parent.
		do
		end

end -- class EV_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2000/03/17 23:31:22  rogers
--| Added set_pointer_style and cursor_on_widget, both with to_be_implemented_checks.
--|
--| Revision 1.13  2000/02/29 22:38:25  rogers
--| Removed redundent code from destroy, and added destroy_just_called := True and is_destroyed := True into destroy.
--|
--| Revision 1.12  2000/02/24 01:43:55  brendel
--| Changed postcondition on `set_parent' to be exactly the same, but without
--| using the function `parent_set'.
--|
--| Revision 1.11  2000/02/23 02:13:59  brendel
--| Changed spaces with tabs.
--|
--| Revision 1.10  2000/02/22 23:08:37  rogers
--| Added parent_set which was taken from EV_ITEM_I, and improved comment on implementation feature clause.
--|
--| Revision 1.9  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.8  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.5  2000/02/05 02:06:47  brendel
--| Added empty features align_text_* and destroyed.
--|
--| Revision 1.7.6.4  2000/02/03 17:18:47  brendel
--| Commented out line where parent is treated as variable.
--|
--| Revision 1.7.6.3  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  1999/12/17 17:36:02  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
