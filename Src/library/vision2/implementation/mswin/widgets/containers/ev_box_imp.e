indexing
	description: 
		"EiffelVision box, deferred class, parent of vertical and%
		%horizontal boxes. Mswindows implementation."
	note: "We use `create with coordinates' to allow the notebook%
		% as containers. They are wel_windows and not%
		% wel_composite_windows."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color,
			enable_sensitive,
			disable_sensitive,
			client_width,
			client_height
		redefine
			enable_sensitive,
			disable_sensitive,
			interface,
			initialize
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)is
				-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			create ev_children.make (2)
			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width
		end

	
	initialize is
			
		do
			Precursor
			remove_item_actions.extend (~removed_so_update_non_expandable_children (?))
			new_item_actions.extend (~added_so_update_non_expandable_children (?))
			is_initialized := True
		end
feature -- Access

	client_width: INTEGER is
			-- Width of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.width - 2 * border_width).max (0)
			else
				Result := (child_cell.width - 2 * border_width).max (0)
			end
		end
	
	client_height: INTEGER is
			-- Height of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.height  - 2 * border_width).max (0)
			else
				Result := (child_cell.height  - 2 * border_width).max (0)
			end
		end

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	padding: INTEGER
			-- Space between the objects in `Current'.

	border_width: INTEGER
			-- Border width around inside edge of `Current'.

	total_spacing: INTEGER is
			-- Total spacing. One spacing between two consecutive children.
		do
			Result := padding * ((childvisible_nb - 1).max (0))
		end

	childvisible_nb: INTEGER
			-- Number of visible children.
 
	childexpand_nb: INTEGER is
			-- Number of visible children which are expanded.
		do
			if non_expandable_children = Void then
				Result := childvisible_nb
			else
				Result := childvisible_nb - non_expandable_children.count
			end
		end

	non_expandable_children: ARRAYED_LIST [INTEGER]
			-- Position of the non expandable children in growing order.

feature -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is the `child' expandable. ie: does it
			-- allow the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			if non_expandable_children = Void then
				Result := True
			else
				child_imp ?= child.implementation
				check
					valid_cast: child_imp /= Void
				end
				Result := not non_expandable_children.has
					(ev_children.index_of (child_imp, 1))
			end
		end

feature -- Status setting

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make `child' expandable if `flag',
			-- not expandable otherwise.
		local
			list: ARRAYED_LIST [INTEGER]
			child_imp: EV_WIDGET_IMP
			value, an_index: INTEGER
			placed: BOOLEAN
		do
				-- First, we find the index of the child.
			child_imp ?= child.implementation
			check
				valid_cast: child_imp /= Void
			end
			an_index := ev_children.index_of (child_imp, 1)

				-- Then, we set the information
			if flag then
				if non_expandable_children /= Void then
					non_expandable_children.prune_all (an_index)
					if non_expandable_children.is_empty then
						non_expandable_children := Void
					end
				end
			else
				if non_expandable_children = Void then
					create non_expandable_children.make (1)
					non_expandable_children.extend (an_index)
				else
					from
						list := non_expandable_children
						placed := False
						list.start
					until
						placed
					loop
						if list.after then
							list.extend (an_index)
							placed := True
						else
							value := list.item
							if an_index < value then
								list.put_left (an_index)
								placed := True
							elseif an_index > value then
								list.forth
							else
								placed := True
							end
						end
					end
				end
			end
			notify_change (Nc_minsize, Current)
		end

feature -- Contract support

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
			-- `Result' True if `new_child' contained in `ev_children'.
  			-- Used in the postcondition of 'add_child'.
   		local
   			child_imp: EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			Result := ev_children.has (child_imp)
 		end
 								
feature {NONE} -- Basic operation

	removed_so_update_non_expandable_children (wid: EV_WIDGET) is
			-- Adjust `non_expandable_children' accordingly
			-- when a child is removed.
		local
			wid_imp: EV_WIDGET_IMP
			an_index: INTEGER
			value: INTEGER
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void
			end
			an_index := ev_children.index_of (wid_imp, 1)
			if non_expandable_children /= Void then
				non_expandable_children.prune_all (an_index)
				if non_expandable_children.is_empty then
					non_expandable_children := Void
				else
					if an_index <= non_expandable_children.count then
						from
							non_expandable_children.go_i_th (an_index)
						until
							non_expandable_children.off
						loop
							value := non_expandable_children.item
							non_expandable_children.remove
							non_expandable_children.put_left (value - 1)
						end
					end
				end
			end
		end

	added_so_update_non_expandable_children (wid: EV_WIDGET) is
			-- Adjust `non_expandable_children' accordingly
			-- when a child is added.
		local
			wid_imp: EV_WIDGET_IMP
			an_index: INTEGER
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void
			end
			an_index := ev_children.index_of (wid_imp, 1)
			if non_expandable_children /= Void then
				from
					non_expandable_children.start
				until
					non_expandable_children.off
				loop
					if non_expandable_children.item >= an_index then
						non_expandable_children.replace (an_index + 1)
					end
					non_expandable_children.forth
				end
			end
		end
 
	rest (total_rest: INTEGER): INTEGER is
				-- `Result' is rest we must add to the current child of
				-- `ev_children' when the size of the parent is not a 
				-- multiple of the number of children.
				-- Dependent on `total_rest'.
		do
			if total_rest > 0 then
				Result := 1
			elseif total_rest < 0 then
				Result := -1
			else
				Result := 0
			end
		end

feature -- from EV_INVISIBLE_CONTAINER_IMP FIXME!!!
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- List of the children of the `Current'.

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_insensitive (flag: BOOLEAN) is
			-- If `flag' then make `Current' insensitive. Else
			-- make `Current' sensitive.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
			widget_imp: EV_WIDGET_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					widget_imp := list.item
					if flag then
						widget_imp.disable_sensitive 
					else
						if not widget_imp.internal_non_sensitive then
							widget_imp.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
		end

	enable_sensitive is
			-- Make `Current' sensitive to user input.
		do
			set_insensitive (False)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	disable_sensitive is
			-- Make `Current' insensitive to user input.
		do
			set_insensitive (True)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.is_empty then
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

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of `Current'?
		do
			Result := ev_children.has (a_child)
		end

