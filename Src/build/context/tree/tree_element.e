
class TREE_ELEMENT 

inherit

	WINDOWS
		rename
			init_toolkit as unused
		export
			{NONE} all
		end;
	CONTEXT_STONE;
	EB_TEXT_IMAGE
		rename
			make as text_image_create
		redefine
			contains, draw, select_figure, deselect
		end;
	COLORS
		export
			{NONE} all
		end


creation

	make

	
feature 

	draw is
		do
			if selected then
				drawing.draw_rectangle (rect_center, string_width + 6,
						string_ascent + string_descent + 6, 0.0);
			end;
			drawing.draw_image_text (base_left, text);
			if draw_circle then
				drawing.draw_arc (right_ref_point, 3, 3, 0.0, 360.0, 0.0, -1);
			end;
			if not (parent_reference = Void) then
				drawing.draw_segment (reference_point, parent_reference);
			end;
		end;

	select_figure is
		do
			selected := True;
			from
				original_stone.child_start
			until
				original_stone.child_offright
			loop
				original_stone.child.tree_element.select_figure;
				original_stone.child_forth
			end;
		end;

	deselect is
		do
			selected := False;
			from
				original_stone.child_start
			until
				original_stone.child_offright
			loop
				original_stone.child.tree_element.deselect;
				original_stone.child_forth
			end;
		end;

	
feature {NONE}

	selected: BOOLEAN;

	reference_point, parent_reference: COORD_XY_FIG;

	right_ref_point: COORD_XY_FIG;

	
feature 

	show_children: BOOLEAN;

	set_children_visibility (visibility: BOOLEAN) is
		do
			if show_children /= visibility then
				if show_children then
					original_stone.hide_tree_elements;
					show_children := False;
				else
					show_children := True;
					original_stone.show_tree_elements;
				end;
			end;
		end;

	
feature {NONE}

	draw_circle: BOOLEAN;

	rect_center: COORD_XY_FIG;

	
feature 

	make (a_context: CONTEXT) is
		do
			show_children := True;
			original_stone := a_context;
			text_image_create;
			set_foreground_color (black);
			set_background_color (white);
			set_text (a_context.label);
			attach_drawing (tree);
			tree.append (Current);
		end;

	
feature {NONE}

	contains (p: COORD_XY_FIG): BOOLEAN is
		local
			top_left_corner: COORD_XY_FIG;
			bottom_right_corner: COORD_XY_FIG;
		do
			top_left_corner := top_left;
			bottom_right_corner := bottom_right;
			Result := p.x >= top_left_corner.x and p.x <= bottom_right_corner.x and
						p.y >= top_left_corner.y and p.y <= bottom_right_corner.y
		end;

	
feature 

	coord_calc: COORD_XY_FIG is
			-- Recompute the position of the tree_element in the
			-- context tree and the position of all the children
		local
			child_position: COORD_XY_FIG;
			child_x, child_y: INTEGER;
			min_y, max_y: INTEGER;
			child: CONTEXT;
		do
			Result := tree.current_position.duplicate;
			child_x := Result.x + string_width + 40;
			child_y := Result.y;
			if show_children then
				draw_circle := False;
				from
					original_stone.child_start
				until
					original_stone.child_offright
				loop
					child := original_stone.child;
					tree.set_new_position (child_x, child_y, child_x);
					child_position := child.tree_element.coord_calc;
					if (child.left_sibling = Void) then
						min_y := child_position.y;
					end;
					if not (child.right_sibling = Void) then
						child_y := tree.current_position.y+20;
					else
						child_y := tree.current_position.y;
						max_y := child_position.y;
					end;
					original_stone.child_forth;
				end;
				if original_stone.arity /= 0 then
					Result.set_y ((min_y + max_y) // 2);
				end;
			else
				draw_circle := (original_stone.arity /= 0);
			end;
			set_top_left (Result);
			rect_center := middle_center;
			reference_point := middle_left;
			reference_point.set_x (reference_point.x - 5);
			right_ref_point := middle_right;
			tree.set_new_position (Result.x, child_y, right_ref_point.x);
			right_ref_point.set_x (right_ref_point.x + 5);
			if show_children then
				from
					original_stone.child_start
				until
					original_stone.child_offright
				loop
					original_stone.child.tree_element.set_parent_reference (right_ref_point);
					original_stone.child_forth;
				end;	
			end;	
		end;

	set_parent_reference (a_point: COORD_XY_FIG) is
		do
			parent_reference := a_point;
		end;

	select_action is
		do
			if original_stone.arity /= 0 then
				set_children_visibility (not show_children);
				tree.display (original_stone);
			end;
		end;

	-- *****************
	-- * Stone Section *
	-- *****************

	original_stone: CONTEXT;

	source: WIDGET is
		do
		end;

	symbol: PIXMAP is
		do
			Result := original_stone.symbol
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	entity_name: STRING is
		do
			Result := original_stone.entity_name
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

end
