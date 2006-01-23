indexing
	description: "Main window for the Eiffel Graph example"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPH_MAIN_WINDOW

inherit
	MAIN_WINDOW

create
	default_create
	
feature {NONE} -- Initialization

	build_main_container is
			-- Create and populate `main_container'.
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			frame: EV_FRAME
		do
			build_extended_menu_bar
			
			create graph
			
			create world.make_with_model_and_factory (graph, create {ELLIPSE_FACTORY})
			world.drop_actions.extend (agent drop_new_node)
			
			create small_world.make_with_model (graph)
			small_world.disable_multiple_selection
			
			create physics_layout.make_with_world (small_world)
			physics_layout.set_center (200, 200)
			physics_layout.set_move_threshold (20)
			
			create circle_layout.make_with_world (world)
			
			create grid_layout.make_with_world (world)
			
			create timer.make_with_interval (40)
			timer.actions.extend (agent on_time_out)
			
			create main_container
			
				create hbox
				
					create vbox
					
					vbox.extend (standard_toolbar)
					vbox.disable_item_expand (standard_toolbar)
					
						create frame
							create model_cell.make_with_world (world)
						frame.extend (model_cell)
					
					vbox.extend (frame)
					
				hbox.extend (vbox)
				
					create vbox
				
						create statistic_frame.make_with_text ("Statistics")
						statistic_frame.set_minimum_height (150)
						build_statistic
						
					vbox.extend (statistic_frame)
					vbox.disable_item_expand (statistic_frame)
					
						create frame.default_create
							
							create view_cell.make_with_world (small_world)
							view_cell.disable_scrollbars
							view_cell.set_world_border (5)
							view_cell.set_autoscroll_border (0)
							
						frame.extend (view_cell)
				
					vbox.extend (frame)
					vbox.set_minimum_width (400)
					
				hbox.extend (vbox)
				hbox.disable_item_expand (vbox)
				
			main_container.extend (hbox)
		end
		
	build_extended_menu_bar is
			-- Add menu item new node.
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new_node.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)
			toolbar_item.select_actions.extend (agent explain)
			toolbar_item.set_pebble (create {NEW_NODE_STONE})
			toolbar_item.set_accept_cursor (accept_node)
			toolbar_item.set_tooltip (add_one_node)
			toolbar_item.set_deny_cursor (deny_node)
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new_node.png")
			toolbar_item.set_text ("+10")
			toolbar_item.select_actions.extend (agent add_random_nodes (10))
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.set_tooltip (add_ten_nodes)
			standard_toolbar.extend (toolbar_item)
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new_node.png")
			toolbar_item.set_text ("+100")
			toolbar_item.select_actions.extend (agent add_random_nodes (100))
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.set_tooltip (add_hundred_nodes)
			standard_toolbar.extend (toolbar_item)
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new_node.png")
			toolbar_item.set_text ("+1000")
			toolbar_item.select_actions.extend (agent add_random_nodes (1000))
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.set_tooltip (add_thousand_nodes)
			standard_toolbar.extend (toolbar_item)
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("circle_layout.png")
			toolbar_item.select_actions.extend (agent layout_circle)
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.set_tooltip (apply_circle_layout)
			standard_toolbar.extend (toolbar_item)
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("grid_layout.png")
			toolbar_item.select_actions.extend (agent layout_grid)
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.set_tooltip (apply_grid_layout)
			standard_toolbar.extend (toolbar_item)
		end
		
	build_statistic is
			-- Populate `statistic_frame'.
		require
			statistic_frame_not_void: statistic_frame /= Void
		local
			table: EV_TABLE
			label: EV_LABEL
		do
			physics_count := 0
			draw_count := 0
			create table
			table.resize (2, 7)
				
				create label.make_with_text ("Number of Nodes:")
			
			table.add (label, 1, 1, 1, 1)
			
				create label.make_with_text ("Number of Links:")
				
			table.add (label, 1, 2, 1, 1)
			
				create label.make_with_text ("Draw time (ms):")
				
			table.add (label, 1, 3, 1, 1)
			
				create label.make_with_text ("Physics time (ms):")
				
			table.add (label, 1, 4, 1, 1)
			
				create label.make_with_text ("Iterations:")
				
			table.add (label, 1, 5, 1, 1)
			
				create label.make_with_text ("Theta average:")
				
			table.add (label, 1, 6, 1, 1)
			
				create label.make_with_text ("Theta: ")
			
			table.add (label, 1, 7, 1, 1)
			
				create node_label.make_with_text ("0")				
				node_label.align_text_left
			
			table.add (node_label, 2, 1, 1, 1)
			
				create link_label.make_with_text ("0")
				link_label.align_text_left
				
			table.add (link_label, 2, 2, 1, 1)
			
				create draw_label.make_with_text ("?")
				draw_label.align_text_left
				
			table.add (draw_label, 2, 3, 1, 1)
			
				create physics_label.make_with_text ("?")
				physics_label.align_text_left
				
			table.add (physics_label, 2, 4, 1, 1)
			
				create iteration_label.make_with_text ("0")
				iteration_label.align_text_left
				
			table.add (iteration_label, 2, 5, 1, 1)
			
				create theta_label.make_with_text ("0.0")
				theta_label.align_text_left
				
			table.add (theta_label, 2, 6, 1, 1)
			
				create theta_selector.make_with_value_range (create {INTEGER_INTERVAL}.make (0, 100))
				theta_selector.set_value (25)
				theta_selector.change_actions.extend (agent on_theta_change)
				
			table.add (theta_selector, 2, 7, 1, 1)
			
			statistic_frame.extend (table)
		end
		
