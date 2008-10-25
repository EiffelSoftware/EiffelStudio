indexing
	description: "[
		Interface of an helper object
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROJECT_HELPER_I

inherit
	USABLE_I

feature -- Access

	last_added_class: !EIFFEL_CLASS_I
			-- Class last added to `project' through call to `add_class'
		require
			usable: is_interface_usable
			class_added: is_class_added
		deferred
		end

	last_added_cluster: !CONF_CLUSTER
			-- Cluster last added to `project' through call to `add_cluster'
		require
			usable: is_interface_usable
			cluster_added: is_cluster_added
		deferred
		end

	last_error: !STRING_32
			-- Error message if last call to either `add_class' or `add_cluster' has failed.
		require
			usable: is_interface_usable
			error_occurred: has_error
		deferred
		ensure
			result_not_empty: not Result.is_empty
		end

feature -- Status report

	is_class_added: BOOLEAN
			-- Has a new class been added?
		require
			usable: is_interface_usable
		deferred
		end

	is_cluster_added: BOOLEAN
			-- Has a new cluster been added?
		require
			usable: is_interface_usable
		deferred
		end

	has_error: BOOLEAN
			-- Has last call to either `add_class' or `add_cluster' produced an error message?
		require
			usable: is_interface_usable
		deferred
		end

	can_compile: BOOLEAN
			-- Can project currently be compiled?
		require
			usable: is_interface_usable
		deferred
		end

	can_run: BOOLEAN
			-- Can project currently be launched in the debugger?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Element change

	add_class (a_cluster: !CONF_CLUSTER; a_path: !STRING; a_file_name: !STRING)
			-- Try to create a new {EIFFEL_TEST_I} instance and add it to cluster.
			--
			-- Note: if successful, new class instance will be available through `last_added_class',
			--       otherwise `last_error' will contain error message.
			--
			-- `a_cluster': Cluster in which new class is created.
			-- `a_path': Relative path to `a_cluster' in which new class file exists.
			-- `a_file_name': File name of new class file.
		require
			usable: is_interface_usable
			a_file_name_not_empty: not a_file_name.is_empty
			a_path_valid: (create {RAW_FILE}.make (a_cluster.location.build_path (a_path, a_file_name))).exists
		deferred
		ensure
			succeeded_xor_error: is_class_added xor has_error
		end

	add_cluster (a_target: !CONF_TARGET; a_path: !STRING)
			-- Try to create new {CONF_CLUSTER} instance and add it to target.
			--
			-- Note: if successful, new clsuter instance will be available through `last_added_cluster',
			--       otherwise `last_error' will contain error message.
			--
			-- `a_target': Target serving as a parent for new clsuter.
			-- `a_path': Full path of new cluster.
		require
			usable: is_interface_usable
			a_path_valid: (create {DIRECTORY}.make (a_path)).exists
		deferred
		ensure
			succeeded_xor_error: is_cluster_added xor has_error
		end

feature -- Basic operations

	compile
			-- Compile `project'.
			--
			-- Note: this routine will not return until compilation has stopped.
		require
			usable: is_interface_usable
			compilable: can_compile
		deferred
		end

	run (a_working_directory: ?STRING; a_arguments: ?STRING; a_env: ?HASH_TABLE [!STRING_32, !STRING_32])
			-- Launch compiled application in debugger.
			--
			-- Note: this routine will return immediatly.
			--
			-- `a_working_directory': Directory in which application is launched, Void if default shall be used.
			-- `a_arguments': Arguments passed to the application, can be Void to launch without arguments.
			-- `a_env': Table containing environment variables for application, Void if no additional
			--             variables should be defined.
		require
			usable: is_interface_usable
			launchable: can_run
		deferred
		end

end
