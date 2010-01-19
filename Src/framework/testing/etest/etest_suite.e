note
	description: "[
		Test suite containing Eiffel tests which are added to {TEST_SUITE_S}.
		
		Whenever the project is successfully done compiling an {ETEST_RETRIEVAL} is launched to find all
		test classes in the system. For every test class the test routines are parsed and synchronized
		with {TEST_SUTIE_S}.
		
		Note: this is not a descendant of {TEST_SUITE_S}. Instead it contains the necessary structures
		      for updating Eiffel tests after a compilation.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_SUITE

inherit
	TEST_SUITE_OBSERVER
		redefine
			on_session_finished
		end

	TEST_SESSION_FACTORY [ETEST_RETRIEVAL]

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	EC_SHARED_PROJECT_ACCESS
		export
			{ANY} project_access
		end

create
	make

feature {NONE} -- Initialization

	make (a_project_helper: like project_helper; a_preferences: like preferences)
			-- Initialize `Current'.
			--
			-- `a_project_helper': Project helper for compiling, debugging and adding new classes.
			-- `a_preferences': Preferences containing test specific settings.
		require
			a_project_helper_attached: a_project_helper /= Void
			a_preferences_attached: a_preferences /= Void
		local
			l_manager: EB_PROJECT_MANAGER
			l_test_suite: TEST_SUITE_S
			l_project_loaded: BOOLEAN
		do
			project_helper := a_project_helper
			preferences := a_preferences
			class_map := new_class_map

			l_project_loaded := project_access.is_initialized

			l_manager := project_access.project.manager
			l_manager.compile_start_agents.extend (agent force_test_class_compilation)
			l_manager.compile_stop_agents.extend (agent on_auto_retrieve)
			if not l_project_loaded then
				l_manager.load_agents.extend_kamikaze (agent retrieve_tests)
			end
			l_manager.close_agents.extend (agent on_project_close)

			if test_suite.is_service_available then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					l_test_suite.test_suite_connection.connect_events (Current)
					l_test_suite.register_factory (Current)

					if l_project_loaded then
						l_test_suite.launch_session (new_session (l_test_suite))
					end
				end
			end
		ensure
			project_helper_set: project_helper = a_project_helper
		end

feature -- Access

	project_helper: TEST_PROJECT_HELPER_I
			-- Project helper for compiling, debugging and adding new classes.

	preferences: TEST_PREFERENCES
			-- Test specific preferences

	library: detachable CONF_LIBRARY
			-- {CONF_LIBRARY} instance representing testing library, Void if library not included or not
			-- compiled yet.
		local
			l_cache: like library_cache
			l_uuid: UUID
			l_lib_list: LIST [CONF_LIBRARY]
			l_universe: UNIVERSE_I
		do
			l_cache := library_cache
			if l_cache = Void and project_access.is_initialized then
				create l_uuid.make_from_string ({ETEST_CONSTANTS}.testing_library_uuid)
				l_universe := project_access.project.system.universe
				l_lib_list := l_universe.library_of_uuid (l_uuid, False)
				if not l_lib_list.is_empty then
					l_cache := l_lib_list.first
					library_cache := l_cache
				end
			end
			Result := l_cache
		end

	library_class (a_name: STRING): detachable EIFFEL_CLASS_I
			-- {EIFFEL_CLASS_I} instance of a testing library class with given name. Void if class does not
			-- exist or library is not yet added and compiled.
			--
			-- `a_name': Name of testing library class that should be returned.
		do
			if attached library as l_library and project_access.is_initialized then
				if attached {EIFFEL_CLASS_I} project_access.class_from_name (a_name, l_library) as l_class then
					Result := l_class
				end
			end
		end

feature {NONE} -- Access: project

	library_cache: detachable like library
			-- Cache for `testing_library'

feature {NONE} -- Access: tests

	class_map: TAG_HASH_TABLE [ETEST_CLASS]
			-- Table mapping class names to corresponding {ETEST_CLASS}.
			--
			-- key: Class name
			-- values: {ETEST_CLASS} instance containing test routines for corresponding class

	retrieval: detachable ETEST_RETRIEVAL
			-- Session for retrieving Eiffel test classes

	old_class_map: detachable like class_map
			-- Old instance of `class_map', only used when retrieving new classes

	synchronizer: ETEST_CLASS_SYNCHRONIZER
			-- Synchronizer
		once
			create Result.make (project_access)
		end

	frozen test_suite: SERVICE_CONSUMER [TEST_SUITE_S]
			-- Access to test suite service {TEST_SUITE_S}.
		once
			create Result
		end

	etest_session_count: NATURAL
			-- Number of etest sessions currently running.