feature -- Access
	
	world: EG_FIGURE_WORLD
			-- The world allowing to manipulate the graph.
	
	small_world: EG_FIGURE_WORLD
			-- The small world with force directed physic.
	
	graph: EG_GRAPH
			-- The graph showen in both `world' and `small_world'.
			
	physics_layout: EG_FORCE_DIRECTED_LAYOUT
			-- Force directed layout
			
	circle_layout: EG_CIRCLE_LAYOUT
			-- Layout to arrange nodes in a circle.
			
	grid_layout: EG_GRID_LAYOUT
			-- Layout to arrange nodes in a grid.

	node_counter: INTEGER
			-- Number of nodes in the graph.
			
feature {NONE} -- Implementation

	model_cell: WORLD_CELL
			-- The cell allowing to edit the graph.
			
	view_cell: WORLD_CELL
			-- The cell with the force directed graph.
			
feature {NONE} -- Add nodes

	add_node (ax, ay: INTEGER) is
			-- Add a new node to `graph' position it at (`ax', `ay') in `world'.
		local
			new_node: EG_NODE
			fig: EG_FIGURE
		do
			node_counter := node_counter + 1
			
			-- Create the node
			create new_node
			new_node.set_name ("NODE_" + node_counter.out)
			
			-- Add it to the graph
			graph.add_node (new_node)
			
			-- Place the new figure at (`ax', `ay') in `world'.
			fig := world.figure_from_model (new_node)
			fig.set_point_position (ax, ay)

			-- Make new node figure a drop target
			fig.set_accept_cursor (accept_node)
			fig.set_deny_cursor (deny_node)
			fig.drop_actions.extend (agent on_link_drop (?, new_node))
			
			-- Make new node figure pickable
			fig.set_pebble (create {NODE_STONE}.make (new_node))
			
			-- Hide label of simple nodes
			fig := small_world.figure_from_model (new_node)
			fig.hide_label
			
			-- Position the simple node at some random position
			fig.set_point_position (300 - random.next_item_in_range (0, 200), 300 - random.next_item_in_range (0, 200) )

			-- Make sure physics is restarted when a simple node is moved
			fig.move_actions.extend (agent on_small_move)
			physics_layout.reset
		end
		
	add_link (n1, n2: EG_LINKABLE) is
			-- Add a link to `graph' connecting `n1' with `n2'.
		require
			n1_not_void: n1 /= Void
			n2_not_void: n2 /= Void
		local
			link: EG_LINK
			simple_link: EG_SIMPLE_LINK
		do
			create link.make_directed_with_source_and_target (n1, n2)
			graph.add_link (link)
			simple_link ?= small_world.figure_from_model (link)
			check
				simple_link /= Void
			end
			simple_link.set_arrow_size (4)
		end

	add_random_nodes (nb: INTEGER) is
			-- Add `nb' nodes to the graph.
		local
			i: INTEGER
			l_nodes: LIST [EG_LINKABLE]
			n1, n2: EG_LINKABLE
		do
			from
				i := 1
			until
				i > nb
			loop
				add_node (random.next_item_in_range (0, model_cell.width), random.next_item_in_range (0, model_cell.height))
				i := i + 1
			end
			from
				i := 1
				l_nodes := graph.flat_nodes
			until
				i > nb * 2
			loop
				n1 := l_nodes.i_th (random.next_item_in_range (1, l_nodes.count))
				n2 := l_nodes.i_th (random.next_item_in_range (1, l_nodes.count))
				add_link (n1, n2)
				i := i + 1	
			end
			from
				l_nodes := graph.flat_nodes
				l_nodes.start
			until
				l_nodes.after
			loop
				n1 := l_nodes.item
				if n1.links.is_empty then
					n2 := l_nodes.i_th (random.next_item_in_range (1, l_nodes.count))
					add_link (n1, n2)
				end
				l_nodes.forth	
			end
			draw_count := 1
			draw_time := 0
			physics_count := 1
			physics_time := 0
			iterations := 0
		end
		
	random: RANGED_RANDOM is
		once
			create Result.make
		end

