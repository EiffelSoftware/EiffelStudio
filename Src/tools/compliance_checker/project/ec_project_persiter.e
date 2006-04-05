indexing
	description: "[
		General purpose persistance and retrieval for a loaded compliance project.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_PROJECT_PERSITER

inherit
	EC_SHARED_PROJECT
		export
			{NONE} all
		end

feature -- Basic Operations

	load_project (a_path: STRING) is
			-- Loads project from `a_path'
		local
			l_file: RAW_FILE
			l_project: like project
			l_reader: SED_MEDIUM_READER_WRITER
		do
			create l_file.make_open_read (a_path)
			create l_reader.make (l_file)
			l_reader.set_for_reading
 			l_project ?= sed_utilities.retrieved (l_reader, False)
 			if l_project /= Void then
 				internal_project_settings.put (l_project)
 			end
 			l_file.close			
		end
		
	save_project (a_path: STRING) is
			-- Saves project to `a_path'
		local
			l_file: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
		do
			create l_file.make_open_write (a_path)
			create l_writer.make (l_file)
			l_writer.set_for_writing
 			sed_utilities.session_store (project, l_writer, False)
 			l_file.flush
 			l_file.close
		end
		
feature {NONE} -- Implementation

	sed_utilities: SED_STORABLE_FACILITIES is
			-- Storable utilities
		once
			create Result
		ensure
			result_not_void: Result /= Void
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
end -- class EC_PROJECT_PERSITER
