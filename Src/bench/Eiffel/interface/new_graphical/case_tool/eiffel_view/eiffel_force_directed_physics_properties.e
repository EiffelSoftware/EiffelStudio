indexing
	description: "Objects that defines stiffnesses for inheritance and client links."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FORCE_DIRECTED_PHYSICS_PROPERTIES

feature -- Access

	inheritance_stiffness: DOUBLE
	
	client_stiffness: DOUBLE

feature -- Element change

	set_inheritance_stiffness (a_stiffness: like inheritance_stiffness) is
			-- Set `inheritance_stiffness' to `a_stiffness'.
		require
			positive: a_stiffness > 0
		do
			inheritance_stiffness := a_stiffness
		ensure
			set: inheritance_stiffness = a_stiffness
		end
		
	set_client_stiffness (a_stiffness: like client_stiffness) is
			-- Set `client_stiffness' to `a_stiffness'.
		require
			positive: a_stiffness > 0
		do
			client_stiffness := a_stiffness
		ensure
			set: client_stiffness = a_stiffness
		end

feature {NONE} -- Implementation

	link_stiffness (a_link: EG_LINK_FIGURE): DOUBLE is
			-- Striffness of `a_link'.
		local
			i_link: EIFFEL_INHERITANCE_FIGURE
		do
			i_link ?= a_link
			if i_link /= Void then
				Result := inheritance_stiffness
			else
				Result := client_stiffness
			end
		end

end -- class EIFFEL_FORCE_DIRECTED_PHYSICS_PROPERTIES
