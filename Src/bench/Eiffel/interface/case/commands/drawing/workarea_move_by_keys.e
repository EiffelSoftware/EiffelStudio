indexing

	description: 
		"Command associated to the workarea. Moves the currently %
		%selected object(s), in direction and speed specified %
		%at the creation of Current command.";
	date: "$Date$";
	revision: "$Revision $"

class 
	WORKAREA_MOVE_BY_KEYS

inherit
	WORKAREA_COMMAND
		rename
			make as wa_com_make	
		end

	ALIGN_GRID 

creation

	make, make_up, make_down, make_left, make_right

feature -- Initialization

	make (wa: like workarea; dx, dy: like delta_x) is
			-- Create a command that executes moves as specified
			-- by the variations `dx' and `dy'
		do
			wa_com_make (wa)
			delta_y := dy
			delta_x := dx
		end

	make_up (wa: like workarea) is
			-- Create a command that executes upward moves
		do
			make (wa, 0, -1)
		ensure
			up: delta_y < 0
			vertical: delta_x = 0
		end

	make_down (wa: like workarea) is
			-- Create a command that executes downward moves
		do
			make (wa, 0, 1)
		ensure
			down: delta_y > 0
			vertical: delta_x = 0
		end

	make_left (wa: like workarea) is
			-- Create a command that executes left hand moves
		do
			make (wa, -1, 0)
		ensure
			left: delta_x < 0
			horizontal: delta_y = 0
		end

	make_right (wa: like workarea) is
			-- Create a command that executes right hand moves
		do
			make (wa, +1, 0)
		ensure
			right: delta_x > 0
			horizontal: delta_y = 0
		end

feature -- Status report

	delta_x: INTEGER
		-- Horizontal variation (>0 is right)

	delta_y: like delta_x
		-- Vertical variation (>0 is down)

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Move the currently selected object(s) (if any)
			-- in the direction specified at creation
		do
			selected_figures := workarea.selected_figures
			if (selected_figures /= Void) and then 
				(not selected_figures.empty) then
				selected_figures := selected_figures.duplicate;	
				filter_list (Void);
				if not selected_figures.empty then
					move_figures;
				end;
			end
		end

feature {NONE} -- Implementation

	selected_figures: GRAPH_LIST [GRAPH_FORM];
	-- Figures selected in workarea

	move_figures is
			-- Move figures based on key movement.
		local
			movables: SORTED_TWO_WAY_LIST [MOVABLE_U];
			entity: GRAPH_FORM;
			graph_linkable: GRAPH_LINKABLE;
			graph_icon: GRAPH_ICON;
			new_parent, old_parent: GRAPH_GROUP;
			reparent_movable: REPARENT_MOVABLE_U;
			translate_movable: TRANSLATE_MOVABLE_U;
			move_figures_u: MOVE_FIGURES_U;
			hierarchy_changes, can_move_all: BOOLEAN;
			newx, newy, oldx, oldy,
			newlocalx, newlocaly: INTEGER;
			cluster_data: CLUSTER_DATA;
			reparent_figure: REPARENT_FIGURE_U;
			reparent_cluster: REPARENT_CLUSTER_U;
			translate_figure: TRANSLATE_FIGURE_U;
			move_cluster: MOVE_CLUSTER_U;
		do
			if selected_figures.count > 1 then
				from
					selected_figures.start
					hierarchy_changes := false;
					can_move_all := true;
					!! movables.make;
				until
					selected_figures.off or not can_move_all
				loop
					entity := selected_figures.item;
					graph_linkable ?= entity;
					if graph_linkable /= Void then
						old_parent := graph_linkable.parent_group;
						newlocalx := new_position (graph_linkable.local_x, 
													delta_x);
						newlocaly := new_position (graph_linkable.local_y, 
													delta_y);
						if workarea.contains (newlocalx, newlocaly) then
							new_parent := workarea.cluster_at (newlocalx, newlocaly);
							if new_parent = Void then
								new_parent := workarea
							end;
							if 	(new_parent = old_parent) or 
								(new_parent /= Void and then
								(new_parent.data = graph_linkable.data)) then
									-- translate
								oldx := graph_linkable.data.x;
								oldy := graph_linkable.data.y;
								newx := new_position (oldx + old_parent.local_x, delta_x) - old_parent.local_x;
								newy := new_position (oldy + old_parent.local_y, delta_y) - old_parent.local_y;
								!! translate_movable.make (graph_linkable.data, newx - oldx, newy - oldy);
								movables.extend (translate_movable);
							else
									-- reparent:
								newx := newlocalx - new_parent.local_x;	
								newy := newlocaly - new_parent.local_y;
								!! reparent_movable.make (graph_linkable.data, new_parent.data, newx, newy);
								movables.extend (reparent_movable);
								hierarchy_changes := true;
							end;
						else --| if workarea.contains....
							can_move_all := false;
						end;
					end;
					selected_figures.forth
				end; --| loop on selected_figures
				if not movables.empty then
					if can_move_all then
						!! move_figures_u.make (movables, hierarchy_changes);
					end;
				end;