feature {EV_ANY_I} -- Interface

	interface: EV_BOX

end -- class EV_BOX_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.36  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.35  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.26.2.27  2001/03/16 19:19:21  rogers
--| Undone previsou commit change.
--|
--| Revision 1.26.2.26  2001/03/16 19:07:18  rogers
--| Added update_for
--|
--| Revision 1.26.2.25  2001/01/26 23:39:14  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.26.2.24  2001/01/19 01:59:30  rogers
--| Removed debugging outout.
--|
--| Revision 1.26.2.23  2001/01/19 00:50:17  rogers
--| Renamed `update_non_expandable_children' to
--| `removed_so_update_non_expandable_children'. Added
--| `added_so_update_non_expandable_children' which will update the non
--| expandable children as necessary when a new child is added. Fixes bug when
--| inserting a child before a non expandable child in `Current'.
--|
--| Revision 1.26.2.22  2000/11/29 00:44:21  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.26.2.21  2000/11/16 18:18:03  xavier
--| `total_spacing' could return a negative result there were no visible children.
--|
--| Revision 1.26.2.20  2000/11/06 18:03:47  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.26.2.19  2000/10/20 01:02:57  manus
--| Fixed a problem with `client_width' and `client_height' that did not take into account
--| that Current is not `is_show_requested'. When it is `is_show_requested' we can go through
--| WEL, otherwise, we have to go through the info contained in `child_cell'.
--|
--| Revision 1.26.2.18  2000/09/13 22:12:00  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.26.2.17  2000/08/16 17:06:53  rogers
--| set_insensitive now restores the cursor position. Added postcondition.
--|
--| Revision 1.26.2.16  2000/08/16 16:35:08  rogers
--| Completing last comment. Fixed set_insensitive so that the enabling/
--| disabling of the children is handled correctly.
--|
--| Revision 1.26.2.14  2000/08/15 16:11:04  rogers
--| Removed redefinition of set_focus.
--|
--| Revision 1.26.2.12  2000/08/11 18:57:39  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.26.2.11  2000/08/08 16:09:42  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| No more `wel_window_parent' hack.
--|
--| Revision 1.26.2.10  2000/07/24 17:23:01  rogers
--| Redefined initialize and added update_non_expandable_children to the
--| remove_item_actions. Re-implemented update_non_expandable_children.
--|
--| Revision 1.26.2.9  2000/07/21 23:03:48  rogers
--| Removed add_child and add_child_ok as no longer used in Vision2.
--|
--| Revision 1.26.2.8  2000/07/21 18:45:56  rogers
--| Removed remove_child as it is no longer necessary in Vision2.
--|
--| Revision 1.26.2.7  2000/06/13 16:43:58  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.26.2.6  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter
--| which tells the parent which children did request the change. Usefull in
--| case of NOTEBOOK for performance reasons (See EV_NOTEBOOK_IMP log for
--| more details)
--|
--| Revision 1.26.2.5  2000/05/30 16:21:28  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.26.2.4  2000/05/15 23:00:19  king
--| is_child_expanded -> is_item_expanded
--|
--| Revision 1.26.2.3  2000/05/08 16:59:56  rogers
--| Changed !! to create.
--|
--| Revision 1.26.2.2  2000/05/03 19:09:24  oconnor
--| mergred from HEAD
--|
--| Revision 1.33  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.32.2.1  2000/04/05 20:00:13  brendel
--| Removed calls to ev_children by graphical insert/remove features.
--|
--| Revision 1.32  2000/03/21 23:39:00  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.31  2000/03/21 17:11:35  brendel
--| Moved all features from EV_INVISIBLE_CONTAINER_IMP up, making it
--| obsolete. If a common ancestor for EV_FIXED and EV_TABLE turn out
--| to be necessary after all, if only for the implementation, we have to
--| think of another name.
--|
--| Revision 1.30  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.29.2.1  2000/03/11 00:19:15  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.29  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.28  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.26.2.1.2.6  2000/01/31 17:27:46  brendel
--| Removed set_default_minimum_size from inh. clause.
--|
--| Revision 1.26.2.1.2.5  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.26.2.1.2.4  2000/01/18 00:45:21  rogers
--| Removed commented parts from ineritance structure. See diff.
--|
--| Revision 1.26.2.1.2.2  1999/12/17 00:55:13  rogers
--| Altered to fit in with the review branch. Redefinitions required.
--| Now inherits from EV_WIDGET_LIST_IMP, make takes an interface.
--|
--| Revision 1.26.2.1.2.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.25.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
