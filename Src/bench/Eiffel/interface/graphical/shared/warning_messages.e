-- Messages appearing in the warner popup window.

class WARNING_MESSAGES

feature {NONE}

	w_Assertion_warning: STRING is "By default assertions enabled in the Ace%N%
								%file are kept in final mode.%N%
								%A final executable with assertion checking%N%
								%enabled is not optimal in speed and size.%N";

	w_Beginning_of_history: STRING is "Beginning of history";

	w_Cannot_compile: STRING is "Read-only project: cannot compile.";

	w_Cannot_create_file (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("Cannot create file:%N");
			Result.append (file_name)
		end;

	w_Cannot_debug: STRING is 
			"Current version of system has not been successfully compiled. %N%
			%Cannot use debugging facilities.";

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
		end;

	w_Cannot_open_project: STRING is 
			"Project is not readable; check permissions.";

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

	w_Class_already_in_cluster (class_name: STRING): STRING is
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

	w_Class_not_in_universe: STRING is "Class is not in the universe";

	w_Directory_not_exist (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Directory: ");
			Result.append (dir_name);
			Result.append ("%Ndoes not exist")
		end;
			
	w_Directory_wrong_permissions (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Directory: ");
			Result.append (dir_name);
			Result.append ("%Ndoes not have appropriate permissions.")
		end;

	w_End_of_history: STRING is "End of history";

	w_Feature_not_compiled: STRING is "Feature is not compiled";

	w_Finalize_warning: STRING is "Finalizing implies some C compilation%N%
									%and linking. Do you want to do it now?";

	w_File_exists (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append (" already exists.%NDo you wish to overwrite it?")
		end;

	w_File_exists_edit_it (file_name: STRING): STRING is
		require
			file_name_not_void: file_name /= Void
		do
			!!Result.make (30);
			Result.append ("File: ");
			Result.append (file_name);
			Result.append (" already exists.%NDo you wish to edit it?")
		end;

	w_Freeze_warning: STRING is "Freezing implies some C compilation%N%
									%and linking. Do you want to do it now?";

	w_License_lost: STRING is "You have lost your licence!%N%
								%(You can still save your changes%N%
								%and exit the project.)";

	w_Invalid_cluster_name: STRING is "Invalid cluster name";

	w_Makefile_more_recent (make_file: STRING): STRING is
		require
			make_file_not_void: make_file /= Void
		do
			!!Result.make (30);
			Result.append (make_file);
			Result.append (" is more recent than the system.%N");
			Result.append ("Do you want to compile the generated C code?")
		end;

	w_Melt_only: STRING is"%
			%This feature is not available in the personal version.%N%
			%Please upgrade to the professional version of ISE Eiffel 3";

	w_Must_compile_first: STRING is "You must compile a system first";

	w_No_associated_file: STRING is "There is no associated file for %
													%pebble dropped";

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

	w_Not_a_filterable_format: STRING is "Only clickable, flat, short %
									%and flat-short forms may be filtered";

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

	w_Object_not_inspectable: STRING is "Object may not be inspected";

	w_Pebble_not_valid: STRING is "Pebble is not valid";

	w_Project_corrupted (dir_name: STRING): STRING is
		require
			dir_name_not_void: dir_name /= Void
		do
			!!Result.make (30);
			Result.append ("Project in: ");
			Result.append (dir_name);
			Result.append ("%Nis corrupted. Cannot continue")
		end;
		
	w_Project_may_be_corrupted: STRING is "Some files were made unwritable.%N%
				%Cannot continue. Project may be corrupted.";

	w_Read_only_project: STRING is "No write permissions on project.%N%
				%Open in read-only mode?";

	w_Specify_a_class: STRING is "Please specify a class";

	w_Specify_a_feature: STRING is "Please specify a feature";

	w_System_not_running: STRING is "System is not running";

	w_System_not_stopped: STRING is "System is not stopped";

	w_Unknown_class: STRING is "Unknown class";

	w_Unknown_feature: STRING is "Unknown feature";

	w_Unknown_object: STRING is "Unknown object";

end -- class WARNING_MESSAGES
