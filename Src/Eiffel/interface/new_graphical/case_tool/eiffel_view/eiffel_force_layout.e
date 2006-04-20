indexing
	description: "Objects that is a force directed physics for Eiffel graphs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FORCE_LAYOUT

inherit
	EG_FORCE_DIRECTED_LAYOUT
		redefine
			default_create,
			new_spring_energy_solver,
			new_spring_particle_solver
		end

create
	make_with_world

feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_FORCE_LAYOU
		do
			Precursor {EG_FORCE_DIRECTED_LAYOUT}
			set_inheritance_stiffness (10)
			set_client_supplier_stiffness (10)
		end

feature -- Access

	inheritance_stiffness: INTEGER
			-- Stiffness for inheritance links.

	client_supplier_stiffness: INTEGER
			-- Stiffness for client supplier links.

feature -- Element change

	set_inheritance_stiffness (a_value: INTEGER) is
			-- Set `inheritance_stiffness' to `a_value'.
		require
			percent: a_value >= 0 and a_value <= 100
		do
			inheritance_stiffness := a_value
		ensure
			set: inheritance_stiffness = a_value
		end

	set_client_supplier_stiffness (a_value: INTEGER) is
			-- Set `client_supplier_stiffness' to `a_value'.
		require
			percent: a_value >= 0 and a_value <= 100
		do
			client_supplier_stiffness := a_value
		ensure
			set: client_supplier_stiffness = a_value
		end

feature {NONE} -- Implementation

	new_spring_particle_solver (particles: LIST [EG_LINKABLE_FIGURE]): EIFFEL_SPRING_PARTICLE is
			-- Create a new spring particle solver for `particles' and initialize it.
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
			Result.set_inheritance_stiffness ((inheritance_stiffness / 10) + 0.001)
			Result.set_client_stiffness ((client_supplier_stiffness / 10) + 0.001)
		end

	new_spring_energy_solver (particles: LIST [EG_LINKABLE_FIGURE]): EIFFEL_SPRING_ENERGY is
			-- Create a new spring energy solver for `particles' and initialize it.
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
			Result.set_inheritance_stiffness ((inheritance_stiffness / 10) + 0.001)
			Result.set_client_stiffness ((client_supplier_stiffness / 10) + 0.001)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_FORCE_LAYOUT
