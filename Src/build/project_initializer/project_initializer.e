indexing
	description: "Project initializer."
	id: "$Id$"
	date: "$Date$"
	Revision: "$Revision$"

class
	PROJECT_INITIALIZER

inherit
	ARGUMENTS
		rename
			command_name as arg_command_name,
			command_line as arg_command_line
		end
	
	CONSTANTS

creation
	make

feature

	make is
			-- Creation.
		local
			i: INTEGER
			found: BOOLEAN
			proj_dir: STRING
		do
			if argument_array.count > 1 then
				from
					i := 1
					found := False
				until
					found or i > argument_array.count
				loop
					if argument (i).is_equal ("-project") then
						found := True
						proj_dir := Environment.project_directory
						proj_dir.wipe_out
						proj_dir.append (argument (i + 1))
						proj_dir.prune_all (' ')
					end
					i := i + 1
				end
				if found then
					init_project
				else
					display_help
				end
			else
				display_help
			end
		end

feature -- Attributes

	error: BOOLEAN
			-- Did an error occur?

	source_list, target_list: LINKED_LIST [STRING]
			-- List of source and target files

feature {NONE} -- Implementation

	init_project is
			-- Init the EiffelBuild project.
		do
			!! target_list.make
			!! source_list.make
			check_eiffelbuild_var_name
			Environment.setup_project_directory
			analyse_config_file
		end

	check_eiffelbuild_var_name is
			-- Set error to True if EiffelBuild_var_name
			-- has not been set or the directory does
			-- not exist.
			-- (export status {NONE})
		local
			dir: PLAIN_TEXT_FILE;
			path_name: STRING
		do
			path_name := environment.get (environment.eiffel_variable_name);
			if path_name = Void or else path_name.empty then
				io.error.putstring ("Environment variable ");
				io.error.putstring (environment.eiffel_variable_name);
				io.error.putstring (" not defined%N");
				error := True
			else
				!! dir.make (path_name);
				if not dir.exists or else not dir.is_readable then
					io.error.putstring ("Directory ");
					io.error.putstring (path_name);
					io.error.putstring (" is not readable.%N");
					io.error.putstring ("Environment variable ");
					io.error.putstring (environment.eiffel_variable_name);
					io.error.putstring (" needs to be set to the correct directory%N");
					error := True
				else
					!! dir.make (environment.eiffelbuild_directory);
					if not dir.exists or else not dir.is_readable then
						io.error.putstring ("Directory ");
						io.error.putstring (dir.name);
						io.error.putstring (" is not readable.%N");
						error := True
					else
						path_name := environment.get (environment.platform_variable_name);
						if path_name = Void or else path_name.empty then
							io.error.putstring ("Environment variable ");
							io.error.putstring (environment.platform_variable_name);
							io.error.putstring (" not defined%N");
							error := True
						else
							error := False
						end
					end
				end
			end
		end;

	analyse_config_file is
			-- Check the file config file.
		local
			config: PLAIN_TEXT_FILE
			file_name: FILE_NAME
			temp_file_name: STRING
		do
			!! file_name.make
			file_name.extend (Environment.Template_files_directory)
			file_name.extend (Environment.Config_init_file_name)
			!! config.make_open_read (file_name)
			from
			until
				config.end_of_file
			loop
				config.read_line
				temp_file_name := clone (config.last_string)
				temp_file_name.prune_all (' ')
				if temp_file_name.has ('>') then
					temp_file_name.prune ('>')
					target_list.extend (temp_file_name)
				elseif not temp_file_name.empty then
					source_list.extend (temp_file_name)
				end
			end
			if source_list.count /= target_list.count then	
				io.error.put_string ("Config.init corrupted")
			else
				proceed_copy
			end
-- 			copy_cmd_instantiator
-- 			copy_app
-- 			copy_shared_control
-- 			copy_states
		end

	proceed_copy is
			-- Copy the files as specified in the config file.
		local
			template_file, project_file: RAW_FILE
			file_name: FILE_NAME
		do
			!! file_name.make
			from
				source_list.start
				target_list.start
			until
				source_list.after
			loop
				file_name.wipe_out
				file_name.extend (Environment.Template_files_directory)
				file_name.extend (source_list.item)
				!! template_file.make_open_read (file_name)
				file_name.wipe_out
				file_name.extend (Environment.Project_directory)
				file_name.extend (target_list.item)
				!! project_file.make_open_write (file_name)
				file_copy (template_file, project_file)
				source_list.forth
				target_list.forth
			end
		end

	file_copy (source_file, target_file: RAW_FILE) is
			-- Copy `source_file' to `target_file'.
		require
			source_is_open_read: source_file.is_open_read
			target_is_open_write: target_file.is_open_write
		local
			buffer: STRING
		do
-- 			source_file.read_stream (source_file.count)
-- 			buffer := source_file.last_string
-- 			target_file.put_string (buffer)
			!! buffer.make (0)
			from
			until
				source_file.end_of_file
			loop
				source_file.read_line
				buffer.append (source_file.last_string)
				buffer.append ("%N")
			end
			source_file.close
			target_file.put_string (buffer)
			target_file.close
		end

	display_help is
			-- Display help message if the syntax is not correct.
		do
			io.put_string ("#####################################%N#  init_build syntax:%N#%Tinit_build -project <project_path>%N#####################################%N")
		end

end -- PROJECT_INITIALIZER
