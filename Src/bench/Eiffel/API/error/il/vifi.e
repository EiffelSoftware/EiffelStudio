indexing
	description: "Error when a class performs incorrect inheritance of external classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VIFI

inherit
	ERROR

feature {NONE} -- Initialization

	make (cl: CLASS_C) is
			-- Create error in class `cl'.
		require
			cl_not_void: cl /= Void
		do
			class_c := cl
		ensure
			class_c_set: class_c = cl
		end

feature -- Access

	class_c: CLASS_C
			-- Class in which error occurred.

feature -- Properties

	code: STRING is "VIFI"
		-- Error code

invariant
	class_c_not_void: class_c /= Void

end -- class VIFI
