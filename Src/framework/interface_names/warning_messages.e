note
	description: "Constants for warning messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	conventions: "w_: Warning message"
	date: "$Date$"
	revision: "$Revision$"

class
	WARNING_MESSAGES

inherit
	PRODUCT_NAMES
		export
			{NONE} workbench_name
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Project file/directory warnings

	w_Select_project_to_create: STRING_32 do Result := locale.translation ("Please select the kind of project you want to create.") end

	w_Cannot_open_project: STRING_32 do Result := locale.translation ("Project is not readable. Check permissions.") end

	w_Cannot_create_project_directory (dir_name: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot create project directory in: $1%NYou may try again after fixing the permissions."), [dir_name])
		end

	w_Project_directory_not_exist (file_name, dir_name: READABLE_STRING_GENERAL): STRING_32
			-- Error message when something is missing in the Project directory.
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("%NCannot open project `$1'.%N%NMake sure you have a complete EIFGEN directory in `$2'."), [file_name, dir_name])
		end

	w_Cannot_compile: STRING_32 do Result := locale.translation ("Read-only project: cannot compile.") end

	w_Project_corrupted (dir_name: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Project in: $1%Nis corrupted. Cannot continue."), [dir_name])
		end

	w_configuration_files_needs_to_be_converted (a_file_name: READABLE_STRING_GENERAL): STRING_32
		require
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Your old configration file needs to be converted to the new format.%N%
				%The default name for the new configuration is '$1'.%N%
				%Select OK if you want to keep this name, or 'Save As...' to choose a different name."), [a_file_name])
		end

	w_project_constains_no_compilable_target: STRING_32 do Result := locale.translation ("This project contains no compilable target.%NPlease open a different project.") end

	w_Project_incompatible (dir_name: READABLE_STRING_GENERAL; comp_version, incomp_version: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void
			valid_version: comp_version /= Void and then incomp_version /= Void
		do
			if incomp_version.is_empty then
				Result := locale.formatted_string (locale.translation ("No version information about project found in:%N$1."), [dir_name])
			else
				Result := locale.formatted_string (locale.translation (
				"Incompatible version for project compiled in: $1.%N$2 version is $3.%NProject was compiled with version $4."),
				[dir_name, workbench_name, comp_version, incomp_version])
			end
		end

	w_Project_incompatible_version (dir_name: READABLE_STRING_GENERAL; comp_version, incomp_version: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void and then not dir_name.is_empty
			valid_comp_version: comp_version /= Void and then not comp_version.is_empty
			valid_incomp_version: incomp_version /= Void
		do
			Result := locale.formatted_string (locale.translation (
			"Incompatible version for project compiled in: $1.%N$2 version is $3.%NProject was compiled with version $4.%N%NClick Yes to convert this project to version $5.%N"),
			[dir_name, workbench_name, comp_version, incomp_version, comp_version])
		end

	w_project_build_precompile (a_path: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (
							locale.translation (
			"The project needs to use a precompiled library, which has not been compiled.%N%
			%(precompiled library: %"$1%")%N%
			%Should the precompile be built?"),
							[a_path]
						)
		end

	w_iron_packages_to_install (a_iron_packages: LIST [READABLE_STRING_32]): STRING_32
		local
			s: STRING_32
		do
			create s.make_empty
			across
				a_iron_packages as ic
			loop
				if not s.is_empty then
					s.append_character (',')
					s.append_character (' ')
				end
				s.append (ic)
			end
			Result := locale.formatted_string (
							locale.translation (
			"The project needs to use the following iron packages, which has not been installed.%N%
			%(packages: %"$1%")%N%
			%Should the iron packages (and their dependencies) be installed?"),
							[s]
						)
		end

	w_project_build_precompile_error: STRING_32 do Result := locale.translation ("Could not generate needed precompiled library.") end

	w_iron_packages_installation_error: STRING_32 do Result := locale.translation ("Could not install iron packages.") end

	w_Project_interrupted (dir_name: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Retrieving project in: $1%Nwas interrupted. Cannot continue."), [dir_name])
		end

	w_no_compilable_target: STRING_32 do Result := locale.translation ("Cannot compile project: no valid target found.") end
			-- Error when no compilable target was found.

	w_None_system: STRING_32 do Result := locale.translation ("A system with an all classes root is not runnable.") end

	w_unable_to_retrieve_wizard_list: STRING_32 do Result := locale.translation ("Unable to retrieve the list of installed wizard.") end

	w_unable_to_initiate_project: STRING_32 do Result := locale.translation ("Unable to initialize the project generated by the wizard") end

	w_unable_to_write_file (a_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation ("Unable to write file: $1"), [a_name]) end;

	w_file_is_corrupted (a_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation ("File $1 is corrupted"), [a_name]) end;

	w_file_can_not_be_open (a_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation ("File $1 cannot not be open"), [a_name]) end;

feature -- File warnings

	w_Cannot_create_file (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot create file:%N$1."), [file_name])
		end

	w_Cannot_create_directory (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot create directory:%N$1."), [file_name])
		end

	w_Cannot_read_file (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("File: '$1' cannot be read."), [file_name])
		end

	w_file_not_exist (f_name: READABLE_STRING_GENERAL): STRING_32
			-- Error message when `f_name' does not exist.
		require
			f_name_not_void: f_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("File: $1%Ndoes not exist."), [f_name])
		end

	w_File_does_not_exist_execution_impossible (a_file_name: READABLE_STRING_GENERAL): STRING_32
		require
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 does not exist.%NExecution impossible.%N"), [a_file_name])
		end

	w_Directory_not_exist (dir_name: READABLE_STRING_GENERAL): STRING_32
			-- Error message when a directory does not exist.
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Directory $1%Ndoes not exist."), [dir_name])
		end

	w_Not_a_plain_file (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1%Nis not a plain file."), [file_name])
		end

	w_Not_creatable (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("File: $1 cannot be created.%NPlease check permissions."), [file_name])
		end

	w_Not_creatable_choose_to_save (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("File: $1 is not writable, neither .swp file.%NPlease choose a place to save."), [file_name])
		end

	w_Not_writable (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("%N$1 is not writable.%NPlease check permissions."), [file_name])
		end

	w_Still_referenced (a_class_name: READABLE_STRING_GENERAL; referenced_classes: READABLE_STRING_GENERAL): STRING_32
		require
			a_class_name_not_void: a_class_name /= Void
			referenced_classes_not_void: referenced_classes /= Void
		do
			Result := locale.formatted_string (locale.translation ("Can't delete class $1 because it is referenced by%N$2%N%NIf this is not the case recompile the system and try again."), [a_class_name, referenced_classes])
		end

	w_File_exists (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("File: $1 already exists.%NDo you wish to overwrite it?"), [file_name])
		end

	w_Not_a_directory (dir_name: READABLE_STRING_GENERAL): STRING_32
		require
			dir_name_not_void: dir_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1%Nis not a directory."), [dir_name])
		end

	w_Not_a_file (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("'$1' is not a file."), [file_name])
		end

	w_Not_a_file_retry (file_name: READABLE_STRING_GENERAL): STRING_32
		require
			file_name_not_void: file_name /= Void
		local
			l_str: STRING_32
		do
			l_str := w_Not_a_file (file_name).as_string_32
			l_str.append (locale.translation (" Try again?"))
			Result := l_str
		end

	w_Not_rename_swp (a_file_name, a_new_name: READABLE_STRING_GENERAL): STRING_32
			-- Cannot rename the swp file into the original file during a save operation.
		require
			a_file_name_not_void: a_file_name /= Void
			a_new_name_not_void: a_new_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Could not rename $1 into $2."), [a_file_name, a_new_name])
		end

	w_Not_rename (a_file_name, a_new_name: READABLE_STRING_GENERAL): STRING_32
			-- Cannot rename `a_file_name' into the `a_new_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_new_name_not_void: a_new_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Could not rename $1 into $2."), [a_file_name, a_new_name])
		end

feature -- Project settings warnings

	w_cluster_path_not_valid: STRING_32 do Result := locale.translation ("Cluster path is not valid.") end

feature -- Debug warnings

	w_apply_debugger_profiles_before_closing: STRING_32 do Result := locale.translation ("The execution profiles have been modified.%NDo you want to apply the changes before closing?") end

	w_Compile_before_debug: STRING_32 do Result := locale.translation ("Do you want to compile before executing?") end

	w_Cannot_debug: STRING_32 do Result := locale.translation ("The current version of system has not been successfully compiled.%N%
						%As a result, you cannot use the debugging facilities.") end

	w_Debug_not_compiled: STRING_32
			-- The user tries to launch an application that is not fully compiled.
		do
			Result := locale.translation (
				"The last compilation was not completed.%N%
				%Running the last compiled application in these conditions can%N%
				%lead to inconsistent information, or to exhibit unexpected behavior.")
		end

	w_Removed_class_debug: STRING_32
			-- The user tries to launch an application from which classes were removed.
		do
			Result := locale.translation (
				"Classes were manually removed since the last compilation.%N%
				%Running the last compiled application in these conditions%N%
				%may lead to inconsistent information, or exhibit unexpected behavior.")
		end

	w_Invalid_working_directory (wd: PATH): STRING_32
			-- Message when working directory is incorrect.
		require
			wd_not_void: wd /= Void
		do
			Result := locale.formatted_string (locale.translation ("Could not launch system in %"$1%"."), [wd.name])
		end

	w_Not_a_condition (expr: READABLE_STRING_GENERAL): STRING_32
			-- Message when an expression is not a condition.
		require
			expr_not_void: expr /= Void
		do
			Result := locale.formatted_string (locale.translation ("%'$1%' is not a condition."), [expr])
		end

	w_Invalid_address (addr: READABLE_STRING_GENERAL): STRING_32
			-- Message when an address does not correspond to an object.
		require
			addr_not_void: addr /= Void
		do
			if addr.is_empty then
				Result := locale.translation ("Please enter a valid address.")
			else
				Result := locale.formatted_string (locale.translation ("%'$1%' is not a valid address.%N%
					%Addresses only make sense while an application is stopped."), [addr])
			end
		end

	w_Overflow_detected: STRING_32	do Result := locale.translation ("Possible stack overflow detected. The application has been paused to let you%N%
									%examine its current status.") end

	w_Syntax_error_in_expression (expr: READABLE_STRING_GENERAL): STRING_32
			-- Message when an expression has an invalid syntax.
		require
			expr_not_void: expr /= Void
		do
			Result := locale.formatted_string (locale.translation ("%'$1%' is an invalid or not supported syntax."), [expr])
		end

	w_dbg_unable_to_get_call_stack_data: STRING_32 do Result := locale.translation ("Unable to get call stack data") end

	w_dbg_double_click_to_refresh_call_stack: STRING_32 do Result := locale.translation ("Double click to refresh call stack") end


feature -- Cluster tree warnings

	w_Cannot_move_class: STRING_32
			-- A class involved in a move operation could not be moved.
		do
			Result := locale.translation (
				"Source file cannot be moved. Please make sure that:%N%
				%- The source file exists,%N%
				%- The source file is not being edited,%N%
				%- The destination directory can be written in.")
		end

	w_Cannot_delete_read_only_class (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (
				locale.translation (
					"Cannot delete class $1%Nbecause it is either precompiled or in a library cluster."),
					[class_name.as_upper]
				)
		end

	w_Cannot_delete_library_cluster (cluster_name: READABLE_STRING_GENERAL): STRING_32
		require
			cluster_name_not_void: cluster_name /= Void
		do
			Result := locale.formatted_string (
				locale.translation (
					"Cannot delete cluster $1 because it is read only."),
					[cluster_name.as_upper]
				)
		end

	w_Cannot_delete_none_empty_cluster (cluster_name: READABLE_STRING_GENERAL): STRING_32
		require
			cluster_name_not_void: cluster_name /= Void
		do
			Result := locale.formatted_string (
				locale.translation (
					"Cannot delete cluster $1 because cluster is not empty"),
					[cluster_name.as_upper]
				)
		end

	w_Cannot_add_to_library_cluster (cluster_name: READABLE_STRING_GENERAL): STRING_32
		require
			cluster_name_not_void: cluster_name /= Void
		do
			Result := locale.formatted_string (
				locale.translation (
					"Cannot add a cluster to cluster $1 because it is read only."),
					[cluster_name.as_upper]
				)
		end

	w_Cannot_find_class (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot find class $1."), [class_name.as_upper])
		end

	w_Cannot_find_cluster (cluster_name: READABLE_STRING_GENERAL): STRING_32
		require
			cluster_name_not_void: cluster_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cannot find cluster $1."), [cluster_name.as_upper])
		end

	w_Choose_class_or_cluster: STRING_32
			-- No class/cluster stone was selected in the development window.
		do Result := locale.translation ("Please first select in the editor the class or cluster that you want to locate.") end

	w_Class_already_in_cluster (base_name: READABLE_STRING_GENERAL): STRING_32
		require
			base_name_not_void: base_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Class with file name $1 already exists."), [base_name])
		end

	w_Class_already_exists (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Class with name: '$1' already exists.%NPlease select a different class name."), [class_name])
		end

	w_Invalid_class_name (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		local
			l_str: STRING_32
		do
			if class_name.is_empty then
				l_str := locale.translation ("An empty class name is not valid.%N")
			else
				l_str := locale.formatted_string (locale.translation ("'$1' is not a valid class name.%N"), [class_name])
			end
			l_str.append (
				locale.translation (
						"Class names may only include%N%
						%alphanumeric characters and underscores,%N%
						%have to start with an alphabetic character%N%
						%and cannot be a reserved word.%N%
						%Please select a different class name.")
			)
			Result := l_str
		end

	w_Invalid_cluster_name (cluster_name: READABLE_STRING_GENERAL): STRING_32
		require
			cluster_name_not_void: cluster_name /= Void
		local
			l_str: STRING_32
		do
			if cluster_name.is_empty then
				l_str := locale.translation ("An empty cluster name is not valid.%N")
			else
				l_str := locale.formatted_string (locale.translation ("'$1' is not a valid cluster name.%N"), [cluster_name])
			end
			l_str.append (
				locale.translation (
						"Cluster names may only include %N%
						%alphanumeric characters and underscores,%N%
						%have to start with an alphabetic character%N%
						%and cannot be a reserved word.%N%
						%Please select a different cluster name.")
			)
			Result := l_str
		end

	w_Invalid_feature_name (feature_name: READABLE_STRING_GENERAL): STRING_32
		require
			feature_name_not_void: feature_name /= Void
		local
			l_str: STRING_32
		do
			if feature_name.is_empty then
				l_str := locale.translation ("An empty feature name is not valid.%N")
			else
				l_str := locale.formatted_string (locale.translation ("'$1' is not a valid feature name.%N"), [feature_name])
			end
			l_str.append (
				locale.translation (
						"Feature names may only include %N%
						%alphanumeric characters and underscores,%N%
						%have to start with an alphabetic character%N%
						%and cannot be a reserved word.%N%
						%Please select a different feature name.")
			)
			Result := l_str
		end

	w_Clear_breakpoints: STRING_32 do Result := locale.translation ("Forget all breakpoints?") end

	w_Cluster_path_already_exists (path: READABLE_STRING_GENERAL): STRING_32
		require
			path_not_void: path /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cluster with path $1 already exists in the universe."), [path.as_upper])
		end;

	w_Cluster_name_already_exists (name: READABLE_STRING_GENERAL): STRING_32
		require
			name_not_void: name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Cluster with name $1 already exists in the universe."), [name.as_upper])
		end;

	w_Confirm_delete_class (class_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Class $1 will be permanently%N%
						%removed from the system and from the disk.%N%N%
						%Are you sure this is what you want?"), [class_name])
		end

	w_Confirm_delete_cluster (cluster_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Cluster $1 will be permanently%N%
						%removed from the system.%N%N%
						%Are you sure this is what you want?"), [cluster_name])
		end

	w_Confirm_delete_cluster_debug (cluster_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Stop debug and remove cluster $1 permanently%N%
						%from the system.%N%N%
						%Are you sure this is what you want?"), [cluster_name])
		end

	w_Cannot_delete_need_recompile: STRING_32 do Result := locale.translation ("Compiled configuration is not up to date, please recompile.") end

	w_configuration_not_up_to_date_need_recompile: STRING_32 do Result := locale.translation ("Compiled configuration is not up to date, please recompile.") end

	w_Could_not_locate (cl_name: READABLE_STRING_GENERAL): STRING_32
			-- Class/cluster could not be found in the cluster tree.
		do
			Result := locale.formatted_string (locale.translation ("Could not locate $1.%NPlease make sure system is correctly compiled."), [cl_name])
		end

	w_Unsufficient_compilation (degree: INTEGER): STRING_32
			-- The last or current compilation of the project did not
			-- go through degree `degree', so that a command cannot be executed.
		require
			valid_degree: degree >= -5 and degree <= 6
		do
			Result := locale.formatted_string (locale.translation ("Command cannot be executed unless compilation%N%
						%goes through degree $1."), [degree.out])
		end

	w_Project_not_compiled: STRING_32
			do Result := locale.translation ("Command cannot be executed because the project%N%
			%has never been compiled.%N%
			%Please compile the project before calling this command.") end

	w_Feature_is_not_compiled: STRING_32
			do Result := locale.translation ("An error occurred on breakpoints because a feature%N%
			%was not correctly compiled.%N%N%
			%Recompiling the project completely will solve the problem.") end

	w_Formatter_failed: STRING_32
			-- A formatter crashed, most probably because the last compilation was not successful
			-- or because we are compiling.
		do Result := locale.translation (
		"Format could not be generated.%N%
		%Please make sure that the system is not being compiled %
		%and that the last compilation was successful.") end

	w_Files_not_saved_before_compiling: STRING_32
			do Result := locale.translation ("Some files have not been saved.%NDo you want to save them before compiling?") end

	w_Degree_needed (n: INTEGER): STRING_32
			-- A command needs a certain degree during a compilation.
		require
			valid_degree: n >= -5 and n <= 6
		do
			Result := locale.formatted_string (locale.translation ("Command cannot be executed until degree $1 completed.%N%
						%Please wait until then before calling this command."), [n.out])
		end

	w_cannot_create_cluster_in_tests_cluster: STRING_32
			-- Waning saying that user can not create normal cluster inside of a test cluster
		do
			Result := locale.translation ("It is not possible to create a normal cluster inside of a test cluster")
		end

feature -- Backup warnings

	w_Crashed: STRING_32
		once
			Result := locale.formatted_string (locale.translation (
					"An unexpected error occurred.%N$1 will now make an attempt to create%N%
						%a backup of the edited files."), [workbench_name])
		end

	w_Backup_succeeded: STRING_32 do Result := locale.translation ("Backup was successful.%N%
								%Class files were saved with a .swp extension.") end

	w_Backup_partial (i: INTEGER): STRING_32
			-- `i' files could not be saved during a backup.
		do
			Result := locale.formatted_string (locale.plural_translation (
				"$1 file could not be backed up.%N%
					%Other class files were saved with a .swp extension.",
				"$1 files could not be backed up.%N%
					%Other class files were saved with a .swp extension.",
				i), [i])
		end

	w_Backup_failed: STRING_32 do Result := locale.translation ("Backup failed for some files.%N%
								%The state of the system was too damaged.") end

	w_Found_backup: STRING_32 do Result := locale.translation ("A backed up version of the file was found.%N%
							%Do you want to open the original file or the backup file?%N%
							%If you choose the original file, the backup file will be%N%
							%deleted. If you choose the backup file, then the original%N%
							%file will be overwritten with the contents of the backup%N%
							%file when you save.%N") end

	w_Save_backup: STRING_32 do Result := locale.translation ("You are about to overwrite the original file with%N%
					%the backup file. Previous content will be lost%N%
					%and the backup file deleted.") end

feature -- Dynamic library warnings

	w_Save_invalid_definition: STRING_32
			-- The user tries to save an invalid definition file.
		do Result := locale.translation ("There are problems in this library definition.%N%
		%Call 'Check' to have more information.%N%
		%Save anyway?") end

	w_Invalid_feature_exportation: STRING_32
			-- A feature export is invalid.
		do Result := locale.translation ("This feature export clause contains errors.%N%
		%Try editing it to have more information.") end

	w_Conflicting_exports: STRING_32
			-- Some feature exportation clauses have conflicts.
		do Result := locale.translation ("Some feature export clauses are conflicting.%N%
		%Please make sure that export clauses do not share%N%
		%either their indices or their exported names.") end

	w_No_errors_found: STRING_32
			-- The export feature definitions seem ok.
		do Result := locale.translation ("No errors were found.") end

	w_Not_a_compiled_class (cl_name: READABLE_STRING_GENERAL): STRING_32
			-- The `cl_name' does not represent a valid class.
		do
			if cl_name /= Void then
				Result := locale.formatted_string (locale.translation ("%"$1%" is not a compiled class."), [cl_name])
			else
				Result := locale.translation ("Please specify a class name.")
			end
		end

	w_Not_a_compiled_class_line (cl_name: READABLE_STRING_GENERAL): STRING_32
			-- The `cl_name' does not represent a valid class.
		do
			if cl_name /= Void then
				Result := locale.formatted_string (locale.translation ("%"$1%" is not a compiled class."), [cl_name])
			else
				Result := locale.translation ("Please specify a class name.")
			end
		end

	w_Class_cannot_export: STRING_32 do Result := locale.translation ("This class cannot export features.%N%
				%Please make sure that it is neither deferred nor generic%N%
				%and that the system is correctly compiled.") end

	w_No_exported_feature (f_name, cl_name: READABLE_STRING_GENERAL): STRING_32
			-- `f_name' cannot be found in class `cl_name'.
		require
			f_not_void_implies_c_not_void: f_name /= Void implies cl_name /= Void
		do
			if f_name = Void then
				Result := locale.translation ("Please enter a feature name.")
			else
				Result := locale.formatted_string (locale.translation ("Class %"$1%"%N%
					%has no feature named %"$2%"."), [cl_name, f_name])
			end
		end

	w_Feature_cannot_be_exported: STRING_32 do Result := locale.translation ("This feature cannot be exported.%N%
				%Deferred features, external ones,%N%
				%and attributes cannot be exported.") end

	w_No_valid_creation_routine: STRING_32
			do Result := locale.translation ("No valid creation routine%N%
			%could be found for this class.%N%
			%Please make sure the chosen class%N%
			%has a creation routine taking no argument.") end

	w_Invalid_parameters: STRING_32
			-- The chosen export parameters are invalid.		
		do Result := locale.translation ("These parameters are invalid.") end

	w_Invalid_index: STRING_32
			-- The chosen index is not valid.
		do Result := locale.translation ("Index is out of range.%N%
		%Indices should be positive integers.") end

	w_Invalid_alias: STRING_32
			-- The chosen parameters are not valid.
		do Result := locale.translation ("Alias is invalid.%N%
		%Please check that it is a valid C identifier.") end

	w_Cannot_load_library (fn: READABLE_STRING_GENERAL): STRING_32
			-- The library located in file `fn' cannot be read.
		do
			Result := locale.formatted_string (locale.translation ("The file $1%N%
					%either cannot be read or does not represent%N%
					%a valid dynamic library definition."), [fn])
		end

	w_Cannot_save_library (fn: READABLE_STRING_GENERAL): STRING_32
			-- The library cannot be written in file `fn'.
		do
			Result := locale.formatted_string (locale.translation ("Could not save the library definition to%N$1."), [fn])
		end

	w_Error_parsing_the_library_file: STRING_32
			-- An error occurred while parsing a .def file.
		do Result := locale.translation ("This file seems to be corrupted.%N%
		%Not all items inside could be loaded.") end

	w_Unsaved_changes: STRING_32
			-- The user tries to exit the dialog although some modifications were not saved.
		do
			Result := locale.translation ("This will discard the modifications.")
		end

feature -- Ace/Project settings warnings

	w_Could_not_parse_ace: STRING_32 do Result := locale.translation ("An error occurred while parsing the configuration file.%N%
									%Please try using the project settings tool.") end

feature -- Argument warnings

	w_obsolete_command_line_option (option: READABLE_STRING_GENERAL): STRING_32
		do Result := locale.formatted_string (locale.translation
			("Obsolete command-line option: %"$1%"."), option) end

feature -- Profiler messages

	w_Profiler_Bad_query: STRING_32
			-- Message displayed when detecting a bad query
		do
			Result := locale.translation (
			"Please enter a correct query, for example:%N%
			%%Tfeaturename = WORD.t*%N%
			%%Tfeaturename < WORD.mak?%N%
			%%Tcalls > 2%N%
			%%Tself <= 3.4%N%
			%%Tdescendants in 23 - 34%N%
			%%Ttotal >= 12.3%N%
			%%Tpercentage /= 2%N%
			%%Tcalls > avg%N%
			%%Tself <= max%N%
			%%Ttotal > min%N%
			%%N%
			%You can also combine subqueries with 'and' and 'or', for example:%N%
			%%Tcalls > 2 and self <= 3.4 or percentage in 2.3 - 3.5"
			)
		end

	w_Profiler_select_one_output_switch: STRING_32 do Result := locale.translation ("Select at least one output switch.") end

	w_Profiler_select_one_language: STRING_32 do Result := locale.translation ("Select at least one language.") end

feature -- Project creation, retrieval, ...

	w_Fill_in_location_field: STRING_32 do Result := locale.translation ("Please fill in the 'Location' field.") end

	w_Fill_in_project_name_field: STRING_32 do Result := locale.translation ("Please fill in the 'System Name' field.") end

	w_Unable_to_load_ace_file (an_ace_name, a_reason: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Unable to load the ace file `$1'.%NFor the following reasons:%N$2"), [an_ace_name, a_reason])
		end

	w_Unable_to_load_config_file (an_ace_name, a_reason: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("Unable to load the project file `$1'.%NFor the following reasons:%N$2"), [an_ace_name, a_reason])
		end

	w_Invalid_directory_or_cannot_be_created (a_directory_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
				"'$1' is not a valid directory and/or cannot be created%N%
				%Please choose a valid and writable directory."),
					[a_directory_name])
		end

	w_Environment_changed (a_key, a_old_val, a_new_val: READABLE_STRING_GENERAL): STRING_32
		local
			l_new: READABLE_STRING_GENERAL
		do
			if a_new_val = Void then
				l_new := locale.translation ("<unset>")
			else
				l_new := a_new_val
			end
			Result :=
				locale.formatted_string (locale.translation (
					"Environment variable '$1' has changed%N%N%
					%Old value: $2%NNew value: $3%N%N%
					%Should the new value be used?"),
					[a_key, a_old_val, l_new]
					)
		end

feature -- Refactoring

	w_Feature_not_written_in_class: STRING_32 do Result := locale.translation ("Feature is not written in selected class.") end
	w_Select_class_feature_to_rename: STRING_32 do Result := locale.translation ("Select class or feature to rename.%NEither use pick and drop or target the editor to the feature or class.") end
	w_Select_feature_to_pull: STRING_32 do Result := locale.translation ("Select a feature to pull up.%NEither use pick and drop or target the editor to the feature to pull up.") end

feature -- Composer

	w_Select_feature_to_add_setter: STRING_32 do Result := locale.translation ("Select a feature to add the setter.%NEither use pick and drop or target the editor to the feature to add the setter.") end
	w_Select_feature_to_remove: STRING_32 do Result := locale.translation ("Select a feature to remove.%NEither use pick and drop or target the editor to the feature to remove.") end
	w_Select_feature_to_process: STRING_32 do Result := locale.translation ("Select a feature to process.%NEither use pick and drop or target the editor to the feature to process.") end
	w_Select_class_to_process: STRING_32 do Result := locale.translation ("Select a class to process.%NEither use pick and drop or target the editor to the class to process.") end

feature -- Contract tool

	w_contract_tool_merge_changes (a_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string ("The associated class file for $1 has been modified outside on the Contract Tool.%
				%The changes will be merged but there is a possibility of data loss.%N%N%
				%Do you want continue saving and merging your changes?", [a_name])
		end

	w_contract_tool_merge_syntax_invalid_changes (a_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string ("The associated class file for $1 currently contains syntax errors. It is possible %
				%to continue merging these changes but the Contract Tool will be unable to edit the contracts for this class %
				%after saving.%N%N%
				%Do you want to continue saving the changes to a syntax invalid class?", [a_name])
		end

	w_contract_tool_removal_all: STRING_32
		do
			Result := locale.translation ("Performing a removal on the contract declaration will removal ALL the contracts underneath.%N%N%
				%Are you want to remove all the contract?")
		end

feature -- Warning messages

	w_Assertion_warning: STRING_32
		do Result := locale.translation ("By default assertions enabled in the configuration file are kept%N%
		%in final mode.%N%
		%%N%
		%Keeping assertion checking inhibits any optimization%N%
		%specified in the configuration (inlining, array optimization,%N%
		%dead-code removal) and will produce a final executable%N%
		%that is not optimal in speed and size.%N%
		%%N%
		%Are you sure you want to keep the assertions in your%N%
		%finalized executable?") end

	w_Cannot_move_favorite_to_a_child: STRING_32
		do Result := locale.translation ("Moving a folder to one of its children%N%
		%is not possible.") end

	w_Cannot_move_feature_alone: STRING_32
		do Result := locale.translation ("Moving a feature favorite is not supported by the favorite manager.") end

	w_Class_not_modifiable: STRING_32 do Result := locale.translation ("The text of this class cannot be modified.") end

	w_class_attribute_expected (a_name: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("class $1 $2 attribute expected"), [a_name, a_id])
		end

	w_class_attributes_expected (a_name: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("class? $1, $2 attributes expected"), [a_name, a_id])
		end

	w_cluster_attribute_expected (a_name: READABLE_STRING_GENERAL; a_id: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("cluster? $1, $2 attribute expected"), [a_name, a_id])
		end

	w_could_not_modify_class: STRING_32 do Result := locale.translation ("The text of this class could not be modified.") end

	w_Could_not_save_all: STRING_32 do Result := locale.translation ("Some files could not be saved.%N%
									%Exit was cancelled.") end

	w_cannot_save_file (a_file_name: READABLE_STRING_GENERAL): STRING_32
		do
			if a_file_name /= Void then
				Result := locale.formatted_string (locale.translation ("Could not save file into '$1'"), [a_file_name])
			else
				Result := locale.translation ("Could not save file to specified location.")
			end
		end

	w_cannot_save_png_file (a_file_name: READABLE_STRING_GENERAL): STRING_32
		do
			if a_file_name /= Void then
				Result := locale.formatted_string (locale.translation ("Could not save diagram to $1"), [a_file_name])
			else
				Result := locale.translation ("Could not save diagram to specified location.")
			end
		end

	w_cannot_generate_png: STRING_32 do Result := locale.translation ("Could not generate PNG file.%NInsufficient video memory.") end

	w_does_not_have_enclosing_cluster: STRING_32 do Result := locale.translation ("This cluster does not have an enclosing cluster.") end

	w_Freeze_warning: STRING_32
		do
			Result := locale.translation (
				"Freezing implies some C compilation and linking.%N%
				% - Click Yes to compile the Eiffel system (including C compilation)%N%
				% - Click No  to compile the Eiffel system (no C compilation)%N%
				% - Click Cancel to abort")
		end

	w_Finalize_warning: STRING_32
		do
			Result := locale.translation (
				"Finalizing implies some C compilation and linking.%N%
				% - Click Yes to compile the C code after finalizing the system%N%
				% - Click No  to skip the C compilation (no executable will be generated)%N%
				% - Click Cancel to abort")
		end

	w_Load_configuration: STRING_32
		do
			Result := locale.translation (
				"An error occurred while loading the %
				%configuration for your profiler.%N%
				%Please check with your system %
				%administrator whether your profiler is %
				%supported.%N")
		end

	w_fix_undo_warning: STRING_32
		do
			Result := locale.translation_in_context (
				"[
					Applying selected fixes causes changes to the source code that cannot be undone automatically.
					
					Classes can be open in the editor before applying fixes.
					
					Click Yes to open classes in the editor and apply fixes.
					Click No to apply fixes without opening classes.
					Click Cancel to abort.
				]", "fix")
		end

	w_target_name_attribute_expected: STRING_32 do Result := locale.translation ("TARGET name attribute expected") end

	w_source_name_attribute_expected: STRING_32 do Result := locale.translation ("SOURCE name attribute expected") end

	w_Ignoring_all_stop_points: STRING_32 do Result := locale.translation ("Application will ignore all breakpoints.") end

	w_Unknown_cluster_name: STRING_32 do Result := locale.translation ("No cluster in the system has this name.") end;
	w_no_cluster_selected_for_class_creation: STRING_32 do Result := locale.translation ("No cluster was selected. Please select a cluster to create a class.") end;
	w_read_only_cluster: STRING_32 do Result := locale.translation ("Selected cluster is read only. Please select a writable cluster for class creation.") end

	w_Invalid_folder_name: STRING_32 do Result := locale.translation ("Invalid folder name") end

	w_Folder_name_cannot_contain: STRING_32 do Result := locale.translation ("%N A favorite folder name cannot contain any of the following characters: %N ( ) * ") end

	w_Invalid_cluster: STRING_32
			-- One of the clusters involved in a move operation was invalid.
		do Result := locale.translation ("One of the clusters is invalid.%N%N%
		%Please check that none is precompiled or a library,%N%
		%and that the corresponding directories have sufficient rights.") end

	w_Makefile_more_recent (make_file: READABLE_STRING_GENERAL): STRING_32
		require
			make_file_not_void: make_file /= Void
		do
			Result := locale.formatted_string (locale.translation (
						"$1 is more recent than the system.%N%
						%Do you want to compile the generated C code?"), [make_file])
		end

	w_Makefile_does_not_exist (make_file: READABLE_STRING_GENERAL): STRING_32
		require
			make_file_not_void: make_file /= Void
		do
			Result := locale.formatted_string (locale.translation (
						"$1 does not exist.%N%
						%Cannot invoke C compilation."), [make_file])
		end

	w_MakefileSH_more_recent: STRING_32 do Result := locale.translation ("The Makefile.SH is more recent than the system.") end

	w_Must_save_before_reloading (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("You must save your changes before reloading class $1.%N%NWould you like to continue?"), [class_name])
		end

	w_Must_save_before_prettifying (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("You must save your changes before prettifying class $1.%N%NWould you like to continue?"), [class_name])
		end

	w_Cannot_prettify (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("The current version of system has not been successfully compiled.%NAs a result, you cannot prettify the class $1."), [class_name])
		end

	w_Must_compile_first: STRING_32 do Result := locale.translation ("You must compile a project first.") end

	w_Must_finalize_first: STRING_32 do Result := locale.translation ("You must finalize your project first.") end

	w_No_class_matches: STRING_32 do Result := locale.translation ("No class in any cluster matches this name.") end

	w_No_cluster_matches: STRING_32 do Result := locale.translation ("No cluster in the system matches this name.") end

	w_No_feature_matches: STRING_32 do Result := locale.translation ("No feature in this class matches this name.") end

	w_No_feature_to_display: STRING_32 do Result := locale.translation ("No features in this file") end

	w_No_such_feature_in_this_class (feature_name, class_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation ("No feature named $1 could be found in class $2."), [feature_name, class_name])
		end

	w_No_system_generated (a_system_name: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
				"Could not find $1.%NPlease make sure the C compilation ended correctly."), [a_system_name])
		end

	w_No_system: STRING_32 do Result := locale.translation ("No system was defined.%NCannot launch the application.") end

	w_Not_an_integer: STRING_32 do Result := locale.translation ("Please enter an integer value.") end

	w_Not_a_positive_integer: STRING_32 do Result := locale.translation ("Please enter a positive integer value.") end

	w_Select_class_cluster_to_remove: STRING_32 do Result := locale.translation ("Please select a class or a cluster before calling this command.%N%
										%It will then be removed.") end

	w_Specify_a_class: STRING_32 do Result := locale.translation ("Please specify a compiled class (or * for all classes).") end

	w_Exiting_stops_compilation: STRING_32 do Result := locale.translation ("It is not possible to exit EiffelStudio while the project is being compiled.") end

	w_Save_before_closing: STRING_32 do Result := locale.translation ("Do you want to save your changes%N%
																			%before closing the window?") end

	w_Stop_debugger: STRING_32 do Result := locale.translation ("This command will stop execution.") end

	w_Exiting_stops_debugger: STRING_32 do Result := locale.translation ("Exiting will stop execution.") end

	w_Closing_stops_debugger: STRING_32 do Result := locale.translation ("Closing the window will stop execution.") end

	w_Unexisting_system: STRING_32 do Result := locale.translation ("System doesn't exist.") end

	w_File_changed (class_name: READABLE_STRING_GENERAL): STRING_32
		do
			if class_name = Void then
				Result := locale.translation ("File has been modified.%NDo you want to save changes?")
			else
				Result := locale.formatted_string (locale.translation ("Class $1 has been modified.%NDo you want to save changes?"), [class_name])
			end
		end

	w_Text_not_editable: STRING_32 do Result := locale.translation ("Current view is not editable.") end

	w_Class_syntax_error_before_generation (class_name: READABLE_STRING_GENERAL): STRING_32
		require
			class_name_not_void: class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ( "Class $1 has syntax error.%N%
					%Code generation cancelled."), [class_name])
		end

	w_Class_modified_outside_diagram: STRING_32 do Result := locale.translation ("Class was modified outside the diagram.%N%
												%Previous commands are not undoable any longer.") end

	w_Class_syntax_error: STRING_32 do Result := locale.translation ("Current class text has a syntax error.%NCode generation was cancelled.") end

	w_New_feature_syntax_error: STRING_32 do Result := locale.translation ("New feature has syntax error.%NCode generation cancelled.") end

	w_Class_name_changed: STRING_32 do Result := locale.translation ("Class name has changed since last compilation.%NCurrent text will not be clickable.%N%
						%Recompile to make it clickable again.") end

	w_Unable_to_execute_wizard (wizard_file: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
				"Unable to execute the wizard.%N%
				%Check that `$1' exists and is executable.%N"),
				[wizard_file])
		end

	w_short_internal_error (a_code: READABLE_STRING_GENERAL): STRING_32
			-- Short internal error using `a_code'.
		require
			a_code_not_void: a_code /= Void
		do
			Result := locale.formatted_string (locale.translation (
					"Internal error ($1): Submit bug at http://support.eiffel.com"),
					[a_code])
		end

	w_Internal_error: STRING_32
		do Result := locale.translation ("An internal failure occurred. If this happens even after relaunching EiffelStudio, perform a clean recompilation.%N%N%
		%You can submit a bug report at http://support.eiffel.com or use the Submit Bug button below.") end

	w_Class_already_edited: STRING_32 do Result := locale.translation ("This class is already being edited%N%
										%in another editor.%N%
										%Editing a class in several editors%N%
										%may cause loss of data.") end
	w_Invalid_options: STRING_32 do Result := locale.translation ("The selected options are invalid.%N%
								%Please select different ones.") end

	w_Index_already_taken: STRING_32 do Result := locale.translation ("This index is already used.%N%
									%Please select another one.") end

	w_Command_needs_class: STRING_32 do Result := locale.translation ("This command requires a class name.%N%
									%It cannot be executed.") end

	w_Command_needs_file: STRING_32 do Result := locale.translation ("This command requires a file name.%N%
									%It cannot be executed.") end

	w_Command_needs_directory: STRING_32 do Result := locale.translation ("This command requires a directory.%N%
									%It cannot be executed.") end

	w_Finalize_precompile: STRING_32    do Result := locale.translation (".NET precompiled libraries can be finalized to create%N%
									%an optimized version as well as a workbench version.%N%
									%Would you like to create a finalized version?") end

	w_Replace_all: STRING_32 do Result := locale.translation ("This operation cannot be undone for files not loaded into the EiffelStudio editor.%N%
									%Are you sure your would like to continue replacing all occurrences?") end

	w_No_system_defined: STRING_32 do Result := locale.translation ("No project has been loaded.") end

	w_Finalizing_running: STRING_32 do Result := locale.translation (
		"A finalizing C/C++ compilation is currently in progress. Starting the Eiffel compilation may terminate current finalizing.%NDo you want to continue?")
		end

	w_Freezing_running: STRING_32 do Result := locale.translation (
		"A freezing C/C++ compilation is currently in progress. Starting the Eiffel compilation may terminate current freezing.%NDo you want to continue?")
		end

	w_cannot_clear_when_c_compilation_running: STRING_32 do Result := locale.translation ("Please clear this window after c compilation has exited.") end
	w_cannot_save_when_c_compilation_running: STRING_32 do Result := locale.translation ("Please save output after c compilation has exited.") end
	w_cannot_save_when_external_running: STRING_32 do Result := locale.translation ("Please save output after external command has exited.") end
	w_external_command_running_in_development_window: STRING_32 do Result := locale.translation ("An external command is running, closing this window will terminate it.%NContinue?") end;
	w_value_of_element_is_not_valid (a_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation ("Value of element $1 is not valid."), [a_name]) end;
	w_element_expected_not_found (a_name: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation ("Element $1 expected but not found."), [a_name]) end;
	w_retrieve_default_color: STRING_32 do Result := locale.translation ("Retrieve default color.") end;

	w_help_topic_could_not_be_displayed: STRING_32 do Result := locale.translation ("Help Topic could not be displayed, please check Eiffel Installation") end

	w_Unknown_error: STRING_32 do Result := locale.translation ("An unknown error has occurred%N") end

	w_file_not_valid_assembly (a_file: READABLE_STRING_GENERAL): STRING_32
		require
			a_file_not_void: a_file /= Void
		do
			Result := locale.formatted_string (locale.translation ("The selected file '$1' is not a valid .NET assembly."), [a_file])
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
