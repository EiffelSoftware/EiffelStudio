indexing
	description: "EiffelVision vertical box. The children stand%
				  %one under the other. Mswindows implementation"
	author: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I

	EV_BOX_IMP
		redefine
			child_minheight_changed,
			child_minwidth_changed
		end

creation
	make

feature {NONE} -- Basic operation 

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the `width' of the box and all the children.
		local
			temp_width: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			lchild := ev_children
			resize (new_width, height)
			temp_width := new_width - 2 * border_width
			if not lchild.empty then
				from
					lchild.start
				until
					lchild.after
				loop
					lchild.item.parent_ask_resize(temp_width, lchild.item.child_cell.height)
					lchild.forth
				end
			end
		end

	set_local_height (temp_height: INTEGER) is
			-- Make 'new_height' the `height' of the box and adapt 
			-- the children height.
		local
			total_rest: INTEGER
			mark:INTEGER
			rate: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if already_displayed then
				if not ev_children.empty then
					lchild := ev_children
						-- Homogeneous state : only the visible children are
						-- importante.
					if is_homogeneous then
						if childvisible_nb > 0 then
							rate := (temp_height - height) // childvisible_nb
							total_rest := (temp_height - height) \\ childvisible_nb 
	
							-- A first loop to see who will have a rest.
							-- The loop is different is the window grow or reduce.
							-- This loop is necessary only if there are some
							-- hidden children.
							if childvisible_nb /= lchild.count then
								if rate >= 0 then
									from
										lchild.go_i_th (index)
									until
										lchild.index = modulo(index - 1, lchild.count) or
										modulo(lchild.index - index, lchild.count) = total_rest
									loop
										if not lchild.item.shown then
											total_rest := total_rest + 1
										end
										if lchild.islast then
											lchild.start
										else
											lchild.forth
										end
									end -- loop
								else
									from
										lchild.go_i_th (modulo (index - 1, lchild.count))
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
									end -- loop
								end -- rate >= 0 
							end -- childvisible_nb /= lchild.count
								-- Then, we ask the children to move and resize.
							from
								mark := border_width
								lchild.start
							until
								lchild.after
							loop
								if lchild.item.shown or else not shown then
									lchild.item.set_move_and_size (border_width, mark, client_width, lchild.item.child_cell.height + rate + rest (total_rest))
									mark := mark + spacing + lchild.item.child_cell.height
								end
								lchild.forth
							end -- loop
							mark := mark - spacing
						end -- childvisible_nb > 0
						-- Non homogeneous state : we have to be carefull to the non
						-- expanded children too.
					else
						if childexpand_nb > 0 then
							rate := (temp_height - height) // childexpand_nb
							total_rest := (temp_height - height) \\ childexpand_nb
							-- A first loop to see who will have a rest.
							-- The loop is different is the window grow or reduce.
							-- This loop is necessary only if there are some
							-- hidden or not expandable children. 
							if childvisible_nb /= lchild.count or childexpand_nb /= lchild.count then
								if rate >= 0 then
									from
										lchild.go_i_th (index)
									until
										lchild.index = modulo (index - 1, lchild.count) or
											modulo(lchild.index - index, lchild.count) = total_rest
									loop
										if not lchild.item.shown or not lchild.item.expandable then
											total_rest := total_rest + 1
										end
										if lchild.islast then
											lchild.start
										else
											lchild.forth
										end
									end -- loop
								else
									from
										lchild.go_i_th (modulo (index - 1, lchild.count))
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
									end -- loop
								end -- rate >= 0
							end -- childvisible_nb /= lchild...
						end -- childexpand_nb > 0
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
									lchild.item.set_move_and_size (border_width, mark, client_width, lchild.item.child_cell.height + rate + rest (total_rest))
								else
									lchild.item.set_move_and_size (border_width, mark, client_width, lchild.item.child_cell.height)
								end
								mark := mark + spacing + lchild.item.child_cell.height
							end
							lchild.forth
						end -- loop
						mark := mark - spacing

					end -- is_homogeneous
					index := modulo (index + total_rest, lchild.count)
					mark := mark + border_width
				else
					-- if there are no children, we simply set the
					-- given height.
					mark := temp_height
				end -- ev_children.empty
					-- At the end, we resize the window in both cases
					-- already displayed or not.
				resize (width, mark)
		end -- already displayed
	end

	initialize_length_at_minimum is
			-- Initialize the width of the window and of the children.
			-- Must be called for anychangement not due to the parent :
			-- a child has resized, homogeneous or spacing has changed.
		local
			mark: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			lchild := ev_children

			-- We initialize the index at one because all the children will
			-- have exactly the same size at the end.
			index := 1

			-- In case the box is homogeneous, we don't care about the expand
			-- attribute of the child.
			if not lchild.empty then
				if is_homogeneous then
					from
						childvisible_nb := 0
						lchild.start
						mark := border_width
					until
						lchild.after
					loop
						if lchild.item.shown or else not shown then
							childvisible_nb := childvisible_nb + 1
							lchild.item.set_move_and_size (border_width, mark, client_width, child.minimum_height)
							mark := mark + lchild.item.child_cell.height + spacing
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
							lchild.item.set_move_and_size (border_width, mark, client_width, lchild.item.minimum_height)
							mark := mark + lchild.item.child_cell.height + spacing
						end
						lchild.forth
					end
				end
				-- To have the final size of the box, we need
				-- to remove one spacing and to had a border.
				mark := mark - spacing + border_width

				-- Then, we resize and set the minimum size of the widget. The order
				-- is very important.
				resize (width, mark)
				set_minimum_height (mark)
			end
		end

	add_children_minimum_height: INTEGER is
			-- Give the sum of the `minimum_height' of all the children
			-- We can't use the index because this function is called by other
			-- routines that used the index already.
		local
			i: INTEGER
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			lchild := ev_children
			if not lchild.empty then
				from
					i := 1
				until
					i = lchild.count + 1
				loop
					Result := Result + (lchild @ i).minimum_height
					i := i + 1
				end
			end
		end

	update_minimum_size is
			-- Update the minimum size of the container
			-- according to the children.
		local
			lchild: ARRAYED_LIST [EV_WIDGET_IMP]
			mw, mh: EV_WIDGET_IMP
			i: INTEGER
		do
			lchild := ev_children
			from
				mw := lchild @ 1
				mh := mw
				i := 2
			until
				i = lchild.count + 1
			loop
				if (lchild @ i).minimum_width > mw.minimum_width then
					mw := lchild @ i
				end
				if (lchild @ i).minimum_height > mh.minimum_height then
					mh := lchild @ i
				end
				i := i + 1
			end
			child := mh
			set_minimum_width (mw.minimum_width)
		end

feature {NONE} -- Implementation for automatic size compute

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because the child did.
		do
			if (child = Void) or (child /= Void and then value > child.minimum_height) then
				child := the_child
				if is_homogeneous then
					set_minimum_height (child.minimum_height * ev_children.count + total_spacing + 2 * border_width)
				else
					set_minimum_height (add_children_minimum_height + total_spacing + 2 * border_width)
				end
			end
		end

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
   			-- Change the minimum width of the container because
   			-- the child changed his own minimum width.
   		do
 			set_minimum_width ((value + 2 * border_width).max (minimum_width))
 		end

	move_and_resize  (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move (a_x, a_y)
			if a_height /= height then
				resize (a_width, height)
				set_local_height (a_height)
			else
				set_local_width (a_width)
			end
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
