indexing

	description: 
		"Factorization of graphical characteristics%
		%for relations representation.";
	date: "$Date$";
	revision: "$Revision $"

deferred class GRAPH_RELATION 

inherit

	SINGLE_MATH
		undefine
			is_equal
		end

	GRAPH_FORM
		redefine
			data, unselect, select_it
		end

	OBSERVER
		rename
			update as observer_update
		undefine
			is_equal
		end

feature -- Updates

	observer_update is
			-- Update the drawing, according to data.
		do
			workareas.change_data(data)
			set_color
			draw
		end

feature --  Properties

	data: RELATION_DATA
			-- Data associated with current entity

	order: INTEGER is 1
			-- Precedence of 'Current' as graphical entity

	stone: RELATION_STONE is
			-- Stone associated with Current
		do
			Result := data.stone
		end;

feature -- Graphical components

	closure: EC_CLOSURE;
			-- closure of current relation

	from_point: EC_COORD_XY;
			-- Point on 'from_form' in front of 'start'

	to_point: EC_COORD_XY;
			-- Point on 'to_form' in front of 'final' arrow head

	link_body: EC_LINE;
			-- Body of arrow representing current relation

	link_head: EC_ARROW_HEAD;
			-- Head of arrow representing current relation

	handles: ARRAYED_LIST [EC_HANDLE];
			-- Handles of arrow representing current relation

	active_triangles: ARRAY [EC_ACTIVE_TRIANGLE];
			-- Triangles of link's direction management

	origin: EC_COORD_XY is
			-- origin a the inheritance link.
		do
			Result := link_body.origin
		end; -- origin

	from_form: GRAPH_LINKABLE is
		deferred
		end; -- from_form

	to_form: GRAPH_LINKABLE is
		deferred
		end -- to_form

	are_active_triangles_shown: BOOLEAN is
			-- True if there's two points, and if the line is neither
			-- horizontal neither vertical and is selected
		do
			Result := selected and then can_have_active_triangle;
		end

