indexing
	description: "Configuration nodes that can be visited."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VISITABLE

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		deferred
		end

end
