indexing
	description: "Objects that can generate/retrieve simple xml files%
		%i.e. one level deep. The format must be a valid build format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

	ANY

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Basic operations

	create_file (root_node_name: STRING; file_name: STRING; data: ARRAY [TUPLE [STRING, STRING]]) is
			-- Create an XML file `file_name', with a root node named `root_node_name' and the root node
			-- containing information given by `data'.
		require
			data_not_void: data /= Void
			root_node_name_not_void: root_node_name /= Void

		local
			document: XM_DOCUMENT
			root_element: XM_ELEMENT
			counter: INTEGER
			namespace: XM_NAMESPACE
			a_name_string, a_data_string: STRING
			file: KL_TEXT_OUTPUT_FILE
			warning_dialog: EV_WARNING_DIALOG
		do
				-- Create the root element.
			create namespace.make_default
			create document.make_with_root_named (root_node_name, namespace)
			root_element := document.root_element
			add_attribute_to_element (root_element, "xsi", "xmlns", Schema_instance)
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

				-- Save document.
			create file.make (file_name)
			file.open_write
			if file.is_open_write then
				file.put_string (xml_format + string_from_xm_document (document))
				file.close
			else
				create warning_dialog.make_with_text (unable_to_save_part1 + file_name + unable_to_save_part2)
				warning_dialog.show_modal_to_window (components.tools.main_window)
			end
		end

	load_file (file_name: STRING): HASH_TABLE [STRING, STRING] is
			-- Load file `file_name. `Result' contains the
			-- information contained in the file.
			-- Do nothing if the file is a directory.
		require
			file_name_not_void: file_name /= Void
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
		ensure
			result_not_void_if_loaded: last_load_successful implies result /= Void
		end

	last_load_successful: BOOLEAN
		-- Was the last call to `load file' successful?

feature {NONE} -- Implementation

	load_and_parse_xml_file (a_filename:STRING): HASH_TABLE [STRING, STRING] is
			-- Load file `a_filename' and parse.
			-- `Result' is all information in `a_filename'.
		require
			file_name_not_void: a_filename /= Void
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
					Result.put (element_info.data, element_info.name)
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
			file: KL_BINARY_INPUT_FILE
			l_concat_filter: XM_CONTENT_CONCATENATOR
		do
			create file.make (a_filename)
			file.open_read
			if file.is_open_read then
				create l_concat_filter.make_null
				create parser.make
				parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, pipe_callback.start>>))
				parser.parse_from_stream (file)
			end
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
			dialog.show_modal_to_window (components.tools.main_window)
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


end -- class GB_SIMPLE_XML_FILE_HANDLER