feature {NONE} -- Animation

	timer: EV_TIMEOUT
			-- Timer for `on_time_out'.
	
	on_time_out is
			-- Timeout: layout physics and calculate time for statistics.
		local
			l_cpu: INTEGER
		do
			if not physics_layout.is_stopped then
				if physics_count >= max_count then
					physics_count := 0
					physics_time := 0
				end
				l_cpu := cpu_ticks
				physics_layout.layout
				
				physics_time := physics_time + (cpu_ticks - l_cpu)
				physics_count := physics_count + 1
				iterations := iterations + 1
			end

			if not graph.is_empty and then not physics_layout.is_stopped then
				view_cell.fit_to_screen
			end
			
			if draw_count >= max_count then
				draw_count := 0
				draw_time := 0
			end
			l_cpu := cpu_ticks
			
			view_cell.projector.full_project
			
			draw_time := draw_time + (cpu_ticks - l_cpu)
			draw_count := draw_count + 1
			
			update_statistic
		end
		
feature {NONE} -- Pick and drop new node

	explain is
			-- Explain how the new node button works.
		local
			dialog: EV_INFORMATION_DIALOG
		do
			create dialog.make_with_text ("Pick and drop this button to add a new node")
			dialog.show_modal_to_window (Current)
		end

	drop_new_node (stone: NEW_NODE_STONE) is
			-- A new node stone was droped on `Current'.
		local
			drop_x, drop_y: INTEGER
		do
			drop_x := model_cell.pointer_position.x
			drop_y := model_cell.pointer_position.y
			
			add_node (drop_x, drop_y)
			iterations := 0
		end
	
	on_link_drop (a_stone: NODE_STONE; a_node: EG_NODE) is
			-- `a_stone' was droped on `a_node'.
		local
			other: EG_NODE
		do
			other := a_stone.node
			graph.add_link (create {EG_LINK}.make_directed_with_source_and_target (other, a_node))
			if physics_layout.is_stopped then
				physics_layout.reset
				iterations := 0
			end
		end
		
	on_small_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
			-- A small figure node was moved.
		do
			if physics_layout.is_stopped then
				physics_layout.reset
				iterations := 0
			end
		end
		
