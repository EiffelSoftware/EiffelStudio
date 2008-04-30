indexing
	description: "Code generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CODE_GENERATOR

inherit
	WIZARD_SHARED_FILE_NAMES
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize
		do
		end

feature -- Access

	Generation_title: STRING is "Generating code"
			-- Generation title.

	Interface_generation_title: STRING is "Generating implemented interfaces"
			-- Interface generation message.

	Registration_code_generation_title: STRING is "Generating registration code"
			-- Registration code generation message.

	Runtime_functions_generation: STRING is "Generating runtime functions"
			-- Runtime functions generation.

	Ace_file_generation: STRING is "Generating Ace and resource files"
			-- Ace and resource file genration.

	Makefile_generation: STRING is "Generating makefiles"
			-- Makefiles genration.

	ace_file_generated: BOOLEAN
			-- Was generated project ace file generated?

	resource_file_generated: BOOLEAN
			-- Was generated project resource file generated?

	makefile_generated: BOOLEAN
			-- Were Makefiles generated?

feature -- Basic operations

	generate is
			-- Code generation
		do
			message_output.add_title (Generation_title)
			create_alias_c_writer
			if not environment.abort then
				process_type_descriptors
			end
			if not environment.abort then
				generate_implemented_interfaces
			end
			if not environment.abort then
				generate_registration_code
			end
			if not environment.abort then
				generate_mappers_and_c_alias
			end
			if not environment.abort then
				generate_ace_and_resource
			end
			if not environment.abort then
				generate_makefiles
			end
		end

	process_type_descriptors is
			-- Process type descriptors.
		local
			i: INTEGER
			C_client_visitor: WIZARD_C_CLIENT_VISITOR
			Eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR
			C_server_visitor: WIZARD_C_SERVER_VISITOR
			Eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR
			l_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR
			l_descriptors: ARRAY [WIZARD_TYPE_DESCRIPTOR]
			l_type: WIZARD_TYPE_DESCRIPTOR
		do
			create C_client_visitor
			create Eiffel_client_visitor
			create C_server_visitor
			create Eiffel_server_visitor

			from
				system_descriptor.start
				progress_report.set_title (Generation_title)
			until
				system_descriptor.after or
				environment.abort
			loop
				l_library := system_descriptor.library_descriptor_for_iteration
				if not Non_generated_type_libraries.has (l_library.guid) then
					l_descriptors := l_library.descriptors
					from
						i := 1
					until
						i > l_descriptors.count or environment.abort
					loop
						l_type := l_descriptors.item (i)
						if l_type /= Void then
							if environment.is_client then
								c_client_visitor.visit (l_type)
								eiffel_client_visitor.visit (l_type)
							else
								c_server_visitor.visit (l_type)
								eiffel_server_visitor.visit (l_type)
							end
						end
						i := i + 1
						progress_report.step
					end
				end
				system_descriptor.forth
			end
		end

	generate_implemented_interfaces is
			-- Generate implemented interfaces.
		local
			l_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
			l_c_client_visitor: WIZARD_C_CLIENT_VISITOR
			l_eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR
			l_c_server_visitor: WIZARD_C_SERVER_VISITOR
			l_eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR
			l_interfaces: LIST [WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR]
		do
			message_output.add_message (Interface_generation_title)

			create l_c_client_visitor
			create l_eiffel_client_visitor
			create l_c_server_visitor
			create l_eiffel_server_visitor

			l_interfaces := system_descriptor.interfaces
			from
				l_interfaces.start
				progress_report.set_title (Interface_generation_title)
			until
				l_interfaces.after or environment.abort
			loop
				l_interface := l_interfaces.item
				l_c_client_visitor.visit (l_interface)
				l_eiffel_client_visitor.visit (l_interface)
				l_c_server_visitor.visit (l_interface)
				l_eiffel_server_visitor.visit (l_interface)
				l_interfaces.forth
				progress_report.step
			end
		end

	generate_registration_code is
			-- Generating Registration code
		local
			outproc_reg_gen: WIZARD_OUTPROC_EIFFEL_REGISTRATION_GENERATOR
			inproc_reg_gen: WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR
			c_reg_gen: WIZARD_C_REGISTRATION_CODE_GENERATOR
		do
			if environment.abort then
				message_output.add_message (Generation_Aborted)
			elseif not environment.is_client and not system_descriptor.coclasses.is_empty then
				if environment.is_out_of_process then
					create outproc_reg_gen
					outproc_reg_gen.generate
				end
				if environment.is_in_process then
					create inproc_reg_gen
					inproc_reg_gen.generate
				end
				create c_reg_gen
				c_reg_gen.generate
			end
		end

	generate_mappers_and_c_alias is
			-- Generating extra files
		local
			l_globals: WIZARD_GENERATED_RT_GLOBALS_GENERATOR
			l_mapper: WIZARD_WRITER_MAPPER_CLASS
		do
			message_output.add_message (Runtime_functions_generation)
			progress_report.set_title (Runtime_functions_generation)

			from
				Generated_ce_mappers.start
			until
				Generated_ce_mappers.after
			loop
				l_mapper := Generated_ce_mappers.item
				Shared_file_name_factory.create_generated_mapper_file_name (l_mapper)
				l_mapper.save_file (Shared_file_name_factory.last_created_file_name)
				l_mapper.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
				l_mapper.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)
				Generated_ce_mappers.forth
			end

			progress_report.step

			from
				Generated_ec_mappers.start
			until
				Generated_ec_mappers.after
			loop
				l_mapper := Generated_ec_mappers.item
				Shared_file_name_factory.create_generated_mapper_file_name (l_mapper)
				l_mapper.save_file (Shared_file_name_factory.last_created_file_name)
				l_mapper.save_declaration_header_file (Shared_file_name_factory.last_created_declaration_header_file_name)
				l_mapper.save_definition_header_file (Shared_file_name_factory.last_created_header_file_name)
				Generated_ec_mappers.forth
			end

			progress_report.step
			Shared_file_name_factory.create_c_alias_file_name (Alias_c_writer)
			progress_report.step
			Alias_c_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
			progress_report.step
			create l_globals.generate
			progress_report.step
			Generated_ce_mappers.wipe_out
			Generated_ec_mappers.wipe_out
			set_alias_c_writer (Void)
		end

	generate_ace_and_resource is
			-- Generating Ace and Resource files.
		local
			definition_file_generator: WIZARD_DEFINITION_FILE_GENERATOR
			ace_generator: WIZARD_ECF_FILE_GENERATOR
			resource_generator: WIZARD_RESOURCE_FILE_GENERATOR
		do
			create ace_generator
			create resource_generator
			message_output.add_message (Ace_file_generation)
			if not environment.is_client then
				ace_generator.generate (Server)
				resource_generator.generate (Server)
				if environment.is_in_process and not system_descriptor.coclasses.is_empty then
					create definition_file_generator
					definition_file_generator.generate
				end
			else
				ace_generator.generate (Client)
				resource_generator.generate (Client)
			end
			ace_file_generated := True
			resource_file_generated := True
		end

	generate_makefiles is
			-- Generate Makefiles.
		local
			makefile_generator: WIZARD_MAKEFILE_GENERATOR
			Clib_folder_name: STRING
		do
			create makefile_generator
			message_output.add_message (Makefile_generation)
			progress_report.set_title (Makefile_generation)
			Env.change_working_directory (environment.destination_folder)

			Clib_folder_name := Client.twin
			Clib_folder_name.append_character (Directory_separator)
			Clib_folder_name.append (Clib)
			makefile_generator.generate (Clib_folder_name, CLib_name)
			progress_report.step

			Clib_folder_name := Server.twin
			Clib_folder_name.append_character (Directory_separator)
			Clib_folder_name.append (Clib)
			makefile_generator.generate (Clib_folder_name, CLib_name)
			progress_report.step

			Clib_folder_name := Common.twin
			Clib_folder_name.append_character (Directory_separator)
			Clib_folder_name.append (Clib)
			makefile_generator.generate (Clib_folder_name, CLib_name)
			progress_report.step

			makefile_generated := True
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
end -- class WIZARD_CODE_GENERATOR

