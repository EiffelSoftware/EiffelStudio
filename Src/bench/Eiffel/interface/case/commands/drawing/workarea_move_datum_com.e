indexing

	description: 
		"Command for moving and dragging one figure on workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_DATUM_COM 

inherit

	WORKAREA_MOVE_DATA_COM

	CONSTANTS

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
			w_area: WORKAREA;
			namable: NAMABLE;
		do
			 workarea.drawing_area.remove_motion_notify_commands
			workarea.drawing_area.remove_button_release_commands (1)
			--remove_leave_and_enter_actions;
			if moving then
				erase
				if workarea /= Void then
					if workarea.data /= data_moved.data then
						--move_data (absolute_x - workarea.x,
						--			absolute_y - workarea.y)
						move_data (butrel_data.x, butrel_data.y) -- New
					end
				end
			end
			moving := FALSE
		end

feature {NONE} -- Properties

	points: ARRAYED_LIST [EC_COORD_XY];
			-- Points to be drawn when linkable is moved

	link_points: ARRAYED_LIST [GRAPH_LINKABLE];
			-- Points from linkable to be drawn when linkable is moved

	data_moved: GRAPH_LINKABLE;
			-- Cluster moved

	cursor_set: BOOLEAN;
			-- Is the Cursor set?

feature {WORKAREA_SELECT_COM} -- Setting
	
	set_data (value: like data_moved) is
			-- Set `data_moved'.
		require
			has_data: value /= void
		local
			relations: GRAPH_REL_LIST [GRAPH_RELATION];
			rel: GRAPH_RELATION;
			show_rel: BOOLEAN
		do
			data_moved := value;
			!! relations.make;
			if not System.is_inheritance_hidden then
				relations.merge (workarea.inherit_list.links_who_has_link 
								(data_moved));
			end;
			if not System.is_client_hidden then
				relations.merge (workarea.cli_sup_list.links_who_has_link 
								(data_moved));
			end;
			if not System.is_aggreg_hidden then
				relations.merge (workarea.aggreg_list.links_who_has_link 
								(data_moved));
			end;
			!! points.make (relations.count);
			!! link_points.make (relations.count);
			from
				show_rel := System.show_all_relations;
				relations.start
			until
				relations.after
			loop
				rel := relations.item;
				if rel.data.is_implementation = show_rel then
					if rel.link_body.points.count = 2 then
						if rel.to_form = data_moved then
							link_points.extend (rel.from_form)
						else
							link_points.extend (rel.to_form)
						end
					else
						points.extend (rel.closest_point_to (data_moved));
					end
				end;
				relations.forth
			end
		ensure
			correctly_set: data_moved = value
		end; -- set_data

feature {NONE} -- Implementation

	old_rel_x : INTEGER
	
	draw is
			-- Draw an icon during moving.
		local
			x0, y0: INTEGER;
			pt, pt2: EC_COORD_XY;
			abs_x, abs_y, rel_x, rel_y: INTEGER;
			not_al_rel_x, not_al_rel_y: INTEGER;
			linkable: GRAPH_LINKABLE
			work_com : CLUSTER_WINDOW_NAVIGATION_COM 
			value : INTEGER	

			scrolled_window	: EC_SCROLLED_W
			scrolled_window_implementation	: EC_SCROLLED_W_IMP

		do
			old_rel_x := relative_x
			if workarea /= Void then
				not_al_rel_x := relative_x-start_rel_x;
				not_al_rel_y := relative_y-start_rel_y;
				rel_x := align_grid (not_al_rel_x);
				rel_y := align_grid (not_al_rel_y);
				if workarea.workarea = workarea then
					data_moved.invert_skeleton (
								workarea.inverted_painter,
								not_al_rel_x, not_al_rel_y);
					from
						points.start
					until
						points.after
					loop
						pt := points.item;
						pt2 := data_moved.final_point_at_position 
									(pt, not_al_rel_x, not_al_rel_y, True)
						workarea.inverted_painter.draw_segment
							(pt.x, pt.y,
							pt2.x, pt2.y);
						points.forth
					end;
					from
						link_points.start
					until
						link_points.after
					loop
						linkable := link_points.item;
						!! pt;
						pt.set (not_al_rel_x, not_al_rel_y);
						pt := pt + data_moved.center;
						pt.set (align_grid (pt.x), align_grid (pt.y));
						pt := linkable.handle_to (pt);
						pt2 := data_moved.final_point_at_position 
								(pt, not_al_rel_x, not_al_rel_y, True)
						workarea.inverted_painter.draw_segment
							(pt.x, pt.y,
							pt2.x, pt2.y);
						link_points.forth
					end;			
				else
					data_moved.invert_skeleton (workarea.inverted_painter, absolute_x - workarea.local_x - start_rel_x, absolute_y - workarea.local_y - start_rel_y)
				end
			end
		end

	erase is
			-- Erase an icon during moving.
		do
			draw
		end;

feature {NONE} -- Implementation

	move_data (rel_x, rel_y: INTEGER) is
			-- Move `data_moved`.
		local
			move_figure: TRANSLATE_FIGURE_U;
			reparent_figure: REPARENT_FIGURE_U;
			parent_group: GRAPH_GROUP;
			x_coord, y_coord : INTEGER
		do
			x_coord := align_grid (data_moved.local_x - start_rel_x + rel_x);
			y_coord := align_grid (data_moved.local_y - start_rel_y + rel_y);
			parent_group := workarea.cluster_at (x_coord, y_coord);
			if parent_group = void then
				parent_group := workarea
			end
			--if pointed_workarea /= Void then
			--	if workarea /= pointed_workarea.workarea then
			--		workarea.unselect_all_without_update
			--	end
			--end
			if (parent_group = data_moved.parent_group) or
				(parent_group.data = data_moved.data) then
				create move_figure.make (data_moved.data,
					x_coord-data_moved.local_x,
					y_coord-data_moved.local_y)
			else
				create reparent_figure.make (data_moved.data,
					parent_group.data,
					x_coord-parent_group.local_x,
					y_coord-parent_group.local_y)
			end;
		end 

end -- class WORKAREA_MOVE_DATUM_COM
