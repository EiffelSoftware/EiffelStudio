indexing
	description: "Constants for warning messages.";
	conventions: "w_: Warning message";
	date: "$Date$";
	revision: "$Revision$"

class
	WARNING_MESSAGES

feature -- Warning messages

	w_Assertion_warning: STRING is "By default assertions enabled in the Ace%N%
							%file are kept in final mode.%N%
							%Keeping assertion checking inhibits any optimization%N%
							%specified in the Ace (inlining, array optimization,%N%
							%dead-code removal) and will produce a final executable%N%
							%that is not optimal in speed and size.%N";

	w_Beginning_of_history: STRING is "Beginning of history"

	w_Cannot_compile: STRING is "Read-only project: cannot compile."

	w_Cannot_create_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("Cannot create file:%N");
			Result.append (file_name)
		end

	w_cannot_backup_project (base_name: STRING): STRING is
			-- To backup the project
		require
			base_name_not_void: base_name /= Void
		do
			!! Result.make (128)
			Result.append ("Cannot make a backup of your old project in %N")
			Result.append (base_name)
			Result.append ("%NMake sure that no backup directory is already there%N")
			Result.append ("or that you have write permissions to this directory.")
		end	
		
	w_Cannot_debug: STRING is "Current version of system has not been successfully compiled. %N%
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

	w_Cannot_find_class (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			!!Result.make (30);
			Result.append ("Cannot find class ");
			upper_name := clone (class_name);
			upper_name.to_upper;
			Result.append (upper_name)
		end;

	w_Cannot_find_cluster (cluster_name: STRING): STRING is
		require
			cluster_name_not_void: cluster_name /= Void
		local
			lower_name: STRING
		do
			!!Result.make (30);
			Result.append ("Cannot find cluster ");
			lower_name := clone (cluster_name);
			lower_name.to_upper;
			Result.append (lower_name)
		end;

	w_Cannot_find_feature (feat_name, class_name: STRING): STRING is
		require
			feat_name_not_void: feat_name /= Void;
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			!!Result.make (30);
			Result.append ("Cannot find feature ");
			Result.append (feat_name);
			Result.append (" for class ");
			upper_name := clone (class_name);
			upper_name.to_upper;
			Result.append (upper_name)
		end

	w_Cannot_open_project: STRING is 
			"Project is not readable; check permissions."

	w_Cannot_read_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!! Result.make (128);
			Result.append ("Directory: ");
			Result.append (dir_name);
			Result.append ("%Ncannot be read")
		end

	w_Cannot_create_project_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!! Result.make (128);
			Result.append ("Cannot create project directory in: ");
			Result.append (dir_name);
			Result.append ("%NYou may try again after fixing the permissions.")
		end

	w_Cannot_read_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append ("%Ncannot be read")
		end;

	w_Cannot_read_file_retry (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			Result := w_Cannot_read_file (file_name);
			Result.append (". Try again?")
		end;

	w_Cannot_read_filter (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("Cannot read filter ");
			Result.append (file_name)
		end;

	w_Cannot_retrieve_info: STRING is "Cannot read class/feature information.%N%
				%Check permissions in EIFGEN and subdirectories.";

	w_Cannot_retrieve_project (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Project in: ");
			Result.append (dir_name);	
			Result.append ("%NCannot be retrieved. Check permissions");
			Result.append ("%Nand please try again")
		end;

	w_Class_already_in_cluster (base_name: STRING): STRING is
		require
			base_name_not_void: base_name /= Void
		local
			upper_name: STRING
		do	
			!!Result.make (30);
			Result.append ("Class with file name ");
			upper_name := clone (base_name);
			upper_name.to_upper;
			Result.append (upper_name);
			Result.append (" already exist in cluster")
		end;

	w_Class_modified (class_name: STRING): STRING is
		require
			class_name_not_void: class_name /= Void
		local
			upper_name: STRING
		do
			!!Result.make (30);
			Result.append ("Class ");
			upper_name := clone (class_name);
			upper_name.to_upper;
			Result.append (upper_name);
			Result.append (" has been modified since last compilation.%N");
			Result.append ("The text will not be clickable.")
		end;

	w_Class_not_in_universe: STRING is "Class is not in the universe"

	w_Clear_breakpoints: STRING is "Do you wish to clear the stop points?"

	w_Default_ace_file_not_exist (f_name: STRING): STRING is
			-- Error message when the Ace file does not exist.
		require
			f_name_not_void: f_name /= Void
		do
			!! Result.make (128);
			Result.append ("Default ace file: ");
			Result.append (f_name);
			Result.append ("%Ndoes not exist.")
		end;

	w_file_not_exist (f_name: STRING): STRING is
			-- Error message when the Ace file does not exist.
		require
			f_name_not_void: f_name /= Void
		do
			!! Result.make (128);
			Result.append ("File: ");
			Result.append (f_name);
			Result.append ("%Ndoes not exist.")
		end;
	
	w_Directory_not_exist (dir_name: STRING): STRING is
			-- Error message when a directory does not exist.
		require
			dir_name_not_void: dir_name /= Void
		do
			!! Result.make (128);
			Result.append ("Directory ");
			Result.append (dir_name);
			Result.append ("%Ndoes not exist.")
		end
			
	w_Project_directory_not_exist (file_name, dir_name: STRING): STRING is
			-- Error message when something is missing in the Project directory.
		require
			dir_name_not_void: dir_name /= Void
		do
			!! Result.make (256);
			Result.append ("%NCannot open project `")
			Result.append (file_name)
			Result.append ("'.%N%NMake sure you have a complete EIFGEN directory in `")
			Result.append (dir_name)
			Result.append ("'.")
		end;
			
	w_Directory_wrong_permissions (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Directory: ");
			Result.append (dir_name);
			Result.append ("%Ndoes not have read-write-execute permissions.")
			Result.append ("%NYou may try again after fixing the permissions.")
		end

	w_End_of_history: STRING is "End of history"

	w_Feature_not_compiled: STRING is "Feature is not compiled"

	w_Finalize_warning: STRING is "Finalizing implies some C compilation%N%
									%and linking. Do you want to do it now?";

	w_Project_exists (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!! Result.make (128)
			Result.append ("In `")
			Result.append (dir_name)
			Result.append ("' an Eiffel project already exists.%N")
			Result.append ("Do you wish to overwrite it?")
		end

	w_File_exists (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append (" already exists.%NDo you wish to overwrite it?")
		end

	w_File_exists_edit_it (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append (" already exists.%NDo you wish to edit it?")
		end

	w_Freeze_warning: STRING is "Freezing implies some C compilation%N%
									%and linking. Do you want to do it now?";

	w_License_lost: STRING is "You have lost your license!%N%
								%(You can still save your changes%N%
								%and exit the project.)";

	w_Load_configuration: STRING is	"An error occured while loading the %
									%configuration for your profiler.%N%
									%Please check with your system %
									%administrator whether your profiler is %
									%supported.%N";

	w_Ignoring_all_stop_points: STRING is "Application will ignore all stop points";

	w_Invalid_cluster_name: STRING is "Invalid cluster name";

	w_Invalid_creation_name (a_name: STRING): STRING is 
		do
			Result := "Invalid creation procedure name: "
			Result.append (a_name)
		end;

	w_Invalid_root_class_name (a_name: STRING): STRING is 
		do
			Result := "Invalid root class name: "
			Result.append (a_name)
		end;

	w_Invalid_system_name (a_name: STRING): STRING is 
		do
			Result := "Invalid system name: "
			Result.append (a_name)
		end;

	w_Include_parents: STRING is "Do you wish to include parents?";

	w_Makefile_more_recent (make_file: STRING): STRING is
		require
			make_file_not_void: make_file /= Void
		do
			!!Result.make (30);
			Result.append (make_file);
			Result.append (" is more recent than the system.%N");
			Result.append ("Do you want to compile the generated C code?")
		end;
	w_Makefile_does_not_exist (make_file: STRING): STRING is
		require
			make_file_not_void: make_file /= Void
		do
			!!Result.make (30);
			Result.append (make_file);
			Result.append (" does not exist.%N");
			Result.append ("Cannot invoke C compilation")
		end

	w_MakefileSH_more_recent: STRING is "The Makefile.SH is more recent than the system."

	w_Melt_only: STRING is "This feature is not available in the personal version.%N%
			%Please upgrade to the professional version of ISE Eiffel 4"

	w_Must_compile_first: STRING is "You must compile a system first"

	w_Must_finalize_first: STRING is "You must finalize your project first"

	w_No_associated_file: STRING is "There is no associated file for pebble dropped"

	w_No_filter_selected: STRING is "No filter selected"

	w_No_system_generated: STRING is "No system was generated.%N%
						%Do you want to compile the generated C code?";

	w_Not_a_directory (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append (dir_name);
			Result.append ("%Nis not a directory")
		end;

	w_Not_a_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append (file_name);
			Result.append ("%Nis not a file")
		end;

	w_Not_a_file_retry (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			Result := w_Not_a_file (file_name);
			Result.append (". Try again?")
		end;

	w_Not_a_filterable_format: STRING is "The selected format is not filterable";

	w_Not_a_plain_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append (file_name);
			Result.append ("%Nis not a plain file")
		end;

	w_Not_creatable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append (" cannot be created.%NPlease check permissions")
		end;

	w_Not_readable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append (file_name);
			Result.append ("%Nis not readable")
		end;

	w_Not_writable (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append ("%Nis not writable.%NPlease check permissions")
		end;

	w_Object_not_inspectable: STRING is "Object may not be inspected"

	w_Pebble_not_valid: STRING is "Pebble is not valid"

	w_Precompile_warning: STRING is "Precompiling implies some C compilation%N%
									%and linking. Do you want to do it now?"

	w_Project_corrupted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Project in: ");
			Result.append (dir_name);
			Result.append ("%Nis corrupted. Cannot continue")
		end;
		
	w_Project_incompatible (dir_name: STRING; 
			comp_version, incomp_version: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
			valid_version: comp_version /= Void and then incomp_version /= Void
		do
			if incomp_version.empty then
				!! Result.make (30);
				Result.append 
					("File `project.txt' does not exist in the EIFGEN directory of project:%N")
				Result.append (dir_name);
			else
				!! Result.make (30);
				Result.append ("Incompatible version for project: ");
				Result.append (dir_name);
				Result.append ("%NEiffelBench version is ");
				Result.append (comp_version);
				Result.append ("%NProject was compiled with version ");
				Result.append (incomp_version);
			end
		end;
		
	w_Project_interrupted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Retrieving project in: ");
			Result.append (dir_name);
			Result.append ("%Nwas interrupted. Cannot continue")
		end;
		
	w_Project_may_be_corrupted: STRING is "Some files were made unwritable.%N%
				%Cannot continue the compilation. Please try again."

	w_Read_only_project: STRING is "No write permissions on project.%N%
				%Open in read-only mode?"

	w_Specify_a_class: STRING is "Please specify class (or * for all classes)"

	w_Specify_a_feature: STRING is "Please specify a feature"

	w_System_not_running: STRING is "System is not running"

	w_System_not_stopped: STRING is "System is not stopped"

	w_Unexisting_system: STRING is "System doesn't exist"

	w_Unknown_class: STRING is "Unknown class"

	w_Unknown_feature: STRING is "Unknown feature"

	w_Unknown_object: STRING is "Unknown object"

	w_File_changed: STRING is "File has changed.%N Do you want to save changes?"

	w_Specify_ace: STRING is "Unspecified ace file%NChoose one?"

end -- class WARNING_MESSAGES
