indexing

	description: "Manage all graphic entities on drawing area.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA 

inherit

	GRAPH_GROUP
		rename
			form_list as group_form_list
		end

	EV_PIXMAP

	CONSTANTS

	ONCES

creation

	make

feature {NONE} -- Initialization

	make (a_parent: EV_CONTAINER; a: like analysis_window) is
			-- Create a workarea with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			parent_exists: a_parent /= void
		local
			namer_hole_com : NAMER_HOLE_COM
			arg: EV_ARGUMENT1[INTEGER]
		do
			!! command_dispatcher.make(Current)
			if a /= Void then
				analysis_window := a
				make_with_size (1000, 1000)
				set_background_color (resources.drawing_bg_color)
				create scrollable_area.make(a_parent)
				create drawing_area.make (scrollable_area, a, Current)
				drawing_area.set_minimum_size (1000, 1000)
				workareas.extend (Current)

				create selected_figures.make
				create area_navigation.make(drawing_area)

				create class_list.make
				create icon_list.make
				create cluster_list.make
				create inherit_list.make
				create cli_sup_list.make
				create aggreg_list.make
				create grid.make (Current)

			--	!! resize_coin.make (Current)
				!! to_refresh.make
				!! refresh_upper_left.make
				!! refresh_clip.make	
	
				-- Initialize the commands.
				create arg.make(3)
				drawing_area.add_button_press_command(3, command_dispatcher, arg)
				create arg.make(1)
				drawing_area.add_button_press_command(1, command_dispatcher, arg)
				create arg.make(0)
				drawing_area.add_motion_notify_command (command_dispatcher, arg)

				-- Pick and Drop
				create workarea_show_focus_com.make (workarea, workarea.drawing_area)
				create hole_command.make (Current)
				drawing_area.activate_pick_and_drop ( workarea_show_focus_com, Void)
				drawing_area.add_default_pnd_command (hole_command, Void)
				create workarea_make_class_com.make (Current)
				create workarea_make_cluster_com.make (Current)

				-- Initialize toolbar options.
				set_cli_sup_link_command
				set_create_class_command	
	
				!! inverted_painter;
				inverted_painter.set_drawing (Current);
			end
		end