--%%%%%%%heu.. this test seems stupid, because same code (?look...)
			else --| if select_figures.count > 1
				graph_linkable ?= selected_figures.first;
				if graph_linkable /= Void then
					cluster_data ?= graph_linkable.data;
					graph_icon ?= graph_linkable;
					old_parent := graph_linkable.parent_group;
					newlocalx := new_position (graph_linkable.local_x, delta_x);
					newlocaly := new_position (graph_linkable.local_y, delta_y);
					if workarea.contains (newlocalx, newlocaly) then
						new_parent := workarea.cluster_at (newlocalx, newlocaly);
						if new_parent = Void then
							new_parent := workarea
						end;
						if (new_parent = old_parent) or
								(new_parent/=Void and then (new_parent.data
								= graph_linkable.data)) then
								-- translate:
							oldx := graph_linkable.data.x;
							oldy := graph_linkable.data.y;
							newx := new_position (oldx + old_parent.local_x, delta_x) - old_parent.local_x;
							newy := new_position (oldy + old_parent.local_y, delta_y) - old_parent.local_y;
							if cluster_data = Void or else 
										graph_icon /= Void then
								!! translate_figure.make (graph_linkable.data, newx - oldx, newy - oldy);
							else
								!! move_cluster.make (cluster_data, newx - oldx, newy - oldy);
							end;
						else 
							-- reparent:
							newx := newlocalx - new_parent.local_x;
							newy := newlocaly - new_parent.local_y;
							if cluster_data = Void or else 
										graph_icon /= Void then
								!! reparent_figure.make (graph_linkable.data, new_parent.data, newx, newy);
							else
								!! reparent_cluster.make (cluster_data, new_parent.data, newx, newy);
							end;
						end;
					end;
				end; --| if graph_linkable /= Void
			end; 
		end;

	filter_list (parent: CLUSTER_DATA) is
			-- Filter list so that selected_figures do not
			-- have cluster `parent' as its parent.
		local
			old_cursor: CURSOR;
			graph_linkable: GRAPH_LINKABLE
			graph_cluster: GRAPH_CLUSTER;
			clusters: GRAPH_LIST [GRAPH_CLUSTER];
			linkable_data: LINKABLE_DATA;
		do
			if not selected_figures.empty then
				!! clusters.make;
				from
					selected_figures.start
				until
					selected_figures.after
				loop
					graph_linkable ?= selected_figures.item;
					if (graph_linkable = Void) then
						selected_figures.remove;
					else
						linkable_data := graph_linkable.data;
						if linkable_data /= parent then
							if parent /= Void and then
								parent.contains_linkable (linkable_data) then
									selected_figures.remove;
							else
								graph_cluster ?= graph_linkable;
								if graph_cluster /= Void then
									clusters.put_front (graph_cluster);
								end;
								selected_figures.forth;
							end;
						else
							selected_figures.forth;
						end;
					end;
				end; --| loop	
				from
					clusters.start
				until
					clusters.after
				loop
					filter_list (clusters.item.data);
					clusters.remove;
				end;
			end; --| if not selected_figures.empty
		end;

	new_position (old_coord, rel_coord: INTEGER): INTEGER is
			-- New position base on `old_coord' and `rel_coord'.
		do
			if system.is_grid_magnetic then
				Result := align_grid (old_coord);
				if rel_coord < 0 and Result > old_coord then
					Result := Result - system.grid_spacing
				elseif rel_coord > 0 and Result < old_coord then
					Result := Result + system.grid_spacing
				elseif Result = old_coord then
					Result := Result + rel_coord * system.grid_spacing;
				end;
			else
				Result := old_coord + rel_coord;
			end;
		end;

end -- class WORKAREA_MOVE_BY_KEYS


