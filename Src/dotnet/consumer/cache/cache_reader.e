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

	SHARED_CONSUMED_ASSEMBLY_FACTORY
		export
			{NONE} all
		end

feature -- Access

	consumed_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO] is
			-- Assemblies in EAC (info.xml)
		local
			i: INTEGER
		do
			if is_initialized then
				Result := info.assemblies_info
			end
		end

	consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY] is
			-- Assemblies in EAC
		local
			l_consumed_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			i: INTEGER
		do
			if is_initialized then
				l_consumed_assemblies_info := info.assemblies_info
				create Result.make (1, l_consumed_assemblies_info.count)
				from
					i := 1
				until
					i > l_consumed_assemblies_info.count
				loop
					Result.put (l_consumed_assemblies_info.item (i).assembly, i)
					i := i + 1
				end
			end
		end

	consumed_assembly (an_assembly_name: STRING): CONSUMED_ASSEMBLY is
			-- Consumed assembly associated to `an_assembly_name'.
		require
			non_void_assembly_name: an_assembly_name /= Void
			not_empty_assembly_name: not an_assembly_name.is_empty
		local
			i: INTEGER
			l_consumed_assemblies: ARRAY [CONSUMED_ASSEMBLY]
		do
			if is_initialized then
				l_consumed_assemblies := consumed_assemblies
				from
					i := 1
				until
					i > l_consumed_assemblies.count or Result /= Void
				loop
					if l_consumed_assemblies.item (i).name.is_equal (an_assembly_name) then
						Result := l_consumed_assemblies.item (i)
					end
					i := i + 1
				end
			end
		end

	assembly_types (aname: ASSEMBLY_NAME): CONSUMED_ASSEMBLY_TYPES is
			-- Assembly information from EAC
		require
			non_void_name: aname /= Void
			valid_name: is_assembly_in_cache (aname)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path (aname) + Assembly_types_file_name)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end

	assembly_types_from_consumed_assembly (ca: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_TYPES is
			-- Assembly information from EAC for `ca'.
		require
			non_void_assembly: ca /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (ca) + Assembly_types_file_name)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end

	consumed_type_from_dotnet_type_name (ca: CONSUMED_ASSEMBLY; type: STRING): CONSUMED_TYPE is
			-- Type information from type `type' contained in `ca'
		require
			non_void_assembly: ca /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
			type_path: STRING
		do
			create des
			type_path := absolute_assembly_path_from_consumed_assembly (ca) + Classes_path + type + ".xml"			
			des.deserialize (type_path)
			Result ?= des.deserialized_object
		end

	consumed_type_from_consumed_referenced_type (ca: CONSUMED_ASSEMBLY; crt: CONSUMED_REFERENCED_TYPE): CONSUMED_TYPE is
			-- Type information from consumed referenced type `crt'.
		require
			non_void_referenced_type: crt /= Void
		local
			crt_ca: CONSUMED_ASSEMBLY
			ca_mapping: CONSUMED_ASSEMBLY_MAPPING
		do
			ca_mapping := assembly_mapping_from_consumed_assembly (ca)
			Result := consumed_type_from_dotnet_type_name (ca_mapping.assemblies @ crt.assembly_id, crt.name)
		ensure
			non_void_info: Result /= Void
		end

	assembly_mapping (aname: ASSEMBLY_NAME): CONSUMED_ASSEMBLY_MAPPING is
			-- Assembly information from EAC
		require
			non_void_name: aname /= Void
			valid_name: is_assembly_in_cache (aname)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path (aname) + Assembly_mapping_file_name)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end

	assembly_mapping_from_consumed_assembly (ca: CONSUMED_ASSEMBLY): CONSUMED_ASSEMBLY_MAPPING is
			-- Assembly information from EAC for `ca'.
		require
			non_void_name: ca /= Void
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_assembly_path_from_consumed_assembly (ca) + Assembly_mapping_file_name)
			Result ?= des.deserialized_object
		ensure
			non_void_info: Result /= Void
		end

	consumed_type (t: TYPE): CONSUMED_TYPE is
			-- Consumed type corresponding to `t'.
		require
			non_void_type: t /= Void
			valid_type: is_type_in_cache (t)
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			create des
			des.deserialize (absolute_type_path (t))
			Result ?= des.deserialized_object
		ensure
			non_void_consumed_type: Result /= Void
		end

	client_assemblies (assembly: CONSUMED_ASSEMBLY): ARRAY [CONSUMED_ASSEMBLY] is
			-- List of assemblies in EAC depending on `assembly'.
		require
			non_void_assembly: assembly /= Void
		local
			i, j, index: INTEGER
			assemblies: like consumed_assemblies
			converter: CACHE_CONVERSION
			a: ASSEMBLY
			names: NATIVE_ARRAY [ASSEMBLY_NAME]
			ca: CONSUMED_ASSEMBLY
		do
			create Result.make (1, 0)
			assemblies := consumed_assemblies
			index := 1
			create converter
			from
				i := 1
			until
				i > assemblies.count
			loop
				a := converter.assembly (assemblies.item (i))
				if converter.successful then
					names := a.get_referenced_assemblies
					from
						j := 0
					until
						j = names.count
					loop
						ca := Consumed_assembly_factory.consumed_assembly_from_name (names.item (j))
						if ca.is_equal (assembly) then
							Result.force (ca, index)
							index := index + 1
						end
						j := j + 1
					end
					i := i + 1			
				end
			end
		end

	initialize is
			-- Initialize cache reader.
		do
			(create {EIFFEL_XML_SERIALIZER}).serialize (create {CACHE_INFO}.make, Absolute_info_path)
		end
		
