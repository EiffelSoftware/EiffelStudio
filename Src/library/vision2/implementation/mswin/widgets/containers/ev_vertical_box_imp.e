indexing
	description:
		"EiffelVision vertical box. The children are arranged vertically.%
		% Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			on_size
		end

create
	make

feature -- Access

	children_height: INTEGER
			-- Sum height of all children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Recompute heights of children.
		do
			is_homogeneous := flag
			notify_change (Nc_minheight, Current)
		end

	set_padding (value: INTEGER) is
			-- Make `value' the new spacing of `Current'.
		do
			padding := value
			notify_change (Nc_minheight, Current)
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width of `Current'.
		do
			border_width := value
			notify_change (Nc_minsize, Current)
		end

feature {NONE} -- Basic operation 

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			Precursor (size_type, a_width, a_height)
			set_children_height (a_height, True)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			set_children_height (a_height, False)
		end

	set_children_height (a_height: INTEGER; originator: BOOLEAN) is
			-- Resize the children to fit the current height.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			expandable: ARRAYED_LIST [INTEGER]
			litem: EV_WIDGET_IMP
			rate, total_rest, mark: INTEGER
			children_size, localint: INTEGER
			cwidth, bwidth, space: INTEGER
			cur: CURSOR
			int1, int2: INTEGER
			next_non_expandable: INTEGER
		do
			if childvisible_nb /= 0 then
				lchild := ev_children
				expandable := non_expandable_children 
				cur := lchild.cursor
				cwidth := client_width
				bwidth := border_width
				space := padding
				children_size := a_height - 2 * bwidth - total_spacing

					-- Homogeneous state : only the visible children are
					-- importante.
				if is_homogeneous then
					rate := children_size // childvisible_nb
					total_rest := children_size \\ childvisible_nb
					from
						mark := bwidth
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							localint := rate + rest (total_rest)
							total_rest := (total_rest - 1).max (0)
							if originator then
								litem.set_move_and_size
									(bwidth, mark, cwidth, localint)
							else
								litem.ev_apply_new_size
									(bwidth, mark, cwidth, localint, True)
							end
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

					-- Non homogeneous state : we have to be careful to the
					-- non expanded children too.
				else
					int1 := children_size - children_height
					int2 := childexpand_nb.max (1)
					rate := int1 // int2
					total_rest := int1 \\ int2

						-- Then, we ask the children to move and resize.
						-- Be carefull to the expanded child.
					from
						mark := bwidth
						lchild.start
						if expandable = Void then
							next_non_expandable := -1
						else
							expandable.start
							next_non_expandable := expandable.item
						end
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							if lchild.index /= next_non_expandable then
								localint := litem.minimum_height +
									rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								localint := litem.minimum_height
								if expandable.islast then
									next_non_expandable := - 1
								else
									expandable.forth
									next_non_expandable := expandable.item
								end
							end
							if originator then
								litem.set_move_and_size
									(bwidth, mark, cwidth, localint)
							else
								litem.ev_apply_new_size
									(bwidth, mark, cwidth, localint, True)
							end
							mark := mark + space + localint
						elseif lchild.index = next_non_expandable then
							if expandable.islast then
								next_non_expandable := - 1
							else
								expandable.forth
								next_non_expandable := expandable.item
							end
						end
						lchild.forth
					end -- loop
				end -- is_homogeneous
			lchild.go_to (cur)
			end -- ev_children.empty
	end

feature {NONE} -- Implementation for automatic size computation.

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				from
					cur := lchild.cursor
					lchild.start
				until
					lchild.after
				loop
					litem := lchild.item
					if litem.is_show_requested then
						nb_visi := nb_visi + 1
						value := value.max (litem.minimum_width)
					end
					lchild.forth
				end
				lchild.go_to (cur)
			end
			childvisible_nb := nb_visi
			ev_set_minimum_width (value + 2 * border_width)
		end

	compute_minimum_height is
			-- Recompute the minimum_height of `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				cur := lchild.cursor
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value.max (litem.minimum_height)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					ev_set_minimum_height (value * nb_visi +
						total_spacing + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							value := value + litem.minimum_height
							nb_visi := nb_visi + 1
						end
						lchild.forth
					end
					children_height := value
					childvisible_nb := nb_visi
					ev_set_minimum_height
						(value + total_spacing + 2 * border_width)
				end
				lchild.go_to (cur)
			else
				children_height := 0
				ev_set_minimum_height (2 * border_width)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and the minimum_height
			-- of `Current'.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			hvalue, wvalue, nb_visi: INTEGER
		do
			childvisible_nb := 0
			if not ev_children.is_empty then
				lchild := ev_children
				cur := lchild.cursor
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue.max (litem.minimum_width)
							hvalue := hvalue.max (litem.minimum_height)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					ev_set_minimum_size (wvalue + 2 * border_width,
						hvalue * nb_visi + total_spacing +
						2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							wvalue := wvalue.max (litem.minimum_width)
							hvalue := hvalue + litem.minimum_height
						end
						lchild.forth
					end
					children_height := hvalue
					childvisible_nb := nb_visi
					ev_set_minimum_size (wvalue + 2 * border_width,
						hvalue + total_spacing + 2 * border_width)
				end
				lchild.go_to (cur)
			else
				children_height := 0
				ev_set_minimum_size (2 * border_width, 2 * border_width)
			end
		end

feature {NONE} -- Implementation

	interface: EV_VERTICAL_BOX

end -- class EV_VERTICAL_BOX_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.35  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.30.2.13  2000/11/29 00:40:48  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.30.2.12  2000/09/29 21:45:17  manus
--| `childvisible_nb' was not updated before doing the call to `ev_set_minimum_size' resulting
--| in strange behavior in EV_*_BOX resizing.
--|
--| Revision 1.30.2.11  2000/09/29 02:04:41  manus
--| Fixed a bug in traversal of `expandable' which could do a precondition violation on forth
--| because we do not check that we are at the end of the list.
--|
--| Revision 1.30.2.10  2000/09/25 01:44:44  manus
--| Fixed a bug because `childvisible_nb' was used in a recursive manner within `compute_minimum_*'
--| (found in EiffelBench documentation wizard dialog)
--| Now we use a local variable to keep the value and set it at the very end.
--|
--| Revision 1.30.2.9  2000/08/11 18:54:42  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.30.2.8  2000/08/08 18:11:25  manus
--| Forgot in `ev_apply_new_size' a call to `ev_move_and_resize' that generates some
--| displays problems because vertical box does not get its new size.
--|
--| Revision 1.30.2.7  2000/08/08 16:09:42  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| No more `wel_window_parent' hack.
--|
--| Revision 1.30.2.6  2000/06/21 21:31:15  manus
--| Speed improvement on computation of minimum size/width/height for horizontal/vertical box
--| by calling only once the `minimum_xxxx' feature
--|
--| Revision 1.30.2.5  2000/06/19 21:42:17  manus
--| Fixed a small bug in `set_children_[width|height]' where we were doing `after' access
--| on `expandable'
--|
--| Revision 1.30.2.4  2000/06/13 19:42:49  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.30.2.3  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.30.2.2  2000/05/30 16:15:07  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.30.2.1  2000/05/03 19:09:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.33  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.32.2.1  2000/03/11 00:19:16  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.32  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.31  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.30.4.4  2000/02/01 03:45:55  brendel
--| Added `interface'.
--| Rearranged inheritance clause.
--|
--| Revision 1.30.4.3  2000/01/27 19:30:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.30.4.2  1999/12/17 00:46:30  rogers
--| Altered to fit in with the review branch. Some redefinitions required. is_show_requested replaces shown.
--|
--| Revision 1.30.4.1  1999/11/24 17:30:29  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
