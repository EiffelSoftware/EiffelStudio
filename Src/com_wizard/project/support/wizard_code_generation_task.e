indexing
	description: "Task used for generating Eiffel and C code"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CODE_GENERATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES
		export
			{NONE} all
		end

feature -- Access

	title: STRING is "Generating Code:"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
			-- System descriptor must be generated first
		local
			l_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			check
				non_void_descriptor: system_descriptor /= Void
			end
			-- Type descriptors generation
			create library_guids.make (10)
			from
				system_descriptor.start
			until
				system_descriptor.after or environment.abort
			loop
				l_library := system_descriptor.library_descriptor_for_iteration
				if not Non_generated_type_libraries.has (l_library.guid) then
					Result := Result + l_library.descriptors.count
				end
				system_descriptor.forth
			end
			
			 -- Implemented interfaces generation
			Result := Result + system_descriptor.interfaces.count
			
			 -- Mapper and C aliases generation
			Result := Result + 9

			 -- Makefiles generation
			Result := Result + 3
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		local
			l_code_generator: WIZARD_CODE_GENERATOR
		do
			create l_code_generator.make
			l_code_generator.generate
			compiler.set_ace_file_generated (l_code_generator.ace_file_generated)
			compiler.set_resource_file_generated (l_code_generator.resource_file_generated)
			compiler.set_makefile_generated (l_code_generator.makefile_generated)
			l_code_generator := Void
		end

	library_counted (a_guid: ECOM_GUID): BOOLEAN is
			-- Were steps for library with GUID `a_guid' already counted?
		do
			Result := Non_generated_type_libraries.has (a_guid) or library_guids.has (a_guid)
		end

feature {NONE} -- Private Access

	library_guids: ARRAYED_LIST [ECOM_GUID]
			-- GUIDs of type libraries whose steps have already been counted

end -- class WIZARD_CODE_GENERATION_TASK
