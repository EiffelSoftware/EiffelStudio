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
			
			save_xml_document (document)
		end	

feature -- XML Routines

	save_xml_document (a_doc: XM_DOCUMENT) is
			-- Save `a_doc' in `ptf'
		require
			doc_not_void: a_doc /= Void
		local
			retried: BOOLEAN
			l_formatter: XM_FORMATTER
			l_output_file: KL_TEXT_OUTPUT_FILE
			file_location: FILE_NAME
		do
			if not retried then
					-- Write document
				create l_formatter.make
				l_formatter.process_document (a_doc)
				create file_location.make_from_string (Shared_constants.Application_constants.Temporary_help_directory)
				file_location.extend (project.name + "_settings.xml")
				create l_output_file.make (file_location)
				l_output_file.open_write
				if l_output_file.is_open_write then
					l_output_file.put_string (l_formatter.last_string)
					l_output_file.flush
					l_output_file.close
				else
					io.putstring ("Unable to write file: " + project.name)
				end
			end
		rescue
			retried := True
			io.putstring ("Unable to write file: " + project.name)
			retry
		end

	deserialize_document: XM_DOCUMENT is
			-- Retrieve xml document associated to file
			-- If deserialization fails, return Void.
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_file: KL_BINARY_INPUT_FILE
			l_xm_concatenator: XM_CONTENT_CONCATENATOR
			l_file_location: FILE_NAME
		do
			create l_file_location.make_from_string (Shared_constants.Application_constants.Temporary_help_directory)
			l_file_location.extend (project.name + "_settings.xml")
			create l_file.make (l_file_location)
			if l_file.exists then
				l_file.open_read
				if l_file.is_open_read then
					create l_parser.make
					create l_tree_pipe.make
					create l_xm_concatenator.make_null
					l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))
					l_parser.parse_from_stream (l_file)
					l_file.close
					if l_parser.is_correct then
						Result := l_tree_pipe.document
					else
						io.putstring ("File " + project.name + " is corrupted")
						Result := Void
					end
				else
					io.putstring ("File " + project.name + " cannot not be open")
				end
			else
				io.putstring ("Try to deserialize unexisting file :%N" + project.name)
			end
		end

feature {NONE} -- Implementation

	project: HELP_PROJECT
			-- Associated project

end -- class HELP_PROJECT_SETTINGS_FILE
