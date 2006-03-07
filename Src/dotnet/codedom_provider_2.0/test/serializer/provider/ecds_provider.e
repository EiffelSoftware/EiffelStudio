indexing
	description: "[
			Pseudo codedom provider used to serialize codedom trees
		]"

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

end -- class ECDS_PROVIDER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------