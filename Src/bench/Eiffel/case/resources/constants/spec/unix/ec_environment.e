indexing

	description: 
		"Directories for EiffelCase (Source, Bitmaps, Postscript, ...)";
	date: "$Date$";
	revision: "$Revision $"

class EC_ENVIRONMENT

inherit

	S_CASE_INFO
		export
			{ANY} all
		end;
	EXECUTION_ENVIRONMENT;
	G_ANY
		export
			{NONE} all
		end

feature -- Constants

	Bin_name: STRING is "bin";
	Bitmaps_name: STRING is "xpm";
	Case_license_name: STRING is "eiffelcase";
			-- application name used by the licence to
			-- dialog with the licence manager daemon
	Case_name: STRING is "case";
	Case_mod_name: STRING is "CASEMOD";
	Casegen_name: STRING is "CASEGEN";
	Class_interface_name: STRING is "class_int";
	Class_chart_name: STRING is "class_ch";
	Class_chart_ext: STRING is "ch";
	Class_code_ext: STRING is "e";
	Class_spec_ext: STRING is "spc";
	Class_dictionary_name: STRING is "clas_dic";
	Cluster_chart_name: STRING is "clust_ch";
	Color_names_name: STRING is "color_names";
	Directory_separator: CHARACTER is
		once
			Result := Operating_environment.directory_separator
		end;
	Documentation_name: STRING is "Doc";
	error_name : STRING is "Error"
	Eiffel_variable_name: STRING is "EIFFEL4";
	home_variable_name: STRING is "HOME";
	Emerge_name: STRING is "emerge";
	Errors_name: STRING is "errors";
	Filters_name: STRING is "filters";
	Help_name : STRING is "help";
	Html_name : STRING is "html";
	Messages_name: STRING is "messages";
	Inline_name: STRING is "in_line";
	Indexing_name: STRING is "indexing";
	Postscript_name: STRING is "postscript";
	Resource_name: STRING is "resources";
	Restore_name: STRING is "restore";
	Spec_name: STRING is "spec";
	System_chart_name: STRING is "sys_ch";
	Storage_name: STRING is "Storage";
	Temp_name: STRING is "tmp";
	View_name: STRING is "view";
	View_directory_name: STRING is "View";
	Warnings_name: STRING is "warnings";
	Configure_name:STRING is "Configurable"
	Unconfigure_name:STRING is "Non_configurable"
	project_file_name	: STRING	is "system_architecture"


feature
	--preference

	preference_file_name	: STRING

feature
	--settings

	set_preference_file_name ( s : STRING ) is
	do
		preference_file_name	:= s
	end

feature -- Properties

	is_motif: BOOLEAN is
			-- Is the Current toolkit MOTIF?
		once
			Result := toolkit.name.is_equal ("MOTIF")
		end

feature -- Access

	Project_directory: STRING is
			-- Set by the main panel.
		once
			!! Result.make (0);
		end;

	platform : STRING is "Windows"

