indexing
	description: "[
		Interface for launching an eiffel compilation.
		
		Note: if compilation is launched through a UI, descendants can overrite `compile' to call the
		      appropriate routines and update the UI.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_COMPILATION_LAUNCHER

feature -- Status report

	is_ready (a_project: !E_PROJECT): BOOLEAN
			-- Can a compilation be launched?
		do
			Result := a_project.able_to_compile
		end

feature -- Status setting

	compile (a_project: !E_PROJECT) is
			-- Compile project if
		require
			ready: is_ready (a_project)
		do
			a_project.quick_melt
			if a_project.freezing_occurred then
				a_project.call_finish_freezing_and_wait (True)
			end
		end

end
