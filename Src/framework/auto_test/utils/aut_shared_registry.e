note
	description: "Shared access to registry"
	author: "Ilinca Ciupa and Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_SHARED_REGISTRY

feature -- Singleton Access

	registry: AUT_REGISTRY
			-- Registry singleton
		once
			create Result
		ensure
			registry_not_void: Result /= Void		
		end

end
