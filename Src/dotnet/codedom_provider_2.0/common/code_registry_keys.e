indexing
	description: "Eiffel Codedom Provider registry key entries"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_REGISTRY_KEYS

feature -- Access

	Configurations_key: STRING is 
			-- Key holding configuration path values
		once
			Result := "Software\ISE\Eiffel Codedom Provider\" + Version + "\Configurations"
		end
	
	Applications_key: STRING is
			-- Key holding process guids
		once
			Result := "Software\ISE\Eiffel Codedom Provider\" + Version + "\Applications"
		end
			
	Setup_key: STRING is
			-- Key holding installation path value
		once
			Result := "Software\ISE\Eiffel Codedom Provider\" + Version + "\Setup"
		end
	
	Compiler_key: STRING is
			-- Key holding compiler values
		once
			Result := "Software\ISE\Eiffel57\"
			Result.append (Compiler_file_name)
			Result.keep_head (Result.count - 4)
		end

	Precompile_ace_files_key: STRING is
			-- Key holding precompiled libraries ace file names
		once
			Result := "Software\ISE\Eiffel Codedom Provider\" + Version + "\Precompile\Ace Files"
		end

	Precompile_folders_key: STRING is
			-- Key holding precompiled libraries paths
		once
			Result := "Software\ISE\Eiffel Codedom Provider\" + Version + "\Precompile\Folders"
		end

	Installation_dir_value: STRING is "InstallDir"
			-- Name of string value that holds installation path
			-- This value is found under the setup key

	Ise_eiffel_value: STRING is "ISE_EIFFEL"
			-- Name of string value that holds ISE_EIFFEL environment variable
			-- This value is found under the compiler key

	Ise_platform_value: STRING is "ISE_PLATFORM"
			-- Name of string value that holds ISE_PLATFORM environment variable
			-- This value is found under the compiler key

	Compiler_file_name: STRING is "ecdpc.exe"
			-- Compiler file name

	Version: STRING is "5.7"
			-- Version number, change when different set of registry keys are needed.

end -- class CODE_REGISTRY_KEYS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
