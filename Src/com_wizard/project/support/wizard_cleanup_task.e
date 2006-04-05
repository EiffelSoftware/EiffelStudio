indexing
	description: "Cleanup task, reset folder content before new generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CLEANUP_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is "Cleaning up destination folder"
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
				if l_folder_name.item (l_folder_name.count) = '\' and l_folder_name.occurrences ('\') > 1 then
					l_folder_name.keep_head (l_folder_name.count - 1)
				end
				create l_folder.make (l_folder_name)
				if l_folder.exists then
					l_folder.delete_content
				else
					environment.set_abort (Destination_folder_cleanup_error)
					environment.set_error_data (environment.destination_folder)
				end
				progress_report.step
			else
				environment.set_abort (Destination_folder_cleanup_error)
				environment.set_error_data (environment.destination_folder)
			end
		rescue
			l_retried := True
			retry
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
end -- class WIZARD_CLEANUP_TASK

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
