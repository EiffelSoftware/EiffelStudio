indexing
	description: "[
		Objects that launch a compilation used by testing framework.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_COMPILATION_LAUNCHER

inherit
	EIFFEL_TEST_COMPILATION_LAUNCHER
		redefine
			is_ready,
			compile
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

feature -- Status report

	is_ready (a_project: !E_PROJECT): BOOLEAN
			-- <Precursor>
		do
			--Result := freeze_project_cmd.executable
			Result := melt_project_cmd.executable
		end

feature -- Basic operations

	compile (a_project: !E_PROJECT)
			-- <Precursor>
		do
			--freeze_project_cmd.execute_and_wait
			melt_project_cmd.execute_and_wait
		end

end
