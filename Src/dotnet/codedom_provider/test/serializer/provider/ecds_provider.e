indexing
	description: "[
			Pseudo codedom provider used to serialize codedom trees
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ECDS_PROVIDER

inherit
	SYSTEM_DLL_CODE_DOM_PROVIDER
		redefine
			file_extension,
			language_options
		end
	
	ANY

create 
	default_create

feature -- Access

	file_extension: SYSTEM_STRING is
			-- Get the file name extension to use when creating source code files.
			-- Files passed to codeDomGenerator.
		once
			Result := ".es"
		end

	language_options: SYSTEM_DLL_LANGUAGE_OPTIONS is
			-- Get a language features identifier.
		once
			Result := {SYSTEM_DLL_LANGUAGE_OPTIONS}.case_insensitive
		end
		
feature -- Basic Operations

	create_generator: ECDS_CODE_GENERATOR is
			-- Create an instance of the Eiffel for .NET code code_generator.
		do
			create Result
		end

	create_compiler: ECDS_CODE_COMPILER is
			-- Create an instance of the Eiffel for .NET code compiler.
		do
			create Result
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


end -- class ECDS_PROVIDER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------