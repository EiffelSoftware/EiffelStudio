indexing
	description: ""
	status: "See notice at end of class"
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

feature -- Access

	last_created_file_name: STRING
			-- Last created file name

	last_created_header_file_name: STRING
			-- Last created header file name (for c files)

feature -- Basic operations

	create_file_name (a_generator: WIZARD_TYPE_GENERATOR; a_writer: WIZARD_WRITER) is
			-- Create new file name according to `a_generator' and `a_writer'.
		require
			non_void_generator: a_generator /= Void
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			a_generator.create_file_name (Current)
		end

	create_registration_file_name (a_generator: WIZARD_REGISTRATION_GENERATOR; a_writer: WIZARD_WRITER) is
			-- Create new file name according to `a_generator' and `a_writer'.
		require
			non_void_generator: a_generator /= Void
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			a_generator.create_file_name (Current)
		end

	create_c_alias_file_name (a_writer: WIZARD_WRITER_C_FILE) is
			-- Create new file name according to `a_writer'.
		require
			non_void_writer: a_writer /= Void
		do
			transient_writer := a_writer
			process_c_common
		end

	create_generated_mapper_file_name (a_writer: WIZARD_WRITER_CPP_CLASS) is
			-- File name for generated Eiffel to C structure mapper
		do
			last_created_header_file_name:= clone (shared_wizard_environment.destination_folder)
			last_created_header_file_name.append (Common)
			last_created_header_file_name.append_character (Directory_separator)
			last_created_file_name := clone (last_created_header_file_name)
			last_created_file_name.append (Clib)
			last_created_header_file_name.append (Include)
			last_created_header_file_name.append_character (Directory_separator)
			last_created_file_name.append_character (Directory_separator)
			last_created_header_file_name.append  (a_writer.name)
			last_created_header_file_name.append (Header_file_extension)
			last_created_file_name.append  (a_writer.name)
			last_created_file_name.append (Cpp_file_extension)
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
			process_eiffel_client_component
		end
		
	process_coclass_eiffel_server is
			-- Create filename for `a_generator'.
		do
			process_eiffel_server_component
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

	process_definition_file is
			-- Create filename for 'a_generator'
		do
			process_definition_file_writer
		end

feature {NONE} -- Implementation

	transient_writer: WIZARD_WRITER
			-- writer used to get filename.
			-- Used during visitor callback.

	process_c_common is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Common)
			process_c (False)
		end

	process_c_client  is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Client)
			process_c (True)
		end

	process_c_server  is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Server)
			process_c (True)
		end

	process_eiffel_interface is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		local
			an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Common)
			last_created_file_name.append_character (Directory_separator)
			last_created_file_name.append (Interfaces)
			last_created_file_name.append_character (Directory_separator)
			an_eiffel_writer ?= transient_writer
			check
				non_void_eiffel_writer: an_eiffel_writer /= Void
			end
			last_created_file_name.append (an_eiffel_writer.class_name)
			last_created_file_name.append (Eiffel_file_extension)
		end

	process_eiffel_structure is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		local
			an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Common)
			last_created_file_name.append_character (Directory_separator)
			last_created_file_name.append (Structures)
			last_created_file_name.append_character (Directory_separator)
			an_eiffel_writer ?= transient_writer
			check
				non_void_eiffel_writer: an_eiffel_writer /= Void
			end
			last_created_file_name.append (an_eiffel_writer.class_name)
			last_created_file_name.append (Eiffel_file_extension)
		end

	process_eiffel_client_component is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Client)
			process_component
		end

	process_eiffel_server_component is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		require
			non_void_writer: transient_writer /= Void
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Server)
			process_component
		end

	process_c (is_cpp: BOOLEAN) is
			-- Set `last_created_file_name' with file name for `a_generator'.
			-- Set `last_created_header_file_name' with header file name for `a_generator'.
		local
			a_c_writer: WIZARD_WRITER_C
		do
			last_created_file_name.append_character (Directory_separator)
			last_created_header_file_name := clone (last_created_file_name)
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

	process_component is
			-- Set `last_created_file_name' with file name for `a_generator'.
		local
			an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
		do
			last_created_file_name.append_character (Directory_separator)
			last_created_file_name.append (Component)
			last_created_file_name.append_character (Directory_separator)
			an_eiffel_writer ?= transient_writer
			check
				non_void_eiffel_writer: an_eiffel_writer /= Void
			end
			last_created_file_name.append (an_eiffel_writer.class_name)
			last_created_file_name.append (Eiffel_file_extension)
		end

	process_definition_file_writer is
			-- Set 'last_created_file_name' with 'system_name'.def
		require
			non_void_writer: transient_writer /= Void
		local
			a_definition_file_writer: WIZARD_WRITER_DEFINITION_FILE
		do
			last_created_file_name := clone (shared_wizard_environment.destination_folder)
			last_created_file_name.append (Server)
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
			valid_file_name: not a_filename.empty
			valid_syntax: a_filename.substring (a_filename.count - 1, a_filename.count).is_equal (Header_file_extension)
		do
			Result := clone (a_filename)
			Result.head (Result.count - 2)
			if is_cpp then
				Result.append (Cpp_file_extension)
			else
				Result.append (C_file_extension)
			end
		end

end -- class WIZARD_FILE_NAME_FACTORY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  