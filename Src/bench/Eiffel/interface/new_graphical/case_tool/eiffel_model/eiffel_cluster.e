indexing
	description: "Objects that is a model for a cluster."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EM_CLUSTER

inherit
	EG_CLUSTER
		redefine
			default_create
		end

create
	make_with_name
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_CLUSTER.
		do
			Precursor {EG_CLUSTER}
		end

	make_with_name (a_name: like name) is
			-- Create an EIFFEL_CLUSTER and set `name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			default_create
			name := a_name
		ensure
			set: name = a_name
		end
		
end -- class EM_CLUSTER
