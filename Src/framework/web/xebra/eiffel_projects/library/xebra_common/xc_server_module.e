note
	description: "[
		Interface for server modules.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_SERVER_MODULE

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Initializes current
		require
			a_name_attached: a_name /= Void
		do
			is_launched := False
			is_running := False
			name := a_name
		ensure
			name_set: equal(name, a_name)
		end

feature  -- Access

	name: STRING

feature -- Status report

	is_launched: BOOLEAN
		-- Checks if a module has been launched

	is_running: BOOLEAN
		-- Checks if a module is currently running	

feature -- Status setting

	shutdown
			-- Shutds down the module.
		deferred
		end

	launch
			-- Launches the module.	
		deferred
		end

	join
			-- Joins the thread.	
		deferred
		end
		
invariant
	name_attached: name /= Void
end

