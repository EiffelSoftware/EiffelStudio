indexing
	description: "Initialization task, initialize settings prior to generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIALIZATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is "Initializing"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			Result := 1
		end

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		local
			l_folder: DIRECTORY
			l_retried: BOOLEAN
			l_folder_name: STRING
		do
			if not l_retried then
				l_folder_name := environment.destination_folder.twin
				if l_folder_name.item (l_folder_name.count) = '\' then
					l_folder_name.keep_head (l_folder_name.count - 1)
				end
				create l_folder.make (l_folder_name)
				if not l_folder.exists then
					recursive_create (l_folder_name)
					if not created then
						environment.set_abort (Initialization_error)
						environment.set_error_data (environment.destination_folder)
					end
				end
				progress_report.step
			else
				environment.set_abort (Initialization_error)
				environment.set_error_data (environment.destination_folder)
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	recursive_create (a_folder: STRING) is
			-- Create directory `a_folder' recursively, set `created' accordingly.
		require
			non_void_folder: a_folder /= Void
		local
			l_elements: LIST [STRING]
			l_root: STRING
			l_directory: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_elements := a_folder.split (Operating_environment.Directory_separator)
				from
					l_elements.start
					l_root := l_elements.item
					l_elements.forth
					created := l_elements.after
				until
					created
				loop
					l_root.append_character (Operating_environment.Directory_separator)
					l_root.append (l_elements.item)
					create l_directory.make (l_root)
					if not l_directory.exists then
						l_directory.create_dir
					end
					l_elements.forth
					created := l_elements.after
				end
			else
				created := False
			end
		rescue
			l_retried := True
			retry
		end
		
	created: BOOLEAN;
			-- Was directory successfully created by `recursive_create'?

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
end -- class WIZARD_INITIALIZATION_TASK

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
