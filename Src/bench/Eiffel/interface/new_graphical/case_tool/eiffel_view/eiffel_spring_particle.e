indexing
	description: "Objects that is an EG_SPRING_PARTICLE with seperate stiffnesses for inheritance and client links."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SPRING_PARTICLE
	
inherit
	EG_SPRING_PARTICLE
		undefine
			link_stiffness
		end
	
	EIFFEL_FORCE_DIRECTED_PHYSICS_PROPERTIES
		undefine
			default_create
		end
	
create
	make_with_particles

end -- class EIFFEL_SPRING_PARTICLE
