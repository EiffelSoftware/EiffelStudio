indexing
	description: "[
			This is the Barnes and Hut implementation for the n_body_force_solver of
			a particle system. The runtime is O (n log n) where n is the number of particles.
			The method was first proposed in:
			"A Hierarchical O(n log n) force calculation algorithm", J. Barnes and P. Hut, Nature, v. 324 (1986)

			To calculate the force on a_particle an EG_QUAD_TREE (node) is traversed where force is either

				traverse (node):
					1. if node is a leaf
						force := n_body_force (a_particle, node.particle)
					2. size of node region / distance between a_particle and center of mass of node < theta
						force := n_body_force (a_particle, node.center_of_mass_particle)
					3. none of the above
						for all children c of node
							force := force + traverse (c)

			The larger theta the better the runtime but also the higher the error since center_of_mass_particle
			is only an approximation of all the particle in the children of node.

				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_PARTICLE_SIMULATION_BH [G -> NUMERIC]

inherit
	EG_PARTICLE_SIMULATION [G]
		redefine
			default_create,
			set_particles
		end

	EV_MODEL_DOUBLE_MATH
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Set `theta' to 0.25.
		do
			theta := 0.25
		ensure then
			set: theta = 0.25
		end

feature -- Element change.

	set_particles (a_particles: like particles) is
			-- Set `particles' to `a_particles' and build `quad_tree'.
		do
			Precursor {EG_PARTICLE_SIMULATION} (a_particles)
			build_quad_tree
		ensure then
			quad_tree_exists: quad_tree /= Void
		end

	set_theta (a_theta: like theta) is
			-- Set `theta' to `a_theta'.
		require
			a_theta_in_range: theta >= 0 and theta <= 1.0
		do
			theta := a_theta
		ensure
			set: theta = a_theta
		end

feature -- Access

	quad_tree: EG_QUAD_TREE
			-- The quad tree to traverse.

	theta: DOUBLE
			-- The higher theta the more approximations are made (see comment in indexing)

	last_theta_average: DOUBLE
			-- The average theta value on last call to `force'.

feature {NONE} -- Implementation

	theta_count: INTEGER
			-- Number of times theta was below 1.0

	n_body_force_solver (a_particle: like particle_type): G is
			-- Solve n_nody_force O(log n) best case O(n) worste case.
		do
			last_theta_average := 0.0
			theta_count := 0
			Result := traverse_tree (quad_tree, a_particle)
			if theta_count > 0 then
				last_theta_average := last_theta_average / theta_count
			end
		end

	traverse_tree (node: EG_QUAD_TREE; a_particle: like particle_type): G is
			-- Traverse `node' and calculate force with `a_particle'.
		local
			r: DOUBLE
			d: INTEGER
			prop: DOUBLE
			cmp: EG_PARTICLE
			region: EV_RECTANGLE
			childe: EG_QUAD_TREE
		do
			if node.is_leaf then
				Result := n_body_force (a_particle, node.particle)
			else
				cmp := node.center_of_mass_particle
				region := node.region
					-- Distance to center of mass
				r := distance (a_particle.x, a_particle.y, cmp.x, cmp.y)
					-- size of the cell
				d := region.width.max (region.height)
					-- proportion between distance and size
				prop := d/r

				if prop < 1.0 then
					last_theta_average := last_theta_average + prop
					theta_count := theta_count + 1
				end
				if prop < theta then
						-- Approximate
					Result := n_body_force (a_particle, cmp)
				else
						-- Inspect children
					childe := node.childe_ne
					if childe /= Void then
						Result := traverse_tree (childe, a_particle)
					end
					childe := node.childe_nw
					if childe /= Void then
						if Result = Void then
							Result := traverse_tree (childe, a_particle)
						else
							Result := Result + traverse_tree (childe, a_particle)
						end
					end
					childe := node.childe_se
					if childe /= Void then
						if Result = Void then
							Result := traverse_tree (childe, a_particle)
						else
							Result := Result + traverse_tree (childe, a_particle)
						end
					end
					childe := node.childe_sw
					if childe /= Void then
						if Result = Void then
							Result := traverse_tree (childe, a_particle)
						else
							Result := Result + traverse_tree (childe, a_particle)
						end
					end
				end
			end
		ensure
			Result_exists: Result /= Void
		end

	build_quad_tree is
			-- Build `quad_tree' from `particles'. O(n log n)
		local
			l_particles: like particles
			l_item: like particle_type
			world_size: EV_RECTANGLE
			maxx, minx, maxy, miny, x, y: INTEGER
		do
			from
				maxx := maxx.min_value
				maxy := maxx
				minx := minx.max_value
				miny := minx
				l_particles := particles
				l_particles.start
			until
				l_particles.after
			loop
				l_item := l_particles.item
				x := l_item.x
				maxx := maxx.max (x)
				minx := minx.min (x)
				y := l_item.y
				maxy := maxy.max (y)
				miny := miny.min (y)
				l_particles.forth
			end
			create world_size.make (minx, miny, maxx - minx, maxy - miny)
			from
				l_particles := particles
				l_particles.start
			until
				l_particles.after
			loop
				l_item := l_particles.item
				if quad_tree = Void then
					create quad_tree.make (world_size, l_item)
				else
					if not quad_tree.has (l_item) then
						quad_tree.insert (l_item)
					end
				end
				l_particles.forth
			end
			quad_tree.build_center_of_mass
		ensure
			build: quad_tree /= Void
		end

invariant
	quad_tree_exists: quad_tree /= Void

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




end -- class EG_PARTICLE_SIMULATION_BH

