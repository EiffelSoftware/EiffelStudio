indexing
	description: "EiffelVision horizontal box. The children stand%
				  %one beside an other. Mswindows implementation"
	note: "The attribute `child' represent here the child with the%
			% largest width of the box."
	author: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_BOX_IMP

inherit
	EV_HORIZONTAL_BOX_I
	
	EV_BOX_IMP
		redefine
			move_and_resize,
			internal_resize
		end
		
creation
	make

feature -- Access

	children_width: INTEGER
			-- Sum of the height of all the children.

feature -- Status setting

	set_homogeneous (flag: BOOLEAN) is
			-- set `is_homogeneous' to `flag'.
			-- Need to be resized
		do
			is_homogeneous := flag
			notify_change (1)
		end

	set_spacing (value: INTEGER) is
			-- Make `value' the new spacing of the box.
		do
			spacing := value
			notify_change (1)
		end

	set_border_width (value: INTEGER) is
			-- Make `value' the new border width.
		do
			border_width := value
			notify_change (1 + 2)
		end

feature {NONE} -- Basic operation

	set_local_height (new_height: INTEGER) is
			-- Set `new_height' to the box and all the children.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			temp_height: INTEGER
			cur: CURSOR
		do
			lchild := ev_children
			resize (width, new_height)
			if childvisible_nb /= 0 then
				temp_height := new_height - 2 * border_width
				from
					cur := lchild.cursor
					lchild.start
				until
					lchild.after
				loop
					lchild.item.parent_ask_resize(lchild.item.child_cell.width, temp_height)
					lchild.forth
				end
				lchild.go_to (cur)
			end
		end

	set_local_width (value: INTEGER) is
			-- Make `value' the `width' of the box and adapt 
			-- the children width.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			litem: EV_WIDGET_IMP
			rate, total_rest, mark: INTEGER
			children_size, localint: INTEGER
			cheight, bwidth, space: INTEGER
			cur: CURSOR
		do
			if childvisible_nb = 0 then
				mark := value
			else
				lchild := ev_children
				cur := lchild.cursor
				cheight := client_height
				bwidth := border_width
				space := spacing
				children_size := value - 2 * bwidth - total_spacing

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
							litem.set_move_and_size (mark, bwidth, localint, cheight)
							mark := mark + space + localint
						end
						lchild.forth
					end
					mark := mark - space

				-- Non homogeneous state : we have to be carefull to the non
				-- expanded children too.
				else
					rate := (children_size - children_width) // (childexpand_nb.max (1))
					total_rest := (children_size - children_width) \\ (childexpand_nb.max (1))

					-- Then, we ask the children to move and resize.
					-- Be carefull to the expanded child.
					from
						mark := bwidth
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							if litem.expandable then
								localint := litem.minimum_width + rate + rest (total_rest)
								if total_rest > 0 then
									total_rest := total_rest - 1
								elseif total_rest < 0 then
									total_rest := total_rest + 1
								end
							else
								localint := litem.minimum_width
							end
							litem.set_move_and_size (mark, bwidth, localint, cheight)
							mark := mark + space + localint
						end
					lchild.forth
					end -- loop

				mark := mark - space
				end -- is_homogeneous

			mark := mark + bwidth
			lchild.go_to (cur)
			end -- ev_children.empty

		resize (mark, height)
	end

feature {NONE} -- Implementation for automatic size compute

	internal_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- A function sometimes used (notebook) that update
			-- and resize the current widget.
		do
			inspect internal_changes
			when 1 then
				compute_minimum_width
			when 2 then
				compute_minimum_height
			when 3 then
				compute_minimum_size
			else
			end
			move (a_x, a_y)
			resize (width, a_height)
			set_local_width (a_width)
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
				from
					cur := lchild.cursor
					childvisible_nb := 0; childexpand_nb := 0; value := 0;
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
						if litem.expandable then
							childexpand_nb := childexpand_nb + 1
						end
					end
					lchild.forth
				end
				lchild.go_to (cur)
				internal_set_minimum_height (value + 2 * border_width)
			end
		end

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
				cur := lchild.cursor
				childvisible_nb := 0; childexpand_nb := 0; value := 0
				if is_homogeneous then
					from
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
							if litem.expandable then
								childexpand_nb := childexpand_nb + 1
							end
						end
						lchild.forth
					end
					internal_set_minimum_width (value * childvisible_nb + total_spacing + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							childvisible_nb := childvisible_nb + 1
							value := value + litem.minimum_width
							if litem.expandable then
								childexpand_nb := childexpand_nb + 1
							end
						end
						lchild.forth
					end
					children_width := value
					internal_set_minimum_width (value + total_spacing + 2 * border_width)
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
				childvisible_nb := 0; childexpand_nb := 0; hvalue := 0; wvalue := 0
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
							if litem.expandable then
								childexpand_nb := childexpand_nb + 1
							end
						end
						lchild.forth
					end
					internal_set_minimum_size (wvalue * childvisible_nb + total_spacing + 2 * border_width, hvalue + 2 * border_width)
				else
					from
						lchild.start
					until
						lchild.after
					loop
						litem := lchild.item
						if litem.shown then
							wvalue := wvalue + litem.minimum_width
							if litem.minimum_height > hvalue then
								hvalue := litem.minimum_height
							end
							childvisible_nb := childvisible_nb + 1
							if litem.expandable then
								childexpand_nb := childexpand_nb + 1
							end
						end
						lchild.forth
					end
					children_width := wvalue
					internal_set_minimum_size (wvalue + total_spacing + 2 * border_width, hvalue + 2 * border_width) 
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
			{EV_BOX_IMP} Precursor (a_x, a_y, width, a_height, repaint)
			set_local_width (a_width)
		end

end -- class EV_VERTICAL_BOX_IMP

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
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
