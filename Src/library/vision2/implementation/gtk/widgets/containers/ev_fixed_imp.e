indexing
	description: 
		"Eiffel Vision fixed. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_FIXED_IMP
	
inherit
	EV_FIXED_I
		redefine
			interface
		end
		
	EV_WIDGET_LIST_IMP
		redefine
			interface
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			set_c_object (C.gtk_fixed_new)
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			C.gtk_widget_set_uposition (w_imp.c_object, an_x, a_y)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			C.gtk_fixed_move (c_object, w_imp.c_object, a_width, a_height)
		end

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
			--| Do nothing more than calling gtk-reorder.
		do
			check
				to_be_implemented: False
			end
		end

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_FIXED

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
--| Revision 1.11  2000/05/02 18:34:22  brendel
--| Corrected implementation.
--|
--| Revision 1.10  2000/05/02 16:32:34  brendel
--| Implemented.
--|
--| Revision 1.9  2000/05/02 00:40:28  brendel
--| Reintroduced EV_FIXED.
--| Complete revision.
--|
--| Revision 1.8  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
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
