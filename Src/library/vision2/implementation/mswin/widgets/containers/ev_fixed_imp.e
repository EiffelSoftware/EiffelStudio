--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision fixed. Mswindows implementation."
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

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			ev_wel_control_container_make
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		do
			check
				to_be_implemented: False
			end
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			check
				to_be_implemented: False
			end
		end

feature {EV_ANY_I} -- Implementation
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Child widgets in z-order starting with farthest away.

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature -- Obsolete

	add_child (child_imp: EV_WIDGET_IMP) is
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1)
		end

	add_child_ok: BOOLEAN is
		obsolete
			"Do: item = Void"
		do
			Result := item = Void
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
		obsolete
			"Do: ?? = item.implementation"
		do
			Result := a_child = item.implementation
		end

end -- class EV_FIXED_IMP

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
--| Revision 1.14  2000/05/02 00:40:27  brendel
--| Reintroduced EV_FIXED.
--| Complete revision.
--|
--| Revision 1.13  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.10.2  2000/01/27 19:30:20  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.10.1  1999/11/24 17:30:26  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
