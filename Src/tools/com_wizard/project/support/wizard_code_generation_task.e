indexing
	description: "Task used for generating Eiffel and C code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	title: STRING is "Generating code"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
			-- System descriptor must be generated first
		local
			l_library: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			if system_descriptor /= Void then
				-- Type descriptors generation
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
end -- class WIZARD_CODE_GENERATION_TASK

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
