--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision static menu bar. A menu bar that always%
		%stay on the top of the window."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_STATIC_MENU_BAR

inherit
	EV_MENU_HOLDER 
		redefine
			implementation
		end

create
	make_with_parent
	
feature {NONE} -- Initialization
	
	make_with_parent (par: EV_TITLED_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		require
			valid_parent: is_valid (par)
		do
			!EV_STATIC_MENU_BAR_IMP!implementation.make (par)
		end

feature -- Access
	
	parent: EV_TITLED_WINDOW is
			-- The parent of the Current widget
			-- If the widget is an EV_TITLED_WINDOW without parent,
			-- this attribute will be `Void'
		require
		do
			Result := implementation.parent
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_STATIC_MENU_BAR_I
	
	create_implementation is
			-- Create implementation of menu bar.
		do
			create {EV_STATIC_MENU_BAR_IMP} implementation.make (par)
		end

end -- class EV_MENU_BAR

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.5  2000/02/04 18:41:17  oconnor
--| unreleased
--|
--| Revision 1.8.6.4  2000/02/04 18:35:14  oconnor
--| unreleased
--|
--| Revision 1.8.6.3  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.8.6.2  2000/01/27 19:30:59  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.4  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.3  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
