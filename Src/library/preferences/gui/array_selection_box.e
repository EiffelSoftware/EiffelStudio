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
			resource
		end

creation
	make

feature -- Implementation

	resource: ARRAY_RESOURCE

feature -- Command

	obsolete_feature is
			-- Commit the new value and update the
			-- environment.
		require
			resource_exists: resource /= Void
		local
			arr: ARRAY_RESOURCE
		do
			arr.set_value(text_f.text)
			update_resource
			caller.update_selected (resource)
		end

end -- class ARRAY_SELECTION_BOX
