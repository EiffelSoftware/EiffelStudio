--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision fixed, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_FIXED_IMP
	
inherit
	
	EV_FIXED_I
		
	EV_INVISIBLE_CONTAINER_IMP
		export {NONE}
			add_child_packing
		redefine
			add_child,
			remove_child
		end
	
create
	
	make

feature {NONE} -- Initialization
	
        make is
                        -- Create a fixed widget. 
		do
			widget := gtk_fixed_new
		end

feature -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite.
			-- Redefined because we do not have any
			-- resizing options in an EV_FIXED.
		do
			-- Put the `vbox' into the current container. 
			gtk_container_add (GTK_CONTAINER (widget), child_imp.widget)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is	
			-- Remove the given child from the children of
			-- the container.
			-- Redefined because we do not have any
			-- resizing options in an EV_FIXED.
		do
			-- Remove the child from the current container. 			
			gtk_container_remove (GTK_CONTAINER (widget), child_imp.widget)
		end

end -- class EV_FIXED

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/02/05 03:54:55  oconnor
--| unreelased
--|
--| Revision 1.6.6.3  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.6.6.2  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.6.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
