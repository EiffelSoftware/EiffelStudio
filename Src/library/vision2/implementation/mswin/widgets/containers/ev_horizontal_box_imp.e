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
		undefine
			child_add_successful
		end
	
	EV_BOX_IMP
		redefine
			add_child,
			child_minwidth_changed,
			child_minheight_changed
		end
		
creation
	make

feature {NONE} -- Basic operation

	set_local_height (new_height: INTEGER) is
			-- Set `new_height' to the box and all the children.
		local
			temp_height: INTEGER
		do
			if new_height /= height then
				resize (width, minimum_height.max (new_height))
				temp_height := minimum_height.max (new_height) - 2 * border_width
				if not ev_children.empty then
					from
						ev_children.start
					until
						ev_children.after
					loop
						ev_children.item.parent_ask_resize(ev_children.item.child_cell.width, temp_height)
						ev_children.forth
					end
				end
			end
		end

	set_local_width (new_width: INTEGER) is
			-- Set `new_width' to the box and adapt the children width.
			-- To distribute the extra space in case the size given is not a 
			-- multiple of the number of children to resize, we need to store
			-- the last child that receive an extra-space and we start the loop
			-- at this children and we grow to add space or we go back if we 
			-- have some space to remove.
		local
			temp_width: INTEGER
			total_rest: INTEGER
			rate: INTEGER
			mark: INTEGER
		do
			if new_width /= width then
				if already_displayed then
					temp_width := minimum_width.max (new_width)
					if not ev_children.empty then

						-- Homogeneous state : only the visible children are
						-- importante.
						if is_homogeneous then
							if childvisible_nb > 0 then
								rate := (temp_width - width) // childvisible_nb
								total_rest := (temp_width - width) \\ childvisible_nb
	
								-- A first loop to see who will have a rest.
								-- The loop is different is the window grow or reduce.
								if childvisible_nb /= ev_children.count then
									if rate >= 0 then
										from
											ev_children.go_i_th (index)
										until
											ev_children.index = modulo(index - 1, ev_children.count) or
											modulo(ev_children.index - index, ev_children.count) = total_rest
										loop
											if not ev_children.item.shown then
												total_rest := total_rest + 1
											end
											if ev_children.islast then
												ev_children.start
											else
												ev_children.forth
											end
										end
									else
										from
											ev_children.go_i_th (modulo (index - 1, ev_children.count))
										until
											ev_children.index = index or
												modulo(ev_children.index - index, ev_children.count) > total_rest
										loop
											if not ev_children.item.shown then
												total_rest := total_rest - 1
											end
											if ev_children.isfirst then
												ev_children.finish
											else
												ev_children.back
											end
										end
									end
								end
		
								-- Then, we ask the children to move and resize.
								from
									mark := border_width
									ev_children.start
								until
									ev_children.after
								loop
									if ev_children.item.shown or else not shown then
										ev_children.item.set_move_and_size (mark, border_width, ev_children.item.child_cell.width + rate + rest (total_rest), client_height)
										mark := mark + spacing + ev_children.item.child_cell.width
									end
									ev_children.forth
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
								if childvisible_nb /= ev_children.count or childexpand_nb /= ev_children.count then
									if rate >= 0 then
										from
											ev_children.go_i_th (index)
										until
											ev_children.index = modulo (index - 1, ev_children.count) or
												modulo(ev_children.index - index, ev_children.count) = total_rest
										loop
											if not ev_children.item.shown or not ev_children.item.expandable then
												total_rest := total_rest + 1
											end
											if ev_children.islast then
												ev_children.start
											else
												ev_children.forth
											end
										end
									else
										from
											ev_children.go_i_th (modulo (index - 1, ev_children.count))
										until
											ev_children.index = index or
												modulo(ev_children.index - index, ev_children.count) > total_rest
										loop
											if not ev_children.item.shown or not ev_children.item.expandable then
												total_rest := total_rest - 1
											end
											if ev_children.isfirst then
												ev_children.finish
											else
												ev_children.back
											end
										end
									end
								end
							end
		
							-- Then, we ask the children to move and resize.
							-- Be carefull to the expanded child.
							from
								mark := border_width
								ev_children.start
							until
								ev_children.after
							loop
								if ev_children.item.shown or else not shown then
									if ev_children.item.expandable then
										ev_children.item.set_move_and_size (mark, border_width, ev_children.item.child_cell.width + rate + rest (total_rest), client_height)
									else
										ev_children.item.set_move_and_size (mark, border_width, ev_children.item.child_cell.width, client_height)
									end
									mark := mark + spacing + ev_children.item.child_cell.width
								end
								ev_children.forth
							end
							mark := mark - spacing
	
						end

					index := modulo (index + total_rest, ev_children.count)
					end

					-- At the end, we resize the window
					resize (mark + border_width, height)
				end		
			end
		end

	initialize_length_at_minimum is
			-- Initialize the width of the window and of the children.
			-- Must be called for anychangement not due to the parent :
			-- a child has resized, homogeneous or spacing has changed.
		local
			mark: INTEGER
		do
				-- We initialize the index at one because all the children will
				-- have exactly the same size at the end.
			index := 1

				-- In case the box is homogeneous, we don't care about the expand
				-- attribute of the child.
			if is_homogeneous then
				from
					childvisible_nb := 0
					ev_children.start
					mark := border_width
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						childvisible_nb := childvisible_nb + 1
						ev_children.item.set_move_and_size (mark, border_width, child.minimum_width, client_height)
						mark := mark + ev_children.item.child_cell.width + spacing
					end
					ev_children.forth
				end
				mark := mark - spacing

				-- In case it is not homegeneous, we must count the number of 
				-- expand children to distribute the extra-space later.
			else
				from
					childexpand_nb := 0
					ev_children.start
					mark := border_width
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						if ev_children.item.expandable then
							childexpand_nb := childexpand_nb + 1
						end
						ev_children.item.set_move_and_size (mark, border_width, ev_children.item.minimum_width, client_height)
						mark := mark + ev_children.item.child_cell.width + spacing
					end
					ev_children.forth
				end
				mark := mark - spacing
			end

				-- Then, we set the minimum size of the widget and we resize it.
			set_minimum_width (mark + border_width)
			resize (minimum_width, height)
		end

	initialize_display is
			-- Reinitialize the box at the same size.
		local
			old_width: INTEGER
		do
			old_width := width
			initialize_length_at_minimum
			if old_width >= minimum_width and already_displayed then
				set_local_width (old_width)
			else
				set_width (minimum_width)
			end
		end

	add_children_minimum_width: INTEGER is
			-- Give the sum of the `minimum_width' of all the children
			-- We can't use the index because this function is called by other
			-- routines that used the index already.
		local
			i: INTEGER
		do
			if not ev_children.empty then
				from
					i := 1
				until
					i = ev_children.count + 1
				loop
					Result := Result + (ev_children @ i).minimum_width
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- Resize the box and all the children inside
		local
			cc: EV_CHILD_CELL_IMP
		do
			cc := child_cell
			cc.resize (minimum_width.max(a_width), minimum_height.max (a_height))
			if resize_type = 3 then
				if cc.width /= width then
					resize (width, cc.height)
					set_local_width (cc.width)
				else
					set_local_height (cc.height)
				end
				move (cc.x, cc.y)
			elseif resize_type = 2 then
				set_local_width (cc.width)
				set_local_height (minimum_height)
				move (cc.x, (cc.height - height)//2 + cc.y)
			elseif resize_type = 1 then
				if cc.width /= width then
					resize (cc.width, minimum_height)
					set_local_width (cc.width)
				else
					set_local_height (minimum_height)
				end	
				move (cc.x, (cc.height - height)//2 + cc.y)
			else
				move ((cc.width - width)//2 + cc.x, (cc.height - height)//2 + cc.y)
				set_local_width (minimum_width)
				set_local_height (minimum_height)
			end
		end

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because the child did.
		do
			if value > child.minimum_width then
				child := the_child
				if shown and then (value > the_child.child_cell.width or not is_homogeneous) then
					initialize_display
				else
					if is_homogeneous then
						set_minimum_width (child.minimum_width * ev_children.count + total_spacing + 2 * border_width)
					else
						set_minimum_width (add_children_minimum_width + total_spacing + 2 * border_width)
					end
				end
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
   			-- Change the minimum width of the container because
   			-- the child changed his own minimum width.
   		do
 			set_minimum_height ((value + 2 * border_width).max (minimum_height))
 		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add a child to the box, it also resize the box
   		do
			if child = Void or (child /= Void and then child_imp.minimum_width > child.minimum_width) then
				child := child_imp
			end
			ev_children.extend (child_imp)
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
