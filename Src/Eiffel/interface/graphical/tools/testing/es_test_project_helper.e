indexing
	description: "[
		Implementation of {TEST_PROJECT_HELPER_I} for EiffelStudio UI.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_PROJECT_HELPER

inherit
	TEST_PROJECT_HELPER_I

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

feature -- Access

	last_added_class: !EIFFEL_CLASS_I
			-- <Precursor>
		do
			if {l_class: like last_added_class} internal_added_class then
				Result := l_class
			end
		end

	last_added_cluster: !CONF_CLUSTER
			-- <Precursor>
		do
			if {l_cluster: like last_added_cluster} internal_added_cluster then
				Result := l_cluster
			end
		end

	last_error: !STRING_32
			-- <Precursor>
		do
			if {l_error: like last_error} internal_error then
				Result := l_error
			end
		end

feature {NONE} -- Access

	internal_added_class: ?like last_added_class
			-- <Precursor>

	internal_added_cluster: ?like last_added_cluster
			-- <Precursor>

	internal_error: ?like last_error
			-- <Precursor>

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	is_class_added: BOOLEAN
			-- <Precursor>
		do
			Result := internal_added_class /= Void
		end

	is_cluster_added: BOOLEAN
			-- <Precursor>
		do
			Result := internal_added_cluster /= Void
		end

	has_error: BOOLEAN
			-- <Precursor>
		do
			Result := internal_error /= Void
		end

	can_compile: BOOLEAN
			-- <Precursor>
		do
			Result := melt_project_cmd.executable and not eiffel_project.is_compiling
		end

	can_run: BOOLEAN
			-- <Precursor>
		do
			Result := run_project_cmd.executable and not eiffel_project.is_compiling
		end

feature -- Element change

	add_class (a_cluster: !CONF_CLUSTER; a_path: !STRING; a_file_name: !STRING)
			-- <Precursor>
		local
			l_stone: !CLASSI_STONE
			l_list: LIST [CONF_CLUSTER]
			l_cluster: CONF_CLUSTER
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_error := Void
				internal_added_class := Void

				l_list := manager.eiffel_universe.cluster_of_location (a_cluster.location.evaluated_directory)

				if manager.universe.conf_system.targets.has_item (a_cluster.target) and then
				   a_cluster.target.clusters.has_item (a_cluster)
				then
					l_cluster := a_cluster
				else

					from
						l_list.start
					until
						l_list.after
					loop
						if l_list.item_for_iteration = a_cluster then
							l_cluster := a_cluster
						end
						l_list.forth
					end
					if l_cluster = Void and then not l_list.is_empty then
						l_cluster := l_list.first
					end
				end

				if l_cluster /= Void then
					manager.add_class_to_cluster (a_file_name, a_cluster, a_path)
					if {l_class: like last_added_class} manager.last_added_class then
						internal_added_class := l_class
						create l_stone.make (internal_added_class)
						window_manager.last_focused_development_window.advanced_set_stone (l_stone)
					end
				end
			end
			if internal_added_class = Void then
				internal_error := locale_formatter.translation ("unable to add class to system")
			end
		rescue
			l_retried := True
			retry
		end

	add_cluster (a_target: !CONF_TARGET; a_path: !STRING)
			-- <Precursor>
		do
			internal_error := Void
			internal_added_cluster := Void
			if {l_cluster: like last_added_cluster} manager.last_added_cluster then
				internal_added_cluster := l_cluster
			else
				internal_error := locale_formatter.translation ("unknown error occurred")
			end
		end

feature -- Basic operations

	compile
			-- <Precursor>
		do
			melt_project_cmd.execute_and_wait
		end

	run (a_working_directory: ?STRING; a_arguments: ?STRING; a_env: ?HASH_TABLE [!STRING_32, !STRING_32])
			-- <Precursor>
		local
			l_params: DEBUGGER_EXECUTION_PARAMETERS
		do
			create l_params
			l_params.set_working_directory (a_working_directory)
			l_params.set_arguments (a_arguments)
			l_params.set_environment_variables (a_env)
			run_project_cmd.launch_with_parameters ({EXEC_MODES}.run, l_params)
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
