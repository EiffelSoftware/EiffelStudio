indexing

	description:	
		"Command to retrieve a stored project.";
	date: "$Date$";
	revision: "$Revision$"

class OPEN_PROJECT 

inherit

	EB_CONSTANTS;
	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	PIXMAP_COMMAND
		rename
			init as make
		redefine
			is_sensitive
		end;
	WARNER_CALLBACKS
		rename
			execute_warner_help as exit_bench,
			execute_warner_ok as open_project
		end

creation

	make
	
feature -- Callbacks

	exit_bench is
		do
			discard_licence;
			exit
		end;

	open_project (argument: ANY) is
		do
			if not project_tool.initialized then
				last_name_chooser.set_window (popup_parent);
				last_name_chooser.call (Current)
			end
		end;

feature -- Status report

	is_sensitive: BOOLEAN is
			-- Can Current be executed?
		do
			Result := True
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Popup and let the user choose what he wants.
		local
			project_dir: PROJECT_DIRECTORY;
			last_char: CHARACTER;
			dir_name: STRING;
			expiration: INTEGER;
			msg: STRING
		do
			if not project_tool.initialized then
				if argument = project_tool then
					name_chooser (popup_parent).set_directory_selection;
					last_name_chooser.hide_file_selection_list;
					last_name_chooser.hide_file_selection_label;
					last_name_chooser.set_title (l_Select_a_directory)
					if not licence.is_unlimited then
						expiration := licence.time_left
						if expiration < 30 then
							msg := "Your license will expire in ";
							msg.append_integer (expiration);
							msg.append (" days")
						end
					end;
					if msg = Void then
						open_project (argument)
					else
						warner (popup_parent).custom_call (Current,
							msg, l_ok, Void, Void);
					end
				else
					dir_name := clone (last_name_chooser.selected_file);
					if dir_name.empty then
						warner (popup_parent).custom_call (Current,
							w_Directory_not_exist (dir_name), 
							l_ok, Void, Void);
					else
						if dir_name.count > 1 then
							last_char := dir_name.item (dir_name.count); 
							if last_char = Directory_separator then
								dir_name.remove (dir_name.count)
							end
						end;
						!!project_dir.make (dir_name);
						make_project (project_dir);
						last_name_chooser.set_file_selection;
						last_name_chooser.set_title (l_Select_a_file);
						last_name_chooser.show_file_selection_list;
						last_name_chooser.show_file_selection_label;
					end
				end
			end
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Open
		end;

feature -- Project Initialization

	make_project (project_dir: PROJECT_DIRECTORY) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		local
			workb: WORKBENCH_I;
			init_work: INIT_WORKBENCH;
			project_eif_file: RAW_FILE;
			ok: BOOLEAN;
			temp: STRING;
			fn: FILE_NAME;
			title: STRING;
			mp: MOUSE_PTR
		do
			ok := True;
			if not project_dir.exists then
				temp := w_Directory_not_exist (project_dir.name);
				ok := False;
			elseif project_dir.is_new then
					-- Create new project
				if 
					not project_dir.is_readable or else
					not project_dir.is_writable or else
					not project_dir.is_executable
				then
					temp := w_Directory_wrong_permissions (project_dir.name);
					ok := False;
				else
						-- Create a new project.
					Eiffel_project.make (project_dir);
					init_project;
					title := clone (l_New_project);
					title.append (": ");
					title.append (project_dir.name);
					project_tool.set_title (title);
				end
			else
					-- Retrieve existing project
				project_eif_file := project_dir.project_eif_file;
				if not project_eif_file.is_readable then
					temp := w_Not_readable (project_eif_file.name);
					ok := False
				elseif not project_eif_file.is_plain then
					temp := w_Not_a_file (project_eif_file.name);
					ok := False
				else
					!! mp.do_nothing;
					mp.restore
					project_tool.set_title ("Retrieving project...");
					mp.set_watch_cursor;
					retrieve_project (project_dir);
					if not Eiffel_project.error_occurred then
						init_project;
						title := clone (l_Project);
						title.append (": ");
						title.append (project_dir.name);
						if Eiffel_system.is_precompiled then
							title.append ("  (precompiled)");
						end
						project_tool.set_title (title);
						project_tool.set_icon_name (Eiffel_system.name);
					end;
				end;
			end;
	
			if ok then
				project_tool.set_initialized
			else	
				warner (popup_parent).custom_call (Current, temp, 
					" OK ", Void, Void);
			end
		end;

	retrieve_project (project_dir: PROJECT_DIRECTORY) is
			-- Retrieve a project from the disk.
		do	
			Eiffel_project.retrieve (project_dir);
			if Eiffel_project.retrieval_error then
				warner (popup_parent).custom_call (Current, 
						w_Project_corrupted (project_dir.name),
						Void, "Exit now", Void)
			elseif Eiffel_project.read_write_error then
				warner (popup_parent).custom_call (Current,
						w_Cannot_open_project, Void, "Exit", Void)
			elseif Eiffel_project.is_read_only and then
				not Eiffel_system.is_precompiled
			then
				project_tool.set_initialized;
				warner (popup_parent).custom_call (Current,
						w_Read_only_project, l_ok, "Exit", Void)
			end;
		end;

	init_project is
			-- Initialize project.
		local
			e_displayer: DEFAULT_ERROR_DISPLAYER;
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT;
		do
			!! e_displayer.make (Error_window);
			Eiffel_project.set_error_displayer (e_displayer);
			if not Project_tool_resources.graphical_output_disabled.actual_value then
				!! g_degree_output;
				Eiffel_project.set_degree_output (g_degree_output)
			end
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name fo the command.
		do
			Result := l_Open_project
		end

end -- class OPEN_PROJECT