feature {NONE} -- Statistic

	statistic_frame: EV_FRAME
			-- Frame showing the statistic informations.

	update_statistic is
			-- Update `statistic_frame'.
		do
			node_label.set_text (node_counter.out)	
			link_label.set_text (graph.flat_links.count.out)
			if draw_count /= 0 then
				draw_label.set_text ((draw_time / draw_count).rounded.out)
			end
			if not physics_layout.is_stopped then
				if physics_count /= 0 then
					physics_label.set_text ((physics_time / physics_count).rounded.out)
				end
				theta_label.set_text (physics_layout.last_theta_average.out)
			else
				physics_label.set_text ("Stopped")
			end
			iteration_label.set_text (iterations.out)
		end
		
	draw_count, physics_count: INTEGER
	max_count: INTEGER is 10
	draw_time, physics_time: INTEGER
	link_label, node_label, draw_label, physics_label, iteration_label, theta_label: EV_LABEL
	iterations: INTEGER
	theta_selector: EV_HORIZONTAL_RANGE
	
	on_theta_change (a_value: INTEGER) is
			-- User changed theta.
		do
			physics_layout.set_theta (a_value)
			physics_layout.reset
		end
	
feature {NONE} -- Save/retrive

	on_save is
			-- User selected save.
		do
			if last_file_name = Void then
				on_save_as
			else
				save (last_file_name)
			end
		end

	on_save_as is
			-- Save as was selected.
		local
			dialog: EV_FILE_SAVE_DIALOG
			file_name, ext: STRING
		do
			create dialog
			dialog.filters.extend (["*.xml", "XML File"])
			dialog.show_modal_to_window (Current)
			
			file_name := dialog.file_name
			if file_name.count > 4 then
				ext := file_name.substring (file_name.count - 3, file_name.count)
				ext.to_lower
				if not ext.is_equal (".xml") then
					file_name := file_name + ".xml"
				end
			elseif file_name.count > 0 then
				file_name := file_name + ".xml"
			end
			if file_name.count > 0 then
				last_file_name := file_name
				save (file_name)
			end
		end
		
	last_file_name: STRING
			-- last used file name.
		
	save (file_name: STRING) is
			-- Save `buffer' to `file'.
		require
			file_name_exists: file_name /= Void
		local
			ptf: RAW_FILE
		do
			create ptf.make_open_write (file_name)
			world.store (ptf)
		end
		
	on_open is
			-- User selected open.
		local
			dialog: EV_FILE_OPEN_DIALOG
			l_nodes: LIST [EG_LINKABLE_FIGURE]
			l_item: EG_LINKABLE_FIGURE
		do
			create dialog
			dialog.filters.extend (["*.xml", "XML File"])
			dialog.show_modal_to_window (Current)
			
			if dialog.file_name /= Void then
				last_file_name := dialog.file_name
				load (last_file_name)
				
				from
					l_nodes := small_world.flat_nodes
					l_nodes.start
				until
					l_nodes.after
				loop
					l_item := l_nodes.item
					if l_item.is_label_shown then
						l_item.hide_label
					end
					l_item.move_actions.extend (agent on_small_move)
					l_item.set_point_position (300 - random.next_item_in_range (0, 200), 300 - random.next_item_in_range (0, 200))
					l_nodes.forth
				end
				
				if physics_layout.is_stopped then
					physics_layout.reset
					iterations := 0
				end
			end
		end
		
	load (file_name: STRING) is
			-- Load file with `file_name'.
		require
			file_name_exists: file_name /= Void
		local
			ptf: RAW_FILE
		do
			create ptf.make_open_read (file_name)
			graph.wipe_out
			world.retrieve (ptf)
			world.full_redraw
			small_world.full_redraw
			node_counter := graph.flat_nodes.count
		end

feature {NONE} -- New

	on_new is
			-- New was selected by user.
		do
			last_file_name := Void
			node_counter := 0
			graph.wipe_out
			world.full_redraw
			small_world.full_redraw
		end
		
feature {NONE} -- Layouts

	layout_circle is
			-- Layout nodes in `world' in a circle.
		do
			circle_layout.set_center (model_cell.width // 2, model_cell.height // 2)
			circle_layout.set_radius ((model_cell.width // 2 - 50).min (model_cell.height // 2 - 50))
			circle_layout.layout
		end
		
	layout_grid is
			-- Layout nodes in `world' in a grid.
		local
			math: DOUBLE_MATH
			noc: INTEGER
		do
			create math
			noc := math.sqrt(node_counter).ceiling
			grid_layout.set_number_of_columns (noc)
			grid_layout.set_point_a_position (50, 50)
			grid_layout.set_point_b_position (model_cell.width - 50, model_cell.height - 50)
			grid_layout.layout
		end

feature {NONE} -- Implementation

	time: C_DATE is
			-- Time to messure the speed.
		once
			create Result
		end

	cpu_ticks: INTEGER is
		do
			time.update
			Result := time.millisecond_now + time.second_now * 1000 + time.minute_now * 60000
		end
		
	accept_node: EV_CURSOR is
		local
			pix: EV_PIXMAP
		once
			create pix
			pix.set_with_named_file ("node.png")
			create Result.make_with_pixmap (pix, 8, 8)
		end
		
	deny_node: EV_CURSOR is
		local
			pix: EV_PIXMAP
		once
			create pix
			pix.set_with_named_file ("Xnode.png")
			create Result.make_with_pixmap (pix, 8, 8)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GRAPH_MAIN_WINDOW

