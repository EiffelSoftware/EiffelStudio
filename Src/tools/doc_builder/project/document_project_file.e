indexing
	description: "Project settings file."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_FILE
	
inherit	
	XML_ROUTINES

	SHARED_OBJECTS
		undefine
			copy, is_equal
		end

create
	make_from_file

feature -- Creation

	make_from_file (a_file: PLAIN_TEXT_FILE) is
			-- Create from existing `preferences'
		require
			file_not_void: a_file /= Void
			file_exists: a_file.exists
		do
			file := a_file		
		end

feature -- Basic operations

	read is
			-- Read XML from file			
		do
			document := deserialize_document (create {FILE_NAME}.make_from_string (file.name))
			if document /= Void then
				process_element (document.root_element)
			else
				show_error ("Could not open project file.%NError description:" + error_description)
			end			
		end
		
	write is
			-- Write Current Project Settings to disk
		local
			l_root, l_element: XM_ELEMENT
			l_name: FILE_NAME
		do
			l_name := Shared_project.full_name
			l_name.add_extension (File_extension)
			create l_root.make_root ("project", Void)
			
			if document = Void then
				create document.make
			else
				document.wipe_out
			end
			
			document.put_first (l_root)

					-- Name
			create l_element.make_child (l_root, "project_name", Void)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, Shared_project.name))
			l_root.put_last (l_element)
			
					-- Location
			create l_element.make_child (l_root, "root_directory", Void)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, Shared_project.root_directory))
			l_root.put_last (l_element)
			
					-- Schema
			if Shared_document_manager.has_schema then
				create l_element.make_child (l_root, "schema", Void)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, Shared_document_manager.schema.name))
				l_root.put_last (l_element)
			end
			
					-- XSL
			if Shared_document_manager.has_xsl then
				create l_element.make_child (l_root, "xsl", Void)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, Shared_document_manager.xsl.name))
				l_root.put_last (l_element)
			end
			
					-- HTML Stylesheet
			if has_stylesheet_file then
				create l_element.make_child (l_root, "html_css", Void)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, stylesheet_file))
				l_root.put_last (l_element)
			end
			
			if not file.name.is_equal (l_name) then
				file.delete
				create file.make_create_read_write (l_name.string)
				file.close
			end
			save_xml_document (document, create {FILE_NAME}.make_from_string (file.name))
		end

feature -- Project Data
	
	stylesheet_file: STRING
			-- HTML Stylesheet file used in project

feature -- Query

	is_valid: BOOLEAN is
			-- Is Current representative of a valid project?
		do
			Result := Shared_project.name /= Void and then Shared_project.root_directory /= Void
		end
	
	has_stylesheet_file: BOOLEAN is
				-- Is there a HTML stylesheet associated with the open project
		do
			Result := stylesheet_file /= Void
		end

feature -- Status Setting
		
	set_css_file (a_css: STRING) is
			-- Set `stylesheet_file'
		require
			css_not_void: a_css /= Void
			css_exists: (create {PLAIN_TEXT_FILE}.make (a_css)).exists
		do
			stylesheet_file := a_css
		ensure
			style_set: stylesheet_file /= Void
		end
		
	remove_css_file is
			-- Remove reference to HTML CSS file
		do
			stylesheet_file := Void
		ensure
			not has_stylesheet_file
		end
	
feature {NONE} -- Implementation

	process_element (e: XM_ELEMENT) is
			-- Read element `e'
		require
			e_not_void: e /= Void
		local
			l_elements: DS_LIST [XM_ELEMENT]
		do
			if e.name.is_equal ("project_name") then
				Shared_project.set_name (e.text)
			end
			if e.name.is_equal ("root_directory") then
			Shared_project.set_root_directory (e.text)
			end
			if e.name.is_equal ("schema") then
				Shared_document_manager.initialize_schema (e.text)
			end
			if e.name.is_equal ("xsl") then
				Shared_document_manager.initialize_xslt (e.text)
			end
			if e.name.is_equal ("html_css") then
				set_css_file (e.text)
			end
			
					-- Process sub_elements
			l_elements := e.elements
			from
				l_elements.start
			until
				l_elements.after
			loop
				process_element (l_elements.item_for_iteration)
				l_elements.forth
			end
		end

	show_error (error: STRING) is
			-- Show validation error
		require
			error_not_void: error /= Void
		local
			error_dlg: EV_INFORMATION_DIALOG
		do
			create error_dlg.make_with_text (error)
			error_dlg.show_modal_to_window (Application_window)
		end

	file: PLAIN_TEXT_FILE
			-- Project File

	document: XM_DOCUMENT
			-- XML structure of `file'

	file_extension: STRING is
			-- File extension
		once
			Result := "dpr"	
		end	

invariant
	has_file: file /= Void
		
end -- class DOCUMENT_PROJECT_FILE
