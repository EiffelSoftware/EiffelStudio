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
			child_width_changed,
			child_height_changed,
			child_minwidth_changed,
			child_minheight_changed
		end
		
creation
	make

feature {NONE} -- Basic operation

	set_local_height (new_height: INTEGER) is
			-- Set `new_height' to the box and all the children.
		do
			resize (width, minimum_height.max (new_height))
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.parent_ask_resize(ev_children.item.child_cell.width, height)
					ev_children.forth
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
			if shown then
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
					
							-- Then, we ask the children to move and resize.
							from
								mark := spacing // 2
								ev_children.start
							until
								ev_children.after
							loop
								if ev_children.item.shown then
									ev_children.item.set_move_and_size (mark, 0, ev_children.item.child_cell.width + rate + rest (total_rest), height)
									mark := mark + spacing + ev_children.item.child_cell.width
								end
								ev_children.forth
							end
						end
	
					-- Non homogeneous state : we have to be carefull to the non
					-- expanded children too.
					else
						if childexpand_nb > 0 then
							rate := (temp_width - width) // childexpand_nb
							total_rest := (temp_width - width) \\ childexpand_nb
		
							-- A first loop to see who will have a rest.
							-- The loop is different is the window grow or reduce.
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
	
						-- Then, we ask the children to move and resize.
						-- Be carefull to the expanded child.
						from
							mark := spacing // 2
							ev_children.start
						until
							ev_children.after
						loop
							if ev_children.item.shown then
								if ev_children.item.expandable then
									ev_children.item.set_move_and_size (mark, 0, ev_children.item.child_cell.width + rate + rest (total_rest), height)
								else
									ev_children.item.set_move_and_size (mark, 0, ev_children.item.child_cell.width, height)
									end
								mark := mark + spacing + ev_children.item.child_cell.width
							end
							ev_children.forth
						end
		
					end
	
				index := modulo (index + total_rest, ev_children.count)
				end
	
				-- At the end, we resize the window
				resize (mark, height)
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
					mark := spacing // 2
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						childvisible_nb := childvisible_nb + 1
						ev_children.item.set_move_and_size (mark, 0, child.minimum_width, height)
						mark := mark + ev_children.item.child_cell.width + spacing
					end
					ev_children.forth
				end

				-- In case it is not homegeneous, we must count the number of 
				-- expand children to distribute the extra-space later.
			else
				from
					childexpand_nb := 0
					ev_children.start
					mark := spacing // 2
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						if ev_children.item.expandable then
							childexpand_nb := childexpand_nb + 1
						end
						ev_children.item.set_move_and_size (mark, 0, ev_children.item.minimum_width, height)
						mark := mark + ev_children.item.child_cell.width + spacing
					end
					ev_children.forth
				end
			end

				-- Then, we set the minimum size of the widget and we resize it.
			set_minimum_width (mark)
			resize (minimum_width, height)
		end

	initialize_display is
			-- Reinitialize the box at the same size.
		local
			old_width: INTEGER
		do
			old_width := width
			initialize_length_at_minimum
			if old_width >= minimum_width and shown then
				set_local_width (old_width)
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
					i = ev_children.count
				loop
					Result := Result + (ev_children @ i).minimum_width
					i := i + 1
				end
			end
		end

	child_height_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according 
			-- to the resize of one of them.
		do
			if shown then
				if value > minimum_height then
					set_height (value)
				else
					set_height (minimum_height)
				end
			end
		end

	child_width_changed (value:INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according
			-- to the resize of one of them.
		do
			if shown then
				if value > child.minimum_width then
					set_width (value * ev_children.count + total_spacing)
				else
					initialize_length_at_minimum
				end
			end
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum height because the child did.
			-- We can't call set minimimum_height because th widget
			-- musn't be resized.
		do
			if value > minimum_height then
					set_minimum_height (value)
			end
		end

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because the child did.
		do
			if is_homogeneous then
				if value > child.minimum_width then
					set_minimum_width (value * ev_children.count + total_spacing)
				end
			else
				set_minimum_width (add_children_minimum_width + total_spacing)
			end
			if value > child.minimum_width then
				child := the_child
			end
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add a child to the box, it also resize the box
   		do
			if child = Void or (child /= Void and then child_imp.minimum_width > child.minimum_width) then
				child := child_imp
			end
			ev_children.extend (child_imp)
			if shown then
				initialize_length_at_minimum
				child_cell.set_width (minimum_width)
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
