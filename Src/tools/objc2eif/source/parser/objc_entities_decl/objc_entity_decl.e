note
	description: "A general Objective-C entity declaration."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJC_ENTITY_DECL

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		deferred
		end

end
