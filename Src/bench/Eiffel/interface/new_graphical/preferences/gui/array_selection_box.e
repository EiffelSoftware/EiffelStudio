indexing
	description: "Array Selection Box"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_SELECTION_BOX

inherit
	TEXT_SELECTION_BOX
		redefine
			commit, resource
		end

creation
	make

feature -- Implementation

	resource: ARRAY_RESOURCE

feature -- Command

	commit is
			-- Commit the new value and update the
			-- environment.
		require
			resource_exists: resource /= Void
		local
			arr: ARRAY_RESOURCE
		do
			arr.set_value(text_f.text)
			update_resource
			caller.update
		end

end -- class ARRAY_SELECTION_BOX
