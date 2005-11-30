indexing
	description: "Generator for processing assignments."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ASSIGNMENT_GENERATOR

inherit
	BYTE_NODE_NULL_VISITOR
		redefine
			is_node_valid
		end

feature -- Status

	is_node_valid (a_node: BYTE_NODE): BOOLEAN is
			-- Is `a_node' valid for current visitor?
		local
			l_access: ACCESS_B
		do
			l_access ?= a_node
			Result := l_access /= Void and then not l_access.read_only
		end

end
