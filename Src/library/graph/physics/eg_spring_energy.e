indexing
	description: "[
			Calculating the energy on a particle depending on dt of the particle.

			force := center_attraction * distance (particle_position, center)
					 + sum [for all links l element particle links] stiffnes * link_stiffnes (l) * (distance (particle_position, other_particle_position))^2 / 2
					 + sum [for all particles p element particles] electrical_repulsion / distance (particle_position, other_particle_position)
			where particle position is position of particle + dt * dx/y
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SPRING_ENERGY

inherit
	EG_PARTICLE_SIMULATION_BH [DOUBLE]
		redefine
			particle_type
		end

	EV_MODEL_DOUBLE_MATH
		undefine
			default_create
		end

	EG_FORCE_DIRECTED_PHYSICS_PROPERTIES
		undefine
			default_create
		end

create
	make_with_particles

feature {NONE} -- Implementation

	npx, npy: DOUBLE
			-- Position of a particle with dt.

	external_force (a_node: like particle_type): DOUBLE is
			-- External force for `a_node'. (attraction to center of universe).
		local
			l_dt: DOUBLE
		do
			l_dt := a_node.dt
			npx := a_node.port_x + l_dt * a_node.dx
			npy := a_node.port_y + l_dt * a_node.dy
			Result := center_attraction * distance (npx, npy, center_x, center_y)
		end

	nearest_neighbor_force (a_node: like particle_type): DOUBLE is
			-- Get the spring force between all of `a_node's adjacent nodes.
		local
			i, nb: INTEGER
			links: ARRAYED_LIST [EG_LINK_FIGURE]
			an_other: like a_node
			an_edge: EG_LINK_FIGURE
			l_distance: DOUBLE
		do
			from
				links := a_node.links
				i := 1
				nb := links.count
			until
				i > nb
			loop
				an_edge := links.i_th (i)
				if an_edge.is_show_requested then
					if a_node = an_edge.source then
						an_other := an_edge.target
					else
						an_other := an_edge.source
					end
					if an_other /=Void and then an_other.is_show_requested then
						l_distance := distance (npx, npy, an_other.port_x, an_other.port_y)
						Result := Result + stiffness * link_stiffness (an_edge) * (l_distance^2) / 2
					end
				end
				i := i + 1
			end
		end

	n_body_force (a_node, an_other: EG_PARTICLE): DOUBLE is
			-- Get the electrical repulsion between all nodes, including those that are not adjacent.
		do
			if a_node /= an_other then
				Result := electrical_repulsion * an_other.mass / distance (npx, npy, an_other.x, an_other.y).max (0.0001)
			end
		end

feature {NONE} -- Implementation

	particle_type: EG_LINKABLE_FIGURE is
			-- Type of particle
		do
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




end -- class EG_SPRING_ENERGY

