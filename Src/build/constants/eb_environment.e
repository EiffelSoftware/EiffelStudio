class EB_ENVIRONMENT 

inherit

	OPERATING_ENVIRONMENT;
	EXECUTION_ENVIRONMENT
		rename
			put as environment_put
		end;

feature -- Directory name constants

	Ace_name: STRING is "Ace";
	Application_name: STRING is "Application";
	Bitmaps_name: STRING is "bitmaps";
	Bin_name: STRING is "bin";
	Build_name: STRING is "build";
	Classes_name: STRING is "Classes";
	Commands_name: STRING is "Commands";
	Eiffel3_variable_name: STRING is "EIFFEL3";
	Groups_name: STRING is "Groups";
	Help_name: STRING is "help";
	Library_name: STRING is "Library";
	Platform_variable_name: STRING is "PLATFORM";
	Resources_name: STRING is "resources";
	Restore_name: STRING is ".restore";
	Spec_name: STRING is "spec";
	State_name: STRING is "State";
	Storage_name: STRING is "Storage";
	Templates_name: STRING is ".templates";
	Widgets_name: STRING is "Widgets";
	Windows_name: STRING is "Windows";

feature -- Project directory name

	Project_Directory: STRING is
			-- Directory for all EiffelBuild 
			-- session files. (Set from the
			-- project window)
		once
			!!Result.make (0)
		end;

feature -- File name constants 

	Application_file_name: STRING is "application";
	Color_names_file_name: STRING is "color_names";
	Commands_file_name: STRING is "commands";
	Command_doc_file_name: STRING is "cmd.doc";
	Command_temp_old_file_name: STRING is "cmd_tmp.old";
	Command_temp_new_file_name: STRING is "cmd_tmp.new";
	Groups_file_name: STRING is "groups";
	Interface_file_name: STRING is "interface";
	Merge1_file_name: STRING is "merge1";
	Merge2_file_name: STRING is "merge2";
	Namer_file_name: STRING is "namer";
	Shared_control_file_name: STRING is "shared_control";
	States_file_name: STRING is "states";
	Translations_file_name: STRING is "translations";
	Windows_file_name: STRING is "windows"

feature -- File names for EiffelBuild

	Ace_file: STRING is
		once
			Result := clone (Resources_directory);
			Result.extend (directory_separator);
			Result.append (Ace_name);
			Result.extend (directory_separator);
			Result.append (Ace_name);
		end;

	Color_names_file: STRING is
		once
			Result := clone (Resources_directory);
			Result.extend (directory_separator);
			Result.append (Color_names_file_name)
		end;

feature -- Directory names for EiffelBuild

	Bitmaps_directory: STRING is
			-- Directory containing the various
			-- bitmaps for EiffelBuild.
		local
			dir: FILE_NAME;
			win: WINDOWS
		once
			Result := clone (EiffelBuild_directory);
			Result.extend (directory_separator);
			Result.append (Bitmaps_name);
		end;

	Eiffel3_directory: STRING is
		once	
			!!Result.make (0);
			Result.append (get (Eiffel3_variable_name));
		end;

	EiffelBuild_directory: STRING is
			-- Directory referenced by the 
			-- Eiffel3_var_name
		local
			env_var: STRING;
			temp: ANY;
		once
			!! Result.make (0);
			Result.append (Eiffel3_directory);
			Result.extend (directory_separator);
			Result.append (Build_name);
		end;

	EiffelBuild_bin: STRING is
		local
			env_var: STRING;
			temp: ANY;
			plat: STRING;
		once
			Result := clone (EiffelBuild_directory);
			Result.extend (directory_separator);
			Result.append (Spec_name);
			Result.extend (directory_separator);
			plat := get (Platform_variable_name);
			if plat /= Void then
				Result.append (plat);
                        	Result.extend (directory_separator);
			end;
			Result.append (Bin_name);
		end;

	Help_directory: STRING is
			-- Directory containing the Eiffel
			-- text of predefined commands
		once
			Result := clone (EiffelBuild_directory);
			Result.extend (directory_separator);
			Result.append (Help_name);
		end;

	Predefined_commands_directory: STRING is
			-- Directory containing the Eiffel
			-- text of predefined commands
		once
			Result := clone (EiffelBuild_directory);
			Result.extend (directory_separator);
			Result.append (Library_name);
			Result.extend (directory_separator);
			Result.append (Commands_name);
		end;

	Resources_directory: STRING is
			-- Directory containing resources
		once
			Result := clone (EiffelBuild_directory);
			Result.extend (directory_separator);
			Result.append (Resources_name);
		end;

feature -- Directory names for projects

	Application_directory: STRING is
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Application_name);
		end;

	Classes_directory: STRING is
			-- Directory for generated Eiffel
			-- classes
			--| Has separator at end
		do
			Result := clone (Project_directory);
			Result.extend (directory_separator);
			Result.append (Classes_name);
			Result.extend (directory_separator);
		end;

	Context_directory: STRING is 
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Widgets_name);
		end;

	Commands_directory: STRING is
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Commands_name);
		end;

	Generated_directory: STRING is
			-- Directory for generated Eiffel
			-- classes
			--| Has no separator at end
		do
			Result := clone (Project_directory);
			Result.extend (directory_separator);
			Result.append (Classes_name);
		end;

	Groups_directory: STRING is 
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Groups_name);
		end;

	Restore_directory: STRING is
			-- Session storage directory
		do
			Result := clone (Project_directory);
			Result.extend (directory_separator);
			Result.append (Restore_name);
		end;

	State_directory: STRING is
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (State_name);
		end;

	Storage_directory: STRING is
			-- Session storage directory
		do
			Result := clone (Project_directory);
			Result.extend (directory_separator);
			Result.append (Storage_name);
		end;

	Templates_directory: STRING is
			-- Session storage directory
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Templates_name);
		end;

	Windows_directory: STRING is
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Windows_name);
		end;

	Widgets_directory: STRING is
		do
			Result := Generated_directory;
			Result.extend (directory_separator);
			Result.append (Widgets_name);
		end;

feature -- File names for Project

	Project_ace_file: STRING is
		once
			Result := clone (Generated_directory);
			Result.extend (directory_separator);
			Result.append (Ace_name);
		end;

feature -- Directory creation

	setup_project_directory is
			-- Set up project directory by creating
			-- the subdirectories and copy the Ace
			-- file to the project directory.
		require
			Project_dir_defined: Project_directory.count > 0
		local
			ace_f: PLAIN_TEXT_FILE;
			proj_ace_f: PLAIN_TEXT_FILE
		do
			mkdir (Project_directory);
			mkdir (Classes_directory);
			mkdir (Windows_directory);
			mkdir (State_directory);
			mkdir (Widgets_directory);
			mkdir (Commands_directory);
			mkdir (Application_directory);
			mkdir (Groups_directory);
			mkdir (Templates_directory);
			mkdir (Storage_directory);
			mkdir (Restore_directory)
			!! proj_ace_f.make (Project_ace_file);
			if not proj_ace_f.exists then
				!! ace_f.make (Ace_file);
				if ace_f.exists and then ace_f.is_readable then
					proj_ace_f.append (ace_f)
				else
					io.error.putstring ("EiffelBuild: cannot find file%N");
					io.error.putstring (ace_f.name);
					io.error.putstring (".%N");
				end;
			end
		end;

feature -- {NONE}

	mkdir (dn: STRING) is
			-- Create subdirectory `dn' of
			-- the project directory.
		require
			valid_dn: dn /= Void
		local
			dir: DIRECTORY;
		do
			!!dir.make (dn);
			if not dir.exists then
				dir.create;
			end
		end;

end	
