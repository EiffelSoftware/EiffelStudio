indexing
	description: "[
			In a EG_QUAD_TREE a `region' is splited into fore equaly sized parts:

						nw|ne
						--+--
						sw|se

			If the the tree has no childrens, meaning it is a leaf, then `particle' is element
			of `region' otherwise the particles in the childrens are element of the childrens
			regions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_QUAD_TREE

create
	make

feature {NONE} -- Initialization

	make (a_region: like region; a_particle: like particle) is
			-- Make a node with `region' `a_region' containing a_particle.
		require
			a_region_exists: a_region /= Void
			a_particle_exists: a_particle /= Void
		do
			region := a_region
			particle := a_particle
			is_leaf := True
		ensure
			set: region = a_region and particle = a_particle
			is_leaf: is_leaf
		end

feature -- Status report

	is_leaf: BOOLEAN
			-- Is node a leaf?

	valid_tree: BOOLEAN is
			-- Are all particles in `Current' element `region'?
		do
			if is_leaf then
				Result := region.has_x_y (particle.x, particle.y)
			else
				Result := True
				if childe_sw /= Void then
					Result := childe_sw.valid_tree
				end
				if Result and then childe_se /= Void then
					Result := childe_se.valid_tree
				end
				if Result and then childe_nw /= Void then
					Result := childe_nw.valid_tree
				end
				if Result and then childe_ne /= Void then
					Result := childe_ne.valid_tree
				end
			end
		end

feature -- Access

	region: EV_RECTANGLE
			-- All particles element of `Current' Tree are element of `region'.

	particle: EG_PARTICLE
			-- Particle in the node.

	childe_sw: EG_QUAD_TREE
			-- Root node for particles in the south west part of `region'.

	childe_se: EG_QUAD_TREE
			-- Root node for particles in the south east part of `region'.

	childe_ne: EG_QUAD_TREE
			-- Root node for particles in the north east part of `region'.

	childe_nw: EG_QUAD_TREE
			-- Root node for particles int the north west part of `region'.

	center_of_mass_particle: EG_PARTICLE
			-- The average particle of all the children particles or particle if `is_leaf'.

feature -- Element change

	build_center_of_mass is
			-- Build a center of mass for every node in the tree.
		local
			x, y: DOUBLE
			l_particle: like center_of_mass_particle
			mass, l_mass: DOUBLE
		do
			if particle /= Void then
				center_of_mass_particle := particle
			else
				if childe_sw /= Void then
					childe_sw.build_center_of_mass
					l_particle := childe_sw.center_of_mass_particle
					mass := l_particle.mass
					x := l_particle.x * mass
					y := l_particle.y * mass
				end
				if childe_se /= Void then
					childe_se.build_center_of_mass
					l_particle := childe_se.center_of_mass_particle
					l_mass := l_particle.mass
					x := x + l_particle.x * l_mass
					y := y + l_particle.y * l_mass
					mass := l_mass + mass
				end
				if childe_ne /= Void then
					childe_ne.build_center_of_mass
					l_particle := childe_ne.center_of_mass_particle
					l_mass := l_particle.mass
					x := x + l_particle.x * l_mass
					y := y + l_particle.y * l_mass
					mass := l_mass + mass
				end
				if childe_nw /= Void then
					childe_nw.build_center_of_mass
					l_particle := childe_nw.center_of_mass_particle
					l_mass := l_particle.mass
					x := x + l_particle.x * l_mass
					y := y + l_particle.y * l_mass
					mass := l_mass + mass
				end
				create center_of_mass_particle.make ((x / mass).truncated_to_integer, (y / mass).truncated_to_integer, mass)
			end
		ensure
			set: center_of_mass_particle /= Void
			inside: region.has_x_y (center_of_mass_particle.x, center_of_mass_particle.y)
		end

	insert (a_particle: like particle) is
			-- Insert `a_particle' into the right position in the tree.
		require
			a_particle_exists: a_particle /= Void
			a_particle_in_region: region.has_x_y (a_particle.x, a_particle.y)
			not_has_a_particle: not has (a_particle)
		local
			hh, hw: INTEGER
			px, py: INTEGER
			l_null_particle: EG_PARTICLE
		do
			hw := (region.width / 2).ceiling
			hh := (region.height / 2).ceiling
			if particle /= Void then
					-- It's a leaf push down particle.
				px := particle.x
				py := particle.y
				if px >= region.left + hw then
					if py >= region.top + hh then
						create childe_se.make (create {EV_RECTANGLE}.set (region.left + hw, region.top + hh, hw, hh), particle)
					else
						create childe_ne.make (create {EV_RECTANGLE}.set (region.left + hw, region.top, hw, hh), particle)
					end
				else
					if py >= region.top + hh then
						create childe_sw.make (create {EV_RECTANGLE}.set (region.left, region.top + hh, hw, hh), particle)
					else
						create childe_nw.make (create {EV_RECTANGLE}.set (region.left, region.top, hw, hh), particle)
					end
				end
					-- Ensure invariant.
				particle := l_null_particle
			end
			check
				particle_pushed_down: particle = Void
			end
			px := a_particle.x
			py := a_particle.y
			if px >= region.left + hw then
				if py >= region.top + hh then
					if childe_se = Void then
						create childe_se.make (create {EV_RECTANGLE}.set (region.left + hw, region.top + hh, hw, hh), a_particle)
					else
						childe_se.insert (a_particle)
					end
				else
					if childe_ne = Void then
						create childe_ne.make (create {EV_RECTANGLE}.set (region.left + hw, region.top, hw, hh), a_particle)
					else
						childe_ne.insert (a_particle)
					end
				end
			else
				if py >= region.top + hh then
					if childe_sw = Void then
						create childe_sw.make (create {EV_RECTANGLE}.set (region.left, region.top + hh, hw, hh), a_particle)
					else
						childe_sw.insert (a_particle)
					end
				else
					if childe_nw = Void then
						create childe_nw.make (create {EV_RECTANGLE}.set (region.left, region.top, hw, hh), a_particle)
					else
						childe_nw.insert (a_particle)
					end
				end
			end
			is_leaf := False
		ensure
			inserted: has (a_particle)
		end

	has (a_particle: EG_PARTICLE): BOOLEAN is
			-- Is a particle equal to `a_particle' element of `Current' tree?
		require
			a_particle_not_void: a_particle /= Void
		local
			px, py: INTEGER
			hh, hw: INTEGER
		do
			px := a_particle.x
			py := a_particle.y
			if not region.has_x_y (px, py) then
				Result := False
			else
				if particle /= Void then
						-- Reached the leaf.
					if particle.x = px and then particle.y = py then
						Result := True
					else
						Result := False
					end
				else
					hw := (region.width / 2).ceiling
					hh := (region.height / 2).ceiling
						-- Look into childrens.
					if px >= region.left + hw then
						if py >= region.top + hh then
							if childe_se = Void then
								Result := False
							else
								Result := childe_se.has (a_particle)
							end
						else
							if childe_ne = Void then
								Result := False
							else
								Result := childe_ne.has (a_particle)
							end
						end
					else
						if py >= region.top + hh then
							if childe_sw = Void then
								Result := False
							else
								Result := childe_sw.has (a_particle)
							end
						else
							if childe_nw = Void then
								Result := False
							else
								Result := childe_nw.has (a_particle)
							end
						end
					end
				end
			end
		end

invariant
	leaf_has_particle_inner_nodes_do_not: is_leaf = (particle /= Void)
	is_leaf_implies_has_particle: is_leaf implies region.has_x_y (particle.x, particle.y)

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




end -- class EG_QUAD_TREE

