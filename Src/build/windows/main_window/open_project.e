
class OPEN_PROJECT 

inherit

	COMMAND
		export
			{NONE} all
		end;

	UNIX_ENV
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end;

	STORAGE_INFO
		export
			{NONE} all
		end;

	ERROR_POPUPER
		export
			{NONE} all
		undefine
			continue_after_popdown
		end;

	QUEST_POPUPER
		export
			{NONE} all
		undefine
			continue_after_popdown
		end;

feature 
	rescued: BOOLEAN;
	ace_file: STRING is "$EIFFEL3/build/Ace/Ace"

	execute (argument: STRING) is
		local
			dir: FILE_NAME;
			bpdir: FILE_NAME;
			msg: STRING;
			restore_interface_name: FILE_NAME;
			storage_interface_name: FILE_NAME;
			char: CHARACTER;	
			storer: STORER;
		do
			Project_directory.wipe_out;
			Project_directory.append (argument);	
			Project_directory.prune_all (' ');
			char := Project_directory.item (Project_directory.count);
			if char = '/' then
				Project_directory.remove (Project_directory.count)
			end;	
			!!dir.make (0);
			dir.from_string (Project_directory);
			if dir.exists then
				!!restore_interface_name.make (0);
				restore_interface_name.from_string (Restore_directory);
				restore_interface_name.append ("/interface");
				!!bpdir.make(0);
				bpdir.from_string (Storage_directory);
				if bpdir.exists then
					!!storage_interface_name.make (0);
					storage_interface_name.from_string (Storage_directory);
					storage_interface_name.append ("/interface");
					if 
						restore_interface_name.exists and then
						restore_interface_name.date >= storage_interface_name.date 
					then
						!!msg.make (0);
						msg.append ("Project saved from system crash. %N");
						msg.append ("Do you wish to retrieve backup files?");
						question_box.popup (Current, msg);
					else
						retrieve_project (Storage_directory);
					end;
				else
					!!msg.make (0);
					msg.append ("Project directory :%N' ");
					msg.append (bpdir.path_name);
					msg.append (" '%N is not an Eiffel build project. %N");
					handle_error (msg);
				end;
			else
				create_initial_directories
			end
		end;

	continue_after_popdown (BOX: MESSAGE_D; yes: BOOLEAN) is
		do
			if box = question_box then
				if yes then
					retrieve_project (Restore_directory)
				else
					retrieve_project (Storage_directory)
				end;
			end
		end;	

feature {NONE}

	install_ace_file is
		local 
			cmd: STRING
		do
			!!cmd.make(64)
			cmd.copy("cp ")
			cmd.append(ace_file)
			cmd.append(" ")
			cmd.append(Project_directory)
			system(cmd)
		end

	create_initial_directories is
			-- Create directories for a project.
		local
			mp: MOUSE_PTR;
			storer: STORER;
			msg: STRING;
			init_storage: BOOLEAN
		do
			if not rescued then
				!!mp;
				main_panel.set_title ("Creating new project...");
				mp.set_watch_shape;
				create_eb_directories;
				install_ace_file;
				init_session;
				app_editor.create_initial_state;
				!!storer.make;
				init_storage := True;
				storer.store (Storage_directory);
				storer := Void;
				display_init_windows;
				mp.restore;
				init_main_panel;
			else
				rescued := False;
				main_panel.set_title ("EiffelBuild");
				!!msg.make (0);
				msg.append ("Cannot write to directory%N");
				if init_storage then
					msg.append (Storage_directory)
				else
					msg.append (Project_directory);	
				end;
				handle_error (msg)
			end
		rescue
			mp.restore;
			rescued := True;
			retry
		end;

	retrieve_project (dir: STRING) is
		local
			file_name: FILE_NAME;
			msg: STRING;
			storer: STORER;
			mp: MOUSE_PTR
		do
			if not rescued then
				main_panel.set_title ("Retrieving project...");
				!!file_name.make (0);
				file_name.from_string (dir);
				for_import.set_value (False);
				!!storer.make;
				!!mp;
				mp.set_watch_shape;
				init_session;
				storer.retrieve (dir);
				if not main_panel.project_initialized 
				then
					display_init_windows;
				end;
				storer.display_retrieved_windows;
				init_main_panel;
				mp.restore;
			else
				rescued := False;
				!!msg.make (0);
				msg.append ("Cannot retrieve application from directory %N");
				msg.append (dir);	
				handle_error (msg)
			end;
		rescue
			main_panel.set_title ("EiffelBuild");
			mp.restore;
			rescued := True;
			retry
		end;

	handle_error (arg: STRING) is
		do
			error_box.popup (Current, arg);
		end;

	init_main_panel is
		do
			main_panel.set_title (Project_directory);
			main_panel.set_project_initialized;
		end;

end	
