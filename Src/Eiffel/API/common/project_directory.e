indexing
	description: "Directory for an eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_DIRECTORY

inherit
	PROJECT_CONTEXT
		export
			{NONE} all
		end

	DIRECTORY
		rename
			make as directory_make,
			mode as file_mode,
			exists as base_exists,
			is_readable as is_base_readable,
			is_writable as is_base_writable,
			is_executable as is_base_executable
		end

	SHARED_WORKBENCH

create
	make

feature -- Initialization

	make (dn: STRING; project_eiffel_file: PROJECT_EIFFEL_FILE) is
		do
			directory_make (dn)
			if project_eiffel_file /= Void then
				set_project_file (project_eiffel_file)
			end
		end

feature -- Access

	valid_project_epr: BOOLEAN is
			-- Is the `project_epr' file valid?
		local
			file: like project_epr_file
		do
			file := project_epr_file;
			Result := file.is_readable and then
				file.is_plain
		ensure
			valid_implies_good_file:
				project_epr_file.is_readable and then
					project_epr_file.is_plain
		end;

	is_readable: BOOLEAN is
			-- May the project be used for browsing and debugging?
		require
			project_epr_file_set: project_epr_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY;
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path);
			create f_code_dir.make (temp_final_generation_path);
			create comp_dir.make (temp_compilation_path);
			create project_file.make (project_epr_file.name);
			Result := is_base_readable and then w_code_dir.is_readable
					and then f_code_dir.is_readable and then comp_dir.is_readable
					and then project_file.is_readable
			if initialized then
				Result := Result and then System.server_controler.is_readable
			end
		end;

	is_writable: BOOLEAN is
			-- May the project be both compiled and used for browsing?
		require
			project_epr_file_set: project_epr_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path)
			create f_code_dir.make (temp_final_generation_path)
			create comp_dir.make (temp_compilation_path)
			create project_file.make (project_epr_file.name)
			Result := is_base_writable and then w_code_dir.is_writable
					and then f_code_dir.is_writable and then comp_dir.is_writable
					and then project_file.is_writable
			if initialized then
				Result := Result and then System.server_controler.is_writable
			end
		end;

	exists: BOOLEAN is
			-- Does the project exist?
			--| Ie, Comp, F_code, W_code and project file exist?
		require
			project_epr_file_set: project_epr_file /= Void
		local
			w_code_dir, f_code_dir, comp_dir: DIRECTORY
			project_file: RAW_FILE
		do
			create w_code_dir.make (temp_workbench_generation_path)
			create f_code_dir.make (temp_final_generation_path)
			create comp_dir.make (temp_compilation_path)
			create project_file.make (project_epr_file.name)
			Result := base_exists and then w_code_dir.exists
				and then f_code_dir.exists and then comp_dir.exists
				and then project_file.exists
			if initialized then
				Result := Result and then System.server_controler.exists
			end
		end

feature -- Update

	set_project_file (project_file: PROJECT_EIFFEL_FILE) is
		require
			project_file_not_void: project_file /= Void
		do
			project_epr_file := project_file
		ensure
			project_epr_file_set: project_epr_file = project_file
		end

feature -- Access

	initialized: BOOLEAN
			-- Has the project correctly initialized?

	project_epr_file: PROJECT_EIFFEL_FILE;
			-- Project.eif file in project directory

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class PROJECT_DIRECTORY
