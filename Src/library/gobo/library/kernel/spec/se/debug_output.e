indexing

	description:

		"Class similuating ISE's class DEBUG_OUTPUT"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2003, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"




deferred class DEBUG_OUTPUT

feature -- Output

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'
		deferred
		ensure
			debug_output_not_void: Result /= Void
		end


end
