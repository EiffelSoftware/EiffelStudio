note
	description: "Interface for drawable objects"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NATIVE_DRAWABLE_I

feature {NATIVE_DRAWABLE_CONTEXT}

	drawable_handle: POINTER
			-- Handle to drawable object.
		deferred
		end

end
