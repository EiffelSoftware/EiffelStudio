indexing
	description: "[
		Implementation of {EIFFEL_TEST_PROJECT_HELPER_I} used for batch environment.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_PROJECT_HELPER

inherit
	ES_EIFFEL_TEST_PROJECT_HELPER
		redefine
			can_compile,
			can_run,
			compile,
			run
		end

feature -- Status report

	can_compile: BOOLEAN
			-- <Precursor>
		do
			Result := eiffel_project.able_to_compile
		end

	can_run: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Basic operations

	compile
			-- <Precursor>
		do
			eiffel_project.quick_melt
			if eiffel_project.freezing_occurred then
				eiffel_project.call_finish_freezing_and_wait (True)
			end
		end

	run (a_working_directory: ?STRING; a_arguments: ?STRING; a_env: ?HASH_TABLE [!STRING_32, !STRING_32])
			-- <Precursor>
		do
		end

end
