indexing
	description: "Code generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CODE_GENERATOR

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		end

	MEMORY
		rename
			free as memory_free
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize
		do
		end

feature -- Access

	Generation_title: STRING is "Generating Code"
			-- Generation title.

	Interface_generation_title: STRING is "Generating implemented interfaces"
			-- Interface generation message.

	Registration_code_generation_title: STRING is "Generating registration code"
			-- Registration code generation message.

	Runtime_functions_generation: STRING is "Generating Runtime functions"
			-- Runtime functions generation.

	Ace_file_generation: STRING is "Generating Ace and resource file"
			-- Ace and resource file genration.

	Makefile_generation: STRING is "Generating Makefiles"
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
			message_output.add_title (Current, Generation_title)
			create_generated_ce_mapper
			create_generated_ec_mapper
			create_alias_c_writer 
			if not Shared_wizard_environment.abort then
				process_type_descriptors 
			end
			full_collect
			if not Shared_wizard_environment.abort then
				generate_implemented_interfaces
			end
			full_collect
			if not Shared_wizard_environment.abort then
				generate_registration_code
			end
			full_collect
			if not Shared_wizard_environment.abort then
				generate_mappers_and_c_alias
			end
			full_collect
			if not Shared_wizard_environment.abort then
				generate_ace_and_resource 
			end
			full_collect
			if not Shared_wizard_environment.abort then
				generate_makefiles 
			end
			full_collect
			if not Shared_wizard_environment.abort then
				message_output.add_warning (Current, Generation_Successful)
			end
		end

	process_type_descriptors is
			-- Process type descriptors.
		local
			i, a_range: INTEGER
			C_client_visitor: WIZARD_C_CLIENT_VISITOR
			Eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR
			C_server_visitor: WIZARD_C_SERVER_VISITOR
			Eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR
		do
			create C_client_visitor
			create Eiffel_client_visitor
			create C_server_visitor
			create Eiffel_server_visitor

			from
				system_descriptor.start
			until
				system_descriptor.after or
				Shared_wizard_environment.abort
			loop
				if 
					not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
				then
					a_range := a_range + system_descriptor.library_descriptor_for_iteration.descriptors.count
				end
				system_descriptor.forth
			end
			progress_report.set_range (a_range)
			from
				system_descriptor.start
				progress_report.start
				progress_report.set_title (Generation_title)
			until
				system_descriptor.after or
				Shared_wizard_environment.abort
			loop
				if 
					not Non_generated_type_libraries.has (system_descriptor.library_descriptor_for_iteration.guid) 
				then
					from
						i := 1
					until
						i > system_descriptor.library_descriptor_for_iteration.descriptors.count or 
						Shared_wizard_environment.abort
					loop
						if system_descriptor.library_descriptor_for_iteration.descriptors.item (i) /= Void then
							if shared_wizard_environment.client then
								c_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								eiffel_client_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
							end
							if shared_wizard_environment.server then
								c_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
								eiffel_server_visitor.visit (system_descriptor.library_descriptor_for_iteration.descriptors.item (i))
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
			a_range: INTEGER
			an_interface: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR
			C_client_visitor: WIZARD_C_CLIENT_VISITOR
			Eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR
			C_server_visitor: WIZARD_C_SERVER_VISITOR
			Eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR
		do
			create C_client_visitor
			create Eiffel_client_visitor
			create C_server_visitor
			create Eiffel_server_visitor

			if Shared_wizard_environment.abort then
				message_output.add_message (Current, Generation_Aborted)
			else
				message_output.add_message (Current, Interface_generation_title)
				from
					system_descriptor.interfaces.start
					a_range := 0
				until
					system_descriptor.interfaces.after or
					Shared_wizard_environment.abort
				loop
					a_range := a_range + 1
					system_descriptor.interfaces.forth
				end

				from
					system_descriptor.interfaces.start
					progress_report.start
					progress_report.set_title (Interface_generation_title)
					progress_report.set_range (a_range)
				until
					system_descriptor.interfaces.after
					or Shared_wizard_environment.abort
				loop
					an_interface := system_descriptor.interfaces.item

					c_client_visitor.visit (an_interface)
					eiffel_client_visitor.visit (an_interface)

					c_server_visitor.visit (an_interface)
					eiffel_server_visitor.visit (an_interface)

					system_descriptor.interfaces.forth
					progress_report.step
				end
			end
		end

	generate_registration_code is
			-- Generating Registration code
		local
			outproc_reg_gen: WIZARD_OUTPROC_EIFFEL_REGISTRATION_GENERATOR
			inproc_reg_gen: WIZARD_INPROC_EIFFEL_REGISTRATION_GENERATOR
			c_reg_gen: WIZARD_C_REGISTRATION_CODE_GENERATOR
		do
			if Shared_wizard_environment.abort then
				message_output.add_message (Current, Generation_Aborted)
			elseif shared_wizard_environment.server then
				if shared_wizard_environment.out_of_process_server then
					create outproc_reg_gen
					outproc_reg_gen.generate
				end
				if shared_wizard_environment.in_process_server then
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
			generated_globals: WIZARD_GENERATED_RT_GLOBALS_GENERATOR
		do
			if Shared_wizard_environment.abort then
				message_output.add_message (Current, Generation_Aborted)
			else
				message_output.add_message (Current, Runtime_functions_generation)
				progress_report.start
				progress_report.set_title (Runtime_functions_generation)
				progress_report.set_range (9)
				Shared_file_name_factory.create_generated_mapper_file_name (Generated_ce_mapper_writer)
				progress_report.step
				Generated_ce_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
				progress_report.step
				Generated_ce_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)	
				progress_report.step
				Shared_file_name_factory.create_generated_mapper_file_name (Generated_ec_mapper_writer)
				progress_report.step
				Generated_ec_mapper_writer.save_file (Shared_file_name_factory.last_created_file_name)
				progress_report.step
				Generated_ec_mapper_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
				progress_report.step
				Shared_file_name_factory.create_c_alias_file_name (Alias_c_writer)
				progress_report.step
				Alias_c_writer.save_header_file (Shared_file_name_factory.last_created_header_file_name)
				progress_report.step
				create generated_globals.generate 
				progress_report.step
			end
			set_generated_ce_mapper (Void)
			set_generated_ec_mapper (Void)
			set_alias_c_writer (Void)
		end
	
	generate_ace_and_resource is
			-- Generating Ace and Resource files.
		local
			definition_file_generator: WIZARD_DEFINITION_FILE_GENERATOR
			ace_generator: WIZARD_ACE_FILE_GENERATOR
			resource_generator: WIZARD_RESOURCE_FILE_GENERATOR
		do
			create ace_generator
			create resource_generator
			if Shared_wizard_environment.abort then
				message_output.add_message (Current, Generation_Aborted)
			else
				message_output.add_message (Current, Ace_file_generation)
				if Shared_wizard_environment.server then
					ace_generator.generate (Server)
					resource_generator.generate (Server)
					if shared_wizard_environment.in_process_server then
						create definition_file_generator
						definition_file_generator.generate
					end

				else
					ace_generator.generate (Client)
					resource_generator.generate (Client)
				end
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
			if Shared_wizard_environment.abort then
				message_output.add_message (Current, Generation_Aborted)
			else
				message_output.add_message (Current, Makefile_generation)
				progress_report.set_title (Makefile_generation)
				execution_environment.change_working_directory (shared_wizard_environment.destination_folder)
				progress_report.start
				progress_report.set_range (3)

				if not shared_wizard_environment.abort then
					Clib_folder_name := clone (Client)
					Clib_folder_name.append_character (Directory_separator)
					Clib_folder_name.append (Clib)
					
					makefile_generator.generate (Clib_folder_name, CLib_name)
					progress_report.step
				end
				if not shared_wizard_environment.abort then
					Clib_folder_name := clone (Server)
					Clib_folder_name.append_character (Directory_separator)
					Clib_folder_name.append (Clib)
					
					makefile_generator.generate (Clib_folder_name, CLib_name)
					progress_report.step
				end
				if not shared_wizard_environment.abort then
					Clib_folder_name := clone (Common)
					Clib_folder_name.append_character (Directory_separator)
					Clib_folder_name.append (Clib)
					
					makefile_generator.generate (Clib_folder_name, CLib_name)
					progress_report.step
				end
				
			end
			makefile_generated := True
		end
		
end -- class WIZARD_CODE_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
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
