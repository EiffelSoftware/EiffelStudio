note
	description: "[
		Implementation of {EIFFEL_TEST_PROJECT_HELPER_I} for EiffelStudio UI.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_PROJECT_HELPER

inherit
	EIFFEL_TEST_PROJECT_HELPER_I

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
		do
			internal_error := Void
			internal_added_class := Void
			manager.add_class_to_cluster (a_file_name, a_cluster, a_path)
			if {l_class: like last_added_class} manager.last_added_class then
				internal_added_class := l_class
			else
				internal_error := local_formatter.translation ("unknown error occurred")
			end
		end

	add_cluster (a_target: !CONF_TARGET; a_path: !STRING)
			-- <Precursor>
		do
			internal_error := Void
			internal_added_cluster := Void
			if {l_cluster: like last_added_cluster} manager.last_added_cluster then
				internal_added_cluster := l_cluster
			else
				internal_error := local_formatter.translation ("unknown error occurred")
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

end