feature {TEST_SESSION_I, ETEST_EXECUTOR, ETEST_COMPILATION_EXECUTOR} -- Status report

	frozen is_etest_session_running: BOOLEAN
			-- Is an etest session currently running?
		do
			Result := etest_session_count > 0
		end

feature -- Status report

	is_auto_retrieving: BOOLEAN
			-- Shoul tests be automatically retrieved after each compilation?

feature {NONE} -- Status report

	is_retrieving: BOOLEAN
			-- Is `Current' updating it's information through an {ETEST_RETRIEVAL}?
		do
			Result := old_class_map /= Void
		ensure
			result_implies_old_class_map_attached: Result implies old_class_map /= Void
		end

	has_class_map_changed: BOOLEAN
			-- Have keys of `class_map' changed since last call to `force_test_class_compilation'

feature -- Status setting

	set_auto_retrieve (an_auto_retrieve: like is_auto_retrieving)
			-- Set `is_auto_retrieving' to given value.
			--
			-- `an_auto_retrieve': New value for `is_auto_retreiving'.
		do
			is_auto_retrieving := an_auto_retrieve
		ensure
			set: is_auto_retrieving = an_auto_retrieve
		end

feature {ETEST_RETRIEVAL} -- Status setting

	start_retrieval (a_retrieval: like new_session)
			-- Set given retrieval as current running retrieval.
		require
			a_retrieval_attached: a_retrieval /= Void
			a_retrieval_usable: a_retrieval.is_interface_usable
		do
			library_cache := Void
			stop_retrieval
			retrieval := a_retrieval
			old_class_map := class_map
			class_map := new_class_map
		end

feature {TEST_SESSION_I, ETEST_EXECUTOR, ETEST_COMPILATION_EXECUTOR} -- Status setting

	increase_etest_session_count
			-- Increase `etest_session_count' by one.
		do
			etest_session_count := etest_session_count + 1
		ensure
			running: is_etest_session_running
		end

	decrease_etest_session_count
			-- Decrease `etest_session_count' by one.
		require
			running: is_etest_session_running
		do
			etest_session_count := etest_session_count - 1
		end

feature {ETEST_CLUSTER_RETRIEVAL} -- Basic operations

	synchronize_test_class (a_class: EIFFEL_CLASS_I)
			-- Synchronize `class_map' with given class and add/remove tests from {TEST_SUITE_S}. If we are
			-- currently retrieving new test classes, synchronize with information from `old_class_map'.
		require
			a_class_attached: a_class /= Void
		local
			l_class_map: like old_class_map
			l_is_old, l_new: BOOLEAN
			l_name: READABLE_STRING_8
			l_etest_class: detachable ETEST_CLASS
		do
			l_name := a_class.name

			if attached old_class_map as l_old_map then
				l_class_map := l_old_map
				l_is_old := True
			else
				l_class_map := class_map
			end

			l_class_map.search (l_name)
			if l_class_map.found then
				l_name := l_class_map.immutable_string (l_name)
				l_etest_class := l_class_map.found_item
				l_class_map.remove (l_name)

				l_etest_class.set_eiffel_class (a_class)

				synchronizer.synchronize (l_etest_class, False)
			else
					-- Before we create a new `l_etest_class', we check that `class_map' has not already retrieved
					-- a {ETEST_CLASS} with the same name.
				if not (l_is_old and class_map.has (l_name)) then
					create l_etest_class.make (a_class, Current)
					synchronizer.synchronize (l_etest_class, False)
					l_name := l_etest_class.name
					l_new := True
				end
			end

			if l_etest_class /= Void then
				if l_etest_class.test_map.is_empty then
					if not l_new then
						has_class_map_changed := True
					end
				else
					if l_new then
						has_class_map_changed := True
					end
					class_map.force (l_etest_class, l_name)
				end
			end
		end

