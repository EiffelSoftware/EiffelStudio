note
	description: "A factory class for creating in-memory repositories."
	author: "Roman Schmocker, Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Status report

	is_buildable: BOOLEAN = True
			-- Does `Current' have enough information to build a repository?

feature {NONE} -- Implmentation

	new_backend: PS_BACKEND
			-- Create a backend.
		do
			create {PS_IN_MEMORY_BACKEND} Result.make
			Result.add_plug_in (create {PS_ATTRIBUTE_REMOVER_PLUGIN})
		end

end
