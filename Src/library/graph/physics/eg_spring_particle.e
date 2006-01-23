indexing
	description: "[
			Calculate spring force for a particle.
			force := - center_attraction * (particle_position - center) / distance (particle_position, center)
					+ sum [for all links l element particle link] - (stiffness * link_stiffness (l) * (particle_position - other_position))
					+ sum [for all particle p element particles] electrical_repulsion * (particle_position - other_position) / distance (particle_position, other_position)^3
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SPRING_PARTICLE

inherit
	EG_PARTICLE_SIMULATION_BH [EG_VECTOR2D [DOUBLE]]
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

	px, py: INTEGER
			-- Position of a particle.

	external_force (a_node: like particle_type): EG_VECTOR2D [DOUBLE] is
			-- External force for `a_node'. (attraction to center of universe).
		local
			l_distance: DOUBLE
			l_force: DOUBLE
		do
			px := a_node.port_x
			py := a_node.port_y

			l_distance := distance (center_x, center_y, px, py)
			if l_distance > 0.1 then
				l_force := - center_attraction / l_distance
				create Result.make (l_force * (px - center_x), l_force * (py - center_y))
			else
				create Result
			end
		end

	nearest_neighbor_force (a_node: like particle_type): EG_VECTOR2D [DOUBLE] is
			-- Get the spring force between all of `a_node's adjacent nodes.
		local
			i, nb: INTEGER
			l_links: ARRAYED_LIST [EG_LINK_FIGURE]
			l_item: EG_LINK_FIGURE
			l_other: EG_LINKABLE_FIGURE
			l_weight: DOUBLE
		do
			from
				create Result
				i := 1
				l_links := a_node.links
				nb := l_links.count
			until
				i > nb
			loop
				l_item := l_links.i_th (i)

				if l_item.is_show_requested then
					if a_node = l_item.source then
						l_other := l_item.target
					else
						l_other := l_item.source
					end
					if l_other.is_show_requested then
						l_weight := stiffness * link_stiffness (l_item)
						Result.set (Result.x - l_weight * (px - l_other.port_x), Result.y - l_weight * (py - l_other.port_y))
					end
				end
				i := i + 1
			end
		end

	n_body_force (a_node, an_other: EG_PARTICLE): EG_VECTOR2D [DOUBLE] is
			-- Get the electrical repulsion between all nodes, including those that are not adjacent.
		local
			l_distance, l_force: DOUBLE
			opx, opy: DOUBLE
		do
			if a_node /= an_other then
				opx := an_other.x
				opy := an_other.y
				l_distance := distance (px, py, opx, opy).max (0.001)

				l_force := electrical_repulsion / (l_distance ^ 3)
				create Result.make (l_force * (px - opx) * an_other.mass, l_force * (py - opy) * an_other.mass)
			else
				create Result
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




end -- class EG_SPRING_PARTICLE

