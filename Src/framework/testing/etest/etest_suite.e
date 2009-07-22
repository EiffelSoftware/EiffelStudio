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

	make (a_project_access: like project_access)
			-- Initialize `Current'.
			--
			-- `a_project_access': Access to Eiffel project.
		require
			a_project_access_attached: a_project_access /= Void
		local
			l_manager: EB_PROJECT_MANAGER
			l_test_suite: TEST_SUITE_S
		do
			project_access := a_project_access
			class_map := new_class_map

			l_manager := project_access.project.manager
			l_manager.load_agents.extend (agent on_compilation_done)
			l_manager.compile_start_agents.extend (agent update_root_class)
			l_manager.compile_stop_agents.extend (agent on_compilation_done)

			if test_suite.is_service_available then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					l_test_suite.test_suite_connection.connect_events (Current)
				end
			end
		end

feature {ETEST_RETRIEVAL}

	project_access: EC_PROJECT_ACCESS
			-- Access to Eiffel project

feature {NONE} -- Access

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

feature {NONE} -- Status report

	is_retrieving: BOOLEAN
			-- Is `Current' updating it's information through an {ETEST_RETRIEVAL}?
		do
			Result := old_class_map /= Void
		ensure
			result_implies_old_class_map_attached: Result implies old_class_map /= Void
		end

feature {ETEST_CLUSTER_RETRIEVAL} -- Basic operations

	synchronize_test_class (a_class: EIFFEL_CLASS_I)
			-- Synchronize `class_map' with given class and add/remove tests from {TEST_SUITE_S}. If we are
			-- currently retrieving new test classes, synchronize with information from `old_class_map'.
		require
			a_class_attached: a_class /= Void
		local
			l_class_map: like old_class_map
			l_is_old: BOOLEAN
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
					-- a {ETEST_CLASS} from `old_class_map' with the same name.
				if not (l_is_old and class_map.has (l_name)) then
					create l_etest_class.make (a_class)
					synchronizer.synchronize (l_etest_class, False)
					l_name := l_etest_class.name
				end
			end

			if l_etest_class /= Void and then not l_etest_class.test_map.is_empty then
				class_map.force_last (l_etest_class, l_name)
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

	on_compilation_done
			-- Called when Eiffel project has finished compilation
		local
			l_retrieval: like retrieval
			l_project: E_PROJECT
			l_test_suite: TEST_SUITE_S
		do
			if is_retrieving then
				l_retrieval := retrieval
				check l_retrieval /= Void end
				if l_retrieval.has_next_step then
					l_retrieval.cancel
				end
				finalize_retrieval (False)
			end

			if test_suite.is_service_available and project_access.is_available then
				l_test_suite := test_suite.service
				if l_test_suite.is_interface_usable then
					create l_retrieval.make (Current, l_test_suite, project_access.project.universe.target)
					retrieval := l_retrieval
					old_class_map := class_map
					class_map := new_class_map
					l_test_suite.launch_session (l_retrieval)
				end
			end
		end

feature {NONE} -- Implementation

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

	update_root_class
			-- If test classes have changed since last time `udpate_root_class' has been called, write
			-- new class referencing all test classes and register it as root clas in system.
		local
			l_system: SYSTEM_I
			l_class: EIFFEL_CLASS_I
			l_cursor: DS_HASH_TABLE_CURSOR [ETEST_CLASS, READABLE_STRING_8]
		do
			l_system := project_access.project.system.system
			l_cursor := class_map.new_cursor
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				l_class := l_cursor.item.eiffel_class
				if not l_system.is_class_referenced (l_class) then
					l_system.add_unref_class (l_class)
				end
				l_cursor.forth
			end
			l_system.set_rebuild (True)
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
