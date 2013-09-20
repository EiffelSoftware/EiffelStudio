note
	description: "Represents any runtime error that might occur in the storage backend, e.g. a disk failure, out-of-memory, a lost connection etc..."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BACKEND_RUNTIME_ERROR

inherit
	PS_ERROR
	redefine
		accept, description
	end

feature

	description: STRING = "Runtime error in backend"
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_backend_runtime_error (Current)
		end
end
