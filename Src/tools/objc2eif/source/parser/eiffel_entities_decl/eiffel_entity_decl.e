note
	description: "A general Eiffel entity declaration."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_ENTITY_DECL

feature -- Visitor Pattern

	accept (visitor: EIFFEL_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		deferred
		end

end
