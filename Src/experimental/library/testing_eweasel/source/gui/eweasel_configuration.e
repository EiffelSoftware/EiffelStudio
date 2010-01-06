note
	description: "Configuration settings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EWEASEL_CONFIGURATION
	
inherit
	EWEASEL_CONFIGURATION_CONSTANTS

create
	make,
	make_new

feature -- Creation

	make (a_filename: STRING)
			-- New configuration loaded from file in `a_filename'
		require
			name_not_void: a_filename /= Void
			file_exists: (create {PLAIN_TEXT_FILE}.make (a_filename)).exists
		do
			create file.make (a_filename)
			parse_file_info
		end	
		
	make_new (a_filename: STRING)
			-- New configuration
		require
			name_not_void: a_filename /= Void
		do
			create file.make_create_read_write (a_filename)
			file.close
		end		
		
feature -- Storage

	save
			-- Save		
		local
			l_root, l_element: XM_ELEMENT
			l_ns: XM_NAMESPACE
			l_document: XM_DOCUMENT
			l_xml_util: XML_ROUTINES
		do
			create l_xml_util
			create l_document.make
			
			create l_ns.make_default
			create l_root.make_root (l_document, root_tag, l_ns)
			l_document.put_first (l_root)

				-- Keep
			create l_element.make (l_root, keep_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, keep_tests))
			l_root.put_last (l_element)
			
				-- Keep EIFGENs
			create l_element.make (l_root, keep_eifgens_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, keep_eifgens.out))
			l_root.put_last (l_element)
			
				-- Platform
			create l_element.make (l_root, platform_type_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, platform_type))
			l_root.put_last (l_element)
			
				-- Output directory
			create l_element.make (l_root, output_location_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, output_directory))
			l_root.put_last (l_element)
				
				-- Include directory
			create l_element.make (l_root, include_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, include_directory))
			l_root.put_last (l_element)	
			
				-- Control file
			create l_element.make (l_root, control_file_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, control_file))
			l_root.put_last (l_element)
				
				-- Catalog file
			if catalog_file /= Void then
				create l_element.make (l_root, catalog_file_tag, l_ns)
				l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, catalog_file))
				l_root.put_last (l_element)	
			end
				
				-- Eiffel installation directory
			create l_element.make (l_root, installation_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, eiffel_installation_directory))
			l_root.put_last (l_element)	
				
				-- Eweasel installation directory
			create l_element.make (l_root, weasel_installation_tag, l_ns)
			l_element.put_first (create {XM_CHARACTER_DATA}.make (l_element, eweasel_installation_directory))
			l_root.put_last (l_element)		
				
			file.open_write
			file.put_string (l_xml_util.document_text (l_document))
			file.close
		end		

feature -- Access

	output_directory: STRING
			-- Location of output directory for test execution
			
	keep_tests: STRING
			-- Argument to indicate what to do with test directories
			
	keep_eifgens: BOOLEAN
			-- Should compiled test EIFGENS be removed after execution?
			
	platform_type: STRING
			-- Compilation platform for test execution
			
	include_directory: STRING
			-- Include directory
			
	eiffel_installation_directory: STRING
			-- Eiffel installation directory
	
	eweasel_installation_directory: STRING
			-- Eweasel installation directory
			
	control_file: STRING
			-- Control file location
		
	catalog_file: STRING
			-- Catalog file location	
		
feature -- Query

	is_valid: BOOLEAN
			-- Is Current valid?  A valid configuration implies that all necessary details are available
			-- to attempt to launch a test suite and run tests
		do
			Result := output_directory /= Void and then 
				platform_type /= Void and then 
				include_directory /= Void and then 
				eiffel_installation_directory /= Void and then 
				control_file /= Void and then 
				eweasel_installation_directory /= Void
		end
		
feature -- Status Setting

	set_output_directory (a_dir: STRING)
			-- Set output directory
		require
			dir_not_void: a_dir /= Void
			dir_not_empty: not a_dir.is_empty
		do
			output_directory := a_dir
		ensure
			dir_set: output_directory = a_dir
		end
		
	set_platform_type (a_platform: STRING)
			-- Set platform type
		require
			platform_not_void: a_platform /= Void
			platform_not_empty: not a_platform.is_empty
		do
			platform_type := a_platform
		ensure
			platform_set: platform_type = a_platform
		end
		
	set_keep_tests (a_identifier: STRING)
			-- Set keep test option
		require
			identifer_not_void: a_identifier /= Void
			identifier_not_empty: not a_identifier.is_empty
		do
			keep_tests := a_identifier
		ensure
			keep_set: keep_tests = a_identifier
		end			
		
	set_keep_eifgens (a_flag: BOOLEAN)
			-- Set keep EIFGENs option
		do
			keep_eifgens := a_flag
		ensure
			keep_set: keep_eifgens = a_flag
		end		
		
	set_include_directory (a_dir: STRING)
			-- Set include directory
		require
			dir_not_void: a_dir /= Void
			dir_not_empty: not a_dir.is_empty
		do
			include_directory := a_dir
		ensure
			dir_set: include_directory = a_dir
		end	
		
	set_eiffel_installation_directory (a_dir: STRING)
			-- Set eiffel_installation directory
		require
			dir_not_void: a_dir /= Void
			dir_not_empty: not a_dir.is_empty
		do
			eiffel_installation_directory := a_dir
		ensure
			dir_set: eiffel_installation_directory = a_dir
		end	
	
	set_eweasel_installation_directory (a_dir: STRING)
			-- Set eweasel_installation directory
		require
			dir_not_void: a_dir /= Void
			dir_not_empty: not a_dir.is_empty
		do
			eweasel_installation_directory := a_dir
		ensure
			dir_set: eweasel_installation_directory = a_dir
		end	
	
	set_control_file (a_file: STRING)
			-- Set control file location
		require
			file_not_void: a_file /= Void
			file_not_empty: not a_file.is_empty
		do
			control_file := a_file
		ensure
			file_set: control_file = a_file
		end
		
	set_catalog_file (a_file: STRING)
			-- Set control file location
		require
			file_not_void: a_file /= Void
			file_not_empty: not a_file.is_empty
		do
			catalog_file := a_file
		ensure
			file_set: catalog_file = a_file
		end
		
feature {NONE} -- Implementation

	file: PLAIN_TEXT_FILE
			-- File

	parse_file_info
			-- Parse information from `file'
		require
			file_not_void: file /= Void
		local
			l_xml: XM_DOCUMENT
			l_xml_util: XML_ROUTINES
		do
			create l_xml_util
			file.open_read
			file.read_stream (file.count)
			l_xml := l_xml_util.deserialize_text (file.last_string)
			file.close
			if l_xml /= Void then
				process_element (l_xml.root_element)
			end
		end		

	process_element (e: XM_ELEMENT)
			-- Read element `e'
		require
			e_not_void: e /= Void
		local
			l_elements: DS_LIST [XM_ELEMENT]
		do		
				-- Output directory
			if e.name.is_equal (output_location_tag) then
				set_output_directory (e.text)
			end
			
				-- Keep tests
			if e.name.is_equal (keep_tag) then
				set_keep_tests (e.text)
			end
			
				-- Keep EIFGENS
			if e.name.is_equal (keep_eifgens_tag) then
				set_keep_eifgens (e.text.is_equal ("True"))
			end
			
				-- Platform type
			if e.name.is_equal (platform_type_tag) then
				set_platform_type (e.text)
			end
			
				-- Include directory
			if e.name.is_equal (include_tag) then
				set_include_directory (e.text)
			end
			
				-- Eiffel installation directory
			if e.name.is_equal (installation_tag) then
				set_eiffel_installation_directory (e.text)
			end
			
				-- Eweasel installation directory
			if e.name.is_equal (weasel_installation_tag) then
				set_eweasel_installation_directory (e.text)
			end
			
				-- Control file
			if e.name.is_equal (control_file_tag) then
				set_control_file (e.text)
			end
			
				-- Catalog file
			if e.name.is_equal (catalog_file_tag) then
				set_catalog_file (e.text)
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

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class EWEASEL_CONFIGURATION
