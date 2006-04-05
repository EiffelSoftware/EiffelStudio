indexing
	description: "Help Project settings/preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_PROJECT_SETTINGS_FILE

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
	
	SHARED_OBJECTS
	
	XML_ROUTINES

create
	make

feature -- Creation

	make (a_project: HELP_PROJECT) is
			-- New settings file for `a_project' and write to disk
		require
			project_not_void: a_project /= Void
		do
			project := a_project
			write
		end		

feature -- Access
		
	write is
			-- Write settings fully, based upon data in `project'
		local
			document: XM_DOCUMENT
			parent_element, element: XM_ELEMENT
			ns: XM_NAMESPACE
			value: XM_CHARACTER_DATA
		do
			create document.make
			create ns.make_default
			create parent_element.make_root (document, Shared_constants.Help_constants.Help_project_tag, ns)
			document.force_first (parent_element)
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Name_tag, ns)
			create value.make (element, project.name)
			element.force_last (value)
			parent_element.force_last (element)
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Directory_tag, ns)
			create value.make (element, project.location.name)
			element.force_last (value)
			parent_element.force_last (element)
			
			if project.title /= Void then
				create element.make_child (parent_element, Shared_constants.Help_constants.Title_tag, ns)
				create value.make (element, project.title)
				element.force_last (value)
				parent_element.force_last (element)
			end
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Files_tag, ns)
			parent_element.force_last (element)

			parent_element := element
			create element.make_child (parent_element, Shared_constants.Help_constants.Project_file_tag, ns)
			create value.make (element, project.project_file_name)
			element.force_last (value)
			parent_element.force_last (element)
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Compiled_file_tag, ns)
			create value.make (element, project.compiled_file_name)
			element.force_last (value)
			parent_element.force_last (element)
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Toc_file_tag, ns)
			create value.make (element, project.toc_file_name)
			element.force_last (value)
			parent_element.force_last (element)
			
			create element.make_child (parent_element, Shared_constants.Help_constants.Log_file_tag, ns)
			create value.make (element, project.error_file_name)
			element.force_last (value)
			parent_element.force_last (element)
			
			save_xml_document (document, file.name)
		end	

feature -- XML Routines

	xm_document: XM_DOCUMENT is
			-- Retrieve xml document associated to file
			-- If deserialization fails, return Void.
		local
			l_file: PLAIN_TEXT_FILE
		do			
			l_file := file
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				Result := deserialize_text (l_file.last_string)
				l_file.close
			end
		end

feature {NONE} -- Implementation

	project: HELP_PROJECT
			-- Associated project
			
	file: PLAIN_TEXT_FILE is
			-- File
		local
			l_file_location: FILE_NAME
		do
--			create l_file_location.make_from_string (shared_constants.application_constants.temporary_help_directory)
			create l_file_location.make_from_string (shared_constants.application_constants.temporary_html_directory)
			l_file_location.extend (project.name + "_settings.xml")
			create Result.make (l_file_location.string)
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
end -- class HELP_PROJECT_SETTINGS_FILE
