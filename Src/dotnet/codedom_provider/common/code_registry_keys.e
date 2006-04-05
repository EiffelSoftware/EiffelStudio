indexing
	description: "Eiffel Codedom Provider registry key entries"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := "Software\ISE\Eiffel56\"
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

	Compiler_file_name: STRING is "ecdpc.exe"
			-- Compiler file name

	Version: STRING is "5.6";
			-- Version number, change when different set of registry keys are needed.

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
