indexing
	description: "Special object responsible for generating IL system."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_GENERATOR

feature {NONE} -- Initialization

	make (deg_output: DEGREE_OUTPUT) is
			-- Generate an IL program.
		require
			deg_output_not_void: deg_output /= Void
		deferred
		end

feature -- Generation

	generate is
			-- Generate an IL assembly.
		deferred
		end

	deploy is
			-- Copy any necessary files to EIFGEN/W_code or EIFGEN/F_code.
		deferred
		end

end