feature -- Directory names

	Bin_directory: DIRECTORY_NAME is
			-- Bin directory in $EIFFELn/case
		local
			platformm: STRING
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend (Spec_name);
			if platform /= Void then
				Result.extend (platformm);
			end;
			Result.extend (Bin_name);
		end;

	Bitmap_directory: DIRECTORY_NAME is
			-- Bitmaps directory in $EIFFELn/case
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend(Unconfigure_name)
			Result.extend (Bitmaps_name);
		end;

	Casegen_directory: DIRECTORY_NAME is
			-- Directory where internal structures are saved
		do
			!! Result.make_from_string (Project_directory);
			Result.extend(Casegen_name)	
		end;

	Documentation_directory: DIRECTORY_NAME is
			-- Directory where docuementation is saved
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend (Documentation_name);
		end;

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
				Result.extend (error_name)
			end	
		end;

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

	set_html_dir (d: STRING) is
		do
			Html_directory.wipe_out
			Html_directory.extend(d)
		end

	Eiffel_directory: DIRECTORY_NAME is
			-- Directory referenced by the
			-- `Eiffel_variable_name'
		once
			!! Result.make_from_string (get (Eiffel_variable_name));
		end;

	home_directory: DIRECTORY_NAME is
			-- Directory referenced by the
			-- `Eiffel_variable_name'
		once
			!! Result.make_from_string (get	( home_variable_name	) )
		end;

	EiffelCase_directory: DIRECTORY_NAME is
			-- Directory referenced by the $EIFFELn
		local
			tmp: STRING;
		once
			tmp := clone (Eiffel_directory);
			if tmp /= Void then
				!! Result.make_from_string (tmp);
				Result.extend (Case_name);
			else
				!! Result.make;
			end
		end;

	Filters_directory: DIRECTORY_NAME is
			-- Directory where filters are found
		once
			!! Result.make_from_string (EiffelCase_directory);
		        Result.extend(Configure_name)
			Result.extend (Filters_name);
		end;

	Help_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend (Help_name);
		end;


	Generated_directory: DIRECTORY_NAME is
			-- Directory where generate eiffel code is saved
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend ("E_code");
		end;

	Postscript_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend (Configure_name)
			Result.extend (Postscript_name);
		end;

	Restore_directory: DIRECTORY_NAME is
		do
			!! Result.make_from_string (Casegen_directory);
			Result.extend (Restore_name);
		end;

	Restore_relative_directory: DIRECTORY_NAME is
		do
			!! Result.make_from_string (casegen_name);
			Result.extend (Restore_name);
		end;

	Resource_directory: DIRECTORY_NAME is
		once
			!! Result.make_from_string (EiffelCase_directory);
			Result.extend (Configure_name)
			Result.extend (Resource_name);
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
			!! Result.make_from_string (casegen_name);
			Result.extend (View_directory_name);
		end;

feature -- File names

	Color_names_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory);
			Result.set_file_name (Color_names_name);
		end;

	Emerge_file: FILE_NAME is
		once
			!! Result.make_from_string (Bin_directory);
			Result.set_file_name (Emerge_name);
		end;

	Errors_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory);
			Result.set_file_name (Errors_name);
		end;

	Messages_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory);
			Result.set_file_name (Messages_name);
		end;

	Inline_file: FILE_NAME is
		do
			!! Result.make_from_string (Resource_directory);
			Result.set_file_name (Inline_name);
		end;

	Indexing_file: FILE_NAME is
		do
			!! Result.make_from_string(Resource_directory)
			Result.set_file_name (Indexing_name)
		end
	
	System_id_file_name: FILE_NAME is
			-- System file name
		do
			!! Result.make_from_string (Storage_directory);
			Result.set_file_name (System_id_name);
		end;

	System_file_name: FILE_NAME is
			-- System file name
		do
			!! Result.make_from_string (Storage_directory);
			Result.set_file_name (System_name);
		end;

	System_id_relative_file_name: FILE_NAME is
			-- System id file name relative to the any project directory
			-- (Has separator at start)
		once
			!! Result.make_from_string (Storage_relative_directory);
			Result.set_file_name (System_id_name);
		end;

	Temporary_file_name: FILE_NAME is
			-- System file name
		do
			!! Result.make_from_string (Documentation_directory);
			Result.set_file_name (Temp_name);
		end;

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
		do
			Project_directory.wipe_out;
			Project_directory.append (p_name);
		end;

	create_initial_directories is
			-- Create initial directories.
		require
			valid_project: Project_directory.count > 0	
		do
			mkdir (Project_directory);
			mkdir (Casegen_directory);
			mkdir (View_directory);
			mkdir (Generated_directory);
			mkdir (Storage_directory);
			mkdir (Documentation_directory);
			mkdir (Restore_directory);
		end;

	mkdir (dn: STRING) is
			-- Create subdirectory `dn' of
			-- the project directory.
		local
			dir: DIRECTORY;
		do
			!!dir.make (dn);
			if not dir.exists then
				dir.create_dir ;
			end
		end;

feature -- Call to external features

	print_to_printer (command: STRING; file: PLAIN_TEXT_FILE) is
			-- Print file `file' to the printer
			-- with printer command `command'.
		require
			valid_command: command /= Void;
			valid_file: file /= Void and then file.exists
		local
			--get_info : GET_INFO
			string_command: STRING
			tmp : STRING
		do
			--!! get_info
			!! string_command.make (0);
			!! tmp.make (256)
			--tmp.append(get_info.printer)
			--tmp.replace_substring_all ("name_file",file.name )
			tmp.append	( command	)
			tmp.append	( " "	)
			tmp.append	( file.name	)
			string_command.append(tmp)
			system (string_command);
		end;

    printer_module: PRINTER_MODULE is
        once
            !! Result 
        end


	execute_emerge (re_proj_dir: STRING) is
			-- Call executable `emerge' if it exists
			-- for reversed engineered project `re_proj_dir'.
		require
			valid_re_proj_dir: re_proj_dir /= Void
		local
			file: PLAIN_TEXT_FILE;
			cmd: STRING
		do
			!! file.make (Emerge_file);
			if file.exists then
				!! cmd.make (0);
				cmd.append ("sh ");
				cmd.append (Emerge_file);
				cmd.append (" -case ");
				cmd.append (re_proj_dir);
				System (cmd)
			end
		end;

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
			valid_p: p /= Void;
			file_is_directory: is_directory (p);
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

feature -- Access

	is_directory (p: STRING): BOOLEAN is
			-- Is `p' a directory ? 
		local
			file: RAW_FILE
		do
			!! file.make (p);
			Result := file.is_directory
		end;

