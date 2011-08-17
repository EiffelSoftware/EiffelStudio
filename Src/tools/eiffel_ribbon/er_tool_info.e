note
	description: "[
					Used for saving/loading tool information
					Such as recent projects
																		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TOOL_INFO

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create recent_projects.make (10)
			recent_projects.compare_objects
		end

feature -- Query

	recent_projects: ARRAYED_LIST [STRING]
			--

	is_using_application_modes: BOOLEAN
			-- If using application mode for multi windows support?
			-- Otherwise it's using DLL

feature -- Command

	set_using_application_modes (a_bool: BOOLEAN)
			-- Set `is_using_application_modes' with `a_bool'
		do
			is_using_application_modes := a_bool
		end

end
