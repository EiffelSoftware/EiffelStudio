indexing
	description: "Read contents of an Eiffel project local assembly cache"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_CACHE_READER
	
inherit
	CACHE_READER
		redefine
			absolute_assembly_path_from_consumed_assembly,
			absolute_assembly_path,
			consumed_type
		end
		
create
	make_with_path
	
feature {NONE}

	make_with_path (a_path: STRING; a_clr_version: STRING) is
			-- Initialize cache reader to read from `a_path'.
		require
			a_path_not_void: a_path /= Void
			not_empty_path: not a_path.is_empty
		local
			a_op_env: OPERATING_ENVIRONMENT
		do
			create a_op_env
			local_cache_path := a_path.twin
			clr_version := a_clr_version
			-- Add trailing directory separator if needed.
			if not (local_cache_path.item (local_cache_path.count) = a_op_env.Directory_separator) then
				local_cache_path.append (a_op_env.Directory_separator.out)
			end	
		end
		
	absolute_assembly_path_from_consumed_assembly (ca: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `ca' types.
		local
			relative_path: STRING
			a_dir: DIRECTORY
		do
			relative_path := relative_assembly_path_from_consumed_assembly (ca)
			create Result.make (local_cache_path.count + relative_path.count)
			Result.append (local_cache_path)
			Result.append (relative_path)

			-- Check if path in local cache exists, if not then it must be in EAC
			create a_dir.make (Result)
			if not a_dir.exists then
				create Result.make (Eiffel_path.count + Eac_path.count + clr_version.count + 1 + relative_path.count)
				Result.append (Eiffel_path)
				Result.append (Eac_path)
				Result.append (clr_version)
				Result.append_character ('\')
				Result.append (relative_path)
			end
		end

	absolute_assembly_path (name: ASSEMBLY_NAME): STRING is
			-- Absolute path to folder containing `name' types.
			-- Always return a value even if `name' in not in EAC
		local
			relative_path: STRING
			a_dir: DIRECTORY
		do
			relative_path := relative_assembly_path (name)
			create Result.make (local_cache_path.count + relative_path.count)
			Result.append (local_cache_path)
			Result.append (relative_path)

			-- Check if path in local cache exists, if not then it must be in EAC
			create a_dir.make (Result)
			if not a_dir.exists then
				create Result.make (Eiffel_path.count + Eac_path.count + clr_version.count + 1 + relative_path.count)
				Result.append (Eiffel_path)
				Result.append (Eac_path)
				Result.append (clr_version)
				Result.append_character ('\')
				Result.append (relative_path)
			end
		end
		
	local_info_path: STRING is
			-- Absolute path of the info xml file.
		once
			create Result.make (local_cache_path.count + info_path.count)
			Result.append (local_cache_path + info_path)
		end
		
	local_cache_path: STRING
		-- Path to local cache path.
		
	local_info: LOCAL_CACHE_INFO is
			-- Information on local assembly cache content
			-- May be Void if not cache is present.
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (local_info_path)
			if des.successful then
				Result ?= des.deserialized_object
			end
		end

	total_consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY] is
			-- Array of consumed assemblies from both local and global caches.
		local
			a_info_assemblies, a_local_info_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			a_local_info: LOCAL_CACHE_INFO
			i, a_count: INTEGER
		do
			if is_initialized then
				a_info_assemblies := info.assemblies
				a_count := a_info_assemblies.count
				a_local_info := local_info
				if a_local_info /= Void then
					a_local_info_assemblies := local_info.assemblies
					a_count := a_count + a_local_info_assemblies.count
				end

				create Result.make (1, a_count)
				from 
					i := 1
				until
					i > a_info_assemblies.count
				loop
					Result.put (a_info_assemblies @ i, i)
					i := i + 1
				end

				if a_local_info_assemblies /= Void then
					from
						-- i is already correctly set from last loop
					until
						i > a_count
					loop
						Result.put (a_local_info_assemblies @ (i - a_info_assemblies.count), i)
						i := i + 1
					end
				end
			end
		end

	prefix_lookup: HASH_TABLE [STRING, STRING] is
			-- Used to get a prefix from an assembly name.
		once
			create Result.make (5)
			Result.compare_objects
		end

feature -- Access

	local_consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY] is
			-- Assemblies in local EAC
		do
			if is_initialized then
				Result := local_info.assemblies			
			end
		end

feature -- Conversion

	consumed_type (t: TYPE): CONSUMED_TYPE is
			-- Consumed type corresponding to `t'.
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (local_cache_path + "\" + relative_type_path (t))
			Result ?= des.deserialized_object
		end

	local_assembly_mapping (aname: ASSEMBLY_NAME): CONSUMED_ASSEMBLY_MAPPING is
			-- Local assembly information from EAC
		require
			non_void_name: aname /= Void
			valid_name: is_assembly_in_cache (aname)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (local_cache_path + "\" + relative_assembly_path (aname) + Assembly_mapping_file_name)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end

invariant
	local_cache_path_not_void: local_cache_path /= Void

end -- class LOCAL_CACHE_READER
