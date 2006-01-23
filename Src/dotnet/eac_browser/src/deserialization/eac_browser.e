indexing
	description: "[
					
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EAC_BROWSER

inherit
	CACHE
		export
			{NONE}all
		end
	CACHE_PATH
		export
			{NONE}all
		end

feature -- Access

	assembly: STRING
			-- assembly

	dotnet_type: STRING
			-- dotnet type name

	consumed_type (an_assembly: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING): CONSUMED_TYPE is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
			a_file_name: STRING
		do
			a_file_name := absolute_type_path (relative_assembly_path (an_assembly), a_dotnet_type_name)
			if Consumed_types.has (a_file_name) then
				Result := Consumed_types.item (a_file_name)
			else
				create des
				Result ?= des.new_object_from_file (a_file_name)
				Consumed_types.extend (Result, a_file_name)
			end
		ensure
			non_void_consumed_type: Result /= Void
		end

	consumed_assembly (an_assembly: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_TYPES is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
			a_file_name: STRING
		do
			a_file_name := absolute_info_assembly_path (an_assembly)
			create des
			Result ?= des.new_object_from_file (a_file_name)
		ensure
			non_void_consumed_type: Result /= Void
		end
		
	referenced_assemblies (an_assembly: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_MAPPING is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
			a_file_name: STRING
		do
			a_file_name := absolute_referenced_assemblies_path (an_assembly)
			create des
			Result ?= des.new_object_from_file (a_file_name)
		ensure
			non_void_consumed_type: Result /= Void
		end

	referenced_assembly (an_assembly: CONSUMED_ASSEMBLY; assembly_id: INTEGER): CONSUMED_ASSEMBLY is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_an_assembly: an_assembly /= Void
			positive_assembly_id: assembly_id >= 0
		local
			l_cam: CONSUMED_ASSEMBLY_MAPPING
		do
			l_cam ?= referenced_assemblies (an_assembly)
			
			Result := l_cam.assemblies.item (assembly_id)
		end

	info: CACHE_INFO is
			-- Assembly information from EAC
		local
			des: EIFFEL_XML_DESERIALIZER
			info_file_name: STRING
		do
			info_file_name := Absolute_info_assemblies_path
			create des
			Result ?= des.new_object_from_file (info_file_name)
		ensure
			non_void_info: Result /= Void
		end

	find_consumed_type (an_assembly: CONSUMED_ASSEMBLY; a_referenced_type: CONSUMED_REFERENCED_TYPE): SPECIFIC_TYPE is
			-- return `CONSUMED_TYPE' associated to `a_referenced_type'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_a_referenced_type: a_referenced_type /= Void
		local
			l_referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			l_assembly_of_referenced_type: CONSUMED_ASSEMBLY
			l_referenced_consumed_type: CONSUMED_TYPE
--			l_array_referenced_type: CONSUMED_ARRAY_TYPE
		do
			l_referenced_assemblies := referenced_assemblies (an_assembly)
			l_assembly_of_referenced_type := l_referenced_assemblies.assemblies.item (a_referenced_type.assembly_id)
			
--			l_array_referenced_type ?= a_referenced_type
--			if l_array_referenced_type = Void then
				l_referenced_consumed_type := consumed_type (l_assembly_of_referenced_type, a_referenced_type.name)
--			else
--				l_array_referenced_type.name.replace_substring_all ("[]", "")
--				l_referenced_consumed_type := consumed_type (l_assembly_of_referenced_type, l_array_referenced_type.name)
--			end
			
			create Result.make (l_assembly_of_referenced_type, l_referenced_consumed_type)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class EIFFEL_NET_NAME
