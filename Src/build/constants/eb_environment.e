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
	Restore_name: STRING is "restore";
	Spec_name: STRING is "spec";
	State_name: STRING is "State";
	Storage_name: STRING is "Storage";
	Templates_name: STRING is "templates";
	temporary_postfix: STRING is "TMP";
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

	Ace_file: FILE_NAME is
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend (Ace_name);
			Result.set_file_name (Ace_name);
		end;

	Color_names_file: FILE_NAME is
		once
			!! Result.make_from_string (Resources_directory);
			Result.set_file_name (Color_names_file_name)
		end;

	Merge1_file: FILE_NAME is
		once
			!! Result.make_from_string (EiffelBuild_bin);
			Result.set_file_name (Merge1_file_name)
		end;

	Merge2_file: FILE_NAME is
		once
			!! Result.make_from_string (EiffelBuild_bin);
			Result.set_file_name (Merge2_file_name)
		end;

feature -- Directory names for EiffelBuild

	Bitmaps_directory: DIRECTORY_NAME is
			-- Directory containing the various
			-- bitmaps for EiffelBuild.
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend (Bitmaps_name);
		end;

	Eiffel3_directory: DIRECTORY_NAME is
		once	
			!! Result.make_from_string (get (Eiffel3_variable_name));
		end;

	EiffelBuild_directory: DIRECTORY_NAME is
			-- Directory referenced by the 
			-- Eiffel3_var_name
		once
			!! Result.make_from_string (Eiffel3_directory);
			Result.extend (Build_name);
		end;

	EiffelBuild_bin: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend_from_array (<< Spec_name,
							get (Platform_variable_name),
							Bin_name >>);
		end;

	Help_directory: DIRECTORY_NAME is
			-- Directory containing the Eiffel
			-- text of predefined commands
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend (Help_name);
		end;

	Predefined_commands_directory: DIRECTORY_NAME is
			-- Directory containing the Eiffel
			-- text of predefined commands
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend_from_array (<< Library_name, Commands_name >>);
		end;

	Resources_directory: DIRECTORY_NAME is
			-- Directory containing resources
		once
			!! Result.make_from_string (EiffelBuild_directory);
			Result.extend (Resources_name);
		end;

feature -- Directory names for projects

	Application_directory: DIRECTORY_NAME is
		do
			Result := Classes_directory;
			Result.extend (Application_name);
		end;

	Classes_directory: DIRECTORY_NAME is
			-- Directory for generated Eiffel
			-- classes
		do
			!! Result.make_from_string (Project_directory);
			Result.extend (Classes_name);
		end;

	Context_directory: DIRECTORY_NAME is 
		do
			Result := Classes_directory;
			Result.extend (Widgets_name);
		end;

	Commands_directory: DIRECTORY_NAME is
		do
			Result := Classes_directory;
			Result.extend (Commands_name);
		end;

	Groups_directory: DIRECTORY_NAME is 
		do
			Result := Classes_directory;
			Result.extend (Groups_name);
		end;

	Restore_directory: DIRECTORY_NAME is
			-- Session storage directory
		do
			!! Result.make_from_string (Project_directory);
			Result.extend (Restore_name);
		end;

	State_directory: DIRECTORY_NAME is
		do
			Result := Classes_directory;
			Result.extend (State_name);
		end;

	Storage_directory: DIRECTORY_NAME is
			-- Session storage directory
		do
			!! Result.make_from_string (Project_directory);
			Result.extend (Storage_name);
		end;

	Templates_directory: DIRECTORY_NAME is
			-- Session storage directory
		do
			Result := Classes_directory;
			Result.extend (Templates_name);
		end;

	Windows_directory: DIRECTORY_NAME is
		do
			Result := Classes_directory;
			Result.extend (Windows_name);
		end;

	Widgets_directory: DIRECTORY_NAME is
		do
			Result := Classes_directory;
			Result.extend (Widgets_name);
		end;

feature -- File names for Project

	Project_ace_file: FILE_NAME is
		once
			!! Result.make_from_string (Project_directory);
			Result.set_file_name (Ace_name);
		end;

feature -- Directory creation

	remove_project_directory is
			-- Set up project directory by creating
			-- the subdirectories and copy the Ace
			-- file to the project directory.
		require
			Project_dir_defined: Project_directory.count > 0
		local
			ace_f: PLAIN_TEXT_FILE;
		do
			if is_directory (Classes_directory) then
				remove_directory (Classes_directory);
			end;
			if is_directory (Storage_directory) then
				remove_directory (Storage_directory);
			end;
			if is_directory (Restore_directory) then
				remove_directory (Restore_directory)
			end;
			!! ace_f.make (Project_ace_file);
			if ace_f.exists then
				ace_f.delete
			end;
		end;

	setup_project_directory is
			-- Set up project directory by creating
			-- the subdirectories and copy the Ace
			-- file to the project directory.
		require
			Project_dir_defined: Project_directory.count > 0
		local
			ace_f: RAW_FILE;
			proj_ace_f: RAW_FILE;
			file_name: FILE_NAME;
			dir_name: DIRECTORY_NAME;
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

feature {NONE} -- Directory remove (recursive)

	remove_directory (p: STRING) is
			-- Remove directory and its sub-directories and their
			-- contents with directory path `p'.
		require
			valid_p: p /= Void;
			file_is_directory: is_directory (p);
		local
			dir: DIRECTORY;
			dir_name: STRING;
			file_name: STRING;
			full_file_name: DIRECTORY_NAME;
			file: PLAIN_TEXT_FILE
		do
			dir_name := clone (p);
			!! dir.make_open_read (dir_name);
			from
				dir.start;
				dir.readentry;
				file_name := dir.lastentry;
			until
				file_name = Void
			loop
				if not (file_name.is_equal (".") or else
					file_name.is_equal (".."))
				then
					!! full_file_name.make_from_string (p);
					full_file_name.extend (file_name);
					!! file.make (full_file_name);
					if file.is_directory then
						remove_directory (full_file_name)
					end;
					file.delete;
				end;
				dir.readentry;
				file_name := dir.lastentry
			end;
			dir.close;
		rescue
			if dir /= Void and then not dir.is_closed then
				dir.close
			end;
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

	is_directory (p: STRING): BOOLEAN is
			-- Is `p' a directory ?
		local
			file: PLAIN_TEXT_FILE
		do
			!! file.make (p);
			Result := file.exists and then file.is_directory
		end;

end	
