indexing

	description: 
		"Command for moving handles of a link on workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_HANDLE_COM 

inherit

	WORKAREA_MOVE_DATA_COM

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
--			handle_at: INTEGER;
--			parent_group: GRAPH_GROUP;
--			new_handle: COORD_XY_DATA;
--			to_join: BOOLEAN;
--			relation, other: GRAPH_RELATION;
--			other_h: HANDLE_DATA;
--			handle_join: INTEGER;
--			inherit_1, inherit_2: INHERIT_DATA;
--			move_handle_undoable: MOVE_HANDLE_U;
--			share_handle_undoable: SHARE_HANDLE_U;
		do
--			if moving then
--				erase;
--				if workarea = pointed_workarea then
--					other := workarea.relation_figure_at (relative_x,
--									relative_y);
--					to_join := (other /= void) and then
--						(not relations.has (other));
--					if to_join then
--						relation := relations.first;
--						to_join := (other.to_form = relation.to_form) or
--							(other.from_form = relation.from_form);
--						if to_join then
--							handle_join :=
--								other.handle_at (relative_x, relative_y);
--							to_join := (handle_join > 0)
--						end;
--						if to_join then
--							to_join := other.data.same_as (relation.data)
--						end
--					end;
--					if to_join then
--						!!share_handle_undoable.make
--							(other.data.break_points.i_th
--							(handle_join), handle, relations.datas)
--					else
--						parent_group :=
--						workarea.cluster_at
--							(relative_x, relative_y);
--						if parent_group = void then
--							parent_group := workarea
--						end;
--						!!new_handle;
--						new_handle.set_x
--							(align_grid (relative_x)-
--								parent_group.local_x);
--						new_handle.set_y
--							(align_grid (relative_y)-
--								parent_group.local_y);
--						new_handle.put_in_cluster (parent_group.data);
--						!!move_handle_undoable.make
--							(handle, new_handle)
--					end
--				end
--			end;
--			workarea.remove_button_motion_action (1, Current, void);
--			workarea.remove_button_release_action (1, Current, void);
--			remove_leave_and_enter_actions;
--			if Environment.is_motif then
--				Windows.restore_cursor;
--			else
--				workarea.ungrab;
--			end;
--			relations := void;
--			handle := void;
--			moving := false
		ensure then
			relations = void;
			handle = void
		end 

feature {NONE} -- Properties

	handle: HANDLE_DATA;
			-- Handle moved

	relations: GRAPH_REL_LIST [GRAPH_RELATION];
			-- Relation in which we add `handle'

	points: ARRAYED_LIST [EC_COORD_XY]
			-- Points

	link_points: ARRAYED_LIST [GRAPH_LINKABLE]
			-- Points

feature {WORKAREA_SELECT_COM} -- Setting

	set_handle (a_handle: like handle) is
			-- Set `handle' and `relations'.
		require
			a_handle /= void
		local
			handle_i: INTEGER;
			new_point: EC_COORD_XY;
			rel: GRAPH_RELATION;
		do
			handle := a_handle;
			!! relations.make;
			relations.merge (workarea.inherit_list.links_who_has (handle));
			relations.merge (workarea.cli_sup_list.links_who_has (handle));
			relations.merge (workarea.aggreg_list.links_who_has (handle));
			!! points.make (5);
			!! link_points.make (5);
			from
				relations.start
			until
				relations.after
			loop
				rel := relations.item;
				handle_i := rel.data.break_points.index_of
									(handle, 1);
				if handle_i = 1 then
						-- at start of relation
					if not link_points.has (rel.from_form) then
						link_points.extend (rel.from_form);
					end
				else
					new_point := rel.point (handle_i);
					if not has_same (points, new_point) then
						points.extend (new_point)
					end;
				end;
				if rel.link_body.points.count = handle_i+2 then
						-- at end of relation
					if not link_points.has (rel.to_form) then
						link_points.extend (rel.to_form);
					end
				else
					new_point := rel.point (handle_i+2);
					if not has_same (points, new_point) then
						points.extend (new_point)
					end;
				end;
				relations.forth
			end
		ensure
			handle = a_handle;
			relations /= void;
			not relations.empty
		end; -- set_handle

feature {NONE} -- Access

	has_same (list: ARRAYED_LIST [EC_COORD_XY]; other: EC_COORD_XY): BOOLEAN is
			-- Is there a point equal to other in list ?
		require
			list /= void;
			other /= void
		local
			old_cursor: CURSOR;
			item: EC_COORD_XY
		do
			old_cursor := list.cursor;
			from
				list.start
			until
				list.after or Result
			loop
				item := list.item;
				Result := (item.x = other.y and then item.y = other.y);
				list.forth
			end;
			list.go_to (old_cursor)
		end; 

feature {NONE} -- Implementation

	draw is
			-- Draw relations.
		local
			abs_x, abs_y, w_x, w_y: INTEGER;
			rel_x, rel_y: INTEGER;
			pt: EC_COORD_XY;
			linkable: GRAPH_LINKABLE
		do
			if pointed_workarea /= Void then
				if workarea = pointed_workarea.workarea then
					rel_x := align_grid (relative_x);
					rel_y := align_grid (relative_y);
					from
						points.start
					until
						points.after
					loop
						pt := points.item;
						workarea.inverted_painter.draw_segment
							(pt.x, pt.y, 
							rel_x, rel_y);
						points.forth
					end;
					from
						link_points.start
					until
						link_points.after
					loop
						linkable := link_points.item;
						!! pt;
						pt.set (rel_x, rel_y);
						pt := linkable.handle_to (pt);
						workarea.inverted_painter.draw_segment
							(pt.x, pt.y, 
							rel_x, rel_y);
						link_points.forth
					end
				end
			end
		end; -- draw
	
	erase is
			-- Erase relations
		do
			draw
		end 

end -- class WORKAREA_MOVE_HANDLE_COM
