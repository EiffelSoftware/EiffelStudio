indexing
	description: "Objects that provide an output in the debugger"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEBUG_OUTPUT

feature {NONE} -- Status report

	debug_output: STRING is
			-- String that should be displayed in the debugger to represent `Current'.
		deferred
		end

end -- class DEBUG_OUTPUT
