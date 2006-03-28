indexing

	description:
		"Representation of a command line project class. Used to initialize,%
		%retrieve and create eiffel projects."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class COMMAND_LINE_PROJECT

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_ERROR_BEHAVIOR

	PROJECT_CONTEXT

	EB_SHARED_OUTPUT_TOOLS

	SHARED_EXEC_ENVIRONMENT

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			class_name as except_class_name,
			raise as raise_exception,
			die as lic_die
		export
			{NONE} all
		end


feature -- Properties

	overwrite_old_project: BOOLEAN
			-- Overwrite an old existing project?

	project_path_name: STRING;
			-- Path where to look for the EIFGEN directory and the
			-- project file.

	Ace_name: STRING;
			-- Name of the Ace file.
			-- ("Ace.ace" or "Ace" by default)

	config_name: STRING
			-- Name of the configuration file.

	config_target: STRING
			-- Name of the configuration target (can be left empty if there is only one target).

	project_is_new: BOOLEAN;
			-- Is it a new project?

	error_occurred: BOOLEAN;
			-- Did an error occur during the initialization
			-- process?

	retried: BOOLEAN;
			-- For rescues

	project_dir: PROJECT_DIRECTORY
		-- Location of the project directory.	

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information
			-- about the current project are saved.

feature -- Update

	init_project is
			-- Initialize the project, look in the project directory for an existing project and load it.
		local
			l_file_name: FILE_NAME
			l_file: RAW_FILE
		do
			create l_file_name.make_from_string (eiffel_gen_path)
			l_file_name.extend (project_file_name)
			create l_file.make (l_file_name)

			if l_file.exists then
				open_project_file (l_file_name)
			else
				create_project
			end
		end

feature -- Project Initialization
	create_project is
			-- Create an Eiffel Project.
		require
			project_path_name_set: project_path_name /= Void
		local
			d: DIRECTORY
			answer: STRING
		do
				-- Initialize the attribute to its default value.
			project_is_new := False

			if not error_occurred then
					-- Check the existence of an already existing Eiffel project.
				create d.make (eiffel_gen_path)
				if d.exists then
						-- A Project exist
					if stop_on_error then
						error_occurred := stop_on_error
						io.error.put_string ("In `")
						io.error.put_string (eiffel_gen_path)
						io.error.put_string ("' an Eiffel project already exists%N")
						io.error.put_string ("Compilation aborted due to `-batch' or `-stop' option.%N")
					elseif not overwrite_old_project then
						io.error.put_string ("In `")
						io.error.put_string (eiffel_gen_path)
						io.error.put_string ("' an Eiffel project already exists.%N")
						io.error.put_string ("Do you wish to overwrite it (Y-yes or N-no)? %N")
						io.read_line
						answer := io.last_string
						answer.to_lower
						error_occurred := not (answer.is_equal ("y") or answer.is_equal ("yes"))
						io.error.put_new_line
						if not error_occurred then
							overwrite_old_project := True
						end
					end
				else
						-- we created it, so if we have an error we will overwrite it silently
					overwrite_old_project := True
					d.create_dir
				end

					-- We create a project without an existing Eiffel Project file.
				create project_dir.make (eiffel_gen_path, Void);
				project_is_new := True
			end
		end

	open_project_file (file_name: STRING) is
			-- Initialize project as a new one or retrieving
			-- existing data in the valid directory `project_dir'.
		do
				--| Retrieve existing project
			create project_file.make (file_name)
			create project_dir.make (eiffel_gen_path, project_file)
		end

feature -- Project retrieval

	retrieve_project is
			-- Retrieve a project from the disk.
		require
			project_directory_exists: project_dir /= Void
		local
			msg: STRING
		do
			io.error.put_string ("Retrieving project...%N")
				-- Retrieve the project
			if not project_dir.exists then
				msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
			elseif
				not project_dir.is_base_readable or else
				not project_dir.is_base_writable or else
				not project_dir.is_base_executable
			then
				msg := Warning_messages.w_Cannot_open_project
			else
				Eiffel_project.make (project_dir)

				if Eiffel_project.retrieval_error then
					if Eiffel_project.is_incompatible then
						msg := Warning_messages.w_Project_incompatible (project_dir.name,
							version_number, Eiffel_project.incompatible_version_number)
					else
						if Eiffel_project.is_corrupted then
							msg := Warning_messages.w_Project_corrupted (project_dir.name)
						elseif Eiffel_project.retrieval_interrupted then
							msg := Warning_messages.w_Project_interrupted (project_dir.name)
						end
					end
				elseif Eiffel_project.incomplete_project then
					msg := Warning_messages.w_Project_directory_not_exist (project_file.name, project_dir.name)
				elseif Eiffel_project.read_write_error then
					msg := Warning_messages.w_Cannot_open_project
				end
			end

			if msg /= Void then
				io.error.put_string (msg)
				io.error.put_new_line
				error_occurred := True
			end
		end

	make_new_project (is_loop: BOOLEAN) is
			-- Initialize project as a new one.
		require
			New_project: project_is_new
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Eiffel_project.make_new (project_dir, True, Void, Void)
				check
					Project_initialized: Eiffel_project.initialized
				end

				Eiffel_ace.set_file_name (config_name)
				if config_target /= Void and then not config_target.is_empty then
					lace.set_target_name (config_target)
				end
			end
		rescue
			l_retried := True
			io.error.put_string ("An error occurred during removal of previous project.%N")
			io.error.put_string ("Please make sure to have full permission to your existing project.%N")
			error_occurred := True
			retry
		end

feature {NONE} -- Error messages

	Warning_messages: WARNING_MESSAGES is
			-- Placeholder to access all warning messages.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class COMMAND_LINE_PROJECT
