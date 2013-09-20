note
	description: "Represents a version mismatch between stored and current object type."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_VERSION_MISMATCH

inherit

	PS_ERROR
	redefine
		description
	end

feature

	description: STRING = "Version mismatch between stored and current object type"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_version_mismatch (Current)
		end

end
