indexing

	description: 
		"Command for moving a set of figures into a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_SET_COM 

inherit

	WORKAREA_MOVE_DATA_COM
	
	CONSTANTS

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; arg: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		do
	--		workarea.ungrab;
	--		workarea.remove_button_motion_action (1, Current, void);
	--		workarea.remove_button_release_action (1, Current, void);
	--		remove_leave_and_enter_actions;
	--		if moving then
	--			erase;
	--			if pointed_workarea /= Void then
	--				--move_data (relative_x-start_rel_x, relative_y-start_rel_y)
	--				move_data (absolute_x - pointed_workarea.real_x,
	--							absolute_y - pointed_workarea.real_y)
	--			end;
	--			moving := false
	--		end;
	--		Windows.restore_cursor
		end

feature {NONE} -- Properties

	data_moved: GRAPH_LIST [GRAPH_FORM];
			-- Cluster moved

	shared_handles: LINKED_LIST [HANDLE_DATA]
			-- handles which must move once

	cursor_set: BOOLEAN;

feature {WORKAREA_SELECT_COM, WORKAREA_MULTISELECT_COM} -- Setting

	set_data (value: like data_moved) is
			-- Set `data_moved'.
		require
			has_data: value /= void
		do
			data_moved := value
		ensure
			correctly_set: data_moved = value
		end -- set_data

feature {NONE} -- Implementation

	draw is
			-- Draw figures during the moving
		do
	--		if pointed_workarea /= Void then
	--			if pointed_workarea = workarea then
	--				data_moved.invert_skeleton (pointed_workarea.inverted_painter,
	--							relative_x-start_rel_x, 
	--							relative_y-start_rel_y)
	--			else
	--				data_moved.invert_skeleton (pointed_workarea.inverted_painter,
	--							absolute_x - pointed_workarea.real_x -
	--							start_rel_x, 
	--							absolute_y - pointed_workarea.real_y -
	--							start_rel_y)
	--			end;
	--			if cursor_set then
	--				if Environment.is_motif then
	--					Windows.set_move_cursor;
	--				else
	--					workarea.grab (Cursors.move_cursor)
	--				end;
	--				cursor_set := False
	--			end;
	--		else
	--			if not cursor_set then
	--				if Environment.is_motif then
	--					Windows.set_group_cursor;
	--				else
	--					workarea.grab (cursors.group_cursor)
	--				end;
	--				cursor_set := True;
	--			end
	--		end	
		end; -- draw

	erase is
			-- Erase figures during the moving
		do
			draw
		end 

feature {NONE} -- Access

	figures_is_valid (rel_x, rel_y: INTEGER): BOOLEAN is
				-- Is figure valid in relative
		local
			graph_link: GRAPH_LINKABLE
		do
			Result := True;
			from
				data_moved.start
			until
				data_moved.after or else
				not Result
			loop
				graph_link ?= data_moved.item;
				if graph_link /= Void then
					Result := graph_link.is_valid_in (rel_x, rel_y)
				end;
				data_moved.forth
			end
		end;

	figures_is_valid_in_other: BOOLEAN is
				-- Is figure valid in relative
		local
			graph_link: GRAPH_LINKABLE
		do
			Result := True;
			from
				data_moved.start
			until
				data_moved.after or else
				not Result
			loop
				graph_link ?= data_moved.item;
				if graph_link /= Void then

					if pointed_workarea /= Void then
						Result := graph_link.is_valid_in_other (pointed_workarea.workarea, 
									absolute_x, absolute_y)
					end
				end;
				data_moved.forth
			end
		end;

feature {NONE} -- Implementation

	move_data (rel_x, rel_y: INTEGER) is
			-- Move figures in `figures'
		require 
			workarea_exists: workarea /= Void;
			workarea.selected_figures /= Void;
		local
			moves_list: SORTED_TWO_WAY_LIST [MOVABLE_U];
			linkable: GRAPH_LINKABLE;
			relation: GRAPH_RELATION;
			move_figures_u: MOVE_FIGURES_U;
			change_cluster: REPARENT_MOVABLE_U;
			a_moving: MOVABLE_U;
			a_link_moving: LINK_MOVABLE_U;
			must_update_system_comp: BOOLEAN
		do
			if pointed_workarea /= Void then
				add_links;
				!! moves_list.make;
				!! shared_handles.make;
				from
					data_moved.start
				until
					data_moved.off
				loop
					linkable ?= data_moved.item;
					relation ?= data_moved.item;
					if relation /= Void and then
						not (workarea.has_visible_ancestor (data_moved,
								relation.from_form.data) and
						workarea.has_visible_ancestor (data_moved,
									relation.to_form.data))
					then
						if is_moving (relation.from_form) then
							if is_moving (relation.to_form) then
								if relation.data.break_points.empty then
									!!a_link_moving.make (relation.data);
									moves_list.extend (a_link_moving)
								else
									moves_list.merge
										(move_relation_data (
										rel_x, rel_y,
										relation))
								end
							else
								if relation.data.break_points.empty then
									!!a_link_moving.make (relation.data);
									moves_list.extend (a_link_moving)
								else
									moves_list.merge
										(move_relation_data (
										rel_x, rel_y,
										relation))
								end
							end
						else
							if is_moving (relation.to_form) then
								if relation.data.break_points.empty then
									!!a_link_moving.make (relation.data);
									moves_list.extend (a_link_moving)
								else
									moves_list.merge
										(move_relation_data (
										rel_x, rel_y,
										relation))
								end
							end
						end
					elseif linkable /= Void and then
					not workarea.has_visible_ancestor (data_moved, linkable.data)
					then
						a_moving := move_linkable_data (rel_x, rel_y, linkable);
						if a_moving /= Void then
							moves_list.extend (a_moving);
							change_cluster ?= a_moving;
							must_update_system_comp := change_cluster /= Void
						end;
					end;
					data_moved.forth
				end;
				if not moves_list.empty then
					if workarea /= pointed_workarea.workarea then
						workarea.unselect_all_without_update
					end
					!!move_figures_u.make (moves_list, must_update_system_comp);
				end;
			end
		end; -- move_data

	is_moving (a_form: GRAPH_LINKABLE): BOOLEAN is
			-- is 'a_form' moving on workarea ?
		require
			has_form: a_form /= Void
		do
			Result := workarea.has_visible_ancestor 
					(data_moved, a_form.data) or else
					data_moved.has (a_form);
		end; -- is_moving

	move_linkable_data (rel_x, rel_y: INTEGER; 
					linkable: GRAPH_LINKABLE): MOVABLE_U is
		local
			move_in_same_cluster: TRANSLATE_MOVABLE_U;
			move_in_other_cluster: REPARENT_MOVABLE_U;
			parent_group: GRAPH_GROUP;
			parent_cluster: GRAPH_CLUSTER;
			x_coord, y_coord: INTEGER;
			not_really_a_new_cluster: BOOLEAN
		do
			--x_coord := align_grid (linkable.local_x + rel_x);
			--y_coord := align_grid (linkable.local_y + rel_y);
			x_coord := align_grid (rel_x + linkable.local_x
										- start_rel_x);
			y_coord := align_grid (rel_y + linkable.local_y
										- start_rel_y);
			parent_group := pointed_workarea.cluster_at 
								(x_coord, y_coord);
			if  
				pointed_workarea.contains (x_coord, y_coord)
			then
				if (parent_group = Void) then
					parent_group := pointed_workarea
				else
					parent_cluster ?= parent_group;
					not_really_a_new_cluster := workarea.has_visible_ancestor
							(data_moved, parent_cluster.data) or
							data_moved.has (parent_cluster)
				end;
				if (parent_group = linkable.parent_group) or
					(parent_group.data = linkable.data) or
					not_really_a_new_cluster
				then
					if pointed_workarea.contains (x_coord, y_coord) then
						!!move_in_same_cluster.make (linkable.data,
								x_coord - linkable.local_x,
								y_coord - linkable.local_y);
						Result := move_in_same_cluster
					end;
				else
					if pointed_workarea.contains (x_coord, y_coord) then
						!!move_in_other_cluster.make (linkable.data,
								parent_group.data,
								x_coord - parent_group.local_x,
								y_coord - parent_group.local_y);
						Result := move_in_other_cluster
					end;
				end
			end
		end; -- move_linkable_data

	add_links is
			-- add interesting links which are not yet in 'data_moved'
		local
			links_moved: LINKED_LIST [RELATION_DATA];
			graph_linkable: GRAPH_LINKABLE;
			graph_relation: GRAPH_RELATION
		do
			!!links_moved.make;
			from
				data_moved.start
			until
				data_moved.after
			loop
				graph_linkable ?= data_moved.item;
				if graph_linkable /= Void then
					links_moved.append
						(graph_linkable.data.extern_inherit_links);
					links_moved.append
						(graph_linkable.data.extern_client_links)
				end;
				data_moved.forth
			end;
			data_moved.start;
			from
				links_moved.start
			until
				links_moved.after
			loop
				graph_relation ?= workarea.find (links_moved.item);
				if graph_relation /= Void and then
				not data_moved.has (graph_relation)
				then
					data_moved.extend (graph_relation)
				end;
				links_moved.forth
			end
		end; -- add_links

	move_relation_data (rel_x, rel_y: INTEGER; 
				relation: GRAPH_RELATION): LINKED_LIST [MOVABLE_U] is
		local
			move_handles_in_same_cluster: TRANSLATE_MOVABLE_U;
			move_handles_in_other_cluster: REPARENT_MOVABLE_U;
			parent_group: GRAPH_GROUP;
			parent_cluster: GRAPH_CLUSTER;
			x_coord, y_coord, x, y: INTEGER;
			fixed_handle, not_really_a_new_cluster: BOOLEAN;
			break_points: LINKED_LIST [HANDLE_DATA]
		do
			!!Result.make;
			from
				break_points := relation.data.break_points;
				break_points.start
			until
				break_points.after
			loop
				if break_points.item.is_being_used then
					if shared_handles.has (break_points.item) then
						fixed_handle := true
					else
						shared_handles.extend
							(break_points.item)
					end
				end;
				if not fixed_handle then
					x := relation.handle (break_points.index).x;
					y := relation.handle (break_points.index).y;
					x_coord := align_grid (rel_x + x - start_rel_x);
					y_coord := align_grid (rel_y + y - start_rel_y);
					if 
						pointed_workarea.contains (x_coord, y_coord) 
					then
						parent_group := pointed_workarea.cluster_at 
											(x_coord, y_coord);
						if parent_group = Void then
							parent_group := pointed_workarea
						else
							parent_cluster ?= parent_group;
							not_really_a_new_cluster :=
								workarea.has_visible_ancestor (data_moved,
									parent_cluster.data) or
								data_moved.has (parent_cluster)
						end;
						if 	parent_group.data = 
							relation.data.break_points.item.parent_cluster or
							not_really_a_new_cluster
						then
							!!move_handles_in_same_cluster.make
								(break_points.item,
								x_coord - x, 
								y_coord - y);
							Result.extend (move_handles_in_same_cluster)
						else
							!!move_handles_in_other_cluster.make
								(break_points.item,
								parent_group.data,
								x_coord - parent_group.local_x,
								y_coord - parent_group.local_y);
							Result.extend (move_handles_in_other_cluster)
						end
					end
				else
					fixed_handle := false
				end;
				break_points.forth
			end
		end 

end -- class WORKAREA_MOVE_SET_COM
