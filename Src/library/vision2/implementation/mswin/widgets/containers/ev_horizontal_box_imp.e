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
			compute_minimum_width,
			compute_minimum_height,
			resize_from_minimum,
			resize_proportionnaly
		end
		
creation
	make


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
			temp_height: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
		do
			lchild := ev_children
			resize (width, new_height)
			if not lchild.empty then
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

	set_local_width (temp_width: INTEGER) is
			-- Set `new_width' to the box and adapt the children width.
			-- To distribute the extra space in case the size given is not a 
			-- multiple of the number of children to resize, we need to store
			-- the last child that receive an extra-space and we start the loop
			-- at this children and we grow to add space or we go back if we 
			-- have some space to remove.
		local
			total_rest: INTEGER
			rate: INTEGER
			mark: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
		do
			if ev_children.empty then
				mark := temp_width
			else
				lchild := ev_children
				cur := lchild.cursor

				-- Homogeneous state : only the visible children are
				-- importante.
				if is_homogeneous then
					if childvisible_nb > 0 then
						rate := (temp_width - width) // childvisible_nb
						total_rest := (temp_width - width) \\ childvisible_nb
						-- A first loop to see who will have a rest.
						-- The loop is different if the window grow or reduce.
						if childvisible_nb /= lchild.count then
							if rate >= 0 then
								from
									lchild.go_i_th (index)
								until
									lchild.index = index - 1 or
									modulo(lchild.index - index, lchild.count) > total_rest
								loop
									if not lchild.item.shown then
										total_rest := total_rest + 1
									end
									if lchild.islast then
										lchild.start
									else
										lchild.forth
									end
								end
							else
								from
									lchild.go_i_th (index - 1)
								until
									lchild.index = index or
										modulo(lchild.index - index, lchild.count) > total_rest
								loop
									if not lchild.item.shown then
										total_rest := total_rest - 1
									end
									if lchild.isfirst then
										lchild.finish
									else
										lchild.back
									end
								end
							end
						end
	
						-- Then, we ask the children to move and resize.
						from
							mark := border_width
							lchild.start
						until
							lchild.after
						loop
							if lchild.item.shown or else not shown then
								lchild.item.set_move_and_size (mark, border_width, lchild.item.child_cell.width + rate + rest (total_rest), client_height)
								mark := mark + spacing + lchild.item.child_cell.width
							end
							lchild.forth
						end
						mark := mark - spacing
					end
	
				-- Non homogeneous state : we have to be carefull to the non
				-- expanded children too.
				else
					if childexpand_nb > 0 then
						rate := (temp_width - width) // childexpand_nb
						total_rest := (temp_width - width) \\ childexpand_nb
						-- A first loop to see who will have a rest.
						-- The loop is different is the window grow or reduce.
						if childvisible_nb /= lchild.count or childexpand_nb /= lchild.count then
							if rate >= 0 then
								from
									lchild.go_i_th (index)
								until
									lchild.index = (index - 1) or
										modulo(lchild.index - index, lchild.count) > total_rest
								loop
									if not lchild.item.shown or not lchild.item.expandable then
										total_rest := total_rest + 1
									end
									if lchild.islast then
										lchild.start
									else
										lchild.forth
									end
								end
							else
								from
									lchild.go_i_th (index - 1)
								until
									lchild.index = index or
										modulo(lchild.index - index, lchild.count) > total_rest
								loop
									if not lchild.item.shown or not lchild.item.expandable then
										total_rest := total_rest - 1
									end
									if lchild.isfirst then
										lchild.finish
									else
										lchild.back
									end
								end
							end
						end
					end
					-- Then, we ask the children to move and resize.
					-- Be carefull to the expanded child.
					from
						mark := border_width
						lchild.start
					until
						lchild.after
					loop
						if lchild.item.shown or else not shown then
							if lchild.item.expandable then
								lchild.item.set_move_and_size (mark, border_width, lchild.item.child_cell.width + rate + rest (total_rest), client_height)
							else
								lchild.item.set_move_and_size (mark, border_width, lchild.item.child_cell.width, client_height)
							end
							mark := mark + spacing + lchild.item.child_cell.width
						end
						lchild.forth
					end
					mark := mark - spacing
				end -- is_homogeneous
				index := modulo (index + total_rest, lchild.count)
				mark := mark + border_width
				lchild.go_to (cur)
			end -- ev_children.empty

--			-- At the end, we resize the window.
--			resize (mark, height)
			resize (temp_width, height)
		end

	initialize_length_at_minimum is
			-- Initialize the width of the window and of the children.
			-- Must be called for anychangement not due to the parent :
			-- a child has resized, homogeneous or spacing has changed.
		local
			mark: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
		do
			lchild := ev_children

				-- We initialize the index at one because all the children will
				-- have exactly the same size at the end.
			index := 1

			if not lchild.empty then
				cur := lchild.cursor

				-- In case the box is homogeneous, we don't care about the expand
				-- attribute of the child.
				if is_homogeneous then
					from
						lchild.start
						childvisible_nb := 0
						mark := border_width
					until
						lchild.after
					loop
						if lchild.item.shown or else not shown then
							childvisible_nb := childvisible_nb + 1
							lchild.item.set_move_and_size (mark, border_width, child.minimum_width, client_height)
							mark := mark + lchild.item.child_cell.width + spacing
						end
						lchild.forth
					end

					-- In case it is not homegeneous, we must count the number of 
					-- expand children to distribute the extra-space later.
				else
					from
						childexpand_nb := 0
						lchild.start
						mark := border_width
					until
						lchild.after
					loop
						if lchild.item.shown or else not shown then
							if lchild.item.expandable then
								childexpand_nb := childexpand_nb + 1
							end
							lchild.item.set_move_and_size (mark, border_width, lchild.item.minimum_width, client_height)
							mark := mark + lchild.item.child_cell.width + spacing
						end
						lchild.forth
					end
				lchild.go_to (cur)
				end
				-- To have the final size of the box, we need
				-- to remove one spacing and to had a border.
				mark := mark - spacing + border_width

				-- Then, we resize and set the minimum size of the widget. The order
				-- is very important.
				resize (mark, height)
			end
		end

	add_children_minimum_width: INTEGER is
			-- Give the sum of the `minimum_width' of all the children
			-- We can't use the index because this function is called by other
			-- routines that used the index already.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
		do
			lchild := ev_children
			if not lchild.empty then
				from
					cur := lchild.cursor
					lchild.start
				until
					lchild.after
				loop
					Result := Result + lchild.item.minimum_width
					lchild.forth
				end
				lchild.go_to (cur)
			end
		end

