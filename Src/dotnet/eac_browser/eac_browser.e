indexing
	description: "[
					
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	EAC_BROWSER

inherit
	CACHE

feature -- Access

	assembly: STRING
			-- assembly

	dotnet_type: STRING
			-- dotnet type name

	consumed_type (a_file_name: STRING): CONSUMED_TYPE is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_type: a_file_name /= Void
			not_empty_a_file_name: not a_file_name.is_empty
		local
			des: EIFFEL_XML_DESERIALIZER
		do
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

	consumed_assembly (a_file_name: STRING): CONSUMED_ASSEMBLY_TYPES is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_type: a_file_name /= Void
			not_empty_a_file_name: not a_file_name.is_empty
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			Result ?= des.new_object_from_file (a_file_name)
		ensure
			non_void_consumed_type: Result /= Void
		end
		
	referenced_assemblies (a_file_name: STRING): CONSUMED_ASSEMBLY_MAPPING is
			-- Consumed type corresponding to `a_file_name'.
		require
			non_void_type: a_file_name /= Void
			not_empty_a_file_name: not a_file_name.is_empty
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			Result ?= des.new_object_from_file (a_file_name)
		ensure
			non_void_consumed_type: Result /= Void
		end

	info: CACHE_INFO is
			-- Assembly information from EAC
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			Result ?= des.new_object_from_file ("E:\Eiffel52\dotnet\assemblies\info.xml")
		ensure
			non_void_info: Result /= Void
		end

end -- class EIFFEL_NET_NAME
