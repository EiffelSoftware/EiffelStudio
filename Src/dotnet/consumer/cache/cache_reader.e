indexing
	description: "Read content of Eiffel Assembly Cache"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_READER

inherit
	CACHE_PATH
		export
			{ANY} all
		end

create
	make

feature -- Access

	consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY] is
			-- Returns all completed consumed assemblies
		local
			l_assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
		do
			if is_initialized then
				create l_assemblies.make_from_array (info.assemblies)
				from
					l_assemblies.start
				until
					l_assemblies.after
				loop
					if not l_assemblies.item.is_consumed then
						l_assemblies.remove
					else
						l_assemblies.forth
					end
				end
				Result := l_assemblies
			end
		end

	consumed_assembly_from_path (a_path: STRING): CONSUMED_ASSEMBLY is
			-- Find a consumed assembly in cache that matches `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			i: INTEGER
			l_consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY]
		do
			l_consumed_assemblies := info.assemblies
			from
				i := 1
			until
				i > l_consumed_assemblies.count or Result /= Void
			loop
				if l_consumed_assemblies.item (i).has_same_path (a_path) then
					Result := l_consumed_assemblies.item (i)
				end
				i := i + 1
			end
		end

	assembly_types (a_assembly: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_TYPES is
			-- Assembly information from EAC
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly) + assembly_types_file_name, True)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end
		
	consumed_type_from_dotnet_type_name (a_assembly: CONSUMED_ASSEMBLY; type: STRING): CONSUMED_TYPE is
			-- Type information from type `type' contained in `ca'
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			des: EIFFEL_XML_DESERIALIZER
			type_path: STRING
		do
			create des
			type_path := absolute_assembly_path_from_consumed_assembly (a_assembly) + classes_path + type + ".xml"			
			des.deserialize (type_path, True)
			Result ?= des.deserialized_object
		ensure
			non_void_result: Result /= Void
		end
		
	consumed_type_from_consumed_referenced_type (a_assembly: CONSUMED_ASSEMBLY; a_crt: CONSUMED_REFERENCED_TYPE): CONSUMED_TYPE is
			-- Type information from consumed referenced type `crt'.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
			non_void_referenced_type: a_crt /= Void
		local
			l_ca_mapping: CONSUMED_ASSEMBLY_MAPPING
			l_name: STRING
		do
			l_ca_mapping := assembly_mapping_from_consumed_assembly (a_assembly)
			
			if a_crt.is_by_ref then
				l_name := a_crt.name.twin
				l_name.keep_head (l_name.count - 1)
			else
				l_name := a_crt.name
			end
			
			Result := consumed_type_from_dotnet_type_name (l_ca_mapping.assemblies @ a_crt.assembly_id, l_name)
		ensure
			non_void_info: Result /= Void
		end
		
	assembly_mapping_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_MAPPING is
			-- Assembly information from EAC for `a_assembly'.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: is_assembly_in_cache (a_assembly.gac_path, True)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly) + Assembly_mapping_file_name, False)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end
		
	consumed_type (a_type: TYPE): CONSUMED_TYPE is
			-- Consumed type corresponding to `t'.
		require
			non_void_type: a_type /= Void
			valid_type: is_type_in_cache (a_type)
		local
			l_des: EIFFEL_XML_DESERIALIZER
			l_ca: CONSUMED_ASSEMBLY
		do
			l_ca := consumed_assembly_from_path (a_type.assembly.location)
			if l_ca /= Void then
				create l_des
				l_des.deserialize (absolute_type_path (l_ca, a_type), True)
				Result ?= l_des.deserialized_object
			end
		ensure
			non_void_consumed_type: Result /= Void
		end
	
	client_assemblies (a_assembly: CONSUMED_ASSEMBLY): ARRAY [CONSUMED_ASSEMBLY] is
			-- List of assemblies in EAC depending on `a_assembly'.
		require
			non_void_assembly: a_assembly /= Void
		local
			l_client_assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_referenced_assemblies: like assembly_mapping_from_consumed_assembly
			l_assemblies: like consumed_assemblies
			i: INTEGER
		do
			l_assemblies := consumed_assemblies
			create l_client_assemblies.make (l_assemblies.count)
			from
				i := 1
			until
				i > l_assemblies.count
			loop
				l_referenced_assemblies := assembly_mapping_from_consumed_assembly (l_assemblies.item (i))
				if l_referenced_assemblies.assemblies.has (a_assembly) then
					l_client_assemblies.extend (l_assemblies.item (i))
				end
				i := i + 1
			end
			Result := l_client_assemblies
		end
		
feature -- Status Report

	is_initialized: BOOLEAN is
			-- Is EAC correctly installed?
		do
			Result := (create {RAW_FILE}.make (Absolute_info_path)).exists
		end

	is_assembly_in_cache (a_path: STRING; a_consumed: BOOLEAN): BOOLEAN is
			-- Is `a_path' in cache and if `a_consumed' has it been consumed
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
		do
			l_ca := consumed_assembly_from_path (a_path)
			Result := l_ca /= Void and (not a_consumed or l_ca.is_consumed)
		end
	
	is_type_in_cache (a_type: TYPE): BOOLEAN is
			-- Is `a_type' in EAC?
		require
			non_void_type: a_type /= Void
		local
			l_ca: CONSUMED_ASSEMBLY
			l_type_path: STRING
		do
			l_ca := consumed_assembly_from_path (a_type.assembly.location)
			if l_ca /= Void then
				l_type_path := absolute_type_path (l_ca, a_type)
				if l_type_path /= Void and not l_type_path.is_empty then
					Result := (create {RAW_FILE}.make (l_type_path)).exists	
				end
			end
		end
		
feature {CACHE_WRITER} -- Implementation

	info: CACHE_INFO is
			-- Information on EAC content
		require
			non_void_clr_version: clr_version /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			if is_initialized then
				create des
				des.deserialize (Absolute_info_path, False)
				if des.successful then
					Result ?= des.deserialized_object
				end
			end
			if Result = Void then
					-- cache info is not initalized or is outdated
				create Result.make (clr_version)
				(create {EIFFEL_XML_SERIALIZER}).serialize (Result, absolute_info_path)
			end
		ensure
			non_void_if_initialized: is_initialized implies Result /= Void
		end

end -- class CACHE_READER
