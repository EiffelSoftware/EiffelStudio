indexing
	description: "Help Project settings/preferences."
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
			create ns.make ("", "")
			create parent_element.make_root (Shared_constants.Help_constants.Help_project_tag, ns)
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
			create l_file_location.make_from_string (shared_constants.application_constants.temporary_help_directory)
			l_file_location.extend (project.name + "_settings.xml")
			create Result.make (l_file_location.string)
		end

end -- class HELP_PROJECT_SETTINGS_FILE
