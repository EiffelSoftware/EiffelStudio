indexing
	description: "Project settings file."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_PROJECT_FILE
	
inherit	
	XML_VALIDATOR
	
	SHARED_OBJECTS

create
	default_create,
	make_from_file

feature -- Creation

	make_from_file (a_filename: STRING) is
			-- Create from existing `preferences'
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		do
			filename := a_filename
			read
		ensure
			name_set: filename /= Void
		end

feature -- Basic operations

	read is
			-- Read XML from file
		local
			reader: XML_XML_TEXT_READER
		do
			if is_valid_xml_file (filename) then
				create reader.make_from_url (filename)
				from
				until
					not reader.read
				loop
					read_node (reader, reader.node_type)
				end
				reader.close
				is_valid := True
			else
				show_error ("Unable to open project file.  File is corrupt.")
			end
		end
		
	write is
			-- Write Current Project Settings to disk
		local
			writer: XML_XML_TEXT_WRITER
		do
			create writer.make_from_filename_and_encoding ((root_directory + "\" + name + ".dpr").to_cil, Void)
			writer.write_start_document_boolean (false)
            writer.write_comment ("This file represents a system documentation project.")
            writer.write_start_element ("project")
            writer.write_element_string_string_string_string ("project_name", Void, name)
            writer.write_element_string_string_string_string ("root_directory", Void, root_directory)
            if has_schema then
            	writer.write_element_string_string_string_string ("schema", Void, schema_file)
            end
           	if has_transform_file then
           		writer.write_element_string_string_string_string ("xsl", Void, transform_file)
           	end
            if has_stylesheet_file then
            	writer.write_element_string_string_string_string ("html_css", Void, stylesheet_file)
            end
            if has_index_file_name then
            	writer.write_element_string_string_string_string ("index_file_name", Void, index_filename)	
            end
            writer.write_element_string_string_string_string ("index_is_root", Void, is_index_root.out)
            writer.write_element_string_string_string_string ("include_empty_directories", Void, include_empty_directories.out)
            writer.write_element_string_string_string_string ("include_directories_no_index", Void, include_directories_no_index.out)
            writer.write_element_string_string_string_string ("include_skipped_sub_directories", Void, include_skipped_sub_directories.out)
			writer.write_end_element
            writer.flush
            writer.close
		end

feature -- Project Data

	name: STRING
			-- Project name

	root_directory: STRING
			-- Root directory of project

	schema_file: STRING
			-- Schema used in project
	
	transform_file: STRING
			-- Transform file used in project
	
	stylesheet_file: STRING
			-- HTML Stylesheet file used in project

	filename: STRING
			-- Project filename for persisted preferences

	index_filename: STRING
			-- File name used to denote index files
			
	is_index_root: BOOLEAN
			-- Is index file in any given directory to be taken a root node?
			
	include_empty_directories: BOOLEAN
			-- Should empty directories be ignored in TOC view?

	include_directories_no_index: BOOLEAN
			-- Should directories with no index be ignored in TOC view?

	include_skipped_sub_directories: BOOLEAN
			-- Should the sub directories of skipped directories be included in the TOC view?

feature -- Query

	is_valid: BOOLEAN
			-- Is Current representative of a valid project?

	has_schema: BOOLEAN is
			-- Is there a schema associated with the open project?
		do
			Result := schema_file /= Void
		end
	
	has_transform_file: BOOLEAN is
			-- Is there a xsl file associated with the open project?
		do
			Result := transform_file /= Void
		end
	
	has_stylesheet_file: BOOLEAN is
				-- Is there a HTML stylesheet associated with the open project
		do
			Result := stylesheet_file /= Void
		end
		
	has_index_file_name: BOOLEAN is
				-- Is there a default index file name?
		do
			Result := index_filename /= Void
		end

feature -- Status Setting

	set_name (a_name: STRING) is
			-- Set `name'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			name := a_name	
		ensure
			name_set: a_name /= Void and not a_name.is_empty
		end

	set_root_directory (a_root_directory: STRING) is
			-- Set `root_directory'
		require
			dir_not_void: a_root_directory /= Void
			dir_exists: (create {DIRECTORY}.make (a_root_directory)).exists
		do
			root_directory := a_root_directory
		ensure
			root_set: root_directory /= Void
		end
		
	set_schema_file (a_schema: STRING) is
			-- Set `schema_file'
		require
			schema_not_void: a_schema /= Void
			schema_exists: (create {PLAIN_TEXT_FILE}.make (a_schema)).exists
		do
			schema_file := a_schema
		ensure
			schema_set: schema_file /= Void
		end
		
	set_xsl_file (a_xsl: STRING) is
			-- Set `transform_file'
		require
			xsl_not_void: a_xsl /= Void
			xsl_exists: (create {PLAIN_TEXT_FILE}.make (a_xsl)).exists
		do
			transform_file := a_xsl
		ensure
			xsl_set: transform_file /= Void
		end
		
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

	set_index_file_name (a_name: STRING) is
			-- Set `index_filename'
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			index_filename := a_name
		ensure
			index_name_set: index_filename /= Void
		end

	set_index_root (a_flag: BOOLEAN) is
 			-- Set `is_index_root'
 		do
 			is_index_root := a_flag
 		end

	set_include_empty_directories (a_flag: BOOLEAN) is
 			-- Set `include_empty_directories'
 		do
 			include_empty_directories := a_flag
 		end
 		
 	set_include_directories_no_index (a_flag: BOOLEAN) is
 			-- Set `skip_directories_no__index'
 		do
 			include_directories_no_index := a_flag
 		end
 		
 	set_include_skipped_sub_directories (a_flag: BOOLEAN) is
 			-- Set `include_skipped_sub_directories'
 		do
 			include_skipped_sub_directories := a_flag
 		end
 	
	remove_xsl_file is
			-- Remove reference to XSL file
		do
			transform_file := Void
		ensure
			not has_transform_file
		end
		
	remove_schema_file is
			-- Remove reference to schema file
		do
			schema_file := Void
		ensure
			not has_schema
		end
		
	remove_css_file is
			-- Remove reference to HTML CSS file
		do
			stylesheet_file := Void
		ensure
			not has_stylesheet_file
		end
		
	remove_index_file_name is
			-- Remove reference to default index file name
		do
			index_filename := Void
		ensure
			not has_index_file_name
		end
	
