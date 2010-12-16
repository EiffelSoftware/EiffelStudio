note
	description: "An Objective-C protocol method declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_PROTOCOL_METHOD_DECL

inherit
	OBJC_ENTITY_DECL

	OBJC_METHOD_DECL
		redefine
			accept
		end

create
	make

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_protocol_method_decl (Current)
		end

feature -- Setters

	set_required(true_or_false: like is_required)
			-- Set `is_required' with `true_or_false'.
		do
			is_required := true_or_false
		ensure
			required_set: is_required = true_or_false
		end

feature -- Access

	is_required: BOOLEAN assign set_required
			-- Is the protocol method represented by Current required?

end