feature -- Access

	start: EC_COORD_XY is
			-- First point of arrow representing current relation
		do
			Result := link_body.start
		end; 

	final: EC_COORD_XY is
			-- Last point of arrow representing current relation
		do
			Result := link_body.final
		end;

	handle_has (c: EC_COORD_XY): BOOLEAN is
			-- Does coord `c' contain in handles?
		do
			from
				handles.start
			until
				handles.after or else Result
			loop
				Result := handles.item = c;
				handles.forth
			end
		end;

	point (pointno: INTEGER): EC_COORD_XY is
			-- Point number 'no`
		require
			small_enough: pointno >= 1;
			large_enough: pointno <= link_body.points.count
		do
			Result := link_body.points.i_th (pointno).duplicate
		end; 

	associated_with (a_linkable: GRAPH_LINKABLE): BOOLEAN is
			-- Can this link be modified when `a_linkable' is modified ?
		require
			a_linkable /= void
		local
			old_pos: INTEGER;
			data_list: LIST [COORD_XY_DATA]
		do
			Result := data.f_rom.descendant_of (a_linkable.data);
			if not Result then
				Result := data.t_o.descendant_of (a_linkable.data)
			end;
			if not Result then
				data_list := data.break_points;
				old_pos := data_list.index;
				from
					data_list.start
				until
					data_list. after or Result
				loop
					Result :=
					data_list.item.parent_cluster.descendant_of
						(a_linkable.data);
					data_list.forth
				end;
				data_list.go_i_th (old_pos)
			end
		end;

	closest_point_to (linkable: GRAPH_LINKABLE): EC_COORD_XY is
		require
			more_than_two_points: link_body.points.count > 2
		do
			if to_form = linkable then
				Result := link_body.points.i_th (link_body.points.count - 1)
			else 
				Result := link_body.points.i_th (2)
			end
		ensure
			valid_result: Result /= Void
		end;

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			tmp_point: EC_COORD_XY
		do
			!!tmp_point;
			tmp_point.set (x_coord, y_coord);
			if link_body.contains (tmp_point) then
				Result := Current
			elseif (are_active_triangles_shown and then
					(active_triangles.item 
						(1).contains_xy (x_coord, y_coord) or else
					active_triangles.item
						(2).contains_xy (x_coord, y_coord)))
			then
				Result := Current
			end;
		end; 

	handle_at (x_coord, y_coord: INTEGER): INTEGER is
			-- Handle pointed by `x_coord' and `y_coord'
			-- 0 if no handle is pointed
		do
			Result := link_body.point_at (x_coord, y_coord);
			if Result /= 0 then
				Result := Result - 1
			end
			if Result > data.break_points.count then
				Result := 0
			end
		ensure
			Result >= 0;
			Result <= link_body.points.count
		end; -- handle_at

	segment_at (x_coord, y_coord: INTEGER): INTEGER is
			-- Segment pointed by `x_coord' and `y_coord'
		do
			Result := link_body.segment_at (x_coord, y_coord);
		ensure
			Result >= 0;
			Result <= link_body.points.count-1
		end -- segment_at

	handle (nb: INTEGER): EC_HANDLE is
			-- Handle number 'nb' of current relation
		require
			small_enough: nb >= 0;
			large_enough: nb <= handles.count + 1
		do
				--| Ignore first handle
			Result := handles.i_th (nb + 1)
		end; 

	handle_data (nb: INTEGER): HANDLE_DATA is
			-- Handle data number 'nb' of current relation
		do
			Result := data.break_points.i_th (nb)
		end;

	handle_position (is_reverse: BOOLEAN; c: EC_COORD_XY): INTEGER is
			-- Handle position for handle `c'
		require
			valid_c: c /= Void;
			has_c: handle_has (c) or else from_form.center = c or
					else to_form.center = c
		do
			if is_reverse then
				if to_form.center = c then
					Result := 1
				elseif from_form.center = c then
					Result := handles.count
				else
					from
						handles.start;
					until
						Result > 0 or handles.after
					loop
						if handles.item = c then
							Result := handles.index
						end;
						handles.forth
					end;
					Result := handles.count + 1 - Result
				end
			else
				if to_form.center = c then
					Result := handles.count
				elseif from_form.center = c then
					Result := 1
				else
					from
						handles.start;
					until
						Result > 0 or handles.after
					loop
						if c = handles.item then
							Result := handles.index
						end;
						handles.forth
					end;
				end
			end
		ensure
			valid_result: Result > 0 and then Result <= handles.count
		end;

feature -- Setting

	attach_workarea (a_workarea: WORKAREA) is
			-- Attach a workarea to the figure
		require else
			a_workarea_exists: not (a_workarea = Void)
		do
			link_body.attach_drawing (a_workarea);
			link_head.attach_drawing (a_workarea);
			attach_attributes_drawing (a_workarea)
		ensure then
			workarea_correctly_set: a_workarea = workarea
		end; -- attach_workarea

feature -- Output

	draw_in_and_update_list (clip_closure: EC_CLOSURE;
					list: LINKED_LIST [EC_DOUBLE_LINE]) is
			-- Draw the graphical representation in the analysis window
			-- if in clear area `clip'.
		require
			valid_clip: clip_closure /= Void;
		do
		end;

	draw_border, draw is
			-- Display client-supplier link in analysis view.
		do
			link_body.draw;
			link_head.draw;
			draw_attributes
		end;  

	select_it is
			-- Select Current graphical figure.
		do
			recompute_handles_closure;
			closure.merge (handles_closure);
			if can_have_active_triangle then
				build_active_triangles;
				closure.merge (active_triangles.item (1).closure);
				closure.merge (active_triangles.item (2).closure)

			end;
			selected := true;
			workarea.selected_figures.add_form (Current);
			update_clip_area
		end;

	unselect is
			-- Unselect Current graphical figure.
		do
			recompute_handles_closure;
			closure.merge (handles_closure);
			if can_have_active_triangle then
				closure.merge (active_triangles.item (1).closure);
				closure.merge (active_triangles.item (2).closure)
			end;
			erase;
			selected := false;
			workarea.selected_figures.start;
			workarea.selected_figures.prune (Current);
			update_clip_area
		end;

	erase_drawing is
			-- Erase current relation.
		do
			erase_attributes;
			link_body.erase;
			link_head.erase
		end; -- erase

	invert_skeleton (painter: PATCH_PAINTER; origin_x, origin_y: INTEGER) is
			-- Invert the relation's skeleton.
			-- Draw on `painter' as if the origin is at
			-- (`origin_x', `origin_y').
		do
		end;

feature -- Update

	update_form is
			-- Update the link according to the
			-- corresponding entity.
		do
			build
		end; 

	build is
			-- Build current relation
		do
			build_link_body;
			link_head.build (final,
				link_body.points.i_th (link_body.points.count - 1));
			build_attributes;
			recompute_closure
		end;

