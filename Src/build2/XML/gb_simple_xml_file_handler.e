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
		export
			{NONE} all
		end
	
	GB_FILE_CONSTANTS
		export
			{NONE} all
		end
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	CDATA_HANDLER
		export
			{NONE} all
		end
	
feature -- Basic operations

	create_file (root_node_name: STRING; file_name: STRING; data: ARRAY [TUPLE [STRING, STRING]]) is
			-- Create an XML file `file_name', with a root node named `root_node_name' and the root node
			-- containing information given by `data'.
		require
			data_not_void: data /= Void
			root_node_name_not_void: root_node_name /= Void
			
		local
			formater: XM_FORMATTER
			document: XM_DOCUMENT
			root_element: XM_ELEMENT
			counter: INTEGER
			namespace: XM_NAMESPACE
			a_name_string, a_data_string: STRING
		do
				-- Create the root element.
			create namespace.make ("", "")
			create root_element.make_root (root_node_name, namespace)
			add_attribute_to_element (root_element, "xsi", "xmlns", Schema_instance)	
			create document.make
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
				add_element_containing_string (root_element, a_name_string, enclose_in_cdata (a_data_string))
				counter := counter + 1
			end
			
				-- Format and save the document.
			create formater.make
			formater.process_document (document)
			write_file_to_disk (formater.last_string, file_name)
		end
		
	load_file (file_name: STRING): ARRAYED_LIST [TUPLE [STRING, STRING]] is
			-- Load file `file_name. `Result' contains the 
			-- information contained in the file.
			-- Do nothing if the file is a directory.
		local
			file: RAW_FILE
			buffer: STRING
		do
				-- We now load the first 54 characters from the file, and
				-- check if they are what we expect a valid build file to hold.
				-- If not, then raise an error.
				-- 54 is completely arbitary, but enough to validate.
			create file.make_open_read (file_name)
			if not file.is_directory and not file.is_device then
				create buffer.make (file.count) 
				file.start
				file.read_stream (file.count)
				file.close
				buffer := file.last_string
					-- This checks that the file actually is a valid Build file, the fact
					-- that 54 charaters are checked is arbitary.
				if buffer.count < 54 or (buffer.substring (1, 54).is_equal (xml_format + "<Project_setting")) then
					Result := load_and_parse_xml_file (file_name)
						-- Assign `True' to `last_load_successful' so it can be queried
						-- externally.
					if parser.is_correct then
						last_load_successful := True
					else
						show_warning_dialog
					end
				else
					show_warning_dialog
				end
			else
				show_warning_dialog
			end
		end
		
	last_load_successful: BOOLEAN
		-- Was the last call to `load file' successful?
		
feature {NONE} -- Implementation

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
			root_element: XM_ELEMENT
			child_names: ARRAYED_LIST [STRING]
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			parse_file (a_filename)
			if parser.is_correct then
				create Result.make (0)
				root_element := pipe_callback.document.root_element
				child_names := all_child_element_names (root_element)
				full_information := get_unique_full_info (root_element)
				from
					child_names.start
				until
					child_names.off
				loop
					element_info := full_information @ (child_names.item)
					Result.extend ([element_info.name, strip_cdata (element_info.data)])
					child_names.forth
				end
			end
		end
				
	pipe_callback: XM_TREE_CALLBACKS_PIPE is
			-- Create unique callback pipe.
		once
			create Result.make
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
			create parser.make
			parser.set_callbacks (pipe_callback.start)
			parser.parse_from_string (buffer)
			parser.finish_incremental
		end
		
	parser: XM_EIFFEL_PARSER
		
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
