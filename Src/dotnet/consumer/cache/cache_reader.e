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
		
	SHARED_CACHE_MUTEX_GUARD
		export 
			{NONE} all
		end

create
	default_create

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
			l_path: STRING
			i: INTEGER
			l_consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY]
		do
			l_consumed_assemblies := info.assemblies
			from
				i := 1
			until
				i > l_consumed_assemblies.count or Result /= Void
			loop
				if l_path = Void then
					l_path := l_consumed_assemblies.item (i).format_path (a_path)
				end
				if l_consumed_assemblies.item (i).has_same_ready_formatted_path (l_path) then
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
			des: EIFFEL_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly) + assembly_types_file_name, 0)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end
		
	consumed_type_from_dotnet_type_name (a_assembly: CONSUMED_ASSEMBLY; a_type: STRING): CONSUMED_TYPE is
			-- Type information from type `type' contained in `ca'
		require
			a_assembly_not_void: a_assembly /= Void
			a_assembly_is_in_consumed_cache: is_assembly_in_cache (a_assembly.gac_path, True)
			a_type_not_void: a_type /= Void
			not_a_type_empty: not a_type.is_empty
		local
			l_des: EIFFEL_DESERIALIZER
			l_type_path: STRING
			l_pos: INTEGER
		do
			l_pos := type_position_from_type_name (a_assembly, a_type)
			if l_pos >= 0 then
				create l_des
				l_type_path := absolute_assembly_path_from_consumed_assembly (a_assembly) + classes_file_name			
				l_des.deserialize (l_type_path, l_pos)
				Result ?= l_des.deserialized_object
			end
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
			des: EIFFEL_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (a_assembly) + Assembly_mapping_file_name, 0)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end
		
	consumed_type (a_type: SYSTEM_TYPE): CONSUMED_TYPE is
			-- Consumed type corresponding to `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_type_is_in_cache: is_type_in_cache (a_type)
		local
			l_des: EIFFEL_DESERIALIZER
			l_ca: CONSUMED_ASSEMBLY
			l_pos: INTEGER
		do
			l_pos := type_position_from_type (a_type)
			if l_pos >= 0 then
				l_ca := consumed_assembly_from_path (a_type.assembly.location)
				if l_ca /= Void then
					create l_des
					l_des.deserialize (absolute_type_path (l_ca), l_pos)
					Result ?= l_des.deserialized_object					
				end				
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
	
	is_type_in_cache (a_type: SYSTEM_TYPE): BOOLEAN is
			-- Is `a_type' in EAC?
		require
			non_void_type: a_type /= Void
		local
			l_ca: CONSUMED_ASSEMBLY
			l_type_path: STRING
			l_pos: INTEGER			
		do
			l_pos := type_position_from_type (a_type)
			if l_pos >= 0 then
				l_ca := consumed_assembly_from_path (a_type.assembly.location)
				if l_ca /= Void then
					l_type_path := absolute_type_path (l_ca)
					if l_type_path /= Void and not l_type_path.is_empty then
						Result := (create {RAW_FILE}.make (l_type_path)).exists	
					end			
				end				
			end
		end
		
feature {CACHE_WRITER} -- Implementation

	info: CACHE_INFO is
			-- Information on EAC content
		require
			non_void_clr_version: clr_version /= Void
		local
			des: EIFFEL_DESERIALIZER
			l_ci: CACHE_INFO
		do
			guard.lock
			if internal_info.item = Void then
				if is_initialized then
					create des
					des.deserialize (Absolute_info_path, 0)
					if des.successful then
						l_ci ?= des.deserialized_object
						if l_ci /= Void then
							internal_info.put (l_ci)
						end
					end
				end
				if internal_info.item = Void then
						-- cache info is not initalized or is outdated
					internal_info.put (create {CACHE_INFO}.make)
					(create {EIFFEL_SERIALIZER}).serialize (internal_info.item, absolute_info_path, False)
				end
			end
			Result := internal_info.item
			guard.unlock
		ensure
			non_void_if_initialized: is_initialized implies Result /= Void
		end
		
feature {NONE} -- Implementation

	internal_info: CELL [CACHE_INFO] is
			-- cache `info'
		once
			create Result
		end

	type_position_from_type (a_type: SYSTEM_TYPE): INTEGER is
			-- retrieve type position from `a_type' in `a_assembly'.
			-- `-1' if not found.
		require
			a_type_not_void: a_type /= Void
		local
			l_ca: CONSUMED_ASSEMBLY
		do
			l_ca := consumed_assembly_from_path (a_type.assembly.location)
			if l_ca /= Void then
				Result := type_position_from_type_name (l_ca, a_type.full_name)
			else
				Result := -1
			end
		ensure
			valid_result: Result =-1 or Result >= 0
		end

	type_position_from_type_name (a_assembly: CONSUMED_ASSEMBLY; a_type: STRING): INTEGER is
			-- retrieve type position from `a_type' in `a_assembly'.
			-- `-1' if not found.
		require
			a_assembly_not_void: a_assembly /= Void
			a_type_not_void: a_type /= Void
			not_a_type_empty: not a_type.is_empty
		local
			l_types: like assembly_types
			i: INTEGER
		do
			l_types := assembly_types (a_assembly)
			Result := -1
			if l_types /= Void then
				from
					i := 1
				until
					i > l_types.count
					or else Result >= 0
					or else l_types.dotnet_names @ i = Void
				loop
					if (l_types.dotnet_names @ i).is_equal (a_type) then
						Result := l_types.positions.item (i)
					else
						i := i + 1
					end
				end
			end
		ensure
			valid_result: Result =-1 or Result >= 0
		end

end -- class CACHE_READER