feature {NONE} -- Implementation for automatic size compute

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
			value: INTEGER
		do
			if not ev_children.empty then
				if is_homogeneous then
					lchild := ev_children
					from
						cur := lchild.cursor
						child := lchild.first
						value := lchild.first.minimum_width
						lchild.go_i_th (2)
					until
						lchild.after
					loop
						if lchild.item.minimum_width > value then
							value := lchild.item.minimum_width
							child := lchild.item
						end
						lchild.forth
					end
					lchild.go_to (cur)
					internal_set_minimum_width (value * ev_children.count + total_spacing + 2 * border_width)
				else
					internal_set_minimum_width (add_children_minimum_width + total_spacing + 2 * border_width)
				end
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			cur: CURSOR
			value: INTEGER
		do
			if not ev_children.empty then
				lchild := ev_children
				from
					cur := lchild.cursor
					value := lchild.first.minimum_height
					lchild.go_i_th (2)
				until
					lchild.after
				loop
					if (lchild.item).minimum_height > value then
						value := lchild.item.minimum_height
					end
					lchild.forth
				end
				lchild.go_to (cur)
				internal_set_minimum_height (value + 2 * border_width)
			end
		end

	resize_from_minimum (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize from the minimum size of the children
		do
			initialize_length_at_minimum
			resize_proportionnaly (a_x, a_y, a_width, a_height)
		end

	resize_proportionnaly (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize everything by difference with the current size.
		do
			move (a_x, a_y)
			if a_width /= width then
				resize (width, a_height)
				set_local_width (a_width)
			else
				set_local_height (a_height)
			end
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