feature -- Drag and drop

	active_entity_data: DATA is
			-- Return the current pointed data.
		do
			if active_entity /= Void then
				Result := active_entity.data
			end
		end

	stone: STONE
		-- Current Stone.

	want_initial_position: BOOLEAN is
			-- Do we want the initial position. 
		local
			graph_linkable: GRAPH_LINKABLE
		do
			graph_linkable ?= active_entity;
			Result := graph_linkable /= Void
		end

	initial_x: INTEGER is
			-- Initial X of the active entity
		local
			graph_linkable: GRAPH_LINKABLE
		do
			graph_linkable ?= active_entity
			check
				graph_linkable_exists: graph_linkable /= Void
			end
			Result := drawing_area.x + graph_linkable.local_x;
			if scrollable_area.x > Result then
				Result := scrollable_area.x + 5
			end
		end

	initial_y: INTEGER is
			-- Initial Y of the active entity
		local
			graph_linkable: GRAPH_LINKABLE
		do
			graph_linkable ?= active_entity
			check
				graph_linkable_exists: graph_linkable /= Void
			end
			Result := drawing_area.y + graph_linkable.local_y
			if scrollable_area.y > Result then
				Result := scrollable_area.y + 5
			end
		end

	highlight_linkable (linkable: GRAPH_LINKABLE) is
				-- Highlight linkable by showing it
				-- in the drawing area and selecting it.
		require
			valid_linkable: linkable /= Void
		local
			x0, y0: INTEGER
		do
			x0 := - linkable.local_x + (analysis_window.width // 2);
			y0 := - linkable.local_y + (analysis_window.height // 2);
			if not linkable.selected then
				linkable.select_it
			end
			x0 := x0 - 20
			y0 := y0 - 20
			drawing_area.set_x_y (x0, y0)
		end;

feature -- components

	scrollable_area: EV_SCROLLABLE_AREA
		-- Scrollable Area which contains the drawing area.

	drawing_area: EC_DRAWING_AREA
		-- Drawing Area

	hole_command: PROCESS_WORKAREA_STONE
		-- Command associated to Current hole

	command_dispatcher: DRAWING_AREA_COMMAND_DISPATCHER
		-- Dispatcher of graphical commands.

	workarea_make_class_com: WORKAREA_MAKE_CLASS_COM
		-- Add new class command

	workarea_make_cluster_com: WORKAREA_MAKE_CLUSTER_COM
		-- Add new cluster command

	inverted_painter: PATCH_PAINTER;
		-- Painer

	refresh_upper_left: EV_COORDINATES
		-- Upper left corner of closure to be refreshed

	refresh_clip: EV_CLIP
		-- Clip used for refreshing

	grid: GRID_PAINTER;
		-- Objet to draw a grid

	resize_coin: RESIZE_COIN_PAINTER;
		-- Object to draw the resize coin

	data: CLUSTER_DATA;
		-- Cluster shown

	workarea: WORKAREA is
			-- Workarea (itself)
		do
			Result := Current
		end

	local_x: INTEGER is
			-- Horizontal position in workarea
		do
		end

	local_y: INTEGER is
			-- Vertical position in workarea
		do
		end

feature -- Graphical properties

	active_entity: GRAPH_FORM;
		-- Entity pointed by the cursor

	analysis_window: MAIN_WINDOW
		-- Window of the workarea

	inherit_list: GRAPH_REL_LIST [GRAPH_INHERIT];
		-- List of all inheritance link figures.

	cli_sup_list: GRAPH_REL_LIST [GRAPH_CLI_SUP]
		-- List of all client/supplier link figures.

	aggreg_list: GRAPH_REL_LIST [GRAPH_AGGREG]
		-- List of all aggregation link figures.

	form_list: GRAPH_LIST[GRAPH_FORM] is
			-- List of all figures of current workarea
			-- (At the moment just classes and clusters)
		do
			Result := group_form_list
			Result.merge (inherit_list)
			Result.merge (cli_sup_list)
			Result.merge (aggreg_list)
		end

feature -- Callbacks properties

	workarea_show_focus_com: WORKAREA_INIT_PND
			-- Focus command (when user moves cursor)

feature  -- Callbacks properties

	create_entity_command: WORKAREA_MAKE_COM
			-- Command to create entities (classes or clusters)

feature -- Graphical properties

	to_refresh: EC_CLOSURE
			-- Area who need to be refreshed

	area_navigation: AREA_NAVIGATION
			-- Manager of commands responsible for the navigation.

feature -- Access

	contains (x0, y0: INTEGER): BOOLEAN is
			-- Does Current contain `p'.
		do
			Result :=	x0 >= 0 and then x0 <= width and then
						y0 >= 0 and then y0 <= height 
		end

	has_visible_ancestor (a_list: LINKED_LIST [GRAPH_FORM];
			a_data: LINKABLE_DATA): BOOLEAN is
			-- Has 'a_data' a visible ancestor in 'a_list'
		require
			has_list: a_list /= Void and then not a_list.empty;
			has_data: a_data /= Void
		local
			a_cluster: CLUSTER_DATA;
			old_position: CURSOR
		do
			old_position := a_list.cursor;
			from
				a_list.start
			until
				a_list.after or Result
			loop
				a_cluster ?= a_list.item.data;
				if a_cluster /= Void then
					Result := a_data /= a_cluster and then
						a_data.visible_descendant_of (a_cluster)
				end;
				a_list.forth
			end;
			a_list.go_to (old_position)
		end;

	is_link_visible (link: RELATION_DATA): BOOLEAN is
			-- Is `link' visible in current workarea ?
		require
			link /= void
		local
			points: LIST [COORD_XY_DATA]
		do
			-- added by pascalf, => protection ...
			if	link/= Void	and then 
				link.f_rom/= Void	and then	
				link.t_o/= Void	then	
				Result := link.is_visible and then
				link.f_rom.visible_descendant_of (data) and then
				link.t_o.visible_descendant_of (data);
			if Result then
				points := link.break_points;
				from
					points.start
				until
					points.after or (not Result)
				loop
					-- added by pascalf, idem ...
					if points.item.parent_cluster/= VOid then	
						Result := 
							points.item.parent_cluster.visible_descendant_of 
								(data)
					else
						Result := TRUE 
						-- case where we just did a REVERSE ENGINEERING
					end	
					points.forth
				end
			end
			end
		end;

feature -- Access (searching)

	find (a_data: DATA): GRAPH_FORM is
			-- Graphical form in workarea whose `.data' is equal to `a_data`
			-- Void if no graphical form is found
		require
			a_data /= void
		local
			linkable: LINKABLE_DATA
		do
			linkable ?= a_data;
			if linkable /= void then
				Result := find_linkable (linkable)
			else
				Result := inherit_list.find (a_data);
				if Result = void then
					Result := cli_sup_list.find (a_data)
				end;
				if Result = void then
					Result := aggreg_list.find (a_data)
				end
			end
		end; 

	figures_in (closure: EC_CLOSURE): LINKED_LIST [GRAPH_FORM] is
			-- Figures in `closure'
		require
			closure_exists: closure /= void
		local
			graph_linkable: GRAPH_LINKABLE;
			graph_relation: GRAPH_RELATION;
			no_selection: BOOLEAN
		do
			Result := form_list.figures_in (closure);
			from
				Result.start
			until
				Result.after
			loop
				graph_linkable ?= Result.item;
				graph_relation ?= Result.item;
				if graph_linkable /= Void then
					no_selection := has_visible_ancestor (Result,
								graph_linkable.data);
				else
					no_selection := has_visible_ancestor (Result,
						graph_relation.from_form.data) and
							has_visible_ancestor (Result,
						graph_relation.to_form.data)
				end;
				if no_selection then
					Result.remove
				else
					Result.forth
				end
			end
		ensure
			has_result: Result /= void
		end; -- figures_in

	figure_at (x_coord, y_coord: INTEGER): GRAPH_FORM is
			-- Figure pointed by `x_coord' and `y_coord'.
		do
			if not System.is_inheritance_hidden then
				Result := inherit_list.figure_at (x_coord, y_coord);
			end;
			if not System.is_client_hidden and then Result = void then
				Result := cli_sup_list.figure_at (x_coord, y_coord)
			end;
			if not System.is_aggreg_hidden and then Result = Void then
				Result := aggreg_list.figure_at (x_coord, y_coord)
			end;
			if Result = void then
				Result := class_list.figure_at (x_coord, y_coord)
			end;
			if Result = void then
				Result := icon_list.figure_at (x_coord, y_coord)
			end;
			if Result = void then
				Result := cluster_list.figure_at (x_coord, y_coord)
			end;
		end;

	relation_figure_at (x_coord, y_coord: INTEGER): GRAPH_RELATION is
			-- Figure pointed by `x_coord' and `y_coord'.
		local
			tmp: GRAPH_FORM
		do
			if not System.is_inheritance_hidden then
				tmp := inherit_list.figure_at (x_coord, y_coord);
			end;
			if not System.is_client_hidden and then tmp = void then
				tmp := cli_sup_list.figure_at (x_coord, y_coord)
			end;
			if not System.is_aggreg_hidden and then tmp = Void then
				tmp := aggreg_list.figure_at (x_coord, y_coord)
			end;
			Result ?= tmp;
		end 

feature -- Setting

	setup_inverted_painter is
		do
			if inverted_painter /= Void then
				inverted_painter.set_logical_mode (10);
				inverted_painter.set_subwindow_mode (1);
				inverted_painter.set_line_width (2);
					-- solid line
				inverted_painter.set_line_style (0);
			end
		end;

	set_cluster (cluster: like data) is
			-- Set new cluster shown.
		require
			cluster /= void
		do
			set_cluster_without_update (cluster);
			refresh_all
		ensure
			data = cluster
		end;

	set_selected_entity (new_entity: like active_entity;
				st: like stone) is
			-- Set new_entity to `active_entity' and
			-- stone entity to `st'.
		require
			both_void: new_entity = Void implies st = Void;
			or_both_not_void: new_entity /= Void implies st /= Void
		local
			group_stone: GROUP_STONE;
			handle_stone: HANDLE_STONE
		do
			active_entity := new_entity;
			stone := st;
			if st /= Void then
				if active_entity.selected then
					handle_stone ?= stone;
					if handle_stone = Void then
						!! group_stone.make (selected_figures, st);
						stone := group_stone
					end;
				end
			end	
		ensure
			entity_correctly_set: active_entity = new_entity
			stone_correctly_set: (stone /= Void and then	
						not active_entity.selected) implies (stone = st)
		end; 

	set_cluster_without_update (cluster: like data) is
			-- Set new cluster shown and do not update display.
		require
			cluster /= void
		do
			data := cluster;
		--	d_area_clear;
			update_lists;
		--	if analysis_window/= Void then
		--		analysis_window.update_unzoom_button
		--	end
		ensure
			data = cluster
		end; -- set_cluster

feature { BUTTON_SELECTION_MANAGEMENT}

	set_aggreg_link_command is
			-- Set added links to be aggregation links
		do
				--| Put in the hole command because was more convenient there: 
			hole_command.set_aggreg_link_command
		end

	set_cli_sup_link_command is
			-- Set added links to be aggregation links
		do
			if hole_command /= Void then
				--| Put in the hole command because was more convenient there: 
				hole_command.set_cli_sup_link_command
			end
		end

	set_inherit_link_command is
			-- Set added links to be aggregation links
		do
				--| Put in the hole command because was more convenient there: 
			hole_command.set_inherit_link_command 
		end

	set_create_cluster_command is
			-- Set the command to create a new entity to the command that 
			-- adds a cluster.
		do
				--| Not put in the hole command, because 
				--| `create_entity_command'is needed here:
			create_entity_command := workarea_make_cluster_com 
		end

	set_create_class_command is
			-- Set the command to create a new entity to the command that 
			-- adds a class.
		do
				--| Not put in the hole command, because 
				--| `create_entity_command'is needed here:
			create_entity_command := workarea_make_class_com
		end

feature -- Clearing

	wipe_out is
			-- Wipe out all data contained into the current
			-- workarea.
		do
			data := Void
			drawing_area.clear
			class_list.wipe_out
			icon_list.wipe_out
			cluster_list.wipe_out
			inherit_list.wipe_out
			cli_sup_list.wipe_out
			aggreg_list.wipe_out
			selected_figures.wipe_out
		end

--	set_width ( new_width : INTEGER ) is
	--do
	--	set_width_widget	( new_width	)
	--	--analysis_window.update_scrolling
--	end

	--set_height ( new_height : INTEGER ) is
--	do
	--	set_height_widget	( new_height	)
	--	--analysis_window.update_scrolling
--	end

	--set_size ( new_width : INTEGER ; new_height : INTEGER ) is
--	do
	--	set_width	( new_width	)
	--	set_height	( new_height	)
--	end

feature -- Update

	update_focus_label is
			-- Update the focus label of the analysis window.
		do
		--	if active_entity /= Void then
		--		analysis_window.focus_label.set_text 
			--		(active_entity.data.focus)
			--else
			--	analysis_window.focus_label.set_text ("")
			--end;
		end;

feature -- List management

	update_lists is
			-- Update the display from the system.
		local
			new_graph_class: GRAPH_CLASS;
			classes: LINKED_LIST [ CLASS_DATA ]
			clusters: LINKED_LIST [ CLUSTER_DATA ]
			new_graph_cluster: GRAPH_CLUSTER;
			new_graph_icon: GRAPH_ICON
		do
			if analysis_window/= Void then
		--		analysis_window.set_cluster_name (data.name);
			end
		--	set_size (data.width, data.height);
			
			if class_list /= Void then
				class_list.wipe_out;
			end

			if icon_list /= Void then
				icon_list.wipe_out;
			end

			if cluster_list /= Void then
				cluster_list.wipe_out;
			end 

			if inherit_list /= Void then
				inherit_list.wipe_out;
			end

			if cli_sup_list /= Void then
					cli_sup_list.wipe_out;
			end
			
			if aggreg_list /= Void then
				aggreg_list.wipe_out;
			end

			if data /= Void then
				classes := data.classes;
				from
					classes.start
				until
					classes.after
				loop
					if not classes.item.is_hidden then
						!!new_graph_class.make (classes.item, Current);
					end;
					classes.forth
				end;

				clusters := data.clusters;
				from
					clusters.start
				until
					clusters.after
				loop
					if not clusters.item.is_hidden then
						if clusters.item.is_icon then
							!!new_graph_icon.make (clusters.item, Current)
						else
							!!new_graph_cluster.make (clusters.item, Current)
						end
					end;
					clusters.forth
				end;
				add_links_for_data
			end
		end; 
	
feature {WORKAREAS_L} -- Update

	change_cluster_tag (clust_data: CLUSTER_DATA) is
			-- Update workarea after the modification of an old data
			-- and update the closure area and erase figures but
			-- (do not draw them).
		require
			clust_data /= void
		local
			graph_cluster: GRAPH_CLUSTER;
			list: LINKED_LIST [RELATION_DATA];
			graph_form: GRAPH_FORM;
			clip_closure: EC_CLOSURE
		do
 			graph_cluster ?= find (clust_data)
 			if graph_cluster /= Void then
 				graph_cluster.update_title
 				list := clust_data.extern_inherit_links
 				list.append (clust_data.extern_client_links)
 				--if not list.empty then
 				--	!! clip_closure.make
 				--	clip_closure.set (refresh_clip.upper_left.x, 
 				--		refresh_clip.upper_left.y,
 				--		refresh_clip.width, 
 				--		refresh_clip.height)
 				--	from
 				--		list.start
 				--	until
 				--		list.after
 				--	loop
 				--		graph_form := find (list.item)
 				--		if graph_form /= Void and then 
 				--			clip_closure.intersects (graph_form.closure) 
 				--		then
 				--			change_for_existing_form (graph_form)
 				--		end;
 				--		list.forth
 				--	end
 				--end
 			end
		end 

	change_data (a_data: DATA) is
			-- Update workarea after the modification of a_data
			-- and update the closure area and erase figures but
			-- (do not draw them). 
		require
			a_data /= void
		local
			a_graph_form: GRAPH_FORM;
			old_w, old_h: INTEGER
		do
			if a_data = data then
				--resize_coin.erase;
				old_w := width;
				old_h := height;
			--	set_size (data.width, data.height);
			-- by pascalf...	refresh_all;
			elseif a_data /= data.parent_cluster then
				a_graph_form := find (a_data);
				if a_graph_form /= Void then
					change_for_existing_form (a_graph_form)
				else
					change_for_new_data (a_data)
				end
			end
		end; -- change_data

	change_color_data (a_data: COLORABLE) is
			-- Change the color of data
			-- in the workarea.
		local
			a_graph_form: GRAPH_FORM
		do
			a_graph_form := find (a_data)
			if a_graph_form /= Void then
				a_graph_form.set_color
				a_graph_form.update_clip_area
			end
		end;

feature {NONE} -- Update

	change_for_existing_form (a_form: GRAPH_FORM) is
			-- Update current workarea for modified 
			-- graph_form.
		require
			a_form /= Void
		local
			graph_linkable: GRAPH_LINKABLE;
		do
			a_form.update
			graph_linkable ?= a_form
			if graph_linkable /= Void then
				if graph_linkable.data.visible_descendant_of (data) then
					inherit_list.update_form_if_associated_with 
							(graph_linkable, System.is_inheritance_hidden);
					cli_sup_list.update_form_if_associated_with 
							(graph_linkable, System.is_client_hidden);
					aggreg_list.update_form_if_associated_with 
							(graph_linkable, System.is_aggreg_hidden)
				else
					inherit_list.erase_form_if_associated_with
							(graph_linkable, System.is_inheritance_hidden)
					cli_sup_list.erase_form_if_associated_with
							(graph_linkable, System.is_client_hidden)
					aggreg_list.erase_form_if_associated_with
							(graph_linkable, System.is_aggreg_hidden)
				end
			end
		end

	change_for_new_data (a_data: DATA) is
			-- Update current workarea after insertion of a new data
			-- `a_data'.
		require
			valid_data: a_data /= Void;
		local
			a_class: CLASS_DATA;
			a_cluster: CLUSTER_DATA;
			an_inherit_link: INHERIT_DATA;
			a_client_link: CLI_SUP_DATA		
		do
			a_class ?= a_data
			a_cluster ?= a_data
			an_inherit_link ?= a_data
			a_client_link ?= a_data
			if a_class /= Void then 
				new_class (a_class)
					-- Draw all links going into/from class data
				if find_class (a_class) /= Void then
					add_inherit_links_in_list (a_class.extern_inherit_links, false);
					add_cli_sup_links_in_list (a_class.extern_client_links, false);
				end
			elseif a_cluster /= Void then
				new_cluster (a_cluster)
				if find_cluster (a_cluster) /= Void or else
					find_icon (a_cluster) /= Void
				then
						-- Draw all links going into/from cluster data
						-- Links within clusters will be recorded twice hence
						-- the need to check for link existances in 
						-- `add_inherit_links_in_list' & `add_cli_sup_links_in_list'
					add_inherit_links_in_list (a_cluster.recursive_inherit_links, 
									true);
					add_cli_sup_links_in_list (a_cluster.recursive_cli_sup_links, 
									true);
				end;
			elseif an_inherit_link /= Void then
				new_inherit (an_inherit_link)
			elseif a_client_link /= Void then
				if a_client_link.is_aggregation then
					new_aggregation (a_client_link)
				elseif a_client_link.is_reflexive then
					new_reflexive (a_client_link)
				else
					new_client (a_client_link)
				end
			end
		end 

feature -- Class management

	new_class (a_class: CLASS_DATA) is
			-- Update workareas after the apparition of a new class.
		require
			valid_class: a_class /= Void
		local
			new_graph_class: GRAPH_CLASS
			new_group_parent: GRAPH_GROUP
		do
			if not a_class.is_hidden then
				new_group_parent := find_graph_group (a_class.parent_cluster)
				if new_group_parent /= void then
					!! new_graph_class.make (a_class, new_group_parent)
				end
			end
		end

	destroy_class (old_class: CLASS_DATA) is
			-- Update workareas after the suppression of an old class
		require
			valid_class: old_class /= Void
		local
			old_graph_class: GRAPH_CLASS
		do
			old_graph_class := find_class (old_class)
			if old_graph_class /= void then
				old_graph_class.destroy
				old_graph_class.parent_group.class_list.remove_form
								(old_graph_class)
				selected_figures.remove_form (old_graph_class)
			end
		end 

feature -- Cluster management

	new_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after the apparition of a new cluster
		require
			valid_cluster: a_cluster /= Void;
		local
			new_graph_cluster: GRAPH_CLUSTER;
			new_graph_icon: GRAPH_ICON;
			new_group_parent: GRAPH_GROUP
		do
			if not a_cluster.is_hidden and then not a_cluster.is_root then
				new_group_parent := find_graph_group (a_cluster.parent_cluster);
				if new_group_parent /= void then
					if a_cluster.is_icon then
						!! new_graph_icon.make (a_cluster, new_group_parent);
					else
						!! new_graph_cluster.make (a_cluster, new_group_parent);
					end;
					
				end;
			end;
		end; 

	destroy_cluster (old_cluster: CLUSTER_DATA) is
			-- Update workareas after the suppression of an old cluster
		require
			valid_cluster: old_cluster /= Void;
		local
			old_graph_cluster: GRAPH_CLUSTER;
			old_graph_icon: GRAPH_ICON
		do
			old_graph_cluster := find_cluster (old_cluster);
			old_graph_icon := find_icon (old_cluster);
			if old_graph_cluster /= void then
				old_graph_cluster.destroy;
				old_graph_cluster.parent_group.cluster_list.remove_form 
						(old_graph_cluster);
				selected_figures.remove_form (old_graph_cluster)
			elseif old_graph_icon /= Void then
				old_graph_icon.destroy;
				old_graph_icon.parent_group.icon_list.remove_form 
						(old_graph_icon);
				selected_figures.remove_form (old_graph_icon)
			end
		end; 

	iconify_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after a cluster has been iconified.
		require
			a_cluster /= void
		local
			new_graph_icon: GRAPH_ICON;
			graph_cluster: GRAPH_CLUSTER
		do
			if not a_cluster.is_hidden then
				graph_cluster := find_cluster (a_cluster);
				if graph_cluster /= void then
					selected_figures.remove_form (graph_cluster);
					graph_cluster.destroy;
					graph_cluster.parent_group.cluster_list.remove_form 
								(graph_cluster);
					!! new_graph_icon.make (a_cluster, 
								graph_cluster.parent_group);
					new_graph_icon.update;
					add_inherit_links_in_list 
							(a_cluster.icon_heir_links (True), False);
					add_cli_sup_links_in_list 
							(a_cluster.icon_client_links (True), False);
				end
			end
		end;

	uniconify_cluster (a_cluster: CLUSTER_DATA) is
			-- Update workareas after a cluster has been uniconified.
		require
			a_cluster /= void
		local
			graph_icon: GRAPH_ICON;
			new_graph_cluster: GRAPH_CLUSTER
		do
			if not a_cluster.is_hidden then
				graph_icon := find_icon (a_cluster);
				if graph_icon /= void then
					selected_figures.remove_form (graph_icon);
					graph_icon.destroy;
					graph_icon.parent_group.icon_list.remove_form (graph_icon);
					!! new_graph_cluster.make (a_cluster, 
							graph_icon.parent_group);
					new_graph_cluster.update;
						-- Draw all links going into/from cluster data
					add_inherit_links_in_list 
							(a_cluster.recursive_inherit_links, True);
					add_cli_sup_links_in_list 
							(a_cluster.recursive_cli_sup_links, True);
				end
			end
		end; 

feature -- Client-supplier relation management

	new_reference, new_client (a_client: CLI_SUP_DATA) is
			-- Update workareas after the apparition of a new client link
		require
			a_client /= Void
		local
			new_graph_cli_sup: GRAPH_CLI_SUP
		do
			if is_link_visible (a_client) then
				!! new_graph_cli_sup.make (a_client, Current);
			end
		end

	new_reflexive (a_client: CLI_SUP_DATA) is
			-- Update workareas after the apparition of a new reflexive link
		require
			a_client /= Void
		local
			new_graph_cli_sup: GRAPH_CLI_SUP
		do
			if is_link_visible (a_client) and then data /= a_client.client then
				!!new_graph_cli_sup.make_reflexive (a_client, Current);
			end
		end

	new_aggregation, new_aggreg (a_client: CLI_SUP_DATA) is
			-- Update workareas after the apparition of
			-- a new aggregation link
		require
			a_client /= Void;
			a_client.is_aggregation
		local
			new_graph_aggreg: GRAPH_AGGREG
		do
			if is_link_visible (a_client) then
				!!new_graph_aggreg.make (a_client, Current);
			end
		end

	destroy_reflexive, destroy_reference, destroy_client (old_client: CLI_SUP_DATA) is
			-- Update workareas after the suppression of an old client link
		require
			not (old_client = Void)
		local
			old_graph_client: GRAPH_CLI_SUP
		do
			old_graph_client := cli_sup_list.find (old_client);
			if old_graph_client /= void then
				old_graph_client.destroy;
				cli_sup_list.remove_form (old_graph_client);
				selected_figures.remove_form (old_graph_client)
			end
		end

	destroy_aggregation, destroy_aggreg (old_client: CLI_SUP_DATA) is
			-- Update workareas after the suppression of
			-- an old aggregation link
		require
			old_client /= void;
			old_client.is_aggregation
		local
			old_graph_aggreg: GRAPH_AGGREG
		do
			old_graph_aggreg := aggreg_list.find (old_client);
			if old_graph_aggreg /= void then
				old_graph_aggreg.destroy;
				aggreg_list.remove_form (old_graph_aggreg);
				selected_figures.remove_form (old_graph_aggreg)
			end
		end

	add_reverse_link (a_client_link: CLI_SUP_DATA) is
			-- Add a reverse link at the 'graph_link' corresponding
			-- to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_client_link);
			if a_graph_clientele /= Void then
				--a_graph_clientele.client.draw_border;
				a_graph_clientele.add_reverse_link;
				a_graph_clientele.update;
			end
		end

	remove_reverse_link (a_client_link: CLI_SUP_DATA) is
			-- Remove a reverse link at the 'graph_link' corresponding
			-- to 'a_client_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_client_link);
			if a_graph_clientele /= Void then
				a_graph_clientele.erase;
				a_graph_clientele.remove_reverse_link;
				a_graph_clientele.update_form;
			end
		end

	add_shared (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Add graphical shared capability to 'a_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_cli_sup: GRAPH_CLI_SUP
		do
			a_graph_cli_sup ?= find (a_client_link);
			if a_graph_cli_sup /= Void then
				a_graph_cli_sup.add_shared (reverse);
				a_graph_cli_sup.update;
			end
		end

	remove_shared (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Remove graphical shared capability to 'a_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_cli_sup: GRAPH_CLI_SUP
		do
			a_graph_cli_sup ?= find (a_client_link);
			if a_graph_cli_sup /= Void then
				a_graph_cli_sup.update_clip_area;
				a_graph_cli_sup.erase;
				a_graph_cli_sup.remove_shared (reverse);
				a_graph_cli_sup.update_form;
			end
		end

	add_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Add graphical multiplicity capability to 'a_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_client_link);
			if a_graph_clientele /= Void then
				a_graph_clientele.add_multiplicity (reverse);
				a_graph_clientele.update;
			end
		end

	remove_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Remove graphical multiplicity capability to 'a_link'
		require
			has_client_link: a_client_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_client_link);
			if a_graph_clientele /= Void then
				a_graph_clientele.update_clip_area;
				a_graph_clientele.erase;
				a_graph_clientele.remove_multiplicity (reverse);
				a_graph_clientele.update_form;
			end
		end

	change_multiplicity (a_client_link: CLI_SUP_DATA; reverse: BOOLEAN) is
			-- Change multiplicity value of 'a_client_link'
		require
			has_link: a_client_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_client_link);
			if a_graph_clientele /= Void then
				a_graph_clientele.change_multiplicity (reverse)
			end
		end

feature -- Inheritance relation management

	new_inherit (a_inherit: INHERIT_DATA) is
			-- Update workareas after the apparition of a new inherit link
		require
			not (a_inherit = Void)
		local
			new_graph_inherit: GRAPH_INHERIT;
		do
			if is_link_visible (a_inherit) then
				!!new_graph_inherit.make (a_inherit, Current);
			end
		end

	destroy_inherit (old_inherit: INHERIT_DATA) is
			-- Update workareas after the suppression of an old inherit link
		require
			not (old_inherit = Void)
		local
			old_graph_inherit: GRAPH_INHERIT;
		do
			old_graph_inherit := inherit_list.find (old_inherit);
			if old_graph_inherit /= void then
				old_graph_inherit.destroy;
				selected_figures.start;
				selected_figures.prune (old_graph_inherit)
			end
		end

feature -- Label management

	change_label (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Change the text of the label associated to ``a_link''
		require
			has_link: a_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_link);
			if a_graph_clientele /= Void then
				if reverse then
					check
						a_graph_clientele /= Void
					end;
					a_graph_clientele.change_reverse_label
				else
					a_graph_clientele.change_label
				end
			end
		end; 

	change_label_position (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Change the position of the label associated to ``a_link''
		require
			has_link: a_link /= Void
		local
			a_graph_link: GRAPH_RELATION;
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_link);
			if a_graph_clientele /= Void then
				if reverse then
					check
						a_graph_clientele /= Void
					end;
					a_graph_clientele.change_reverse_label_position
				else
					a_graph_clientele.change_label_position
				end
			end
		end

	change_label_orientation (a_link: RELATION_DATA; reverse: BOOLEAN) is
			-- Change the orientation (horizontal/vertical) of the 
			-- label associated to ``a_link''
		require
			has_link: a_link /= Void
		local
			a_graph_clientele: GRAPH_CLIENTELE
		do
			a_graph_clientele ?= find (a_link);
			if a_graph_clientele /= Void then
				if reverse then
					check
						a_graph_clientele /= Void
					end;
					a_graph_clientele.change_reverse_label_orientation
				else
					a_graph_clientele.change_label_orientation
				end
			end
		end

	straight_clientele_link_between (first_entity,
					second_entity: LINKABLE_DATA): CLI_SUP_DATA is
			-- Clientele link without 'break_points' between 'first_entity'
			-- and 'second_entity' if exists
		require
			has_extremities: first_entity /= Void and second_entity /= Void
		local
			other_links, links: LINKED_LIST [CLI_SUP_DATA];
			item: CLI_SUP_DATA
		do
			links := first_entity.extern_client_links;
			other_links := second_entity.extern_client_links;
			if other_links.empty then
				links.wipe_out
			else
				from
					links.start
				until
					links.after
				loop
					item := links.item;
					if (not other_links.has (item)) or else
						(not item.break_points.empty or 
							item.client = first_entity)
					then
						links.remove
					else
						links.forth
					end
				end;
			end;
			if not links.empty then
				Result := links.first
			end
		end;

feature {NONE} -- Drawing 
	
	add_links_for_data is
			-- Draw the links associated with `data'.
		local
			classes: LINKED_LIST [ CLASS_DATA ]
			clusters: LINKED_LIST [ CLUSTER_DATA ]
			class_data: CLASS_DATA
		do
			classes := data.classes;
			from
				classes.start
			until
				classes.after
			loop	
				class_data := classes.item;
				if not class_data.is_hidden then
					add_inherit_links_in_list (class_data.heir_links, false)
					add_cli_sup_links_in_list (class_data.client_links, false)
				end;
				classes.forth
			end;
			classes := Void;
			clusters := data.clusters;
			from
				clusters.start
			until
				clusters.after
			loop
				if not clusters.item.is_hidden then
					if clusters.item.is_icon then
						add_inherit_links_in_list 
							(clusters.item.icon_heir_links (false), False);
						add_cli_sup_links_in_list 
							(clusters.item.icon_client_links (false), False);
					else
						add_links_for_cluster (clusters.item);
					end
				end;
				clusters.forth
			end
		end;

	add_links_for_cluster (cluster: CLUSTER_DATA) is
			-- Draw the links associated with 'cluster'
		require
			valid_cluster: cluster /= void;
		local
			classes: LINKED_LIST [ CLASS_DATA ]
			clusters: LINKED_LIST [ CLUSTER_DATA ]
			class_data: CLASS_DATA
		do
			add_inherit_links_in_list (cluster.heir_links, false);
			add_cli_sup_links_in_list (cluster.client_links, false);
			if not cluster.is_icon then
				classes := cluster.classes;
				from
					classes.start
				until
					classes.after
				loop	
					class_data := classes.item;
					if not class_data.is_hidden then
						add_inherit_links_in_list (class_data.heir_links, false)
						add_cli_sup_links_in_list (class_data.client_links, false)
					end;
					classes.forth
				end;
				classes := Void;
				clusters := cluster.clusters;
				from
					clusters.start
				until
					clusters.after
				loop
					if not clusters.item.is_hidden then 
						if clusters.item.is_icon then
							add_inherit_links_in_list 
								(clusters.item.icon_heir_links (false), False);
							add_cli_sup_links_in_list 
								(clusters.item.icon_client_links (false), False);
						else
							add_links_for_cluster (clusters.item);
						end;
					end;
					clusters.forth
				end
			end
		end;

	add_inherit_links_in_list (links: LINKED_LIST [INHERIT_DATA]; 
			check_for_existance: BOOLEAN) is
			-- Add inherit links in `links' and draw them if 'displayed'
		local
			graph_inherit: GRAPH_INHERIT;
			inherit_data: INHERIT_DATA
		do
			if links /= void then
				from
					links.start
				until
					links.after
				loop
					inherit_data := links.item;
					if not check_for_existance or else
						inherit_list.find (inherit_data) = Void 
					then
						new_inherit (inherit_data)
					end;
					links.forth;
				end
			end
		end; 

	add_cli_sup_links_in_list (links: LINKED_LIST [CLI_SUP_DATA];
			check_for_existance: BOOLEAN) is
			-- Add client-supplier links in `links'
		local
			graph_cli: GRAPH_CLIENTELE;
			cli_sup_data: CLI_SUP_DATA
		do
			if links /= void then
				from
					links.start
				until
					links.after
				loop
					cli_sup_data := links.item;
					if cli_sup_data.is_aggregation then
						if not check_for_existance or else
							aggreg_list.find (cli_sup_data) = void
						then
							new_aggreg (cli_sup_data)
						end
					elseif cli_sup_data.is_reflexive then
						if not check_for_existance or else
							cli_sup_list.find (cli_sup_data) = void
						then
							new_reflexive (cli_sup_data)
						end
					else
						if not check_for_existance or else
							cli_sup_list.find (cli_sup_data) = void
						then
							new_client (cli_sup_data)
						end
					end;
					links.forth
				end
			end
		end 

feature -- Handles management

	move_handle (handle: HANDLE_DATA) is
			-- Update 'handle' on current workarea.
		require
			handle /= void
		do
			inherit_list.links_who_has (handle).update;
			cli_sup_list.links_who_has (handle).update;
			aggreg_list.links_who_has (handle).update;
		end

feature -- Output

	display is
			-- Display each graphical entity on 'workarea'
		local
			clip_closure: EC_CLOSURE;
			display_pointer: POINTER;
			list: LINKED_LIST [EC_DOUBLE_LINE]
		do
			!! clip_closure.make;
			clip_closure.set (refresh_clip.upper_left.x, 
					refresh_clip.upper_left.y,
					refresh_clip.width, 
					refresh_clip.height)

			if grid /= Void then
				grid.draw_in (clip_closure)
			end

			if cluster_list /= Void then
				cluster_list.draw_in (clip_closure)
			end

			if icon_list /= Void then
				icon_list.draw_in (clip_closure)
			end

			if class_list /= Void then
				class_list.draw_in (clip_closure)
			end

			if not System.is_aggreg_hidden then
				if aggreg_list /= Void then
					!! list.make
					aggreg_list.draw_in_and_update_list (clip_closure, list)
						-- Erase middle for relations that have
						-- handles which are shared.
					from
						list.start
					until
						list.after
					loop
						list.item.erase_middle
						list.forth
					end
				end
			end;
			if not System.is_client_hidden then
				if cli_sup_list /= Void then
					!! list.make;
						cli_sup_list.draw_in_and_update_list (clip_closure, list);
					-- Erase middle for relations that have
					-- handles which are shared.
					from
						list.start
					until
						list.after
					loop
						list.item.erase_middle;
						list.forth
					end
				end
			end;
			if not System.is_inheritance_hidden then
				if inherit_list /= Void then
					inherit_list.draw_in (clip_closure);
				end 
			end;
			if resize_coin /= Void then
				resize_coin.draw;
			end

		end

	refresh_all is
			-- Refresh the whole window.
		do
			set_background_color (resources.drawing_bg_color) 
			clear
				-- It will be larger than the actual exposed area
				-- of the workarea but it beats redrawing the whole
				-- workarea when this routine is called.
			--to_refresh.set (- x, - y,
			--	- x + analysis_window.width,
			--	- y + analysis_window.height)
			refresh
		end

	group_to_refresh (data_list: LINKED_LIST [DATA]) is
			-- Refresh the forms whose data is in data_list
		require
			has_data: data_list /= Void and then not data_list.empty
		local
			graph_form: GRAPH_FORM;
			graph_linkable: GRAPH_LINKABLE
		do
			from
				data_list.start
			until
				data_list.after
			loop
				graph_form := find (data_list.item)
				if graph_form /= Void then
					graph_form.update_clip_area
					graph_linkable ?= graph_form
					if graph_linkable /= Void and then
					graph_linkable.data.visible_descendant_of
										(data)
					then
						inherit_list.update_form_if_associated_with
									(graph_linkable, System.is_inheritance_hidden)
						cli_sup_list.update_form_if_associated_with
									(graph_linkable, System.is_client_hidden)
						aggreg_list.update_form_if_associated_with
									(graph_linkable, System.is_aggreg_hidden)
					end
				end
				data_list.forth
			end
			refresh
		end

	refresh is
			-- Refresh the area delimited by `to_refresh'.
			-- Wipe out `to_refresh'.
		local
			w, h: INTEGER
		do
			if not to_refresh.empty then
				if refresh_clip.upper_left /= Void then
					inverted_painter.draw_rectangle (refresh_clip.upper_left.x - 2, refresh_clip.upper_left.y -2, refresh_clip.width +4, refresh_clip.height+4)
				end
				refresh_upper_left.set (to_refresh.up_left_x - 1,
						to_refresh.up_left_y - 1)
				w := to_refresh.down_right_x - to_refresh.up_left_x + 2
				h := to_refresh.down_right_y - to_refresh.up_left_y + 2
				if w > 0 and then h > 0 then
					refresh_clip.set (refresh_upper_left, w, h)
					--set_clip (refresh_clip)
					display
					--set_no_clip
					to_refresh.wipe_out
					debug ("DRAWING")
						inverted_painter.draw_rectangle (refresh_clip.upper_left.x -2, refresh_clip.upper_left.y -2, refresh_clip.width+4, refresh_clip.height+4)
					end
				end
			end
		end

feature -- Selection management

	selected_figures: GRAPH_LIST [GRAPH_FORM];
			-- List of selected figures

	unselect_all_without_update is
			-- Unselect all figures in `selected_figures'.
			-- without updating the workarea.
		do
			from
				selected_figures.start
			until
				selected_figures.after
			loop
				selected_figures.item.unselect;
			end;
		ensure
			empty_select_figures: selected_figures.empty
		end; 

	unselect_all is
			-- Unselect all figures in `selected_figures'.
		local
			graph_form: GRAPH_FORM
		do
			from
			until
				selected_figures.empty
			loop
				graph_form := selected_figures.first;
				graph_form.unselect
			end;
			refresh	
		ensure
			empty_select_figures: selected_figures.empty
		end

invariant

	has_selected_figures_list:	selected_figures /= void
	has_class_figures_list:		class_list /= void
	has_icon_figures_list:		icon_list /= void
	has_cluster_figures_list:		cluster_list /= void
	has_inherit_links_list:		inherit_list /= void
	has_reference_links_list:		cli_sup_list /= void
	has_aggregation_links_list:	aggreg_list /= void
	--area_navigation_exists: 		area_navigation /= Void

end -- class WORKAREA
