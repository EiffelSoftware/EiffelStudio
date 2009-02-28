note
	description: "[
		Sets of tests performing black box testing by launching an external system.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_SYSTEM_TEST_SET

inherit
	EQA_TEST_SET
		rename
			on_prepare as on_prepare_frozen,
			on_clean as on_clean_frozen
		redefine
			on_prepare_frozen,
			on_clean_frozen
		end

feature {EQA_SYSTEM_EXECUTION} -- Access

	file_system: EQA_FILE_SYSTEM
			-- File system for creating directories and files
		require
			prepared: is_prepared
		local
			l_file_system: detachable EQA_FILE_SYSTEM
			l_env: like environment
			l_platform: PLATFORM
		do
			l_file_system := file_system_cache
			if l_file_system = Void then
				create l_platform
				l_env := environment
				create l_file_system.make (l_env)
				file_system_cache := l_file_system
			end
			Result := l_file_system
		end

	environment: EQA_SYSTEM_ENVIRONMENT
			-- Environment specifying source/target directory for `Current'.
		require
			prepared: is_prepared
		local
			l_env: detachable like environment_cache
		do
			l_env := environment_cache
			if l_env = Void then
				create l_env.make (Current)
				environment_cache := l_env
			end
			Result := l_env
		end

feature {NONE} -- Access: execution

	current_execution: detachable EQA_SYSTEM_EXECUTION

feature {NONE} -- Access: caching

	file_system_cache: detachable like file_system
			-- Cache for `file_system'

	environment_cache: detachable like environment
			-- Cache for `environment'

feature {NONE} -- Query

	compare_output (a_output: READABLE_STRING_8)
		require
			current_execution_attached: current_execution /= Void
			current_execution_exited: attached current_execution as l_exec_exited and then
				l_exec_exited.is_launched and then l_exec_exited.has_exited
			current_execution_stored_output: attached current_execution as l_exec_out and then
				l_exec_out.output_path /= Void
		local
			l_path: detachable EQA_SYSTEM_PATH
			l_execution: like current_execution
		do
			l_execution := current_execution
			check l_execution /= Void end
			l_path := l_execution.output_path
			check l_path /= Void end
			assert ("identical_output", file_system.has_same_content_as_string (l_path, a_output))
		end

	compare_output_with_file (a_output_path: EQA_SYSTEM_PATH)
		require
			current_execution_attached: current_execution /= Void
			current_execution_exited: attached current_execution as l_exec_exited and then
				l_exec_exited.is_launched and then l_exec_exited.has_exited
			current_execution_stored_output: attached current_execution as l_exec_out and then
				l_exec_out.output_path /= Void
			a_output_path_not_empty: not a_output_path.is_empty
		local
			l_path: detachable EQA_SYSTEM_PATH
			l_execution: like current_execution
		do
			l_execution := current_execution
			check l_execution /= Void end
			l_path := l_execution.output_path
			check l_path /= Void end
			assert ("identical_output", file_system.has_same_content_as_path (l_path, a_output_path))
		end

feature {NONE} -- Basic operations

	prepare_system (a_output_path: EQA_SYSTEM_PATH)
			-- Create new `current_execution' using provided path to store output.
			--
			-- `a_output_path': Path where output retrieved from system will be stored.
		local
			l_exec: like current_execution
		do
			create l_exec.make (environment)
			l_exec.set_output_path (a_output_path)
			current_execution := l_exec
		ensure
			current_execution_attached: current_execution /= Void
			current_execution_uses_environment: attached current_execution as l_exec_e and then
				l_exec_e.environment = environment
			current_execution_not_launched: attached current_execution as l_exec_nl and then
				not l_exec_nl.is_launched
			current_execution_uses_valid_output: attached current_execution as l_exec_o and then
				l_exec_o.output_path ~ old a_output_path
		end

	run_system (a_args: ARRAY [STRING])
			-- Launch `current_execution' and process output until it exits.
		require
			current_execution_attached: current_execution /= Void
			current_execution_not_launched: attached current_execution as l_exec_nl and then
				not l_exec_nl.is_launched
		local
			l_exec: like current_execution
		do
			l_exec := current_execution
			check l_exec /= Void end
			a_args.do_all (agent (a_arg: STRING; a_exec: attached like current_execution)
				require
					a_arg_attached: a_arg /= Void
				do
					a_exec.add_argument (a_arg)
				end (?, l_exec))
			l_exec.launch
			l_exec.process_output_until_exit
				-- Safety assignments to satisfy postcondition
			current_execution := l_exec
		ensure
			current_execution_unchanged: current_execution = old current_execution
			current_execution_exited: attached current_execution as l_exec_exited and then
				l_exec_exited.is_launched and then l_exec_exited.has_exited
		end

feature {NONE} -- Events

	frozen on_prepare_frozen
			-- <Precursor>
		do
			assert ("multithreaded", (create {PLATFORM}).is_thread_capable)
			on_prepare
		ensure then
			prepared: is_prepared
		end

	frozen on_clean_frozen
			-- <Precursor>
		do
			on_clean

				-- TODO: delete testing directory if test succeeded

			file_system_cache := Void
			environment_cache := Void
			current_execution := Void
		ensure then
			environment_cache_detached: environment_cache = Void
			file_system_cache_detached: file_system_cache = Void
			current_execution_detached: current_execution = Void
		end

	on_prepare
			-- Called when `on_prepare_frozen' is called.
		require
			has_valid_name: has_valid_name
		do
		ensure
			prepared: is_prepared
		end

	on_clean
			-- Called when `on_prepare_clean' is called.
		require
			prepared: is_prepared
		do
		ensure
			has_valid_name: has_valid_name
		end

invariant
	environment_cache_valid: attached {like environment} environment_cache as l_env implies l_env.test_set = Current
	file_system_cache_valid: attached {like file_system} file_system_cache as l_fs implies l_fs.environment = environment

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
