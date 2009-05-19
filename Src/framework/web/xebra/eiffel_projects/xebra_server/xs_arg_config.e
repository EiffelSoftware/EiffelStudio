note
	description: "[
		Contains settings that are read from execution arguments
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ARG_CONFIG

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create debug_level.make_empty
		ensure
			debug_level_attached: debug_level /= Void
		end

feature -- Access

	debug_level: SETTABLE_INTEGER

feature -- Status report

feature -- Status setting

	set_debug_level  (a_debug_level: like debug_level)
			-- Sets debug_level.
		require
			a_debug_level_attached: a_debug_level /= Void
		do
			debug_level  := a_debug_level
		ensure
			debug_level_set: debug_level  = a_debug_level
		end

feature {NONE} -- Implementation

invariant
	debug_level_attached: debug_level /= Void
end

