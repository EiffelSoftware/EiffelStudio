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

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_project_access: like project_access; a_project_helper: like project_helper; a_auto_retrieve: BOOLEAN)
			-- Initialize `Current'.
			--
			-- `a_project_access': Access to Eiffel project.
			-- `a_project_helper': Project helper for compiling, debugging and adding new classes.
			-- `a_auto_retrieve': True if `Current' should retrieve new tests after loading/compiling the
			--                    project. False otherwise.
		require
			a_project_access_attached: a_project_access /= Void
			a_project_helper: a_project_helper /= Void
		local
			l_manager: EB_PROJECT_MANAGER
			l_test_suite: TEST_SUITE_S
		do
			project_access := a_project_access
			project_helper := a_project_helper
			class_map := new_class_map

			l_manager := project_access.project.manager
			l_manager.compile_start_agents.extend (agent force_test_class_compilation)
			if a_auto_retrieve then
				l_manager.compile_stop_agents.extend (agent retrieve_tests)
				l_manager.load_agents.extend (agent retrieve_tests)
			end

			if test_suite.is_service_available then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					l_test_suite.test_suite_connection.connect_events (Current)
				end
			end
		ensure
			project_helper_set: project_helper = a_project_helper
		end

feature -- Access

	project_access: EC_PROJECT_ACCESS
			-- Access to Eiffel project

	project_helper: TEST_PROJECT_HELPER_I
			-- Project helper for compiling, debugging and adding new classes.

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

	class_map: DS_HASH_TABLE [ETEST_CLASS, READABLE_STRING_8]
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
				l_name := l_class_map.found_key
				l_etest_class := l_class_map.found_item
				l_class_map.remove_found_item

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
					class_map.force_last (l_etest_class, l_name)
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

			if test_suite.is_service_available and project_access.is_initialized then
				l_test_suite := test_suite.service
				if
					l_test_suite.is_interface_usable and
					attached library_class ({ETEST_CONSTANTS}.eqa_test_set_name) as l_class
				then
					create l_retrieval.make (Current, l_test_suite, project_access.project.universe.target, l_class)
					retrieval := l_retrieval
					old_class_map := class_map
					class_map := new_class_map
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
					class_map.force_last (l_test_class, l_old_map.key_for_iteration)
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
			l_class_writer: ETEST_EVALUATOR_ROOT_WRITER
			l_class_map: like class_map
			l_list: DS_ARRAYED_LIST [EIFFEL_CLASS_I]
			l_class: EIFFEL_CLASS_I
			l_dir_NAME: DIRECTORY_NAME
			l_file_name: FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
			l_system: SYSTEM_I
		do
			stop_retrieval
			if (is_etest_session_running or has_class_map_changed) and project_access.is_initialized then
				l_system := project_access.project.system.system
				has_class_map_changed := False
				create l_class_writer
				l_dir_name := l_system.project_location.eifgens_cluster_path
				if not file_system.directory_exists (l_dir_name) then
					file_system.create_directory (l_dir_name)
				end
				create l_file_name.make_from_string (l_dir_name)
				l_file_name.extend (l_class_writer.class_name.as_lower)
				l_file_name.add_extension ("e")
				create l_file.make (l_file_name)
				if not l_file.exists then
					l_system.force_rebuild
				end
				l_file.open_write
				if l_file.is_open_write then
					l_class_map := class_map
					create l_list.make (l_class_map.count)
					from
						l_class_map.start
					until
						l_class_map.after
					loop
						l_class := l_class_map.item_for_iteration.eiffel_class
						if file_system.file_exists (l_class.file_name) then
							l_list.force_last (l_class)
						end
						l_class_map.forth
					end
					l_class_writer.write_source (l_file, l_list)
					l_file.close
					if not l_system.is_explicit_root (l_class_writer.class_name, l_class_writer.root_feature_name) then
						l_system.add_explicit_root (Void, l_class_writer.class_name, l_class_writer.root_feature_name)
					end
				end
			end
		end


feature {NONE} -- Factory

	new_class_map: like class_map
			-- Create new `class_map'
		do
			create Result.make_default
			Result.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [READABLE_STRING_8]})
		end

invariant
	retrieval_attached_equals_old_class_map_attached: (retrieval /= Void) = (old_class_map /= Void)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
