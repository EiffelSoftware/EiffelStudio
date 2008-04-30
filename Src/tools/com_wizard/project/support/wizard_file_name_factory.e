indexing
	description: "File name factory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FILE_NAME_FACTORY

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	ANY

feature -- Access

	last_created_file_name: STRING
			-- Last created file name

	last_created_header_file_name: STRING
			-- Last created header file name (for c files)

	last_created_declaration_header_file_name: STRING is
			-- Last created declaration header file name (for cpp files)
		require
			non_void_last_created_header_file_name: last_created_header_file_name /= Void
		do
			Result := declaration_header_file_name (last_created_header_file_name)
		end

feature -- Basic operations

	create_file_name (a_generator: WIZARD_TYPE_GENERATOR; a_writer: WIZARD_WRITER) is
			-- Create new file name according to `a_generator' and `a_writer'.
		require
			non_void_generator: a_generator /= Void
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			a_generator.create_file_name (Current)
			transient_writer := Void
		end

	create_registration_file_name (a_generator: WIZARD_REGISTRATION_GENERATOR; a_writer: WIZARD_WRITER) is
			-- Create new file name according to `a_generator' and `a_writer'.
		require
			non_void_generator: a_generator /= Void
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			a_generator.create_file_name (Current)
			transient_writer := Void
		end

	create_c_alias_file_name (a_writer: WIZARD_WRITER_C_FILE) is
			-- Create new file name according to `a_writer'.
		require
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			process_c_common
			transient_writer := Void
		end

	create_definition_file_name (a_generator: WIZARD_DEFINITION_FILE_GENERATOR; a_writer: WIZARD_WRITER) is
			-- Create filename for 'a_generator'
		do
			transient_writer := a_writer
			process_definition_file_writer
			transient_writer := Void
		end

	create_generated_mapper_file_name (a_writer: WIZARD_WRITER_C) is
			-- File name for generated Eiffel to C structure mapper
		do
			transient_writer := a_writer
			if environment.is_client then
				create_directory_prefix (Client)
			else
				create_directory_prefix (Server)
			end
			process_c (True)
			transient_writer := Void
		end

	create_source_inner_class_name (a_writer: WIZARD_WRITER_C) is
			-- File name for inner class.
		do
			transient_writer := a_writer

			create_directory_prefix (Server)

			process_c (True)
			transient_writer := Void
		end

feature {WIZARD_TYPE_GENERATOR, WIZARD_REGISTRATION_GENERATOR} -- Visitor

	process_alias_c_client is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_alias_c_server is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_alias_eiffel_client is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_alias_eiffel_server is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_coclass_c_client is
			-- Create filename for `a_generator'.
		do
			process_c_client
		end

	process_coclass_c_server is
			-- Create filename for `a_generator'.
		do
			process_c_server
		end

	process_coclass_eiffel_client is
			-- Create filename for `a_generator'.
		do
			create_directory_prefix (Client)
			add_subdirectory (Component)
			process_eiffel
		end

	process_impl_interface_eiffel_client is
			-- Create filename for `a_generator'.
		do
			create_directory_prefix (Client)
			add_subdirectory (Interface_proxy)
			process_eiffel
		end

	process_coclass_eiffel_server is
			-- Create filename for `a_generator'.
		do
			create_directory_prefix (Server)
			add_subdirectory (Component)
			process_eiffel
		end

	process_impl_interface_eiffel_server is
			-- Create filename for `a_generator'.
		do
			create_directory_prefix (Server)
			add_subdirectory (Interface_stub)
			process_eiffel
		end

	process_enum_c_client is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_enum_c_server is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_enum_eiffel_client is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_enum_eiffel_server  is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_interface_c_client is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_interface_c_server is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_interface_eiffel_client is
			-- Create filename for `a_generator'.
		do
			process_eiffel_interface
		end

	process_interface_eiffel_server is
			-- Create filename for `a_generator'.
		do
			process_eiffel_interface
		end

	process_record_c_client is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_record_c_server is
			-- Create filename for `a_generator'.
		do
			process_c_common
		end

	process_record_eiffel_client is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_record_eiffel_server is
			-- Create filename for `a_generator'.
		do
			process_eiffel_structure
		end

	process_class_object is
			-- Create filename for `a_generator'.
		do
			process_c_server
		end

	process_registration_code is
			-- Create filename for 'a_generator'
		do
			process_c_server
		end

