indexing

	description: 
		"Directories for EiffelCase (Source, Bitmaps, Postscript, ...)";
	date: "$Date$";
	revision: "$Revision $"

class EC_ENVIRONMENT

inherit

	EXECUTION_ENVIRONMENT

feature -- Constants

	Bin_name: STRING is "bin"
	Bitmaps_name: STRING is "bmp"
	Case_name: STRING is "case"
	Casegen_name: STRING is "CASEGEN"
	Directory_separator: CHARACTER is
		once
			Result := Operating_environment.directory_separator
		end
	Documentation_name: STRING is "Doc"
	error_name : STRING is "Error"
	Eiffel_variable_name: STRING is "EIFFEL4"
	Errors_name: STRING is "errors"
	Filters_name: STRING is "filters"
	Help_name : STRING is "help"
	Html_name : STRING is "html"
	Messages_name: STRING is "messages"
	Inline_name: STRING is "in_line"
	Postscript_name: STRING is "postscript"
	Resource_name: STRING is "resources"
	Size_window_name : STRING is "system"
	Spec_name: STRING is "spec"
	Storage_name: STRING is "Storage"
	System_name: STRING is "system";
	Temp_name: STRING is "tmp"
	View_name: STRING is "view"
	View_directory_name: STRING is "View"
	Warnings_name: STRING is "warnings"
	Configure_name:STRING is "Configurable"
	Unconfigure_name:STRING is "Non_configurable"
	
	resources_name:STRING is "d:\Eiffel44\case\configurable\new_resources\general.xml"

feature -- Settings

	set_html_dir (d: STRING) is
		-- Set the directory where the html sources will be generated.
		require
			not_void: d /= Void
		do
			Html_directory.wipe_out
			Html_directory.extend(d)
		end

feature -- variables

	preference_file_name	: STRING

feature -- Access

	Project_directory: STRING is
			-- Set by the main panel.
		once
			!! Result.make (0)
		end

	platform : STRING is "Windows"

