indexing
	description: "Allows non GUI threads to add idle actions to GUI thread"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_APPLICATION

inherit
	EV_APPLICATION
		redefine
			create_implementation
		end

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
			-- Add thread safe operations to standard implementation.
		do
			create {EV_THREAD_APPLICATION_IMP} implementation.make (Current)
		end

end -- class EV_THREAD_APPLICATION
