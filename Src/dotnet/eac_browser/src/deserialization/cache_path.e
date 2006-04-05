indexing
	description: "Path to various EAC files"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_PATH

inherit
	COMMON_PATH
	EAC_COMMON_PATH

feature -- Access

	relative_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to folder containing `an_assembly' types relative to `Eac_path'.
			-- Always return a value even if `an_assembly' in not in EAC.
		require
			non_void_assembly: an_assembly /= Void
		local
			version: STRING
			culture: STRING
		do
			create Result.make (an_assembly.name.count + an_assembly.version.count + an_assembly.culture.count + an_assembly.key.count + 4)
			Result.append (an_assembly.name)
			Result.append ("-")
			version := clone (an_assembly.version)
			version.replace_substring_all (".", "_")
			Result.append (version)
			Result.append ("-")
			culture := an_assembly.culture
			culture.to_lower
			if not culture.is_equal ("neutral") then
				Result.append (culture)
			end
			Result.append ("-")
			Result.append (an_assembly.key)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
	
	absolute_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `an_assembly' types.
			-- Always return a value even if `an_assembly' in not in EAC.
		require
			non_void_assembly: an_assembly /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + relative_path.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	relative_type_path (assembly_relative_path: STRING; a_dotnet_type_name: STRING): STRING is
			-- Path to file describing `t' relative to `Eac_path'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_assembly_relative_path: assembly_relative_path /= Void
			not_empty_assembly_relative_path: not assembly_relative_path.is_empty
		do
			create Result.make (assembly_relative_path.count + Classes_path.count + a_dotnet_type_name.count + 4)
			Result.append (assembly_relative_path)
			Result.append (Classes_path)
			Result.append (a_dotnet_type_name)
			Result.append (".xml")
		ensure
			non_void_result: Result /= Void
		end

	absolute_type_path (assembly_relative_path: STRING; a_dotnet_type_name: STRING): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'.
			-- Return Void if `a_dotnet_type_name' is not in EAC.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_assembly_relative_path: assembly_relative_path /= Void
			not_empty_assembly_relative_path: not assembly_relative_path.is_empty
		local
			type_relative_path: STRING
		do
			type_relative_path := relative_type_path (assembly_relative_path, a_dotnet_type_name)
			create Result.make (Eiffel_path.count + Eac_path.count + type_relative_path.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (type_relative_path)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

	absolute_referenced_assemblies_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'
			-- Return Void if `an_assembly' is not in EAC.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			assembly_relative_path: STRING
		do
			assembly_relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_mapping_file_name.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (assembly_relative_path)
			Result.append (Assembly_mapping_file_name)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

feature -- Access

	absolute_info_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'.
			-- Return Void if `an_assembly' is not in EAC.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			assembly_relative_path: STRING
		do
			assembly_relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_original_types_file_name.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (assembly_relative_path)
			Result.append (Assembly_original_types_file_name)
			
			if not (create {RAW_FILE}.make (Result)).exists then
				create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_types_file_name.count + 4)
				Result.append (Eiffel_path)
				Result.append (Eac_path)
				Result.append (assembly_relative_path)
				Result.append (Assembly_types_file_name)
				
				if not (create {RAW_FILE}.make (Result)).exists then
					Result := Void
				end
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end
		
	absolute_info_assemblies_path: STRING is
			-- Absolute path to EAC assemblies file info.
		once
			create Result.make (Eiffel_path.count + Eac_path.count + Info_path.count)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (Info_path)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
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


end -- class CACHE_PATH