feature {TEST_SUITE_S} -- Events: test suite

	on_session_finished (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			if a_session = retrieval then
				finalize_retrieval (True)
			end
		end

feature {NONE} -- Events: project

	on_auto_retrieve
			-- Called when project is loaded or done compiling.
		do
			if is_auto_retrieving then
				retrieve_tests
			end
		end

	on_project_close
			-- Called when the Eiffel project is closed.
		do
			if project_access.is_initialized then
				write_evaluator_root_class (create {ARRAYED_LIST [EIFFEL_CLASS_I]}.make (0), False)
			end
		end

feature -- Element change

	retrieve_tests
			-- Called when Eiffel project has finished compilation
		local
			l_project: E_PROJECT
			l_test_suite: TEST_SUITE_S
			l_retrieval: like retrieval
		do
				-- Wipe out caches
			library_cache := Void

			stop_retrieval

			if test_suite.is_service_available and project_access.is_initialized and then project_access.project.successful then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					create l_retrieval.make (Current, l_test_suite)
					l_test_suite.launch_session (l_retrieval)
				end
			end
		end

feature {NONE} -- Implementation

	stop_retrieval
			-- Stop and finalize any current retrieval.
		local
			l_retrieval: like retrieval
		do
			if is_retrieving then
				l_retrieval := retrieval
				check l_retrieval /= Void end
				if l_retrieval.has_next_step then
					l_retrieval.cancel
				end
				finalize_retrieval (False)
			end
		ensure
			not_retrieving: not is_retrieving
		end

	finalize_retrieval (a_remove: BOOLEAN)
			-- Finalize current retrieval by cleaning up remaining classes `old_class_map'.
			--
			-- `a_remove': If True, remaining tests in `old_class_map' are removed. Otherwise they are added
			--             to class map.
		require
			retrieving: is_retrieving
		local
			l_old_map: like old_class_map
			l_test_class: ETEST_CLASS
		do
			l_old_map := old_class_map
			check old_map_attached: l_old_map /= Void end
			from
				l_old_map.start
			until
				l_old_map.after
			loop
				l_test_class := l_old_map.item_for_iteration
				if a_remove then
					synchronizer.synchronize (l_test_class, True)
					has_class_map_changed := True
				else
					class_map.force (l_test_class, l_old_map.key_for_iteration)
				end
				l_old_map.forth
			end
			old_class_map := Void
			retrieval := Void
		ensure
			not_retrieving: not is_retrieving
		end

	force_test_class_compilation
			-- If test classes have changed since last time `udpate_root_class' has been called, write
			-- new class referencing all test classes and register it as root clas in system.
		local
			l_class_map: like class_map
			l_list: ARRAYED_LIST [EIFFEL_CLASS_I]
			l_class: EIFFEL_CLASS_I
		do
			stop_retrieval
			if (is_etest_session_running or has_class_map_changed) and project_access.is_initialized then
				has_class_map_changed := False
				l_class_map := class_map
				create l_list.make (l_class_map.count)
				from
					l_class_map.start
				until
					l_class_map.after
				loop
					l_class := l_class_map.item_for_iteration.eiffel_class
					if file_system.file_exists (l_class.file_name) then
						l_list.force (l_class)
					end
					l_class_map.forth
				end
				write_evaluator_root_class (l_list, True)
			end
		end

	write_evaluator_root_class (a_list: LIST [EIFFEL_CLASS_I]; a_create: BOOLEAN)
			-- Write anchor root class with classes in given list.
			--
			-- `a_list': A list containing class names to be referenced in root class.
			-- `a_create': True if creation of root class should be forced, otherwise it is only created
			--             if the file already existed.
		require
			a_list_attached: a_list /= Void
			project_initialized: project_access.is_initialized
		local
			l_class_writer: ETEST_EVALUATOR_ROOT_WRITER
			l_dir_name: DIRECTORY_NAME
			l_file_name: FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
			l_system: SYSTEM_I
		do
			create l_class_writer
			l_system := project_access.project.system.system
			l_dir_name := l_system.project_location.eifgens_cluster_path
			create l_file_name.make_from_string (l_dir_name)
			l_file_name.extend (l_class_writer.class_name.as_lower)
			l_file_name.add_extension ("e")
			create l_file.make (l_file_name)
			if l_file.exists then
				l_file.open_write
			elseif a_create then
				if not file_system.directory_exists (l_dir_name) then
					file_system.recursive_create_directory (l_dir_name)
				end
				l_file.open_write
				l_system.force_rebuild
			end
			if l_file.is_open_write then
				l_class_writer.write_source (l_file, a_list)
				l_file.close
				if l_system.is_explicit_root (l_class_writer.class_name, l_class_writer.root_feature_name) then
					if a_list.is_empty then
						l_system.remove_explicit_root (l_class_writer.class_name, l_class_writer.root_feature_name)
					end
				else
					if not a_list.is_empty then
						l_system.add_explicit_root (Void, l_class_writer.class_name, l_class_writer.root_feature_name)
					end
				end
			end
		end

feature {NONE} -- Factory

	new_session (a_test_suite: TEST_SUITE_S): ETEST_RETRIEVAL
			-- <Precursor>
		do
			create Result.make (Current, a_test_suite)
		end

	new_class_map: like class_map
			-- Create new `class_map'
		do
			create Result.make (10)
		end

invariant
	retrieval_attached_equals_old_class_map_attached: (retrieval /= Void) = (old_class_map /= Void)

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
