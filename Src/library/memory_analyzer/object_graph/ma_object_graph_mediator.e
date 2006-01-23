indexing
	description: "Analyze the objects in the memory on a graph"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_GRAPH_MEDIATOR
	
inherit
	MA_SINGLETON_FACTORY
	
create
	make_with_drawable
	
feature {NONE} -- Initialization

	make_with_drawable (a_drawable: EV_FRAME) is
			-- Create function.
		require
			a_drawable_not_void: a_drawable /= Void
			a_drawable_not_destroyed: not a_drawable.is_destroyed
			a_drawable_not_full: a_drawable.extendible
		do
			object_drawing:= a_drawable
			
			create graph
			create world.make_with_model_and_factory (graph, create {MA_FIGURE_FACTORY})
			create model_cell.make_with_world (world)	
			
			object_drawing.set_minimum_height (600)
			object_drawing.extend (model_cell)	
			
			create objects_already_draw.make (10)
			
			node_counter := 0
			last_zoom_value := 50
		
			create links_should_orignal_color.make (10)
			create nodes_visited.make (10)
			create grid_layout.make_with_world (world)
		end
	
feature -- Command

	arrange_in_grid is
			-- Arrange nodes in a circle.
		local
			math: DOUBLE_MATH
			noc: INTEGER
		do
			if node_counter > 0  then
				create math
				noc := math.sqrt(node_counter).ceiling
				grid_layout.set_number_of_columns (noc)
				grid_layout.set_point_a_position (10, 10)
				grid_layout.set_point_b_position (object_drawing.width - 50, object_drawing.height - 50)
				grid_layout.layout				
			end
		end
		
	find_draw_node_by_object (a_object: ANY): EG_NODE is
			-- Find in `objects_already_draw' return a EG_NODE which corresponding to object.
		require
			a_object_not_void : a_object /= Void
		local
			l_obj_with_node : TUPLE [ANY, EG_NODE]
		do
			from 
				objects_already_draw.start
			until
				Result /= Void or objects_already_draw.after
			loop
				l_obj_with_node := objects_already_draw.item_for_iteration
					-- Test the address.
				if l_obj_with_node.item (1) = a_object then
					Result ?= l_obj_with_node.item (2)
					check
						result_not_void: Result /= Void
					end
				end
				objects_already_draw.forth
			end
		ensure
			result_not_void : Result /= Void
		end
		

	object_already_draw (a_object: ANY): BOOLEAN is
			-- if a_object already have a represent figure drawed ?
		require 
			a_object_not_void : a_object /= Void
		do
			from 
				objects_already_draw.start
			until
				Result or objects_already_draw.after
			loop
				Result := a_object = objects_already_draw.item_for_iteration.item (1)
				objects_already_draw.forth
			end
		end
	
	clear_graph is		
			-- Clear graph.
		do
			graph.wipe_out
			node_counter := 0
			objects_already_draw.wipe_out
		end
	
	add_nodes_refer_to (a_object: ANY) is
			-- Add the a_object node and all the nodes refers to it.
		require
			a_object_not_void: a_object /= Void
		local
			refers: SPECIAL[ANY]
			i: INTEGER
			l_temp : ANY
		do
		
			if not object_already_draw (a_object) then
				add_node_random_pos(a_object.generating_type)
				refers  := memory.referers (a_object)
 				if refers /= Void then
 					from 
 						i := 0
 					until
 						i = refers.count
 					loop
 						l_temp := refers.item (i)
 						add_nodes_refer_to (l_temp)
 						i := i + 1
 					end
 				end
			end
		end
		
	add_node_random_pos(a_object:ANY) is
			-- Add a node into the graph at a random position
		require
			a_object_not_void: a_object /= Void
		do
			add_node (random.next_item_in_range (0, object_drawing.width),random.next_item_in_range (0,object_drawing.height), a_object)
		end
		
	add_node (ax, ay: INTEGER;a_object:ANY) is
			-- Add a new node to `graph' position it at (`ax', `ay') in `world'.
		require
			a_object_not_void: a_object /= Void
			ax_not_large_or_small: ax >= 0 and ax <= 2000
			ay_not_large_or_small: ay >= 0 and ay <= 2000
		local
			fig: EG_FIGURE
			l_intro : STRING
			l_tuple: TUPLE [ANY, EG_NODE]
		do
			node_counter := node_counter + 1
			
			create last_drawed_node
			
			l_intro := a_object.out
			if l_intro.count > 20 then
				l_intro := internal.type_name (a_object)
			end
			last_drawed_node.set_name (node_counter.out + " : " + l_intro)
			graph.add_node (last_drawed_node)

			fig := world.figure_from_model (last_drawed_node)
			fig.set_point_position (ax, ay)

			-- Make new node figure a drop target
			fig.set_accept_cursor (accept_node)
			fig.set_deny_cursor (deny_node)
