note
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

	default_create
			-- Set `theta' to 0.25.
		do
			theta := 0.25
		ensure then
			set: theta = 0.25
		end

feature -- Element change.

	set_particles (a_particles: like particles)
			-- Set `particles' to `a_particles' and build `quad_tree'.
		do
			Precursor {EG_PARTICLE_SIMULATION} (a_particles)
			build_quad_tree
		ensure then
			quad_tree_exists: quad_tree /= Void
		end

	set_theta (a_theta: like theta)
			-- Set `theta' to `a_theta'.
		require
			a_theta_in_range: theta >= 0 and theta <= 1.0
		do
			theta := a_theta
		ensure
			set: theta = a_theta
		end

feature -- Access

	quad_tree: detachable EG_QUAD_TREE
			-- The quad tree to traverse.

	theta: DOUBLE
			-- The higher theta the more approximations are made (see comment in indexing)

	last_theta_average: DOUBLE
			-- The average theta value on last call to `force'.

feature {NONE} -- Implementation

	theta_count: INTEGER
			-- Number of times theta was below 1.0

	n_body_force_solver (a_particle: like particle_type): detachable G
			-- Solve n_nody_force O(log n) best case O(n) worste case
		do
			last_theta_average := 0.0
			theta_count := 0
			if attached quad_tree as l_quad_tree then
				Result := traverse_tree (l_quad_tree, a_particle)
			end
			if theta_count > 0 then
				last_theta_average := last_theta_average / theta_count
			end
		end

	traverse_tree (node: EG_QUAD_TREE; a_particle: like particle_type): detachable G
			-- Traverse `node' and calculate force with `a_particle'.
		require
			not_void: node /= Void
		local
			r: DOUBLE
			d: INTEGER
			prop: DOUBLE
			region: EV_RECTANGLE
			childe: detachable EG_QUAD_TREE
--			l_result: detachable like traverse_tree
			l_particle: detachable EG_PARTICLE
		do
			if node.is_leaf then
				l_particle := node.particle
				if l_particle /= Void then
					Result := n_body_force (a_particle, l_particle)
				else
					check is_leaf: False end
				end
			elseif attached node.center_of_mass_particle as cmp then
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
					if attached childe as l_childe then
						Result := traverse_tree (l_childe, a_particle)
					end
					childe := node.childe_nw
					if
						attached childe as l_childe_2 and then
						attached traverse_tree (l_childe_2, a_particle) as num
					then
						if Result = Void then
							Result := num
						else
							Result := Result + num
						end
					end
					childe := node.childe_se
					if
						attached childe as l_childe_3 and then
						attached traverse_tree (l_childe_3, a_particle) as num
					then
						if Result = Void then
							Result := num
						else
							Result := Result + num
						end
					end
					childe := node.childe_sw
					if
						attached childe as l_childe_4 and then
						attached traverse_tree (l_childe_4, a_particle) as num
					then
						if Result = Void then
							Result := num
						else
							Result := Result + num
						end
					end
				end
			else
				check node_has_center_of_mass_particle: False end
			end
--		ensure
--			Result_exists: Result /= Void
		end

	build_quad_tree
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
				if attached quad_tree as l_quad_tree then
					if not l_quad_tree.has (l_item) then
						l_quad_tree.insert (l_item)
					end
				else
					create quad_tree.make (world_size, l_item)
				end
				l_particles.forth
			end
			if attached quad_tree as l_quad_tree_2 then
				l_quad_tree_2.build_center_of_mass
			else
				check False end -- Implied by previous loop
			end
		ensure
			build: quad_tree /= Void
		end

invariant
	quad_tree_exists: quad_tree /= Void

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EG_PARTICLE_SIMULATION_BH

