indexing
	description: "EiffelVision horizontal box. The children stand%
				  %one beside an other. Mswindows implementation"
	note: "The attribute `child' represent here the child with the%
			% largest width of the box."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_BOX_IMP

inherit
	EV_HORIZONTAL_BOX_I
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			on_size
		end

creation
	make

feature -- Access

	children_width: INTEGER
			-- Sum of the width of all the children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Recompute widths of children.
		do
			is_homogeneous := flag
			notify_change (Nc_minwidth, Current)
		end

	set_padding (value: INTEGER) is
			-- Make `value' the new spacing of `Current'.
		do
			padding := value
			notify_change (Nc_minwidth, Current)
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
			Precursor {EV_BOX_IMP} (size_type, a_width, a_height)
			set_children_width (a_width, True)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			set_children_width (a_width, False)
		end

	set_children_width (a_width: INTEGER; originator: BOOLEAN) is
			-- Move and resize the children to have them adapted to the
			-- current width.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			expandable: ARRAYED_LIST [INTEGER]
			litem: EV_WIDGET_IMP
			rate, total_rest, mark: INTEGER
			children_size, localint: INTEGER
			cheight, bwidth, space: INTEGER
			cur: CURSOR
			int1, int2: INTEGER
			next_non_expandable: INTEGER
		do
			if childvisible_nb /= 0 then
				lchild := ev_children
				expandable := non_expandable_children
				cur := lchild.cursor
				cheight := client_height
				bwidth := border_width
				space := padding
				children_size := a_width - 2 * bwidth - total_spacing

					-- Homogeneous state : only the visible children are
					-- important.
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
									(mark, bwidth, localint, cheight)
							else
								litem.ev_apply_new_size (mark, bwidth,
									localint, cheight, True)
							end
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

					-- Non homogeneous state : we have to be carefull to the non
					-- expanded children too.
				else
					int1 := children_size - children_width
					int2 := childexpand_nb.max (1)
						-- It is possible that int1 < 0.
						-- This occurs when `Current' has a minimum width and
						-- the children are larger. Because of the minimum
						-- width, `Current' does not expand.
					if int1 >= 0 then
						rate := int1 // int2
						total_rest := int1 \\ int2
					else
						rate := 0
						total_rest := 0
					end

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
								localint := litem.minimum_width +
									rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								localint := litem.minimum_width
								if expandable.islast then
									next_non_expandable := - 1
								else
									expandable.forth
									next_non_expandable := expandable.item
								end
							end
							if originator then
								litem.set_move_and_size
									(mark, bwidth, localint, cheight)
							else
								litem.ev_apply_new_size (mark, bwidth,
									localint, cheight, True)
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
					end -- loop.
				end -- is_homogeneous.
			lchild.go_to (cur)
			end
		end

feature {NONE} -- Implementation for automatic size compute

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
				from
					cur := lchild.cursor
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
				lchild.go_to (cur)
				childvisible_nb := nb_visi
			end
			ev_set_minimum_height (value + 2 * border_width)
		end

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
							value := value.max (litem.minimum_width)
						end
						lchild.forth
					end
					childvisible_nb := nb_visi
					ev_set_minimum_width (value * nb_visi +
						total_spacing + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.is_show_requested then
							nb_visi := nb_visi + 1
							value := value + litem.minimum_width
						end
						lchild.forth
					end
					children_width := value
					childvisible_nb := nb_visi
					ev_set_minimum_width
						(value + total_spacing + 2 * border_width)
				end
				lchild.go_to (cur)
			else
				children_width := 0
				ev_set_minimum_width (2 * border_width)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and the minimum_height of
			-- `Current'.
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
					ev_set_minimum_size (wvalue * nb_visi +
						total_spacing + 2 * border_width, hvalue +
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
							wvalue := wvalue + litem.minimum_width
							hvalue := hvalue.max (litem.minimum_height)
						end
						lchild.forth
					end
					children_width := wvalue
					childvisible_nb := nb_visi
					ev_set_minimum_size (wvalue + total_spacing +
						2 * border_width, hvalue + 2 * border_width) 
				end
				lchild.go_to (cur)
			else
				children_width := 0
				ev_set_minimum_size (2 * border_width, 2 * border_width)
			end
		end

feature {NONE} -- Implementation

	interface: EV_HORIZONTAL_BOX

end -- class EV_HORIZONTAL_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

