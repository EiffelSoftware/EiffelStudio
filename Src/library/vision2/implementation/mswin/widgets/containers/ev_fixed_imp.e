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
			interface,
			compute_minimum_height,
			compute_minimum_width,
			compute_minimum_size
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp,
			default_style,
			wel_move_and_resize
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			create ev_children.make (2)
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			wel_win: EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void
			end
			wel_win.child_cell.move (an_x, a_y)
			wel_win.wel_move (an_x, a_y)
			wel_win.invalidate
			if
				an_x + wel_win.width > width or else
				a_y + wel_win.height > height
			then
				notify_change (Nc_minsize, wel_win)
			end
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			wel_win: EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void
			end
			wel_win.parent_ask_resize (a_width, a_height)
			if
				wel_win.x_position + wel_win.width > width or else
				wel_win.y_position + wel_win.height > height
			then
				notify_change (Nc_minsize, wel_win)
			end
		end

feature {EV_ANY_I} -- Implementation

	invalidate_agent: PROCEDURE [ANY, TUPLE []]
			-- Called after a change has occurred.
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Child widgets in z-order starting with farthest away.

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Assign `a_window' to `top_level_window_imp'.
		do
			top_level_window_imp := a_window
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.set_top_level_window_imp (a_window)
				ev_children.forth
			end
		end

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_visible
				-- + Ws_clipchildren + Ws_clipsiblings
		end

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {NONE} -- Implementation

	compute_minimum_width is
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width: INTEGER
			cur: INTEGER
		do
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				new_min_width := new_min_width.max (v_imp.x_position + v_imp.wel_width)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
			internal_set_minimum_width (new_min_width)
		end

	compute_minimum_height is
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_height: INTEGER
			cur: INTEGER
		do
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				new_min_height := new_min_height.max (v_imp.y_position + v_imp.wel_height)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
			internal_set_minimum_height (new_min_height)
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width, new_min_height: INTEGER
			cur: INTEGER
		do
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				new_min_width := new_min_width.max (v_imp.x_position + v_imp.wel_width)
				new_min_height := new_min_height.max (v_imp.y_position + v_imp.wel_height)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
			internal_set_minimum_size (new_min_width, new_min_height)
		end

feature -- Obsolete

	add_child (child_imp: EV_WIDGET_IMP) is
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1, Current)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1, Current)
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

feature {NONE} -- WEL Implementation

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- And we reajust size of all children.
		local
			v_imp: EV_WIDGET_IMP
			cur: INTEGER
		do
			cwin_move_window (wel_item, a_x, a_y, a_width, a_height, repaint)
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				cwin_move_window (v_imp.wel_item, v_imp.x_position,
						v_imp.y_position, v_imp.width, v_imp.height, repaint)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
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
--| Revision 1.18  2000/06/07 17:27:59  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.12.8.5  2000/06/05 23:57:06  manus
--| Added redefinition of `wel_move_and_resize' that performs sizing operations on itself
--| and its children. Needed with new way of doing computation of `minimum_size'.
--| In `set_item_position' and `set_item_size' we call `notify_change' only when current
--| child is out of EV_FIXED, if it is still inside we do not do anything.
--|
--| Revision 1.12.8.4  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.12.8.3  2000/05/08 22:11:59  brendel
--| Improved compute_minimum_*.
--| Removed widget_changed.
--|
--| Revision 1.12.8.2  2000/05/05 00:05:07  brendel
--| Fixed using compute_minimum_size, parent_ask_resize and notify_change.
--|
--| Revision 1.12.8.1  2000/05/03 19:09:29  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/05/02 18:33:19  brendel
--| Completed implementation.
--|
--| Revision 1.16  2000/05/02 16:12:56  brendel
--| Implemented.
--|
--| Revision 1.15  2000/05/02 15:12:50  brendel
--| Added creation of ev_children.
--|
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