feature {NONE} -- Implementation

	declaration_header_file_name (a_name: STRING): STRING is
			-- Declaration header file name from definition header file name `a_name'
		require
			non_void_name: a_name /= Void
		local
			i, l_count: INTEGER
		do
			l_count := a_name.count
			if not a_name.is_empty then
				i := a_name.last_index_of ('\', l_count)
				create Result.make (l_count + 5)
				Result.append (a_name.substring (1, i))
				Result.append ("decl_")
				Result.append (a_name.substring (i + 1, l_count))
			else
				create Result.make_empty
			end
		ensure
			non_void_declaration_header_file_name: Result /= Void
		end

	process_c_common is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			create_directory_prefix (Common)
			process_c (False)
		end

	process_c_client  is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			create_directory_prefix (Client)
			process_c (True)
		end

	process_c_server  is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			create_directory_prefix (Server)
			process_c (True)
		end

	process_eiffel_interface is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			create_directory_prefix (Common)
			add_subdirectory (Interfaces)
			process_eiffel
		end

	process_eiffel_structure is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			create_directory_prefix (Common)
			add_subdirectory (Structures)
			process_eiffel
		end

	process_eiffel is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		local
			an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
		do
			last_created_file_name.append_character (Directory_separator)
			an_eiffel_writer ?= transient_writer
			check
				non_void_eiffel_writer: an_eiffel_writer /= Void
			end
			last_created_file_name.append (an_eiffel_writer.class_name)
			last_created_file_name.append (Eiffel_file_extension)
		end

	process_c (is_cpp: BOOLEAN) is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_transient_writer: transient_writer /= Void
		local
			a_c_writer: WIZARD_WRITER_C
		do
			last_created_file_name.append_character (Directory_separator)
			last_created_header_file_name := last_created_file_name.twin
			last_created_file_name.append (Clib)
			last_created_file_name.append_character (Directory_separator)
			a_c_writer ?= transient_writer
			check
				non_void_c_writer: a_c_writer /= Void
			end
			last_created_file_name.append (header_to_c_file_name (a_c_writer.header_file_name, is_cpp))
			last_created_header_file_name.append (Include)
			last_created_header_file_name.append_character (Directory_separator)
			last_created_header_file_name.append (a_c_writer.header_file_name)
		end

	process_definition_file_writer is
			-- Set 'last_created_file_name' with 'system_name'.def
		require
			non_void_writer: transient_writer /= Void
		local
			a_definition_file_writer: WIZARD_WRITER_DEFINITION_FILE
		do
			create_directory_prefix (Server)
			last_created_file_name.append_character (Directory_separator)
			a_definition_file_writer ?= transient_writer
			if a_definition_file_writer /= Void then
				last_created_file_name.append (a_definition_file_writer.system_name)
			end
			last_created_file_name.append (Definition_file_extension)
		end

	header_to_c_file_name (a_filename: STRING; is_cpp: BOOLEAN): STRING is
			-- Map header file name into C file name
		require
			non_void_file_name: a_filename /= Void
			valid_file_name: not a_filename.is_empty
			valid_syntax: a_filename.substring (a_filename.count - 1, a_filename.count).is_equal (Header_file_extension)
		do
			Result := a_filename.twin
			Result.keep_head (Result.count - 2)
			if is_cpp then
				Result.append (Cpp_file_extension)
			else
				Result.append (C_file_extension)
			end
		end

	create_directory_prefix (a_directory: STRING) is
			-- Prepend `last_created_file_name' with path to `a_directory'.
		do
			last_created_file_name := environment.destination_folder.twin
			last_created_file_name.append (a_directory)
		end

	add_subdirectory (a_subdirectory: STRING) is
			-- Prepend `last_created_file_name' with path to `a_subdirectory'.
		do
			last_created_file_name.append_character (Directory_separator)
			last_created_file_name.append (a_subdirectory)
		end

	transient_writer: WIZARD_WRITER;
			-- writer used to get filename.
			-- Used during visitor callback.

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
end -- class WIZARD_FILE_NAME_FACTORY