feature -- Directory names

	Bin_directory: DIRECTORY_NAME is
			-- Bin directory in $EIFFELn/case
		local
			platformm: STRING
		once
			!! Result.make_from_string (EiffelCase_directory)
			Result.extend (Spec_name)
			if platform /= Void then
				Result.extend (platformm)
			end
			Result.extend (Bin_name)
		end

	Bitmap_directory: DIRECTORY_NAME is
			-- Bitmaps directory in $EIFFELn/case
		once
			!! Result.make_from_string (EiffelCase_directory)
			Result.extend(Unconfigure_name)
			Result.extend (Bitmaps_name)
		end

	Casegen_directory: DIRECTORY_NAME is
			-- Directory where internal structures are saved
		do
			!! Result.make_from_string (Project_directory)
			Result.extend(Casegen_name)	
		end

	Documentation_directory: DIRECTORY_NAME is
			-- Directory where docuementation is saved
		do
			!! Result.make_from_string (Casegen_directory)
			Result.extend (Documentation_name)
		end

	error_directory: DIRECTORY_NAME is
			-- Directory where docuementation is saved
		local
			s : STRING	
		do
			s := Casegen_directory	
			if s/= Void and then s.count>0  then	
				!! Result.make_from_string (Casegen_directory);
				Result.extend (error_name)
			else
				-- no CASEGEN directory already generæted 
				-- we generate it in current ...
				!! result.make
				Result.extend (Configure_name)
				Result.extend (error_name)
			end	
		end


	Html_resources : DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory)
			Result.extend(Configure_name)
			Result.extend (html_name)
		end

	Html_directory : DIRECTORY_NAME is
			-- Directory where the html doc is saved
		once
			!! Result.make_from_string(Documentation_directory)
			Result.extend (html_name)
		end

	Eiffel_directory: DIRECTORY_NAME is
			-- Directory referenced by the
			-- `Eiffel_variable_name'
		once
			!! Result.make_from_string (get (Eiffel_variable_name))
		end

	EiffelCase_directory: DIRECTORY_NAME is
			-- Directory referenced by the $EIFFELn
		local
			tmp: STRING
		once
			tmp := clone (Eiffel_directory)
			if tmp /= Void then
				!! Result.make_from_string (tmp)
				Result.extend (Case_name)
			else
				!! Result.make
			end
		end;

	Filters_directory: DIRECTORY_NAME is
			-- Directory where filters are found
		once
			!! Result.make_from_string (EiffelCase_directory)
			Result.extend (Configure_name)
			Result.extend (Filters_name)
		end

	Generated_directory: DIRECTORY_NAME is
			-- Directory where generate eiffel code is saved
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend ("E_code");
		end;

	Postscript_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory)
			Result.extend (Configure_name)
			Result.extend (Postscript_name)
		end

	Restore_directory: DIRECTORY_NAME is
		do
		--	!! Result.make_from_string (Casegen_directory)
		--	Result.extend (Restore_name)
		end

	Restore_relative_directory: DIRECTORY_NAME is
		do
		--	!! Result.make_from_string (casegen_name);
		--	Result.extend (Restore_name);
		end;

	Resource_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend (Configure_name)
			Result.extend (Resource_name)
		end;

	Storage_directory: DIRECTORY_NAME is
			-- Directory where project is saved.
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend (Storage_name);
		end;

	Storage_relative_directory: DIRECTORY_NAME is
			-- Storage directory relative to any project
			-- (Has separator at start)
		once
			!! Result.make_from_string (casegen_name);
			Result.extend (Storage_name);
		end;

	View_directory: DIRECTORY_NAME is
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend (View_directory_name);
		end;

	View_relative_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (casegen_name)
			Result.extend (View_directory_name)
		end;

feature -- File names

	Errors_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory)
			Result.set_file_name (Errors_name)
		end

	Messages_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory)
			Result.set_file_name (Messages_name)
		end

	Inline_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory)
			Result.set_file_name (Inline_name)
		end
	
	System_id_file_name: FILE_NAME is
			-- System file name
		do
		--	!! Result.make_from_string (Storage_directory)
		--	Result.set_file_name (System_id_name)
		end

	System_file_name: FILE_NAME is
			-- System file name
		do
			!! Result.make_from_string (Storage_directory)
			Result.set_file_name (System_name)
		end

	Temporary_file_name: FILE_NAME is
			-- System file name
		do
			!! Result.make_from_string (Documentation_directory)
			Result.set_file_name (Temp_name)
		end

	View_relative_file_name: FILE_NAME is
		once
			!! Result.make_from_string (View_relative_directory);
			Result.set_file_name (View_name);
		end;

	View_file_name: FILE_NAME is
		do
			!! Result.make_from_string (View_directory);
			Result.set_file_name (View_name);
		end;

	Warnings_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory);
			Result.set_file_name (Warnings_name);
		end;

feature -- Element change for directory structures

	set_project_directory (p_name: STRING) is
			-- Set project dir to `p_name'.
		local
			recent_fi : RECENT_FILES_LIST
		do
			Project_directory.wipe_out
			Project_directory.append (p_name)
			--!! recent_fi.add_project
		end;

	create_initial_directories is
			-- Create initial directories.
		require
			valid_project: Project_directory.count > 0	
		do
			mkdir (Project_directory)
			mkdir (Casegen_directory)
			mkdir (View_directory)
			mkdir (Generated_directory)
			mkdir (Storage_directory)
			mkdir (Documentation_directory)
			mkdir (Restore_directory)
		end;

	mkdir (dn: STRING) is
			-- Create subdirectory `dn' of
			-- the project directory.
		local
			dir: DIRECTORY;
		do
			!!dir.make (dn);
			if not dir.exists then
				dir.create_dir
			end
		end

	set_preference_file_name ( s : STRING ) is
			-- Set preferences file name
		do
			preference_file_name	:= s
		end

feature -- Call to external features

	print_to_printer (command: STRING; file: PLAIN_TEXT_FILE) is
			-- Print file `file' to the printer
			-- with printer command `command'.
		require
			valid_command: command /= Void;
			valid_file: file /= Void and then file.exists
		local
			get_info : GET_INFO
			string_command: STRING
			tmp : STRING
		do
			!! get_info
			!! string_command.make (0);
			!! tmp.make (256)
			tmp.append(get_info.printer)
			tmp.replace_substring_all ("name_file",file.name )
			string_command.append(tmp)
	--		string_command.append ("copy ");
	--		string_command.append (file.name);
	--		string_command.append (" \\OSLO\HPDeskJe");
			system (string_command);
		end;

--	print_text (text: EV_TEXT; title: STRING; win : TOP_SHELL) is
--			-- Print a text
--		require
--			
--		local
--			rich_edit: WEL_RICH_EDIT
--			dc: WEL_PRINTER_DC
--			print_dialog: WEL_PRINT_DIALOG
--			comp: WEL_COMPOSITE_WINDOW
--		do
--			!! print_dialog.make
--			comp ?= win.implementation
--			if comp /= Void then
--				print_dialog.activate (comp)
--			end
--			dc := print_dialog.dc
--			rich_edit ?= text.implementation
--			if (dc /= Void) and then (dc.exists) then
--				if rich_edit /= Void then
--					rich_edit.print_all(dc, title)
--				end
--			end
--		end
--
--	return_composite ( win: TOP_SHELL ):TOP_SHELL_I is
--		-- Needed for accessibility.
--		-- used by printer module.
--		do
--			Result := win.implementation
--		end

-- 	return_text ( win: EV_TEXT ):EV_TEXT_I is
-- 		-- Needed for accessibility.
-- 		-- used by printer module.
-- 		do
-- 			Result := win.implementation
-- 		end

--	print_texts (text_list: LINKED_LIST [EV_TEXT]; win: TOP_SHELL ) is
--		local
--			rich_edit: WEL_RICH_EDIT
--			dc: WEL_PRINTER_DC
--			print_dialog: WEL_PRINT_DIALOG
--			comp: WEL_COMPOSITE_WINDOW
--		do
--			!! print_dialog.make
--			comp ?= win.implementation
--			if comp /= Void then
--				print_dialog.activate (comp)
--			end
--			dc := print_dialog.dc
--			if (dc /= Void) and then (dc.exists) then
--				from
--					text_list.start
--				until
--					text_list.after
--				loop
--					rich_edit ?= text_list.item.implementation
--					if rich_edit /= Void then
--						rich_edit.print_all(dc, "Textural generation")
--					end
--					text_list.forth	
--				end
--			end
--		end

	printer_module: PRINTER_MODULE is
		once
			!! Result
		end

	execute_mkdir (path: STRING) is
			-- Create (all the components of) directory `path',
			-- if possible
		require
			path_exists: path /= Void
		local
			pos, i: INTEGER
		do
			from
				i := 1
			until
				i > path.count
			loop
				pos := path.index_of (Directory_separator, i);
				if pos = i then
					i := i + 1
				elseif pos > i then
					mkdir (path.substring (1, pos - 1));
					i := pos + 1;
				elseif pos = 0 then
					if i <= path.count then
						mkdir (path.substring (1, path.count));
					end;
					i := path.count + 1
				end
			end
		end

feature -- Removal

	remove_directory (p: STRING) is
			-- Remove directory and its sub-directories and their
			-- contents with directory path `p'.
		require
			valid_p: p /= Void
		local
			dir: DIRECTORY;
			dir_name: STRING;
			full_file_name: DIRECTORY_NAME;
			file_name: STRING;
			file: RAW_FILE
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
					!! full_file_name.make_from_string (p)
					full_file_name.extend (file_name)
					!! file.make (full_file_name)
					if file.is_directory then
						remove_directory (full_file_name)
					end;
					file.delete
				end;
				dir.readentry
				file_name := dir.lastentry
			end;
			dir.close
		rescue
			if dir /= Void and then not dir.is_closed then
				dir.close
			end
		end

end -- class EC_ENVIRONMENT