feature {NONE} -- Implementation

	recompute_closure is
			-- Recalculate relation's closure
		do
			link_body.recompute_closure;
			link_head.recompute_closure;
			recompute_attributes_closure
			closure := link_body.closure;
			closure.merge (link_head.closure);
			closure.merge (attributes_closure)
		end 

	build_link_body is
			-- Build the body of arrow representing current relation
		local
			list_data: LINKED_LIST [HANDLE_DATA];
			list_graph: LINKED_LIST [EC_COORD_XY];
			start_point, final_point,tmp_point,
			new_point: EC_COORD_XY;
			ref_cluster: GRAPH_GROUP
		do
			list_data := data.break_points;
			list_graph := link_body.points;
			from
			until
				list_data.count + 2 = list_graph.count
			loop
				if list_data.count + 2 > list_graph.count then
					!!new_point;
					list_graph.start;
					list_graph.put_right (new_point)
				else
					list_graph.start;
					list_graph.forth;
					list_graph.remove
				end
			end;
			from
				list_data.start;
				list_graph.start;
				list_graph.forth;
			until
				list_data. after
			loop
				ref_cluster := workarea.find_graph_group
							(list_data.item.parent_cluster);
				if ref_cluster /= Void then
					list_graph.item.set (ref_cluster.local_x +
								list_data.item.x,
								ref_cluster.local_y +
								list_data.item.y)
				end;
				list_data.forth;
				list_graph.forth
			end;
			if link_body.points.count = 2 then
				!!start_point;
				!!final_point;
				start_point.set (from_form.center.x, from_form.center.y);
				final_point.set (to_form.center.x, to_form.center.y);
				final_point := to_form.handle_to (start_point) --final_point); -- start_point before pascalf
				start_point := from_form.handle_to (final_point) -- )  -- final_point before pascalf
			else
				start_point := from_form.handle_to (list_graph.i_th (2));
				final_point := to_form.handle_to (list_graph.i_th
								(list_graph.count - 1))
			end;
			start.set (start_point.x, start_point.y);
			final.set (final_point.x, final_point.y);
			from_point.set (start.x, start.y);
			to_point.set (final.x, final.y);
			new_point := link_head.base (link_body.points.i_th
						(link_body.points.count - 1), final);
			final.set (new_point.x, new_point.y);
		end;

	build_attributes is
			-- Build attributes of standard relation
		do
			build_handles;
			if can_have_active_triangle then
				build_active_triangles
			end;
		end;

	draw_attributes is
			-- Draw attributes of standard relation
		do
			if are_active_triangles_shown then
				active_triangles.item (1).draw;
				active_triangles.item (2).draw
			end;
			if selected then
				draw_handles
				if can_have_active_triangle then
					active_triangles.item (1).draw;
					active_triangles.item (2).draw
				end
			end
		end; 

	erase_attributes is
			-- Erase attributes of standard relation
		do
			if selected then
				erase_handles
				if can_have_active_triangle then
					active_triangles.item (1).erase;
					active_triangles.item (2).erase
				end;
			end;
		end;

	attach_attributes_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a_drawing to attributes of standard relation
		do
			active_triangles.item (1).attach_drawing (a_drawing);
			active_triangles.item (2).attach_drawing (a_drawing);
			attach_handles_drawing (a_drawing)
		end; -- attach_attributes_drawing

	recompute_attributes_closure is
			-- Recompute the closure of standard relation's attributes
		do
			if selected then
				recompute_handles_closure;
				if can_have_active_triangle then
					active_triangles.item (1).recompute_closure;
					active_triangles.item (2).recompute_closure
				end
			end;
		end; -- recompute_attributes_closure

	attributes_closure: EC_CLOSURE is
			-- Closure of current relation's standard attributes
		do
			!!Result.make;
			if selected then
				Result.merge (handles_closure);
				if can_have_active_triangle then
					Result.merge (active_triangles.item (1).closure);
					Result.merge (active_triangles.item (2).closure)
				end
			end;
		end -- attributes_closure

	make_relation (a_workarea: WORKAREA) is
			-- Make the graphical representation of current relation
		require
			has_workarea: a_workarea /= Void
		do
			!! from_point
			!! to_point
			make_link_head
			make_attributes
			attach_workarea (a_workarea);
			selected := False
			build
			set_color
			observer_management.add_observer(data, Current)
		end; -- make_relation

	make_link_head is
			-- Make the head of arrow representing current relation
		deferred
		end; -- make_link_head

	make_attributes is
			-- Make the attributes of standard relation
		do
			make_handles;
			make_active_triangles;
		end -- make_attributes

	make_active_triangles is
			-- Make the active triangles
		local
			an_active_triangle: EC_ACTIVE_TRIANGLE
		do
			!!active_triangles.make (1, 2);
			!!an_active_triangle.make;
			active_triangles.put (an_active_triangle, 1);
			!!an_active_triangle.make;
			active_triangles.put (an_active_triangle, 2)
		ensure
			has_active_triangles: (active_triangles /= Void) and
						(active_triangles.count = 2)
		end; -- make_active_triangles
			
	build_active_triangles is
			-- Build active triangles of current relation
		local
			midx, midy: INTEGER;
			dx, dy: INTEGER;
			a: REAL
		do
			midx := (start.x + final.x) // 2;
			midy := (start.y + final.y) // 2;
			dx := final.x - start.x;
			dy := final.y - start.y;
			if dx = 0 then
				if 0 < dy then
					a := pi / 2
				else
					a := -pi / 2
				end
			else
				a := -arc_tangent (dy / dx);
				if 0 < dx then
					a := a + pi
				end;
			end;
			active_triangles.item (1).set (midx, midy + 11, -7, a,
							midx, midy);
			active_triangles.item (2).set (midx, midy - 11, +7, a,
							midx, midy)
		end; -- build_active_triangles

	can_have_active_triangle: BOOLEAN is
			-- True if there's two points, and if the line is neither
			-- horizontal neither vertical
		do
			if link_body.points.count = 2 then
				Result := (final.x - start.x) *
					(final.y - start.y) /= 0
			end
		ensure
			must_two_points_to_be_shown :
					Result implies (link_body.points.count = 2)
		end;

	make_handles is
			-- Make first and last handle.
		local
			first, last: EC_HANDLE;
		do
			!! first.make (8);
			!! last.make (8);
			!! handles.make (2);
			handles.extend (first);
			handles.extend (last)
		end; -- make_handles

	build_handles is
			-- Build 'handles'
		local
			list_data: LINKED_LIST [HANDLE_DATA];
			new_handle: EC_HANDLE;
			ref_cluster: GRAPH_GROUP
		do
			handles.first.set (from_point.x, from_point.y);
			handles.last.set (to_point.x, to_point.y);
			list_data := data.break_points;
			from
			until
				list_data.count = handles.count - 2
			loop
				if list_data.count > handles.count - 2 then
					!! new_handle.make (6);
					new_handle.attach_drawing (workarea);
					handles.start;
					handles.put_right (new_handle);
				else
					handles.start;
					handles.forth;
					handles.remove
				end
			end;
			from
				list_data.start;
				handles.start;
						-- Skip first handle.
				handles.forth;
			until
				list_data.after
			loop
				ref_cluster := workarea.find_graph_group
							(list_data.item.parent_cluster);
				if ref_cluster /= Void then
					handles.item.set (ref_cluster.local_x +
								list_data.item.x,
							ref_cluster.local_y +
								list_data.item.y)
				end;
				list_data.forth;
				handles.forth
			end
		ensure
			handles_set: handles.count = data.break_points.count + 2
		end; 

	draw_handles is
			-- Draw boxes around points of 'link_body'
		require
			selected: selected
		do
			from
				handles.start; 
			until
				handles.after
			loop
				handles.item.draw;
				handles.forth;
			end
		end; -- draw_handles

	erase_handles is
			-- Erase boxes drawn by `draw_handles'
		require
			selected: selected
		do
			from
				handles.start;
			until
				handles.after
			loop
				handles.item.erase;
				handles.forth;
			end
		end; 

	attach_handles_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach drawing area to handles
		require
			has_drawing: a_drawing /= Void
		do
			from
				handles.start
			until
				handles.after
			loop
				handles.item.attach_drawing (a_drawing);
				handles.forth
			end
		end; -- attach_handles_drawing

	recompute_handles_closure is
			-- Recompute the closure of handles
		do
			from
				handles.start
			until
				handles.after
			loop
				handles.item.recompute_closure;
				handles.forth
			end
		end; -- recompute_handles_closure

	handles_closure: EC_CLOSURE is
			-- Closure of handles
		do
			!!Result.make;
			from
				handles.start
			until
				handles.after
			loop
				Result.merge (handles.item.closure);
				handles.forth
			end
		end; -- handles_closure


	set_color is
		local
			a_color: EV_COLOR;
			colorable: COLORABLE
		do
			a_color := data.color
			if a_color = Void then
				!! a_color.make_rgb(255,255,0)
			end
			link_body.set_color (a_color)
			link_head.set_color (a_color)
			from
				handles.start
			until
				handles.after
			loop
				handles.item.set_color (a_color)
				handles.forth
			end;
			active_triangles.item (1).set_color (a_color)
			active_triangles.item (2).set_color (a_color)
		end;

invariant

	has_link_body: link_body /= Void;
	has_link_head: link_head /= Void;
	has_handles: handles /= Void;
	has_triangles: active_triangles /= Void	;

end -- class GRAPH_RELATION
