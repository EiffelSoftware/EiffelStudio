indexing
	description: "Objects that is a force directed physics for Eiffel graphs."
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

	new_spring_particle_solver (particles: LIST [EG_PARTICLE]): EIFFEL_SPRING_PARTICLE is
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
		
	new_spring_energy_solver (particles: LIST [EG_PARTICLE]): EIFFEL_SPRING_ENERGY is
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

end -- class EIFFEL_FORCE_LAYOUT
