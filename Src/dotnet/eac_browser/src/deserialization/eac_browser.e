indexing
	description: "[
					
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	EAC_BROWSER

inherit
	CACHE
	CACHE_PATH

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
			l_array_referenced_type: CONSUMED_ARRAY_TYPE
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

end -- class EIFFEL_NET_NAME
