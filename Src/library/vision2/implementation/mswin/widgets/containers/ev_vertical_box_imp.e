indexing
	description:
		"EiffelVision vertical box. The children stand%
		% one under the other. Mswindows implementation."
	author: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I

	EV_BOX_IMP
		redefine
			move_and_resize,
			set_child_expandable
		end

creation
	make

feature -- Access

	children_height: INTEGER
			-- Sum of the height of all the children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Need to be resized
		do
			is_homogeneous := flag
			notify_change (Nc_minheight)
		end

	set_spacing (value: INTEGER) is
			-- Make `value' the new spacing of the box.
		do
			spacing := value
			notify_change (Nc_minheight)
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width.
		do
			border_width := value
			notify_change (Nc_minsize)
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		do
			{EV_BOX_IMP} Precursor (child, flag)
			notify_change (Nc_minheight)
		end

feature {NONE} -- Basic operation 

	set_children_width is
			-- Make `new_width' the `width' of the box and all the children.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			temp: INTEGER
			cur: CURSOR
		do
			lchild := ev_children
			if childvisible_nb /= 0 then
				from
					cur := lchild.cursor
					lchild.start
				until
					lchild.after
				loop
					litem := lchild.item
					litem.integrate_changes
					litem.parent_ask_resize (client_width, litem.child_cell.height)
					lchild.forth
				end
				lchild.go_to (cur)
			end
		end

	set_children_height is
			-- Make 'new_height' the `height' of the box and adapt 
			-- the children height.
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
				space := spacing
				children_size := height - 2 * bwidth - total_spacing

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
						if litem.shown then
							localint := rate + rest (total_rest)
							total_rest := (total_rest - 1).max (0)
							litem.set_move_and_size (bwidth, mark, cwidth, localint)
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

				-- Non homogeneous state : we have to be carefull to the non
				-- expanded children too.
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
						if litem.shown then
							if lchild.index /= next_non_expandable then
								localint := litem.minimum_height + rate + rest (total_rest)
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
							litem.set_move_and_size (bwidth, mark, cwidth, localint)
							mark := mark + space + localint
						elseif lchild.index = next_non_expandable then
							expandable.forth
							next_non_expandable := expandable.item
						end
						lchild.forth
					end -- loop
				end -- is_homogeneous
			lchild.go_to (cur)
			end -- ev_children.empty
	end

feature {NONE} -- Implementation for automatic size compute

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value: INTEGER
		do
			if not ev_children.empty then
				lchild := ev_children
				from
					cur := lchild.cursor
					childvisible_nb := 0; value := 0;
					lchild.start
				until
					lchild.after
				loop
					litem := lchild.item
					if litem.shown then
						childvisible_nb := childvisible_nb + 1
						if litem.minimum_width > value then
							value := litem.minimum_width
						end
					end
					lchild.forth
				end
				lchild.go_to (cur)
				internal_set_minimum_width (value + 2 * border_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_height of the object.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			value: INTEGER
		do
			if not ev_children.empty then
				lchild := ev_children
				cur := lchild.cursor
				childvisible_nb := 0;  value := 0;
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							childvisible_nb := childvisible_nb + 1
							if litem.minimum_height > value then
								value := litem.minimum_height
							end
						end
						lchild.forth
					end
					internal_set_minimum_height (value * childvisible_nb + total_spacing + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							value := value + litem.minimum_height
							childvisible_nb := childvisible_nb + 1
						end
						lchild.forth
					end
					children_height := value
					internal_set_minimum_height (value + total_spacing + 2 * border_width)
				end
				lchild.go_to (cur)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and the minimum_height of the object.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			cur: CURSOR
			hvalue, wvalue: INTEGER
		do
			if not ev_children.empty then
				lchild := ev_children
				cur := lchild.cursor
				childvisible_nb := 0; hvalue := 0; wvalue := 0 
				if is_homogeneous then
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							childvisible_nb := childvisible_nb + 1
							if litem.minimum_width > wvalue then
								wvalue := litem.minimum_width
							end
							if litem.minimum_height > hvalue then
								hvalue := litem.minimum_height
							end
						end
						lchild.forth
					end
					internal_set_minimum_size (wvalue + 2 * border_width, hvalue * childvisible_nb + total_spacing + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							childvisible_nb := childvisible_nb + 1
							if litem.minimum_width > wvalue then
								wvalue := litem.minimum_width
							end
							hvalue := hvalue + litem.minimum_height
						end
						lchild.forth
					end
					children_height := hvalue
					internal_set_minimum_size (wvalue + 2 * border_width, hvalue + total_spacing + 2 * border_width)
				end
				lchild.go_to (cur)
			end
		end

feature {NONE} -- WEL Implementation

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		do
			{EV_BOX_IMP} Precursor (a_x, a_y, a_width, a_height, repaint)
			set_children_height
		end

end -- class EV_VERTICAL_BOX_IMP

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
