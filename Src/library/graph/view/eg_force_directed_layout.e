indexing
	description: "[
			EG_FORCE_DIRECTED_LAYOUT is a force directed layout using a spring particle system and
			a Barnes and Hut solver. The complexity is therfore O(n log n) where n is the number of
			linkables.

			Links between nodes behave as if they where springs.
				The higher `stiffness' the stronger the springs.

			All nodes are repulsing each other from each other as if they where magnets with same polarity.
				The higher `electrical_repulsion' the stronger the repulsion.

			All nodes fall into the center.
				The position of the center is (`center_x', `center_y') and the higher `center_attraction'
				the faster the nodes fall into the center.

			`theta' is the error variable for Barnes and Hut where 0 is low error and slow calculation and
				100 is high error and fast calculation.

				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_FORCE_DIRECTED_LAYOUT

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
			move_threshold := 10
			theta :=  25
			create stop_actions
		end

feature -- Status report

	is_stopped: BOOLEAN
			-- Is stopped?

feature -- Access

	center_attraction: INTEGER
			-- Attraction of the center in percent.

	center_x: INTEGER
			-- X position of the center.

	center_y: INTEGER
			-- Y position of the center.

	stiffness: INTEGER
			-- Stiffness of the links in percent.

	electrical_repulsion: INTEGER
			-- Electrical repulsion between nodes in percent.

	stop_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when the layouting stops.

	move_threshold: DOUBLE
			-- Call `stop_actions' if no node moved
			-- for more then `move_threshold'.

	theta: INTEGER
			-- Error variable for Barnes and Hut.

	last_theta_average: DOUBLE
			-- Average theta value after last call to `layout'.

feature -- Element change

	preset (a_level: INTEGER) is
			-- Rest the setting accordingly to `a_level', which is one of:
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
				set_center_attraction (15)
				set_stiffness (2)
				set_electrical_repulsion (100)
			end
		end

	set_move_threshold (d: INTEGER) is
			-- Set `move_threshold' to `d'.
		do
			move_threshold := d
		ensure
			set: move_threshold = d
		end

	set_theta (a_theta: INTEGER) is
			-- Set `theta' to `a_theta'.
		require
			valid_value: a_theta >= 0 and a_theta <= 100
		do
			theta := a_theta
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
		ensure
			set: center_x = ax and center_y = ay
		end

feature -- Basic operations

	reset is
			-- Set `is_stopped' to False.
		do
			is_stopped := False
			iterations := 0
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
				if world.nodes.is_empty then
					is_stopped := True
					stop_actions.call (Void)
				else
					max_move := 0
					last_theta_average := 0.0
					theta_count := 0

					layout_linkables (world.nodes, 1, Void)

					if max_move < move_threshold * world.scale_factor ^ 0.5 and iterations > 10 then
						is_stopped := True
						stop_actions.call (Void)
					else
						iterations := iterations + 1
					end
					if theta_count > 0 then
						last_theta_average := last_theta_average / theta_count
					end
				end
			else
				last_theta_average := 0.0
			end
		end

feature {NONE} -- Implementation

	max_move: INTEGER
			-- Maximal move in x and y direction of a node.

	theta_count: INTEGER
			-- Theta count.

	iterations: INTEGER
			-- Number of iterations

	layout_linkables (linkables: ARRAYED_LIST [EG_LINKABLE_FIGURE]; level: INTEGER; cluster: EG_CLUSTER_FIGURE) is
			-- arrange `linkables'.
		local
			l_item: EG_LINKABLE_FIGURE
			i, nb: INTEGER
			l_force: EG_VECTOR2D [DOUBLE]
			dx, dy: INTEGER
			move: INTEGER
			l_linkables: like linkables
			spring_particle: EG_SPRING_PARTICLE
			spring_energy: EG_SPRING_ENERGY
		do
			if not is_stopped then
				-- Filter out not visible nodes
				from
					create l_linkables.make (linkables.count)
					linkables.start
				until
					linkables.after
				loop
					l_item := linkables.item
					if l_item.is_show_requested then
						l_linkables.extend (l_item)
					end
					linkables.forth
				end

				if not l_linkables.is_empty then
							-- Initialize particle solvers
					spring_particle := new_spring_particle_solver (l_linkables)
					spring_energy := new_spring_energy_solver (l_linkables)

						-- solve system
					from
						i := 1
						nb := l_linkables.count
					until
						i > nb
					loop
						l_item := l_linkables.i_th (i)

						if not l_item.is_fixed then
								-- Calculate spring force
							l_force := spring_particle.force (l_item)
							l_item.set_delta (l_force.x, l_force.y)
								-- Update statistic
							last_theta_average := last_theta_average + spring_particle.last_theta_average
							theta_count := theta_count + 1

								-- Calculate spring energy
							recursive_energy (l_item, spring_energy)

								-- Move item
							dx := (l_item.dt * l_item.dx).truncated_to_integer
							dy := (l_item.dt * l_item.dy).truncated_to_integer

							move := dx.abs + dy.abs
							if move > max_move then
								max_move := move
							end

							l_item.set_x_y (l_item.x + dx, l_item.y + dy)
							l_item.set_delta (0, 0)
						end
						i := i + 1
					end
				end
			end
		end

	recursive_energy (a_node: EG_LINKABLE_FIGURE; solver: EG_SPRING_ENERGY) is
			-- Calculate spring energy for `a_node'
		local
			i: INTEGER
			l_energy, l_initial_energy: DOUBLE
			l_dt: DOUBLE
		do
			l_dt := a_node.dt

			a_node.set_dt (0)
			l_initial_energy := solver.force (a_node)
			last_theta_average := last_theta_average + solver.last_theta_average
			theta_count := theta_count + 1

			l_dt := (l_dt * 2)
			a_node.set_dt (l_dt)
			l_energy := solver.force (a_node)
			last_theta_average := last_theta_average + solver.last_theta_average
			theta_count := theta_count + 1

			from
				i := 0
			until
				l_energy <= l_initial_energy or else i > 4
			loop
				i := i + 1
				l_dt := l_dt / 4
				a_node.set_dt (l_dt)
				l_energy := solver.force (a_node)
				last_theta_average := last_theta_average + solver.last_theta_average
				theta_count := theta_count + 1
			end
		end

	new_spring_particle_solver (particles: LIST [EG_LINKABLE_FIGURE]): EG_SPRING_PARTICLE is
			-- Create a new spring particle solver for `particles' and initialize it.
		require
			particles_exist: particles /= Void
			particles_not_empty: not particles.is_empty
		local
			l_center_attraction, l_stiffness, l_electrical_repulsion: DOUBLE
		do
			l_center_attraction := center_attraction / 25
			l_stiffness := ((stiffness / 300) * 0.5).max (0.0001) / world.scale_factor
			l_electrical_repulsion := (1 + electrical_repulsion * 400) * (world.scale_factor ^ 1.5)

			create Result.make_with_particles (particles)

			Result.set_center (center_x, center_y)
			Result.set_center_attraction (l_center_attraction)
			Result.set_electrical_repulsion (l_electrical_repulsion)
			Result.set_stiffness (l_stiffness)
			Result.set_theta (theta / 100)
		ensure
			Result_exists: Result /= Void
		end

	new_spring_energy_solver (particles: LIST [EG_LINKABLE_FIGURE]): EG_SPRING_ENERGY is
			-- Create a new spring energy solver for `particles' and initialize it.
		require
			particles_exist: particles /= Void
			particles_not_empty: not particles.is_empty
		local
			l_center_attraction, l_stiffness, l_electrical_repulsion: DOUBLE
		do
			l_center_attraction := center_attraction / 25
			l_stiffness := ((stiffness / 300) * 0.5).max (0.0001) / world.scale_factor
			l_electrical_repulsion := (1 + electrical_repulsion * 400) * (world.scale_factor ^ 1.5)

			create Result.make_with_particles (particles)

			Result.set_center (center_x, center_y)
			Result.set_center_attraction (l_center_attraction)
			Result.set_electrical_repulsion (l_electrical_repulsion)
			Result.set_stiffness (l_stiffness)
			Result.set_theta (theta / 100)
		ensure
			Result_exists: Result /= Void
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




end -- class EG_FORCE_DIRECTED_LAYOUT

