
class TREE_ELEMENT 

inherit

	WINDOWS
	CONTEXT_STONE
	EB_TEXT_IMAGE
		rename
			make as text_image_create
		redefine
			contains, draw, select_figure, deselect
		end

creation

	make

feature 

	data: CONTEXT

	selected: BOOLEAN

	mfont: FONT is
		once
			if Result = Void then
				Result := font
			end
		end

	draw is
		do
			if selected then
				drawing.draw_rectangle (rect_center, string_width + 6,
						string_ascent + string_descent + 6, 0.0)
			end
			drawing.draw_image_text (base_left, text)
			if draw_circle then
				drawing.draw_arc (right_ref_point, 3, 3, 0.0, 360.0, 0.0, -1)
			end
			if parent_reference /= Void then
				drawing.draw_segment (reference_point, parent_reference)
			end
		end

	select_figure is
		do
			selected := True
			data.set_selected_color
			from
				data.child_start
			until
				data.child_offright
			loop
				data.child.tree_element.select_figure
				data.child_forth
			end
		end

	deselect is
		do
			data.deselect_color
			selected := False
			from
				data.child_start
			until
				data.child_offright
			loop
				data.child.tree_element.deselect
				data.child_forth
			end
		end

	
feature {NONE}

	reference_point, parent_reference: COORD_XY_FIG

	right_ref_point: COORD_XY_FIG

	
feature 

	show_children: BOOLEAN

	set_children_visibility (visibility: BOOLEAN) is
		do
			if show_children /= visibility then
				if show_children then
					data.hide_tree_elements
					show_children := False
				else
					show_children := True
					data.show_tree_elements
				end
			end
		end

	
feature {NONE}

	draw_circle: BOOLEAN

	rect_center: COORD_XY_FIG

	
feature 

	make (a_context: CONTEXT) is
		do
			show_children := True
			data := a_context
			text_image_create
			set_foreground_color (Resources.foreground_figure_color)
			set_background_color (Resources.background_figure_color)
			set_text (a_context.title_label)
			attach_drawing (tree)
			tree.append (Current)
		end

	
feature {NONE}

	contains (p: COORD_XY_FIG): BOOLEAN is
		local
			top_left_corner: COORD_XY_FIG
			bottom_right_corner: COORD_XY_FIG
		do
			top_left_corner := top_left
			bottom_right_corner := bottom_right
			Result := p.x >= top_left_corner.x and p.x <= bottom_right_corner.x and
						p.y >= top_left_corner.y and p.y <= bottom_right_corner.y
		end

	
feature 

	coord_calc: COORD_XY_FIG is
			-- Recompute the position of the tree_element in the
			-- context tree and the position of all the children
		local
			child_position: COORD_XY_FIG
			child_x, child_y: INTEGER
			min_y, max_y: INTEGER
			child: CONTEXT
		do
			Result := tree.current_position.duplicate
			child_x := Result.x + string_width + 40
			child_y := Result.y
			if show_children then
				draw_circle := False
				from
					data.child_start
				until
					data.child_offright
				loop
					child := data.child
					tree.set_new_position (child_x, child_y, child_x)
					child_position := child.tree_element.coord_calc
					if (child.left_sibling = Void) then
						min_y := child_position.y
					end
					if not (child.right_sibling = Void) then
						child_y := tree.current_position.y+20
					else
						child_y := tree.current_position.y
						max_y := child_position.y
					end
					data.child_forth
				end
				if data.arity /= 0 then
					Result.set_y ((min_y + max_y) // 2)
				end
			else
				draw_circle := (data.arity /= 0)
			end
			set_top_left (Result)
			rect_center := middle_center
			reference_point := middle_left
			reference_point.set_x (reference_point.x - 5)
			right_ref_point := middle_right
			tree.set_new_position (Result.x, child_y, right_ref_point.x)
			right_ref_point.set_x (right_ref_point.x + 5)
			if show_children then
				from
					data.child_start
				until
					data.child_offright
				loop
					data.child.tree_element.set_parent_reference (right_ref_point)
					data.child_forth
				end	
			end	
		end

	set_parent_reference (a_point: COORD_XY_FIG) is
		do
			parent_reference := a_point
		end

	expand_action is
		do
			if data.arity /= 0 then
				set_children_visibility (not show_children)
				tree.display (data)
			end
		end

end
