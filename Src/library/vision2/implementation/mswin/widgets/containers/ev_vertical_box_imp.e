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
		undefine
			child_add_successful
		end
	
	EV_BOX_IMP
		redefine
			add_child,
			child_minheight_changed,
			child_minwidth_changed
		end

creation
	make

feature {NONE} -- Basic operation 

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the `width' of the box and all the children.
		do
			if new_width /= width then
				resize (minimum_width.max (new_width), height)
				if not ev_children.empty then
					from
						ev_children.start
					until
						ev_children.after
					loop
						ev_children.item.parent_ask_resize(width, ev_children.item.child_cell.height)		
						ev_children.forth
					end
				end
			end
		end

	set_local_height (new_height: INTEGER) is
			-- Make 'new_height' the `height' of the box and adapt 
			-- the children height.
		local
			temp_height: INTEGER
			total_rest: INTEGER
			mark:INTEGER
			rate: INTEGER
		do
			if new_height /= height then
				if already_displayed then
					temp_height := minimum_height.max (new_height)
					if not ev_children.empty then
	
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
									mark := 0
									ev_children.start
								until
									ev_children.after
								loop
									if ev_children.item.shown or else not shown then
										ev_children.item.set_move_and_size (0, mark, width, ev_children.item.child_cell.height + rate + rest (total_rest))
										mark := mark + spacing + ev_children.item.child_cell.height
									end
									ev_children.forth
								end
								mark := mark - spacing
							end
	
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
								mark := 0
								ev_children.start
							until
								ev_children.after
							loop
								if ev_children.item.shown or else not shown then
									if ev_children.item.expandable then
										ev_children.item.set_move_and_size (0, mark, width, ev_children.item.child_cell.height + rate + rest (total_rest))
									else
										ev_children.item.set_move_and_size (0, mark, width, ev_children.item.child_cell.height)
										end
									mark := mark + spacing + ev_children.item.child_cell.height
								end
								ev_children.forth
							end
							mark := mark - spacing
		
						end

						index := modulo (index + total_rest, ev_children.count)
						end
					end
	
					-- At the end, we resize the window
					resize (width, mark)
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
					mark := 0
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						childvisible_nb := childvisible_nb + 1
						ev_children.item.set_move_and_size (0, mark, width, child.minimum_height)
						mark := mark + ev_children.item.child_cell.height + spacing
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
					mark := spacing // 2
				until
					ev_children.after
				loop
					if ev_children.item.shown or else not shown then
						if ev_children.item.expandable then
							childexpand_nb := childexpand_nb + 1
						end
						ev_children.item.set_move_and_size (0, mark, width, ev_children.item.minimum_height)
						mark := mark + ev_children.item.child_cell.height + spacing
					end
					ev_children.forth
				end
				mark := mark - spacing
			end

				-- Then, we set the minimum size of the widget and we resize it.
			set_minimum_height (mark)
			resize (width, minimum_height)
		end

	initialize_display is
			-- Reinitialize the box at the same size.
		local
			old_height: INTEGER
		do
			old_height := height
			initialize_length_at_minimum
			if old_height >= minimum_height and already_displayed then
				set_local_height (old_height)
			else
				set_height (minimum_height)
			end
		end

	add_children_minimum_height: INTEGER is
			-- Give the sum of the `minimum_height' of all the children
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
					Result := Result + (ev_children @ i).minimum_height
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because the child did.
		do
			if value > child.minimum_height then
				child := the_child
				if shown and then (value > the_child.child_cell.height or not is_homogeneous) then
					initialize_display
				else
					if is_homogeneous then
						set_minimum_height (child.minimum_height * ev_children.count + total_spacing)
					else
						set_minimum_height (add_children_minimum_height + total_spacing)
					end
				end
			end
		end

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
   			-- Change the minimum width of the container because
   			-- the child changed his own minimum width.
   		do
 			set_minimum_width (value.max (minimum_width))
 		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add a child to the box, it also resize the box
   		do
			if child = Void or (child /= Void and then child_imp.minimum_height > child.minimum_height) then
				child := child_imp
			end
			ev_children.extend (child_imp)
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
