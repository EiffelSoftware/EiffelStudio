indexing
	description: "Objects that can generate/retrieve simple xml files%
		%i.e. one level deep. The format must be a valid build format."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SIMPLE_XML_FILE_HANDLER
	
inherit
	
	GB_CONSTANTS
	
	GB_XML_UTILITIES
	
	TOE_TREE_FACTORY
	
	GB_SHARED_TOOLS
	
feature -- Basic operations

	create_file (root_node_name: STRING; file_name: STRING; data: ARRAY [TUPLE [STRING, STRING]]) is
			-- Create an XML file `file_name', with a root node named `root_node_name' and the root node
			-- containing information given by `data'.
		require
			data_not_void: data /= Void
			root_node_name_not_void: root_node_name /= Void
			
		local
			formater: XML_FORMATER
			document: XML_DOCUMENT
			root_element: XML_ELEMENT
			toe_document: TOE_DOCUMENT
			counter: INTEGER
			a_name_string, a_data_string: STRING
		do
				-- Create the root element.
			root_element := new_root_element (root_node_name, "")
			add_attribute_to_element (root_element, "xsi", "xmlns", Schema_instance)	
			
			create toe_document.make
			create document.make_from_imp (toe_document)
			document.start
				-- Add `application_element' as the root element of `document'.
			document.force_first (root_element)
			
			
				-- Add information in `names' and `data' to the file.
			from
				counter := 1
			until
				counter > data.count
			loop
				a_name_string ?= (data @ counter) @ 1
				a_data_string ?= (data @ counter) @ 2
				check
					data_not_void: a_name_string /= Void and a_data_string /= Void
				end
				add_element_containing_string (root_element, a_name_string, a_data_string)
				counter := counter + 1
			end
			
				-- Format and save the document.
			create formater.make
			formater.process_document (document)
			write_file_to_disk (formater.last_string.to_utf8, file_name)
		end
		
	load_file (file_name: STRING): ARRAYED_LIST [TUPLE [STRING, STRING]] is
			-- Load file `file_name. `Result' contains the 
			-- information contained in the file.
		local
			file: RAW_FILE
			buffer: STRING
		do
				-- We now load the first 54 characters from the file, and
				-- check if they are what we expect a valid build file to hold.
				-- If not, then raise an error.
				-- 54 is completely arbitary, but enough to validate.
			create file.make_open_read (file_name)
			create buffer.make (file.count) 
			file.start
			file.read_stream (file.count)
			file.close
			buffer := file.last_string
			if buffer.count < 54 or (buffer.substring (1, 54).is_equal (xml_format + "<Project_setting")) then
				parser := create_tree_parser
				Result := load_and_parse_xml_file (file_name)
					-- Assign `True' to `last_load_successful' so it can be queried
					-- externally.
				last_load_successful := True
			else
				show_warning_dialog
			end
		end
		
	last_load_successful: BOOLEAN
		-- Was the last call to `load file' successful?
		
feature {NONE} -- Implementation

	parser: XML_TREE_PARSER
		-- XML tree parser used by `Current'.

	write_file_to_disk (xml_text: STRING; file_name: STRING) is
			-- Create a file named `filename' with content `xml_text'.
		local
			file: RAW_FILE
		do
			create file.make_open_write (file_name)
			file.start
			file.putstring (xml_format)
			file.put_string (xml_text)
			file.close
		end
		
	load_and_parse_xml_file (a_filename:STRING): ARRAYED_LIST [TUPLE [STRING, STRING]] is
			-- Load file `a_filename' and parse.
			-- `Result' is all information in `a_filename'.
		local
			temp_window: EV_TITLED_WINDOW
			error_dialog:EV_ERROR_DIALOG
			root_element: XML_ELEMENT
			child_names: ARRAYED_LIST [STRING]
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			parse_file (a_filename)
			if not parser.is_correct then
				create temp_window
				create error_dialog.make_with_text ("Invalid XML Schema.")
				error_dialog.show_modal_to_window (temp_window)
				temp_window.destroy
			else
				create Result.make (0)
				root_element := parser.document.root_element
				child_names := all_child_element_names (root_element)
				full_information := get_unique_full_info (root_element)
				from
					child_names.start
				until
					child_names.off
				loop
					element_info := full_information @ (child_names.item)
					Result.extend ([element_info.name, element_info.data])
					child_names.forth
				end
			end
		end
		
	parse_file (a_filename: STRING) is
			-- Parse XML file `filename' with `parser'.
		local
			file: RAW_FILE
			buffer: STRING
		do
			create file.make_open_read (a_filename)
			create buffer.make (file.count) 
			file.start
			file.read_stream (file.count)
			buffer := file.last_string
			parser.parse_from_string (buffer)
			parser.set_end_of_document
		end
		
	show_warning_dialog is
			-- Show a warning with notification that the file
			-- was not a valid build file.
		local
			dialog: EV_WARNING_DIALOG
		do
			last_load_successful := False
			create dialog.make_with_text (Invalid_project_warning)
			dialog.show_modal_to_window (main_window)
		end
		

end -- class GB_SIMPLE_XML_FILE_HANDLER
