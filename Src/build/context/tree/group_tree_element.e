indexing
	description: "Group tree element: represents a group context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class GROUP_TREE_ELEMENT 

inherit

	TREE_ELEMENT
		redefine
			data,
--			coord_calc, expand_action,
			select_figure, deselect
		end

creation

	make

feature 

	data: GROUP_C

-- 	coord_calc: COORD_XY_FIG is
-- 			-- Recompute the position of the tree_element in the
-- 			-- context tree and the position of all the children
-- 		local
-- 			child_position: COORD_XY_FIG
-- 			child_x, child_y: INTEGER
-- 			child: CONTEXT
-- 			min_y, max_y: INTEGER
-- 			list: LINKED_LIST [CONTEXT]
-- 		do
-- 			Result := tree.current_position.duplicate
-- 			child_x := Result.x + string_width + 40
-- 			child_y := Result.y
-- 			list := data.subtree
-- 			if show_children then
-- 				draw_circle := False
-- 				from
-- 					list.start
-- 				until
-- 					list.after
-- 				loop
-- 					child := list.item
-- 					tree.set_new_position (child_x, child_y, child_x)
-- 					child_position := child.tree_element.coord_calc
-- 					if list.isfirst then
-- 						min_y := child_position.y
-- 					end
-- 					if not list.islast then
-- 						child_y := tree.current_position.y+20
-- 					else
-- 						child_y := tree.current_position.y
-- 						max_y := child_position.y
-- 					end
-- 					list.forth
-- 				end
-- 				if list.count /= 0 then
-- 					Result.set_y ((min_y + max_y) // 2)
-- 				end
-- 			else
-- 				draw_circle := (list.count /= 0)
-- 			end
-- 			set_top_left (Result)
-- 			rect_center := middle_center
-- 			reference_point := middle_left
-- 			reference_point.set_x (reference_point.x - 5)
-- 			right_ref_point := middle_right
-- 			tree.set_new_position (Result.x, child_y, right_ref_point.x)
-- 			right_ref_point.set_x (right_ref_point.x + 5)
-- 			if show_children then
-- 				from
-- 					list.start
-- 				until
-- 					list.after
-- 				loop
-- 					list.item.tree_element.set_parent_reference (right_ref_point)
-- 					list.forth
-- 				end
-- 			end
-- 		end

	select_figure is
		local
			a_list: LINKED_LIST [CONTEXT]
		do
			selected := True
			a_list :=  data.subtree
			data.set_selected_color
			from
				a_list.start
			until
				a_list.after
			loop
				a_list.item.tree_element.select_figure
				a_list.forth
			end
		end

	deselect is
		local
			a_list: LINKED_LIST [CONTEXT]
		do
			selected := False
			a_list :=  data.subtree
			data.deselect_color
			from
				a_list.start
			until
				a_list.after
			loop
				a_list.item.tree_element.deselect
				a_list.forth
			end
		end

-- 	expand_action is
-- 		do
-- 			if data.subtree.count /= 0 then
-- 				set_children_visibility (not show_children)
-- 				tree.display (data)
-- 			end
-- 		end

end -- class GROUP_TREE_ELEMENT