feature -- Status Report

	is_initialized: BOOLEAN is
			-- Is EAC correctly installed?
		do
			Result := (create {RAW_FILE}.make ((create {CACHE_PATH}).Absolute_info_path)).exists
		end

	is_assembly_in_cache (aname: ASSEMBLY_NAME): BOOLEAN is
			-- Is `aname' in EAC?
		require
			non_void_aname: aname /= Void
		do
			if aname.get_public_key_token /= Void then
				Result := (create {DIRECTORY}.make (absolute_assembly_path (aname))).exists
			end
		end

	is_assembly_in_cache_2 (assembly_location: STRING): BOOLEAN is
			-- Is `assembly_location' in EAC?
		require
			non_void_assembly_location: assembly_location /= Void
			not_empty_assembly_location: not assembly_location.is_empty
		local
			l_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			l_assembly_name: ASSEMBLY_NAME
			i: INTEGER
			relative_path: STRING
		do
			l_assemblies_info := consumed_assemblies_info
			from
				i := 1
			until
				i > l_assemblies_info.count or relative_path /= Void
			loop
				l_assembly_name := feature {ASSEMBLY_NAME}.get_assembly_name (assembly_location.to_cil)
				if l_assemblies_info.item (i).assembly.out.is_equal (create {STRING}.make_from_cil (l_assembly_name.full_name)) then
					if l_assemblies_info.item (i).location.is_equal (create {STRING}.make_from_cil (l_assembly_name.code_base)) then
						Result := True
						check
							directory_exists: (create {DIRECTORY}.make (absolute_assembly_path (l_assembly_name))).exists
						end
					end
				end
				i := i + 1
			end
		end

	is_type_in_cache (t: TYPE): BOOLEAN is
			-- Is `t' in EAC?
		do
			if t.assembly.get_name.get_public_key_token /= Void then
				Result := (create {RAW_FILE}.make (absolute_type_path (t))).exists
			end
		end

feature {CACHE_WRITER, EMITTER, CACHE_PATH} -- Implementation

	info: CACHE_INFO is
			-- Information on EAC content
		local
			des: EIFFEL_XML_DESERIALIZER
		do
			if not is_initialized then
				initialize
				create Result.make
			else
				create des
				des.deserialize (Absolute_info_path)
				if des.successful then
					Result ?= des.deserialized_object
				end
			end
		ensure
			non_void_if_initialized: is_initialized implies Result /= Void
		end

end -- class CACHE_READER
