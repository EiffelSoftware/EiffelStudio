indexing
	description: "Constants for warning messages."
	conventions: "w_: Warning message"
	date: "$Date$"
	revision: "$Revision$"

class
	WARNING_MESSAGES

inherit
	PRODUCT_NAMES
		export
			{NONE} all
		end

feature -- Project file/directory warnings

	w_Select_project_to_load: STRING is
		"Please select a project in the list or Click%N%
		%on the %"Browse%" button to open a project."

	w_Select_project_to_create: STRING is
		"Please select the kind of project you want to create."

	w_Cannot_open_project: STRING is 
		"Project is not readable. Check permissions."

	w_Cannot_create_project_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("Cannot create project directory in: ")
			Result.append (dir_name)
			Result.append ("%NYou may try again after fixing the permissions.")
		end

	w_Cannot_retrieve_info: STRING is 
		"Cannot read class/feature information.%N%
		%Check permissions in EIFGEN and subdirectories."

	w_Project_directory_not_exist (file_name, dir_name: STRING): STRING is
			-- Error message when something is missing in the Project directory.
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (256)
			Result.append ("%NCannot open project `")
			Result.append (file_name)
			Result.append ("'.%N%NMake sure you have a complete EIFGEN directory in `")
			Result.append (dir_name)
			Result.append ("'.")
		end

	w_Cannot_retrieve_project (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (30)
			Result.append ("Project in: ")
			Result.append (dir_name)
			Result.append ("%NCannot be retrieved. Check permissions")
			Result.append ("%Nand please try again.")
		end

	w_Cannot_compile: STRING is "Read-only project: cannot compile."

	w_Project_exists (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("In `")
			Result.append (dir_name)
			Result.append ("' an Eiffel project already exists.%N")
			Result.append ("Do you wish to overwrite it?")
		end

	w_Project_could_not_deleted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("Could not delete project in`")
			Result.append (dir_name)
			Result.append ("'.%N")
			Result.append ("Please select another directory or make sure%N")
			Result.append ("that no programs are using a file from this project.")
		end

	w_Project_corrupted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (30)
			Result.append ("Project in: ")
			Result.append (dir_name)
			Result.append ("%Nis corrupted. Cannot continue.")
		end
		
	w_Project_incompatible (dir_name: STRING; comp_version, incomp_version: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
			valid_version: comp_version /= Void and then incomp_version /= Void
		do
			if incomp_version.is_empty then
				create Result.make (30)
				Result.append ("File `project.txt' does not exist in the EIFGEN directory of project:%N")
				Result.append (dir_name)
				Result.append (".")
			else
				create Result.make (30)
				Result.append ("Incompatible version for project: ")
				Result.append (dir_name)
				Result.append (".%N")
				Result.append (Workbench_name)
				Result.append (" version is ")
				Result.append (comp_version)
				Result.append (".%NProject was compiled with version ")
				Result.append (incomp_version)
				Result.append (".")
			end
		end
		
	w_Project_incompatible_version (dir_name: STRING; comp_version, incomp_version: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void and then not dir_name.is_empty
			valid_comp_version: comp_version /= Void and then not comp_version.is_empty
			valid_incomp_version: incomp_version /= Void and then not incomp_version.is_empty
		do
			create Result.make (30)
			Result.append ("Incompatible version for project: ")
			Result.append (dir_name)
			Result.append (".%N")
			Result.append (Workbench_name)
			Result.append (" version is ")
			Result.append (comp_version)
			Result.append (".%NProject was compiled with version ")
			Result.append (incomp_version)
			Result.append (".%N%N")
			Result.append ("Click OK to convert this project to version ")
			Result.append (comp_version)
			Result.append (".%N")
		end
		
	w_Project_interrupted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (30)
			Result.append ("Retrieving project in: ")
			Result.append (dir_name)
			Result.append ("%Nwas interrupted. Cannot continue.")
		end
		
	w_Project_may_be_corrupted: STRING is "Some files were made unwritable.%N%
				%Cannot continue the compilation. Please try again."

	w_Read_only_project: STRING is "No write permissions on project.%N%
				%Open in read-only mode?"

	w_None_system: STRING is "A system whose root class is NONE is not runnable."

feature -- File warnings

	w_Cannot_create_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("Cannot create file:%N")
			Result.append (file_name)
			Result.append (".")
		end

	w_Cannot_create_directory (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("Cannot create directory:%N")
			Result.append (file_name)
			Result.append (".")
		end

	w_Cannot_read_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("Directory: ")
			Result.append (dir_name)
			Result.append ("%Ncannot be read.")
		end

	w_Cannot_read_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (file_name.count + 25)
			Result.append ("File: '")
			Result.append (file_name)
			Result.append ("' cannot be read.")
		end

	w_Cannot_read_file_retry (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			Result := w_Cannot_read_file (file_name)
			Result.append (". Try again?")
		end

	w_Cannot_read_filter (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (file_name.count + 25)
			Result.append ("Cannot read filter '")
			Result.append (file_name)
			Result.append ("'.")
		end

	w_Default_ace_file_not_exist (f_name: STRING): STRING is
			-- Error message when the Ace file `f_name' does not exist.
		require
			f_name_not_void: f_name /= Void
		do
			create Result.make (128)
			Result.append ("Default ace file: ")
			Result.append (f_name)
			Result.append ("%Ndoes not exist.")
		end

	w_file_not_exist (f_name: STRING): STRING is
			-- Error message when `f_name' does not exist.
		require
			f_name_not_void: f_name /= Void
		do
			create Result.make (128)
			Result.append ("File: ")
			Result.append (f_name)
			Result.append ("%Ndoes not exist.")
		end

	w_File_does_not_exist_execution_impossible: STRING is " does not exist.%NExecution impossible.%N"

	
	w_Directory_not_exist (dir_name: STRING): STRING is
			-- Error message when a directory does not exist.
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("Directory ")
			Result.append (dir_name)
			Result.append ("%Ndoes not exist.")
		end
			
	w_Directory_already_exists (dir_name: STRING): STRING is
			-- Error message when a directory already exists.
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (128)
			Result.append ("Directory ")
			Result.append (dir_name)
			Result.append ("%Nalready exists.")
		end
			
	w_Directory_wrong_permissions (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (30)
			Result.append ("Directory: ")
			Result.append (dir_name)
			Result.append ("%Ndoes not have read-write-execute permissions.")
			Result.append ("%NYou may try again after fixing the permissions.")
		end

	w_Not_a_plain_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append (file_name)
			Result.append ("%Nis not a plain file.")
		end

	w_Not_creatable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("File: ")
			Result.append (file_name)
			Result.append (" cannot be created.%NPlease check permissions.")
		end

	w_Not_readable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append (file_name)
			Result.append ("%Nis not readable.")
		end

	w_Not_writable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("File: ")
			Result.append (file_name)
			Result.append ("%Nis not writable.%NPlease check permissions.")
		end

	w_File_modified_by_another_editor: STRING is "This file has been modified by another editor."

	w_File_exists (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("File: ")
			Result.append (file_name)
			Result.append (" already exists.%NDo you wish to overwrite it?")
		end

	w_File_exists_edit_it (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (30)
			Result.append ("File: ")
			Result.append (file_name)
			Result.append (" already exists.%NDo you wish to edit it?")
		end

	w_Not_a_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			create Result.make (30)
			Result.append (dir_name)
			Result.append ("%Nis not a directory.")
		end

	w_Not_a_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			create Result.make (file_name.count + 18)
			Result.append ("'")
			Result.append (file_name)
			Result.append ("' is not a file.")
		end

	w_Not_a_file_retry (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			Result := w_Not_a_file (file_name)
			Result.append (". Try again?")
		end

	w_Cannot_open_any_file: STRING is "Only files representing known%N%
									%classes can be opened."
			-- An attempt was made to open a file that does not correspond to a class in the universe.

feature -- Project settings warnings

	w_cluster_with_name_exists: STRING is "A cluster with this name already exists. Please use another name."

	w_cluster_name_not_valid: STRING is "Cluster name is not valid."

	w_cluster_path_not_valid: STRING is "Cluster path is not valid."
			
feature -- Debug warnings

	w_Cannot_debug: STRING is "Current version of system has not been successfully compiled.%N%
						%Cannot use debugging facilities."

	w_Cannot_debug_attributes: STRING is
			"This format is not applicable to attributes."

	w_Cannot_debug_constants: STRING is
			"This format is not applicable to constant attributes."

	w_Cannot_debug_deferreds: STRING is
			"This format is not applicable to deferred features."

	w_Cannot_debug_dynamics: STRING is
			"This format is not applicable to dynamic features."

	w_Cannot_debug_externals: STRING is
			"This format is not applicable to external features."

	w_Cannot_debug_feature: STRING is
			"This format is not applicable to this feature."

	w_Cannot_debug_uniques: STRING is
			"This format is not applicable to unique attributes."

	w_Debug_not_compiled: STRING is
			-- The user tries to launch an application that is not fully compiled.
		"The last compilation was not complete.%N%
		%Running the last compiled application in these conditions%N%
		%may lead to inconsistent information, or to an unexpected behavior."

	w_Removed_class_debug: STRING is
			-- The user tries to launch an application from which classes were removed.
		"Classes were manually removed since last compilation.%N%
		%Running the last compiled application in these conditions%N%
		%may lead to inconsistent information, or to an unexpected behavior."

	w_Disable_breakpoints: STRING is "Do you wish to disable all breakpoints?"

	w_Invalid_working_directory (wd: STRING): STRING is
			-- Message when working directory is incorrect.
		require
			wd_not_void: wd /= Void
		do
			Result := "Could not launch system in %"" + wd + "%"."
		end

feature -- Cluster tree warnings

	w_Cannot_move_class: STRING is
			-- A class involved in a move operation could not be moved.
		"Source file cannot be moved.%N%
		%Please make sure that:%N%
		%the source file exists,%N%
		%the source file is not being edited,%N%
		%the destination directory can be written in."

	w_Cannot_delete_read_only_class (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (100)
			Result.append ("Cannot delete class ")
			upper_name := clone (class_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append ("%Nbecause it is either precompiled%N%
							%or in a library cluster.")
		end

	w_Cannot_delete_library_cluster (cluster_name: STRING): STRING is
		require
			cluster_name_not_void: cluster_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (100)
			Result.append ("Cannot delete cluster ")
			upper_name := clone (cluster_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append ("%Nbecause it is either a precompiled%N%
							%or a library cluster.")
		end

	w_Cannot_add_to_library_cluster (cluster_name: STRING): STRING is
		require
			cluster_name_not_void: cluster_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (100)
			Result.append ("Cannot add a cluster to cluster%N")
			upper_name := clone (cluster_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append ("%Nbecause it is either a precompiled%N%
							%or a library cluster.")
		end

	w_Cannot_find_class (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (30)
			Result.append ("Cannot find class ")
			upper_name := clone (class_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append (".")
		end

	w_Cannot_find_cluster (cluster_name: STRING): STRING is
		require
			cluster_name_not_void: cluster_name /= Void
		local
			lower_name: STRING
		do
			create Result.make (30)
			Result.append ("Cannot find cluster ")
			lower_name := clone (cluster_name)
			lower_name.to_upper
			Result.append (lower_name)
			Result.append (".")
		end

	w_Cannot_find_feature (feat_name, class_name: STRING): STRING is
		require
			feat_name_not_void: feat_name /= Void
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (30)
			Result.append ("Cannot find feature ")
			Result.append (feat_name)
			Result.append (" for class ")
			upper_name := clone (class_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append (".")
		end

	w_Choose_class_or_cluster: STRING is
			-- No class/cluster stone was selected in the development window.
		"Please first select in the editor the class or cluster%Nthat you want to locate."

	w_Class_already_in_cluster (base_name: STRING): STRING is
		require
			base_name_not_void: base_name /= Void
		do	
			create Result.make (30)
			Result.append ("Class with file name ")
			Result.append (base_name)
			Result.append (" already exists in cluster.")
		end

	w_Class_still_in_cluster (base_name: STRING): STRING is
		require
			base_name_not_void: base_name /= Void
		do	
			create Result.make (30)
			Result.append ("A class with file name ")
			Result.append (base_name)
			Result.append ("%Nis still referenced in this cluster.%NPlease recompile to update the system.")
		end

	w_Class_already_exists (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		do
			create Result.make (100)
			Result.append ("Class with name: '")
			Result.append (class_name)
			Result.append ("' already exists.%NPlease select a different class name.")
		end

	w_Enter_path: STRING is "Please enter a folder%Nto receive the new cluster."

	w_Invalid_class_name (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		do
			create Result.make (100)
			Result.append ("'")
			Result.append (class_name)
			Result.append ("' is not a valid class name.%N%
						%Class names should only include%N%
						%alphanumeric characters or underscores,%N%
						%and start with an alphabetic character.%N%
						%Please select a different class name.")
		end

	w_Invalid_cluster_name (cluster_name: STRING): STRING is
		require
			cluster_name_not_void: cluster_name /= Void
		do
			create Result.make (100)
			Result.append ("'")
			Result.append (cluster_name)
			Result.append ("' is not a valid cluster name.%N%
						%Cluster names should only include %N%
						%alphanumeric characters or underscores.%N%
						%Please select a different cluster name.")
		end

	w_Class_modified (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			create Result.make (30)
			Result.append ("Class ")
			upper_name := clone (class_name)
			upper_name.to_upper
			Result.append (upper_name)
			Result.append (" has been modified since last compilation.%N")
			Result.append ("The text will not be clickable.")
		end

	w_Class_not_in_universe: STRING is "Class is not in the universe."

	w_Clear_breakpoints: STRING is "Forget all breakpoints?"

	w_Cluster_path_already_exists (path: STRING): STRING is
		require
			path_not_void: path /= Void
		local
			upper_name: STRING
		do	
			!!Result.make (70);
			Result.append ("Cluster with path ");
			upper_name := clone (path);
			upper_name.to_upper;
			Result.append (upper_name);
			Result.append (" already exists in the universe.")
		end;

	w_Cluster_name_already_exists (name: STRING): STRING is
		require
			name_not_void: name /= Void
		local
			upper_name: STRING
		do	
			!!Result.make (70);
			Result.append ("Cluster with name ");
			upper_name := clone (name);
			upper_name.to_upper;
			Result.append (upper_name);
			Result.append (" already exists in the universe.")
		end;

	w_Directory_already_in_cluster (base_name: STRING): STRING is
		require
			base_name_not_void: base_name /= Void
		local
			upper_name: STRING
		do	
			!!Result.make (60);
			Result.append ("Directory with name ");
			upper_name := clone (base_name)
			upper_name.to_lower
			Result.append (upper_name)
			Result.append (" already exists.%N%
				%Do you want to use it for the new cluster?")
		end

	w_Confirm_delete_class (class_name: STRING): STRING is
		do
			Result := "Class " + class_name + " will be permanently%N%
						%removed from the system and from the disk.%N%N%
						%Are you sure this is what you want?"
		end

	w_Confirm_delete_cluster (cluster_name: STRING): STRING is
		do
			Result := "Cluster " + cluster_name + " will be permanently%N%
						%removed from the system.%N%N%
						%Are you sure this is what you want?"
		end

	w_Compiling: STRING is "Command cannot be executed while the project is%N%
							%being compiled.%N%
							%Please wait until compilation finishes."
	
	w_Could_not_locate (cl_name: STRING): STRING is
			-- Class/cluster could not be found in the cluster tree.
		do
			Result := "Could not locate " + cl_name + ".%NPlease make sure system is correctly compiled."
		end

	w_Unsufficient_compilation (degree: INTEGER): STRING is
			-- The last or current compilation of the project did not
			-- go through degree `degree', so that a command cannot be executed.
		require
			valid_degree: degree >= -5 and degree <= 6
		do
			Result := "Command cannot be executed unless compilation%N%
						%goes through degree " + degree.out + "."
		end

	w_Unsuccessful_compilation: STRING is "Command cannot be executed because last compilation%N%
											%was not successful.%N%
											%Please compile the project before calling this command."

	w_Project_not_compiled: STRING is 
			"Command cannot be executed because the project%N%
			%has never been compiled.%N%
			%Please compile the project before calling this command."

	w_Feature_is_not_compiled: STRING is 
			"An error occurred on breakpoints because a feature%N%
			%was not correctly compiled.%N%N%
			%Recompiling the project completely will solve the problem."

	w_Formatter_failed: STRING is
			-- A formatter crashed, most probably because the last compilation was not successful
			-- or because we are compiling.
		"Format could not be generated.%N%
		%Please make sure that the system is not being compiled %
		%and that the last compilation was successful."

	w_Files_not_saved_before_compiling: STRING is
			"Some files have not been saved.%N%
			%Do you want to save them before compiling?%N"

	w_Degree_needed (n: INTEGER): STRING is
			-- A command needs a certain degree during a compilation.
		require
			valid_degree: n >= -5 and n <= 6
		do
			Result := "Command cannot be executed until degree " + n.out + " completed.%N%
						%Please wait until then before calling this command."
		end

	w_Select_parent_cluster: STRING is
			-- User needs to select a cluster in the new cluster dialog.
		"Please select a cluster from the list.%N%
		%A parent cluster is needed."

feature -- Backup warnings

	w_cannot_backup_project (base_name: STRING): STRING is
			-- To backup the project
		require
			base_name_not_void: base_name /= Void
		do
			create Result.make (128)
			Result.append ("Cannot make a backup of your old project in %N")
			Result.append (base_name)
			Result.append (".%NMake sure that no backup directory is already there%N")
			Result.append ("and that you have write permissions to this directory.")
		end	

	w_Crashed: STRING is 
		once
			Result := "An unexpected error occurred.%N"+
					WorkBench_name+" will now make an attempt to create%N%
						%a backup of the edited files."
		end

	w_Backup_succeeded: STRING is "Backup was successful.%N%
								%Class files were saved with a .swp extension."

	w_Backup_partial (i: INTEGER): STRING is
			-- `i' files could not be saved during a backup.
		do
			Result := i.out
			if i = 1 then
				Result.append ("file")
			else
				Result.append (" files")
			end
			Result.append (" could not be backed up.%N%
					%Other class files were saved with a .swp extension.")
		end

	w_Backup_failed: STRING is "Backup failed for some files.%N%
								%The state of the system was too damaged."

	w_Found_backup: STRING is "A backed up version of the file was found.%N%
							%Do you want to open the normal file or the backup file?%N%
							%If you choose the normal file, the backup file will be%N%
							%deleted. If choose the backup file, the text will not be%N%
							%editable. To modify it, you will have to save it first.%N"

	w_Save_backup: STRING is "You are about to overwrite the original file with%N%
					%the backup file. Previous content will be lost%N%
					%and the backup file deleted."

	w_Edited_backup: STRING is "You edited a backup version of the file.%N%
							%Do you want to save your modifications to the backed up version%N%
							%or erase the backup file and save your modifications%N%
							%to the normal file?"

feature -- Dynamic library warnings

	w_Save_invalid_definition: STRING is
			-- The user tries to save an invalid definition file.
		"There are problems in this library definition.%N%
		%Call 'Check' to have more information.%N%
		%Save anyway?"

	w_Invalid_feature_exportation: STRING is
			-- A feature export is invalid.
		"This feature export clause contains errors.%N%
		%Try editing it to have more information."

	w_Conflicting_exports: STRING is
			-- Some feature exportation clauses have conflicts.
		"Some feature export clauses are conflicting.%N%
		%Please make sure that export clauses do not share%N%
		%either their indices or their exported names."

	w_No_errors_found: STRING is
			-- The export feature definitions seem ok.
		"No errors were found."

	w_Not_a_compiled_class (cl_name: STRING): STRING is
			-- The `cl_name' does not represent a valid class.
		do
			if cl_name /= Void then
				Result := "%"" + cl_name + "%"%N%
				%is not a compiled class."
			else
				Result := "Please specify a class name."
			end
		end

	w_Not_a_compiled_class_line (cl_name: STRING): STRING is
			-- The `cl_name' does not represent a valid class.
		do
			if cl_name /= Void then
				Result := "%"" + cl_name + "%" %
				%is not a compiled class."
			else
				Result := "Please specify a class name."
			end
		end

	w_Class_cannot_export: STRING is "This class cannot export features.%N%
				%Please make sure that it is neither deferred nor generic%N%
				%and that the system is correctly compiled."

	w_No_exported_feature (f_name, cl_name: STRING): STRING is
			-- `f_name' cannot be found in class `cl_name'.
		require
			f_not_void_implies_c_not_void: f_name /= Void implies cl_name /= Void
		do
			if f_name = Void then
				Result := "Please enter a feature name."
			else
				Result := "Class %"" + cl_name + "%"%N%
					%has no feature named %"" + f_name + "%"."
			end
		end

	w_Feature_cannot_be_exported: STRING is "This feature cannot be exported.%N%
				%Deferred features, external ones,%N%
				%and attributes cannot be exported."

	w_No_valid_creation_routine: STRING is
			"No valid creation routine%N%
			%could be found for this class.%N%
			%Please make sure the chosen class%N%
			%has a creation routine taking no argument."

	w_Invalid_parameters: STRING is
			-- The chosen export parameters are invalid.
		"These parameters are invalid."

	w_Invalid_index: STRING is
			-- The chosen index is not valid.
		"Index is out of range.%N%
		%Indices should be positive integers."

	w_Invalid_alias: STRING is
			-- The chosen parameters are not valid.
		"Alias is invalid.%N%
		%Please check that it is a valid C identifier."

	w_Cannot_load_library (fn: STRING): STRING is
			-- The library located in file `fn' cannot be read.
		do
			Result := "The file " + fn + "%N%
					%either cannot be read or does not represent%N%
					%a valid dynamic library definition."
		end

	w_Cannot_save_library (fn: STRING): STRING is
			-- The library cannot be written in file `fn'.
		do
			Result := "Could not save the library definition to%N" + fn + "."
		end

	w_Error_parsing_the_library_file: STRING is
			-- An error occurred while parsing a .def file.
		"This file seems to be corrupted.%N%
		%Not all items inside could be loaded."

	w_Unsaved_changes: STRING is
			-- The user tries to exit the dialog although some modifications were not saved.
		"This will discard the modifications."
		

feature -- Preferences warnings

	w_Invalid_preference_file_root (file_name: STRING): STRING is
			-- file named `file_name' is not an XML file with "EIFFEL_DOCUMENT" as
			-- root tag.
		do
			Result := "EIFFEL_DOCUMENT tag missing in file: "+ file_name + "."
		end

	w_Preferences_delayed_resources: STRING is
		once
			Result := "The changes you have made to the following resources%N%
				%will be effective when you restart " + Workbench_name + ".%N%N"
		end

feature -- Ace/Project settings warnings

	w_Could_not_parse_ace: STRING is "An error occurred while parsing the Ace file.%N%
									%Please try using the system configuration tool."
	
	w_Incorrect_ace_configuration: STRING is "Some values are invalid, %
									%please correct the corresponding entries"

	w_Root_cluster_cannot_be_deleted: STRING is "Cannot delete root node of cluster tree."

	w_Specify_ace: STRING is "Project requires an Ace file (control file)."

feature -- Profiler messages

	w_Profiler_Bad_query: STRING is
			-- Message displayed when detecting a bad query
		do
			create Result.make (0)
			Result.append ("Please enter a correct query, for example:%N")
			Result.append ("%Tfeaturename = WORD.t*%N")
			Result.append ("%Tfeaturename < WORD.mak?%N")
			Result.append ("%Tcalls > 2%N")
			Result.append ("%Tself <= 3.4%N")
			Result.append ("%Tdescendants in 23 - 34%N")
			Result.append ("%Ttotal >= 12.3%N")
			Result.append ("%Tpercentage /= 2%N")
			Result.append ("%Tcalls > avg%N")
			Result.append ("%Tself <= max%N")
			Result.append ("%Ttotal > min%N")
			Result.append ("%N")
			Result.append ("You can also combine subqueries with 'and' and 'or', for example:%N")
			Result.append ("%Tcalls > 2 and self <= 3.4 or percentage in 2.3 - 3.5")
		end
		
	w_Profiler_select_one_output_switch: STRING is "Select at least one output switch."

	w_Profiler_select_one_language: STRING is "Select at least one language."

feature -- Project creation, retrieval, ...

	w_Unable_to_retrieve_project: STRING is "Unable to retrieve the project, it may be corrupted."
	
	w_Fill_in_location_field: STRING is "Please fill in the 'Location' field."
	
	w_Fill_in_project_name_field: STRING is "Please fill in the 'Project Name' field."
	
	w_Fill_in_ace_field: STRING is "Please fill in the 'Ace file' field."
	
	w_Unable_to_load_ace_file (an_ace_name: STRING): STRING is 
		do
			Result := "Unable to load the ace file `" + an_ace_name + "'."
		end
		
	w_Invalid_directory_or_cannot_be_created (a_directory_name: STRING): STRING is
		do
			Result := "'" + a_directory_name + "' is not a valid directory and/or cannot be created%N%
				%Please choose a valid and writable directory."
		end
		

feature -- Warning messages

	w_Assertion_warning: STRING is 
		"By default assertions enabled in the Ace file are kept%N%
		%in final mode.%N%
		%%N%
		%Keeping assertion checking inhibits any optimization%N%
		%specified in the Ace (inlining, array optimization,%N%
		%dead-code removal) and will produce a final executable%N%
		%that is not optimal in speed and size.%N%
		%%N%
		%Are you sure you want to keep the assertions in your%N%
		%finalized executable?"

	w_Beginning_of_history: STRING is "Beginning of history"

	w_Backup_file_not_editable: STRING is "Backup file cannot be modified.%NTo edit it, save it first."
	
	w_Cannot_move_favorite_to_a_child: STRING is 
		"Moving a folder to one of its children%N%
		%is not possible."

	w_Class_not_modifiable: STRING is "The text of this class cannot be modified."

	w_Continue: STRING is "%N%NDo you want to continue anyway?"

	w_Unknown_error: STRING is "This command failed."

	w_End_of_history: STRING is "End of history"
	
	w_cannot_save_png_file (a_file_name: STRING): STRING is 
		do
			if a_file_name /= Void then
				Result := "Could not save diagram to " + a_file_name
			else
				Result := "Could not save diagram to specified location."
			end
		end
	
	w_cannot_generate_png: STRING is "Could not generate PNG file.%NInsufficient video memory."
	
	w_Environment_not_initialized: STRING is "$ISE_EIFFEL is not initialized. Execution impossible%N"

	w_Feature_not_compiled: STRING is "Feature is not compiled."

	w_Features_not_compiled: STRING is "Features not yet compiled."

	w_Freeze_warning: STRING is 
		"Freezing implies some C compilation and linking.%N%
		% - Click Yes to compile the Eiffel system (including C compilation)%N%
		% - Click No  to compile the Eiffel system (no C compilation)%N%
		% - Click Cancel to abort%N%
		%%N"

	w_Finalize_warning: STRING is 
		"Finalizing implies some C compilation and linking.%N%
		% - Click Yes to compile the C code after finalizing the system%N%
		% - Click No  to skip the C compilation (no executable will be generated)%N%
		% - Click Cancel to abort%N%
		%%N"

	w_License_lost: STRING is "You have lost your license!%N%
								%(You can still save your changes%N%
								%and exit the project.)"

	w_Load_configuration: STRING is	"An error occurred while loading the %
									%configuration for your profiler.%N%
									%Please check with your system %
									%administrator whether your profiler is %
									%supported.%N"

	w_Ignoring_all_stop_points: STRING is "Application will ignore all breakpoints."

	w_Unknown_cluster_name: STRING is "No cluster in the system has this name.";

	w_Invalid_folder_name: STRING is "Invalid folder name"

	w_Invalid_creation_name (a_name: STRING): STRING is 
		do
			Result := "Invalid creation procedure name: "
			Result.append (a_name)
		end

	w_Invalid_root_class_name (a_name: STRING): STRING is 
		do
			Result := "Invalid root class name: "
			Result.append (a_name)
		end

	w_Invalid_system_name (a_name: STRING): STRING is 
		do
			Result := "Invalid system name: "
			Result.append (a_name)
		end

	w_Invalid_cluster: STRING is
			-- One of the clusters involved in a move operation was invalid.
		"One of the clusters is invalid.%N%N%
		%Please check that none is precompiled or a library,%N%
		%and that the corresponding directories have sufficient rights."

	w_Include_parents: STRING is "Do you wish to include parents?"

	w_Makefile_more_recent (make_file: STRING): STRING is
		require
			make_file_not_void: make_file /= Void
		do
			create Result.make (30)
			Result.append (make_file)
			Result.append (" is more recent than the system.%N")
			Result.append ("Do you want to compile the generated C code?")
		end
		
	w_Makefile_does_not_exist (make_file: STRING): STRING is
		require
			make_file_not_void: make_file /= Void
		do
			create Result.make (30)
			Result.append (make_file)
			Result.append (" does not exist.%N")
			Result.append ("Cannot invoke C compilation.")
		end

	w_MakefileSH_more_recent: STRING is "The Makefile.SH is more recent than the system."

	w_Melt_only: STRING is "This feature is not available in the personal version.%N%
			%Please upgrade to the professional version of ISE Eiffel 4."

	w_Must_compile_first: STRING is "You must compile a project first."

	w_Must_finalize_first: STRING is "You must finalize your project first."

	w_No_associated_file: STRING is "There is no associated file for pebble dropped."
	
	w_No_class_matches: STRING is "No class in any cluster matches this name."

	w_No_cluster_matches: STRING is "No cluster in the system matches this name."

	w_No_feature_matches: STRING is "No feature in this class matches this name."

	w_No_feature_to_display: STRING is "No feature in this file"

	w_No_filter_selected: STRING is "No filter selected"

	w_No_such_feature_in_this_class (feature_name, class_name: STRING): STRING is
		do
			Result := "No feature named " + feature_name + " could be found in class " + class_name + "."
		end

	w_No_system_generated: STRING is "No system was generated.%N%
						%Please make sure the C compilation ended correctly."

	w_No_dotnet_system_generated: STRING is "No system was generated.%N%
						%Please make sure the Eiffel compilation ended successfully."

	w_No_system: STRING is "No system was defined.%NCannot launch the application."

	w_Not_a_filterable_format: STRING is "The selected format is not filterable."

	w_Not_an_integer: STRING is "Please enter an integer value."


	w_Object_not_inspectable: STRING is "Object may not be inspected."

	w_Pebble_not_valid: STRING is "Pebble is not valid."

	w_Precompile_warning: STRING is "Precompiling implies some C compilation%N%
									%and linking. Do you want to do it now?"
									
	w_Select_class_cluster_to_remove: STRING is "Please select a class or a cluster %N%
										%before calling this command.%N%
										%It will then be removed."

	w_Specify_a_class: STRING is "Please specify a compiled class (or * for all classes)."

	w_Specify_a_feature: STRING is "Please specify a feature."

	w_Stop_compilation: STRING is "This command will stop the compilation."

	w_Stop_debugger: STRING is "This command will stop the debugger."

	w_System_not_running: STRING is "System is not running."

	w_System_not_stopped: STRING is "System is not stopped."

	w_Unexisting_system: STRING is "System doesn't exist."

	w_Unknown_class: STRING is "Unknown class"

	w_Unknown_feature: STRING is "Unknown feature"

	w_Unknown_object: STRING is "Unknown object"

	w_File_changed (class_name: STRING): STRING is
		do
			if class_name = Void then
				Result := "File has been modified.%NDo you want to save changes?"
			else
				Result := "Class "+ class_name + " has been modified.%NDo you want to save changes?"
			end
		end

	w_Syntax_error: STRING is "Class has syntax error.%NText will not be clickable.%NSee highlighted area."

	w_Search_error_includes_null_char: STRING is "The expression you entered includes the null character.%NThe search is not possible."

	w_Search_error_not_regular_expression: STRING is "The expression you entered is not a regular expression."

	w_Select_object_to_remove: STRING is "Please select a top-level item%N%
										%different from the current object%N%
										%(i.e. the first one) in the object tree%N%
										%to have it removed."

	w_Text_not_editable: STRING is "Current text is not editable."
	
	w_Class_header_syntax_error (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		do
			Result := "Syntax error in class "
			Result.append (class_name)
		end
		
	w_Class_syntax_error_before_generation (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		do
			Result := "Class " + class_name + " has syntax error.%N"
			Result.append ("Code generation cancelled.")
		end
		
	w_Class_modified_outside_diagram: STRING is "Class was modified outside the diagram.%N%
												%Previous commands are not undoable any longer."
												
	w_Inheritance_from_any: STRING is "Cannot remove inheritance from ANY."
		
	w_New_feature_syntax_error: STRING is "New feature has syntax error.%NCode generation cancelled."
		
	w_Wrong_class_name: STRING is "Syntax error in name or generics"

	w_Class_name_changed: STRING is "Class name has changed since last compilation.%NCurrent text will not be clickable.%N%
						%Recompile to make it clickable again."
						
	w_Unable_to_execute_wizard (wizard_file: STRING): STRING is
		do
			Result := 
				"Unable to execute the wizard.%N%
				%Check that `"+wizard_file+"' exists and is executable.%N"	
		end
		
	w_Internal_error: STRING is
		"An internal error occurred.%N%N%
		%1 - Check that you have enough space to compile.%N%
		%2 - Check that you are not using specific Eiffel%N%
		%     construct not supported by EiffelSharp%N%
		%3 - If this happens even after relaunching the environment%N%
		%     delete your EIFGEN and recompile from scratch.%N%N%
		%Follow the instructions at http://support.eiffel.com/submit.html in%N%
		%order to submit a bug report at http://support.eiffel.com"
		
		
end -- class WARNING_MESSAGES