feature {NONE} -- Implementation

	read_node (reader: XML_XML_TEXT_READER; a_node: XML_XML_NODE_TYPE) is
			-- Read `a_node' found in `reader'
		require
			reader_not_void: reader /= Void
			node_not_void: a_node /= Void
		local
			element: XML_XML_ELEMENT
			node_type: XML_XML_NODE_TYPE
			element_name: STRING
		do
			if a_node.to_integer = feature {XML_XML_NODE_TYPE}.element.to_integer then
				create element_name.make_from_cil (reader.name)
				if element_name.is_equal ("project_name") then
					if reader.read then
						set_name (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("root_directory") then
					if reader.read then
						set_root_directory (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("schema") then
					if reader.read then
						set_schema_file (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("xsl") then
					if reader.read then
						set_xsl_file (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("html_css") then
					if reader.read then
						set_css_file (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("index_file_name") then
					if reader.read then
						set_index_file_name (create {STRING}.make_from_cil (reader.value))
					end
				elseif element_name.is_equal ("index_is_root") then
					if reader.read then						
						if (create {STRING}.make_from_cil (reader.value)).is_equal ("True") then
							set_index_root (True)
						else
							set_index_root (False)
						end
					end
				elseif element_name.is_equal ("include_empty_directories") then
					if reader.read then
						if (create {STRING}.make_from_cil (reader.value)).is_equal ("True") then
							set_include_empty_directories (True)
						else
							set_include_empty_directories (False)
						end						
					end
				elseif element_name.is_equal ("skip_directories_no_index") then
					if reader.read then
						if (create {STRING}.make_from_cil (reader.value)).is_equal ("True") then
							set_include_directories_no_index (True)
						else
							set_include_directories_no_index (False)
						end						
					end
				elseif element_name.is_equal ("include_skipped_sub_directories") then
					if reader.read then
						if (create {STRING}.make_from_cil (reader.value)).is_equal ("True") then
							set_include_skipped_sub_directories (True)
						else
							set_include_skipped_sub_directories (False)
						end						
					end
				end
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

invariant
	has_filename: filename /= Void
	has_location: root_directory /= Void
	root_exists: (create {DIRECTORY}.make (root_directory)).exists
		
end -- class DOCUMENT_PROJECT_FILE
