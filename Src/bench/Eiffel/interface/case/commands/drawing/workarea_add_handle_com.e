indexing

	description: 
		"Command to add a graphical handle to a relation.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_ADD_HANDLE_COM

inherit

	WORKAREA_MOVE_DATA_COM

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
			parent_group: GRAPH_GROUP;
			to_join: BOOLEAN;
			other: GRAPH_RELATION;
			handle_join: INTEGER;
			new_handle: HANDLE_DATA;
			add_shared_handle_undoable: ADD_SHARED_HANDLE_U;
			new_handle_undoable: ADD_HANDLE_U;
		do
			if moving then
				erase
				--if workarea = windows.screen.pointed_workarea then
					other := workarea.relation_figure_at (relative_x,
									relative_y);
					to_join := (other /= void) and
						(relation /= other);
					if to_join then
						to_join := (other.to_form =
								relation.to_form) or
							(other.from_form =
								relation.from_form);
						if to_join then
							handle_join := other.handle_at
								(relative_x, relative_y);
							to_join := (handle_join /= 0);
						end;
						if to_join then
							to_join := other.data.same_as (relation.data)
						end
					end;
					if to_join then
						!! add_shared_handle_undoable.make
							(other.data.break_points.i_th (handle_join),
								relation.data, handle - 1)
					else
						parent_group := workarea.cluster_at
								(relative_x, relative_y)
						if parent_group = void then
							parent_group := workarea
						end
						!!new_handle
						new_handle.set_x (align_grid(relative_x)-
								parent_group.local_x)
						new_handle.set_y (align_grid(relative_y)-
								parent_group.local_y)
						new_handle.put_in_cluster
								(parent_group.data)
						!! new_handle_undoable.make
							(relation, handle - 1, new_handle,
							start_rel_x, start_rel_y)
					end
				--end
			end
		    workarea.drawing_area.remove_motion_notify_commands
			workarea.drawing_area.remove_button_release_commands (1)
			relation := void
			moving := False
		ensure then
			relation = void
		end 

feature {NONE} -- Properties

	relation: GRAPH_RELATION;
			-- Relation in which we add a handle

	handle: INTEGER;
			-- Position of the new handle

	point1, point2: EC_COORD_XY
			-- Extremities of link's segment in which add the handle

	linkable1, linkable2: GRAPH_LINKABLE
			-- Linkable extremities of link's segment in which add the handle

feature {WORKAREA_SELECT_COM} -- Setting

	set_relation (new_relation: like relation; handle_nbr: like handle) is
			-- Set relation in which we add a handle
		require
			new_relation_exists: new_relation /= Void
			large_enough: handle_nbr >= 1 
		do
			relation := new_relation;
			handle := handle_nbr;
			
			if handle = 1 then
				-- handle in first position, first extremity is a linkable object
				linkable1 := relation.from_form;
				point1 := Void;
			else
				-- first extremity is the previous handle
				linkable1 := Void;
				point1 := relation.point (handle);
			end

			if relation.link_body.points.count = handle + 1 then
				-- handle in last position, second extremity is a linkable object
				linkable2 := relation.to_form;
				point2 := Void;
			else
				-- second extremity is the next handle
				linkable2 := Void;
				point2 := relation.point (handle+1)
			end
		ensure
			relation_correctly_set: relation = new_relation;
			handle_correctly_set: handle = handle_nbr;
			has_extremity_1: (point1 /= Void) xor (linkable1 /= Void) 
			has_extremity_2: (point2 /= Void) xor (linkable2 /= Void) 
		end 

feature {NONE} -- Implementation

	draw is
			-- Draw a segment during action.
		local
			rel_x, rel_y: INTEGER;
			pt: EC_COORD_XY
		do
			rel_x := align_grid (relative_x);
			rel_y := align_grid (relative_y)
			if point1 = Void then
				!! pt;
				pt.set (rel_x, rel_y);
				pt := linkable1.handle_to (pt);
				workarea.inverted_painter.draw_segment
					(pt.x, pt.y,
					rel_x, rel_y);
			else
				workarea.inverted_painter.draw_segment
					(point1.x, point1.y, 
					rel_x, rel_y);
			end;
			if point2 = Void then
				!! pt;
				pt.set (rel_x, rel_y);
				pt := linkable2.handle_to (pt);
				workarea.inverted_painter.draw_segment
					(pt.x, pt.y,
					rel_x, rel_y);
				
			else
				workarea.inverted_painter.draw_segment
					(point2.x, point2.y, 
					rel_x, rel_y)
			end
		end; -- draw

	erase is
			-- Erase the segment drawn during action.
		do
			draw
		end 

end -- class WORKAREA_ADD_HANDLE_COM