feature -- Output

	interpret (s: STRING): STRING is
			-- Interpretation of string `s' where the environment varaibles
			-- are interpreted
		require
			good_argument: s /= Void;
		local
			current_character, last_character: CHARACTER;
			s1,s2: STRING;
			i, j: INTEGER;
			stop : BOOLEAN;
			ptr: ANY;
		do
			from
				Result := s;
				i := 1;
			until
				i > Result.count
			loop
				current_character := Result.item (i);
				if 	current_character = '$'
					and then
					last_character /= '%%'
				then
						-- Found beginning of a environment variable
						-- It is either ${VAR} or $VAR
					if i > 1 then
						s1 := Result.substring (1, i - 1);
					else
						!!s1.make (0);
					end;
					i := i + 1;
					current_character := Result.item (i);
					if current_character = '{' then
							-- Looking for a right brace
						from
							i := i + 1;
							j := i;
						until
							j > Result.count or else Result.item (j) = '}'
						loop
							j := j + 1;
						end;
					else
							-- Looking for a non-alphanumeric character
						from
							j := i;
							stop := False
						until
							j > Result.count or else stop
						loop
							current_character := Result.item (j);
							stop := 	(not (current_character.is_alpha or else
												current_character.is_digit))
										and
										(current_character /= '_');
							if not stop then
								j := j + 1;
							end;
						end;
							-- We've been one char too far
						j := j - 1;
					end;
					if j > Result.count then
						j := Result.count;
					end;
					if Result.item (j) = '}' then
						if j - 1 >= i then
							s2 := get (Result.substring (i, j - 1));
						else
							!!s2.make (0);
						end;
					else
						if j >= i then
							s2 := get (Result.substring (i, j));
						else
							!!s2.make (0);
						end;
					end;
					if s2 = Void then
						!!s2.make (0);
					end;
					s1.append (s2);
					i := s1.count + 1;
					if j < Result.count then
						s1.append
							(Result.substring (j + 1, Result.count));
					end;
					Result := s1;
				end;
				i := i + 1;
			end;
		ensure
			good_result: Result /= Void;
		end;

end -- class EC_ENVIRONMENT
