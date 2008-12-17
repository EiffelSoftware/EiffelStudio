indexing
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

	file_system: !EQA_FILE_SYSTEM
			-- File system for creating directories and files
		require
			prepared: is_prepared
		local
			l_file_system: ?EQA_FILE_SYSTEM
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

	environment: !EQA_SYSTEM_ENVIRONMENT
			-- Environment specifying source/target directory for `Current'.
		require
			prepared: is_prepared
		local
			l_env: ?like environment_cache
		do
			l_env := environment_cache
			if l_env = Void then
				create l_env.make (Current)
				environment_cache := l_env
			end
			Result := l_env
		end

feature {NONE} -- Access

	file_system_cache: ?like file_system
			-- Cache for `file_system'

	environment_cache: ?like environment
			-- Cache for `environment'

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
		local
			l_dir: DIRECTORY
		do
			on_clean

				-- TODO: delete testing directory if test succeeded

			file_system_cache := Void
			environment_cache := Void
		ensure then
			internal_environment_detached: environment_cache = Void
			internal_file_system_detached: file_system_cache = Void
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
	environment_cache_valid: {l_env: like environment} environment_cache implies l_env.test_set = Current
	file_system_cache_valid: {l_fs: like file_system} file_system_cache implies l_fs.environment = environment

end
