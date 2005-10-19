indexing
	description: "Errors for invalid custom attribute specification."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VICA

inherit
	FEATURE_ERROR
		rename
			class_c as context_class
		end

feature -- Properties

	code: STRING is "VICA"
		-- Error code

invariant
	context_class_not_void: context_class /= Void

end -- class VICA
