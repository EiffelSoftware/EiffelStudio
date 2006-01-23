indexing
	description: "[
			Objects that arrange nodes using a physical model.
			This algorithm has runtime complexity O(n^2) and is replaced by
			EG_FORCE_DIRECTED_LAYOUT wich does the same with complexity O(n log n).
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_FORCE_DIRECTED_LAYOUT_N2
	
obsolete
	"Use EG_FORCE_DIRECTED_LAYOUT instead."

inherit
	EG_LAYOUT
		redefine
			default_create,
			layout
		end
		
	EV_MODEL_DOUBLE_MATH
		undefine
			default_create
		end
		
create
	make_with_world
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EG_FORCE_DIRECTED_LAYOUT
		do
			Precursor {EG_LAYOUT}
			preset (3)
			move_threshold := 10.0
			create stop_actions
		end
			
feature -- Access

	center_attraction: INTEGER
		
	stiffness: INTEGER
		
	electrical_repulsion: INTEGER
		
	energy_tolerance: DOUBLE
			-- Algorithm variables
			
	center_x: INTEGER
	center_y: INTEGER
			-- Position of the center.
			
	stop_actions: EV_NOTIFY_ACTION_SEQUENCE
	
	move_threshold: DOUBLE
			-- Stop layouting and call `stop_actions' if no node moved
			-- for more then `move_threshold'.
			
feature -- Access

	fence: EV_RECTANGLE
			-- Fence to keep nodes in (optional, Void if no fence)
			
	is_stopped: BOOLEAN
		
			
feature -- Element change

	set_fence (a_fence: like fence) is
			-- Set 'fence'.
		do
			fence := a_fence
		ensure
			set: fence = a_fence
		end
		
	set_move_threshold (d: DOUBLE) is
			-- Set `move_threshold' to `d'.
		do
			move_threshold := d
		ensure
			set: move_threshold = d
		end
		
		