--			fig.drop_actions.extend (agent on_link_drop (?, last_drawed_node))
			
			-- Make new node figure pickable
--			fig.set_pebble (create {NODE_STONE}.make (last_drawed_node))

			fig.pointer_button_release_actions.extend (agent on_select_node)
			create l_tuple
			l_tuple.put (a_object, 1)
			l_tuple.put (last_drawed_node, 2)
			check
				a_object /= Void
				last_drawed_node /= Void
			end
			world.update
			-- Put the object and the node into the hashtable
			objects_already_draw.force (l_tuple, fig)
		end		
		
	on_select_node (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Set the refernce lines red, others black.
		local
			l_node_figure: EG_FIGURE
		do
			l_node_figure := world.selected_figures.first

			node_reference_change_color (l_node_figure)
			set_reference_line_color_back
			nodes_visited.wipe_out
		end
	
	add_link (n1, n2: EG_LINKABLE) is
			-- Add a link to `graph' connecting `n1' with `n2'.
		require
			n1_not_void: n1 /= Void
			n2_not_void: n2 /= Void
		do
			graph.add_link (create {EG_LINK}.make_directed_with_source_and_target (n1, n2) )
		end
		
feature -- Implementation for agents
	
	drop_a_object (a_object: ANY) is
			-- When user pick a object from the object_grid (in main_book's 2nd tab).
		require
			a_object_not_void: a_object /= Void
		local
			l_info: EV_INFORMATION_DIALOG
		do
			if object_already_draw (a_object) then
				create l_info.make_with_text ("The object is already on the graph.")
				l_info.show_relative_to_window (main_window)
			else
				add_node_random_pos (a_object)				
			end
		end
		
	find_refers is
			-- Find the refers to current slected node and draw the nodes which refer to it.
		local
			l_nodes: ARRAYED_LIST [EG_FIGURE]	
			l_node: EG_FIGURE
			l_object: ANY
			l_refers: SPECIAL [ANY]
			l_int,refer_count: INTEGER
			l_link_node: EG_NODE
			l_linkable: EG_LINKABLE
			l_info_dlg: EV_INFORMATION_DIALOG
		do
			l_nodes := world.selected_figures
			if l_nodes.count > 0 then
				l_node := l_nodes.first
				l_object :=	objects_already_draw.item (l_node).item (1)
				l_refers := memory.referers (l_object)
				from 
					l_int := 0
					refer_count := l_refers.count
				until
					l_int = refer_count
				loop
					if object_already_draw(l_refers.item (l_int))  then
						-- add link to two already drawed object
						l_link_node := find_draw_node_by_object(l_refers.item (l_int))
						l_linkable ?= objects_already_draw.item (l_node).item (2)
						check 
							l_linkable /= Void
						end
						add_link (l_linkable, l_link_node )
					else
						add_node_random_pos(l_refers.item (l_int))
						l_linkable ?= objects_already_draw.item (l_node).item (2)
						check 
							l_linkable /= Void
						end
						add_link (l_linkable, last_drawed_node )
					end					
					l_int := l_int + 1
				end
			else
				create l_info_dlg.make_with_text ("Please select a node first.")
				l_info_dlg.show_relative_to_window (main_window)
			end
			world.update
		end		

	find_object_by_type_name (a_type_name: STRING) is
			-- Find all the objects in the system which type is "a_type_name".
		local
			l_temp : ANY
			l_information:EV_INFORMATION_DIALOG
		do
			l_temp := object_finder.find_objects_by_type_name (a_type_name)
			if l_temp = Void then
				create l_information.make_with_text ("object with type name "+a_type_name+" not found.")
				l_information.show_relative_to_window (main_window)
			elseif object_already_draw (l_temp) then
				create l_information.make_with_text ("object with type name "+a_type_name+" already exist on the graph.")
				l_information.show_relative_to_window (main_window)
			else
				add_objects_of_same_type (a_type_name)
			end
		end
		
	
	
	zoom_changed (a_value:INTEGER) is
			-- Change the graph size base on the zoom value.
		require
			a_value_not_zeor: a_value /= 0
		do
			world.scale (a_value/last_zoom_value)
			last_zoom_value := a_value
		end

	find_object_by_instance_name (a_object_name: STRING) is
			-- Find all the objects which name (the field name) is a_object_name then put then all on the graph.
		local
			l_object:ANY
			l_information:EV_INFORMATION_DIALOG
			object_drawed:BOOLEAN
		do
			l_object := object_finder.find_objects_by_object_name (a_object_name)
			if l_object /= Void then
				--check if the graph already draw
				object_drawed := object_already_draw (l_object)
				if not object_drawed then
					clear_graph
					add_node (random.next_item_in_range (0, object_drawing.width), random.next_item_in_range (0, object_drawing.height), l_object.generating_type)
				else
					create l_information.make_with_text ("The object with name %"" + a_object_name + "%" already in the graph.")
					l_information.show_relative_to_window (main_window)
				end
			else
				create l_information.make_with_text ("The object with name %"" + a_object_name + "%" not found.")
				l_information.show_relative_to_window (main_window)
			end
		end


feature {NONE} -- Graphics Implementation
	
	node_reference_change_color (a_node: EG_FIGURE) is
			-- Change the reference line color, and set other reference lines' color back.
		local
			l_links: ARRAYED_LIST [EG_LINK]
			l_link: EG_LINK
			l_ref_link: MA_REFERENCE_LINK
		do
			l_links := graph.flat_links
			
			from 
				l_links.start
			until
				l_links.after
			loop
		
				l_link := l_links.item
				if l_link.source = a_node.model  then				

					l_ref_link ?= world.figure_from_model (l_link)
					check l_ref_link /= Void end
					l_ref_link.set_color
					if not nodes_visited.has (world.figure_from_model (l_link.target)) then
						nodes_visited.force (Void, world.figure_from_model (l_link.target))
						node_reference_change_color (world.figure_from_model (l_link.target))
					else					
						io.put_string ("%NThere is a circle relation in the graph. the class name is : ..."  )
					end

					links_should_orignal_color.force (Void, l_link)
				end
				l_links.forth
			end
		end	
		
	set_reference_line_color_back is
			-- Set the lines' color  which is should be orignal color.
		local
			l_links: ARRAYED_LIST [EG_LINK]
			l_ref_link: MA_REFERENCE_LINK
		do
			l_links := graph.flat_links
			from 
				l_links.start
			until
				l_links.after
			loop
				if not links_should_orignal_color.has (l_links.item) then
					l_ref_link ?= world.figure_from_model (l_links.item)
					check l_ref_link /= Void end
					l_ref_link.set_color_back
				end
				l_links.forth
			end
			links_should_orignal_color.wipe_out
		end
		
feature {NONE} -- Low Level Logic Implementation

	add_objects_of_same_type (a_type_name: STRING) is
			-- Add all objects of the given dynamic type.
		require
			a_type_name_not_void: a_type_name /= Void
		local
			l_type_key: INTEGER
			l_data: ARRAYED_LIST[ANY]
			l_row_index, i: INTEGER
			l_item: ANY
		do
			l_type_key:= object_finder.find_key_for_type (a_type_name)
			l_data := memory.memory_map.item (l_type_key)
			
			if l_data /= Void then
				from
					l_data.start
					i := l_row_index + 1
				until
					l_data.after
				loop
					l_item := l_data.item
					if l_item /= Void then
						add_node_random_pos (l_item)						
					end
					l_data.forth
				end
			end
		end
		
	random: MA_RANGED_RANDOM is
		once
			create Result.make
		end

feature {NONE} -- Fields 

	links_should_orignal_color: DS_HASH_TABLE [ANY, EG_LINK] 
			-- Nodos which should be orignal color
	
	nodes_visited: DS_HASH_TABLE [ANY, EG_FIGURE]
			-- Nodes which should have been visited

	grid_layout: EG_GRID_LAYOUT
			-- Layout can layout the nodes in the figure
	
	last_drawed_node:EG_NODE
			--Node which was just drawed

	objects_already_draw: DS_HASH_TABLE [TUPLE [ANY, EG_NODE], EG_FIGURE]
			-- Objects which is already draw on the graph, ANY is the object which EG_NODE is correspond to
	
	object_drawing : EV_FRAME
			-- Place this class to draw graphics of objects
	world: EG_FIGURE_WORLD
			-- World allowing to manipulate the graph.
	model_cell: MA_WORLD_CELL
			-- Cell allowing to edit the graph.
	graph: EG_GRAPH
			-- Graph contain object nodes.
	node_counter: INTEGER
			-- Number of nodes in the graph.

	last_zoom_value: INTEGER
			-- Last zoom value of the scale. It is used for zoom graph.
			
invariant

	objects_already_draw_not_void: objects_already_draw /= Void
	object_drawing_not_void: object_drawing /= Void
	graph_not_void: graph /= Void
	world_not_void: world /= Void
	model_cell_not_void: model_cell /= Void
	links_should_orignal_color_not_void: links_should_orignal_color /= Void
	nodes_visited_not_void: nodes_visited /= Void
	grid_layout_not_void: grid_layout /= Void
	objects_already_draw_has_no_void_item: True-- No Void items in `objects_already_draw'
	
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




end
