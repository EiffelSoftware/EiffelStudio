indexing
	description: "Stone representing an Eiffel class"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_STONE

inherit
	CLASS_NAME_STONE
	FILED_STONE
	SHARED_EIFFEL_PROJECT
	PLATFORM_CONSTANTS

feature -- Access

	class_i: CLASS_I is
		deferred
		end

	cluster: CLUSTER_I is
			-- Cluster associated with current.
		deferred
		end

end -- class CLASS_STONE
