indexing
	description: "Shared generation environment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_GENERATION_ENVIRONMENT

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ANY

feature -- Access

	Shared_file_name_factory: WIZARD_FILE_NAME_FACTORY is
			-- Shared file name factory.
		once
			create Result
		end

	system_descriptor: WIZARD_SYSTEM_DESCRIPTOR is
			-- System descriptor.
		do
			Result := System_descriptor_cell.item
		end

	vartype_namer: WIZARD_VARTYPE_NAMER is
			-- Vartype to string mapper
		once
			create Result.make
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler
		once
			create Result
		end

	Formatter: STRING is "f"
			-- Message formatter.

	Generation_Successful: STRING is "Generation terminated successfully"
			-- Successful ending message

	Generation_Aborted: STRING is "Generation aborted"
			-- Successful ending message

feature {WIZARD_MANAGER} -- Element Change

	set_system_descriptor (a_descriptor: like system_descriptor) is
			-- Set `system_descriptor' with `a_descriptor'.
		do
			System_descriptor_cell.replace (a_descriptor)
		ensure
			descriptor_set: system_descriptor = a_descriptor
		end

feature {NONE} -- Implementation

	System_descriptor_cell: CELL [WIZARD_SYSTEM_DESCRIPTOR] is
			-- System descriptor shell
		once
			create Result.put (Void)
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
end -- class WIZARD_SHARED_GENERATION_ENVIRONMENT

