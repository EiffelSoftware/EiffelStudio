indexing
	description: "Task used for initializing directories where EiffelCOM Wizard will generate files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date"
	revision: "$revision"

class
	WIZARD_DIRECTORY_INITIALIZATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

	WIZARD_FILE_SYSTEM_MANAGEMENT
		export
			{NONE} all
		end

feature -- Access

	title: STRING is "Initializing generation"
			-- Task title

	steps_count: INTEGER is 12
			-- Number of steps involved in task

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		local
			l_path, l_path2: STRING
		do
			l_path := environment.destination_folder.twin
			initialize_subdirectory (l_path, "Common")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Common\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Interfaces")
			progress_report.step
			initialize_subdirectory (l_path2, "Structures")
			progress_report.step
			initialize_subdirectory (l_path, "Client")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Client\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Component")
			progress_report.step
			initialize_subdirectory (l_path2, "Interface_proxy")
			progress_report.step
			initialize_subdirectory (l_path, "Server")
			progress_report.step
			l_path2 := l_path.twin
			l_path2.append ("Server\")
			initialize_clib_include (l_path2)
			progress_report.step
			initialize_subdirectory (l_path2, "Component")
			progress_report.step
			initialize_subdirectory (l_path2, "Interface_stub")
			progress_report.step
		end

	initialize_clib_include (a_path: STRING) is
			-- Initialize sub-directories `Clib' and `Include' of directory `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			initialize_subdirectory (a_path, "Clib")
			initialize_subdirectory (a_path, "Include")
		end

	initialize_subdirectory (a_path, a_subdirectory: STRING) is
			-- Initialize sub-directory `a_subdirectory' from directory `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			non_void_subdirectory: a_subdirectory /= Void
			valid_subdirectory: not a_subdirectory.is_empty
		local
			l_path: STRING
		do
			create l_path.make (a_path.count + a_subdirectory.count)
			l_path.append (a_path)
			l_path.append (a_subdirectory)
			initialize_directory (l_path)
		end
	
	initialize_directory (a_path: STRING) is
			-- Initialize directory `a_path'
		require
			non_void_path: a_path /= Void
		local
			l_file: RAW_FILE
			l_string: STRING
			l_directory: DIRECTORY
		do
			create l_file.make (a_path)
			if l_file.exists then
				if not l_file.is_directory then
					if environment.backup then
						l_string := "File already exists: "
						l_string.append (a_path)
						message_output.add_warning (l_string)
						message_output.add_message ("File backed up with extension %".bac%"")
						l_string := a_path.twin
						l_string.append (".bac")
						file_copy (a_path, l_string)
					end
					file_delete (a_path)
					create l_directory.make (a_path)
					check
						not_exists: not l_directory.exists
					end
					l_directory.create_dir
				end
			else
				create l_directory.make (a_path)
				check
					not_exists: not l_directory.exists
				end
				l_directory.create_dir
			end
	end

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
end -- class WIZARD_DIRECTORY_INITIALIZATION_TASK

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
