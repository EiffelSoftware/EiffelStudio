indexing
	description: "Eiffel Codedom Provider registry key entries"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_REGISTRY_KEYS

feature -- Access

	Configurations_key: STRING is "Software\ISE\Eiffel Codedom Provider\Configurations"
			-- Key holding configuration path values
	
	Applications_key: STRING is "Software\ISE\Eiffel Codedom Provider\Applications"
			-- Key holding process guids
			
	Setup_key: STRING is "Software\ISE\Eiffel Codedom Provider\Setup"
			-- Key holding installation path value
	
	Compiler_key: STRING is
			-- Key holding compiler values
		once
			Result := "Software\ISE\Eiffel55\"
			Result.append (Compiler_file_name)
			Result.keep_head (Result.count - 4)
		end

	Installation_dir_value: STRING is "InstallDir"
			-- Name of string value that holds installation path
			-- This value is found under the setup key

	Ise_eiffel_value: STRING is "ISE_EIFFEL"
			-- Name of string value that holds ISE_EIFFEL environment variable
			-- This value is found under the compiler key

	Compiler_file_name: STRING is "ecdpc.exe"
			-- Compiler file name

end -- class CODE_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