feature -- Basic operations

	preset (a_level: INTEGER) is
			-- Rest the setting accoridingly to 'a_level', which is one of:
			-- 1: tight, 2: normal, 3: loose
		do
			if a_level = 1 then
				-- Tight
				set_center_attraction (90)
				set_stiffness (100)
				set_electrical_repulsion (30)
			elseif a_level = 2 then
				-- Normal
				set_center_attraction (50)
				set_stiffness (50)
				set_electrical_repulsion (50)
			elseif a_level = 3 then
				-- Loose
				set_center_attraction (10)
				set_stiffness (0)
				set_electrical_repulsion (90)
			end
		end

	set_center_attraction (a_value: INTEGER) is
			-- Set 'center_attraction' value in percentage of maximum.
		require
			valid_value: a_value >= 0 and then a_value <= 100
		do
			center_attraction := a_value
		ensure
			set: center_attraction = a_value
		end

	set_stiffness (a_value: INTEGER) is
			-- Set 'stiffness' value in percentage of maximum.
		require
			valid_value: a_value >= 0 and then a_value <= 100
		do
			stiffness := a_value
		ensure
			set: stiffness = a_value
		end

	set_electrical_repulsion (a_value: INTEGER) is
			-- Set 'electrical_repulsion' value in percentage of maximum.
		require
			valid_value: a_value >= 0 and then a_value <= 100
		do
			electrical_repulsion := a_value
		ensure
			set: electrical_repulsion = a_value
		end
		
	set_center (ax, ay: INTEGER) is
			-- Set `center_x' to `ax' and `center_y' to `ay'.
		do
			center_x := ax
			center_y := ay
		end
		
	reset is
			-- Set `is_stopped' to False.
		do
			is_stopped := False
		ensure
			set: not is_stopped 
		end
		
	stop is
			-- Set `is_stopped' to True, call `stop_actions'.
		do
			is_stopped := True
			stop_actions.call (Void)
		ensure
			set: is_stopped
		end

	layout is
			-- Arrange the elements in `graph'.
		do
			if not is_stopped then
				max_move := 0.0
				internal_center_attraction := (center_attraction / 50) --/ (world.scale_factor ^ 2)
				internal_stiffness := (0.01 + stiffness / 300) --/ (world.scale_factor ^ 2)
				internal_electrical_repulsion := (1 + electrical_repulsion * 200) * (world.scale_factor ^ 1.5)
				layout_linkables (world.nodes, 1, void)
				if max_move < move_threshold * world.scale_factor ^ 0.5  then
					is_stopped := True
					stop_actions.call (Void)
				end
			end
		end

feature {NONE} -- Implementation

	ground_tolerance: DOUBLE is 2.0
	previous_total_energy: DOUBLE
	total_energy: DOUBLE
	internal_center_attraction: DOUBLE
	internal_stiffness: DOUBLE
	internal_electrical_repulsion: DOUBLE
	

	max_move: DOUBLE
			-- Maximal move in x and y direction of a node.

	
	tolerance: DOUBLE is 0.001
	math: DOUBLE_MATH is once create Result end
			-- For math functions
	
	get_link_weight (link: EG_LINK_FIGURE): DOUBLE is
			-- 
		do
			Result := 0.25 / world.scale_factor
		end
		
	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables'.
		local
			l_distance, l_force: DOUBLE
			l_item, l_other: EG_LINKABLE_FIGURE
			links: ARRAYED_LIST [EG_LINK_FIGURE]
			i, nb, j, nb2: INTEGER
			move: DOUBLE
			px, py: INTEGER
			opx, opy: INTEGER
			a_edge: EG_LINK_FIGURE
			l_weight: DOUBLE
		do
			if not is_stopped then
				from
					i := 1
					nb := linkables.count
				until
					i > nb
				loop
					l_item := linkables.i_th (i)
					if l_item.is_show_requested and then not l_item.is_fixed then				
						px := l_item.port_x 
						py := l_item.port_y 

						if internal_center_attraction > 0 then
							l_distance := distance (center_x, center_y, px, py)
							if l_distance > 0.1 then
								l_force := - internal_center_attraction / l_distance
								l_item.set_delta (l_item.dx + l_force * (px - center_x), l_item.dy + l_force * (py - center_y))
							end
						end	

						links := l_item.links
						from
							j := 1
							nb2 := links.count
						until
							j > nb2
						loop
							a_edge := links.i_th (j)
							if a_edge.is_show_requested then
								if l_item = a_edge.source then
									l_other := a_edge.target
								else
									l_other := a_edge.source
								end
								if l_other.is_show_requested then 
									opx := l_other.port_x
									opy := l_other.port_y
									l_distance := distance (px, py, opx, opy)
									if l_distance > tolerance then
										l_weight := internal_stiffness * get_link_weight (a_edge)
										l_item.set_delta (l_item.dx - l_weight * (px - opx), l_item.dy - l_weight * (py - opy))
									end
								end
							end
							j := j + 1
						end
						
						from
							j := 1--i + 1
						until
							j > nb
						loop
							l_other := linkables.i_th (j)
							if l_other.is_show_requested then 
								if l_item /= l_other then
									opx := l_other.port_x 
									opy := l_other.port_y 
									
									l_distance := distance (px, py, opx, opy).max (tolerance)
									
									l_force := internal_electrical_repulsion / (l_distance^3)
									l_item.set_delta (l_item.dx + l_force  * (px - opx), l_item.dy + l_force *  (py - opy))
								end
							end
							j := j + 1
						end
						
						
						recursive_energy (l_item, linkables)
						move := (l_item.dt * l_item.dx).abs + (l_item.dt * l_item.dy).abs
						if move > max_move then
							max_move := move
						end
						l_item.set_x_y ((l_item.x + l_item.dx * l_item.dt).truncated_to_integer, (l_item.y + l_item.dy * l_item.dt).truncated_to_integer)
						l_item.set_delta (0, 0)
					end
					i := i + 1
				end
					
						
			end
		end
		
	repulse (a_node, a_other: EG_LINKABLE_FIGURE) is
			-- Get the electrical repulsion between all nodes, including those that are not adjacent.
		local
			l_distance, l_force: DOUBLE
			npx, npy, opx, opy: INTEGER
		do
			if a_node /= a_other then
				npx := a_node.port_x
				npy := a_node.port_y
				opx := a_other.port_x
				opy := a_other.port_y
				l_distance := distance (npx, npy, opx, opy)
				if l_distance < tolerance then
					l_distance := tolerance
				end
				l_force := internal_electrical_repulsion / l_distance / l_distance / l_distance
				a_node.set_delta (a_node.dx + l_force  * (npx - opx), a_node.dy + l_force *  (npy - opy))
			end
		end

	attract_connected (a_node: EG_LINKABLE_FIGURE; a_edge: EG_LINK_FIGURE) is
			-- Get the spring force between all of its adjacent nodes.
		local
			l_distance: DOUBLE
			l_other: EG_LINKABLE_FIGURE
			l_weight: DOUBLE
			npx, npy, opx, opy: DOUBLE--INTEGER
		do
			if a_node = a_edge.source then
				l_other := a_edge.target
			else
				l_other := a_edge.source
			end
			if l_other.is_show_requested then
				npx := a_node.port_x 
				npy := a_node.port_y 
				opx := l_other.port_x 
				opy := l_other.port_y 
				l_distance := distance (npx, npy, opx, opy)
				if l_distance > tolerance then
					l_weight := get_link_weight (a_edge)
					a_node.set_delta (a_node.dx - internal_stiffness * l_weight * (npx - opx), a_node.dy - internal_stiffness * l_weight * (npy - opy))
				end
			end
		end

	recursive_energy (a_node: EG_LINKABLE_FIGURE; linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]) is
		require
			a_node_not_void: a_node /= Void
			a_node_is_shown_requested: a_node.is_show_requested
		local
			l_initial_energy, l_dt, l_energy: DOUBLE
			i: INTEGER
			
			nb: INTEGER
			links: ARRAYED_LIST [EG_LINK_FIGURE]
			a_other: like a_node
			a_edge: EG_LINK_FIGURE
			l_distance, l_distance2: DOUBLE
			npx, npy: DOUBLE
			ox, oy, px, py: INTEGER
			l_weight: DOUBLE
		do
			l_dt := a_node.dt * 2
			a_node.set_dt (l_dt)
			
			px := a_node.port_x
			py := a_node.port_y
			npx := a_node.port_x + l_dt * a_node.dx
			npy := a_node.port_y + l_dt * a_node.dy
			l_energy := internal_center_attraction * distance (npx, npy, center_x, center_y)
			l_initial_energy := internal_center_attraction * distance (px, py, center_x, center_y)
			from
				i := 1
				nb := linkables.count
			until
				i > nb
			loop
				a_other := linkables.i_th (i)
				if a_node /= a_other and then a_other.is_show_requested then--and then a_other.has_visible_link then
					ox := a_other.port_x
					oy := a_other.port_y
					l_energy :=  l_energy + internal_electrical_repulsion / distance (npx, npy, ox, oy).max (0.0001)
					l_initial_energy :=  l_initial_energy + internal_electrical_repulsion / distance (px, py, ox, oy).max (0.0001)
				end
				i := i + 1
			end
			links := a_node.links
			from
				i := 1
				nb := links.count
			until
				i > nb
			loop
				a_edge := links.i_th (i)
				if a_edge.is_show_requested then
					if a_node = a_edge.source then
						a_other := a_edge.target
					else
						a_other := a_edge.source
					end
					if a_other /=Void and then a_other.is_show_requested then-- and then a_other.has_visible_link then
						ox := a_other.port_x
						oy := a_other.port_y
						l_weight := internal_stiffness * get_link_weight (a_edge)

						l_distance := distance (npx, npy, ox, oy)
						l_distance2 := distance (px, py, ox, oy)
						
						l_energy := l_energy +  l_weight * l_distance * l_distance / 2
						l_initial_energy := l_initial_energy + l_weight * l_distance2 * l_distance2 / 2
					end
				end
				i := i + 1
			end

			check
				l_energy = get_node_energy (a_node, l_dt, linkables)	
				l_initial_energy = get_node_energy (a_node, 0, linkables)
			end

			from
				i := 0
			until
				l_energy <= l_initial_energy or else i > 4
			loop
				i := i + 1
				l_dt := l_dt / 4
				l_energy := get_node_energy (a_node, l_dt, linkables)
			end
			a_node.set_dt (l_dt)
		end

	get_node_energy (a_node: EG_LINKABLE_FIGURE; a_dt: DOUBLE; linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]): DOUBLE is
		require
			a_node_not_void: a_node /= Void
			a_node_is_shown_requested: a_node.is_show_requested
		local
			i, nb: INTEGER
			links: ARRAYED_LIST [EG_LINK_FIGURE]
			a_other: like a_node
			a_edge: EG_LINK_FIGURE
			l_distance: DOUBLE
			npx, npy: DOUBLE
		do
			npx := a_node.port_x + a_dt * a_node.dx
			npy := a_node.port_y + a_dt * a_node.dy
			Result := internal_center_attraction * distance (npx, npy, center_x, center_y)
			from
				i := 1
				nb := linkables.count
			until
				i > nb
			loop
				a_other := linkables.i_th (i)
				if a_node /= a_other and then a_other.is_show_requested then--and then a_other.has_visible_link then
					Result :=  Result + internal_electrical_repulsion / distance (npx, npy, a_other.port_x, a_other.port_y).max (0.0001)
				end
				i := i + 1
			end
			links := a_node.links
			from
				i := 1
				nb := links.count
			until
				i > nb
			loop
				a_edge := links.i_th (i)
				if a_edge.is_show_requested then
					if a_node = a_edge.source then
						a_other := a_edge.target
					else
						a_other := a_edge.source
					end
					if a_other /=Void and then a_other.is_show_requested then-- and then a_other.has_visible_link then
						l_distance := distance (npx, npy, a_other.port_x, a_other.port_y)
						Result := Result + internal_stiffness * get_link_weight (a_edge) * l_distance * l_distance / 2
					end
				end
				i := i + 1
			end
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




end -- class EG_FORCE_DIRECTED_LAYOUT_N2

