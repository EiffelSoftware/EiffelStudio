indexing
	description: "[
		Representation of an assembly as seen by universe. It simply inherits from CLUSTER_I
		and only adds information specific to an assembly, i.e. name, culture, version
		and public key token.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_I
	
inherit
	CLUSTER_I
		undefine
			format
		redefine
			classes, copy_old_cluster, is_assembly
		end

	ASSEMBLY_INFO
		rename
			make as assembly_info_make
		export
			{NONE} assembly_info_make, set_culture, set_version, set_public_key_token
		end

create
	make_from_ast,
	make_from_consumed_assembly,
	make_from_precompiled_cluster
	
feature {NONE} -- Initialization

	make_from_ast (a: ASSEMBLY_SD) is
			-- Create Current from data in `a'.
		require
			a_not_void: a /= Void
		local
			l_assembly_directory: STRING
			l_assembly_location: PATH_NAME
			l_env: EIFFEL_ENV
		do
				-- Initialize assembly info.
			cluster_name := a.cluster_name
			assembly_info_make (a.assembly_name)
			if a.version /= Void and a.culture /= Void and a.public_key_token /= Void then
				set_version (a.version)
				set_culture (a.culture)
				set_public_key_token (a.public_key_token)
			else
				is_local := True
				initialize_from_local_assembly (a.assembly_name)
			end

			prefix_name := a.prefix_name
			if prefix_name /= Void then
				prefix_name := prefix_name.as_lower
			end

			is_library := True
			is_recursive := True
			hide_implementation := True
			
				-- Initialize location of XML files representing classes
				-- of current assembly.
			create l_env
			l_assembly_directory := build_assembly_path (assembly_name, version, culture,
				public_key_token)
				
			if is_local then
					-- Look in EIFGEN/Assemblies.
				l_assembly_location := clone (Local_assembly_path)
			else
					-- Look in EAC.
				l_assembly_location := clone (l_env.Assemblies_path)
			end
			l_assembly_location.extend (l_assembly_directory)
			create dollar_path.make_from_string (l_assembly_location)
			update_path
			
			consume_assemblies

				-- Necessary initialization to preserve inherited invariants.
			create renamings.make
			create ignore.make
			create sub_clusters.make (0)
			create classes.make (0)
		ensure
			cluster_name_set: cluster_name = a.cluster_name
			assembly_name_set: not is_local implies (assembly_name = a.assembly_name)
			version_set: not is_local implies version = a.version
			culture: not is_local implies culture = a.culture
			public_key_token: not is_local implies public_key_token = a.public_key_token
		end

	make_from_consumed_assembly (l_ass: CONSUMED_ASSEMBLY) is
			-- Create Current from data in `l_ass'.
		local
			l_assembly_directory: STRING
			l_assembly_location: PATH_NAME
			l_env: EIFFEL_ENV
		do
				-- Initialize assembly info.
			cluster_name := l_ass.out
			assembly_info_make (l_ass.name)
			if l_ass.version /= Void and l_ass.culture /= Void and l_ass.key /= Void then
				set_version (l_ass.version)
				set_culture (l_ass.culture)
				set_public_key_token (l_ass.key)
			else
				is_local := True
				initialize_from_local_assembly (l_ass.name)
			end

			prefix_name := clone (l_ass.name) + "_"
			prefix_name.replace_substring_all (".", "_")
			prefix_name := prefix_name.as_lower

			is_library := True
			is_recursive := True
			hide_implementation := True
			
				-- Initialize location of XML files representing classes
				-- of current assembly.
			create l_env
			l_assembly_directory := build_assembly_path (assembly_name, version, culture,
				public_key_token)
				
			if is_local then
					-- Look in EIFGEN/Assemblies.
				l_assembly_location := clone (Local_assembly_path)
			else
					-- Look in EAC.
				l_assembly_location := clone (l_env.Assemblies_path)
			end
			l_assembly_location.extend (l_assembly_directory)
			create dollar_path.make_from_string (l_assembly_location)
			update_path
			
			consume_assemblies

				-- Necessary initialization to preserve inherited invariants.
			create renamings.make
			create ignore.make
			create sub_clusters.make (0)
			create classes.make (0)
		ensure
			cluster_name_set: cluster_name /= Void
			assembly_name_set: not is_local implies (assembly_name = l_ass.name)
			version_set: not is_local implies version = l_ass.version
			culture: not is_local implies culture = l_ass.culture
			public_key_token: not is_local implies public_key_token = l_ass.key
		end
		
feature -- Comparison

	same_assembly_as (other: like Current): BOOLEAN is
			-- Compare assembly info only.
		require
			other_not_void: other /= Void
		do
			Result := assembly_name.is_equal (other.assembly_name) and then
				equal (prefix_name, other.prefix_name) and then
				equal (version, other.version) and then
				equal (culture, other.culture) and then
				equal (public_key_token, other.public_key_token)
		end
		
feature -- Access

	prefix_name: STRING
			-- Prefix to all class names in current assembly.

	classes: HASH_TABLE [EXTERNAL_CLASS_I, STRING]
			-- List all classes available in current assembly
			-- indexed by their Eiffel names.

	dotnet_classes: HASH_TABLE [EXTERNAL_CLASS_I, STRING]
			-- List all classes available in current assemblly
			-- Indexed by theit Dotnet names.

	referenced_assemblies: ARRAY [ASSEMBLY_I]
			-- List of referenced assemblies in Current assembly. 
			-- Indexed by assembly ID.

	is_local: BOOLEAN
			-- Is current assembly a local assembly.
			
	assembly_path: STRING
			-- Path of current assembly if it is a local assembly.

	is_assembly: BOOLEAN is True
			-- Is current an instance of ASSEMBLY_I?

feature -- Copy

	copy_old_cluster (old_assembly: like Current) is
			-- Copy all information of `old_assembly' into Current
			-- except ignore and renaming clauses.
		do
			Precursor {CLUSTER_I} (old_assembly)
			assembly_name := old_assembly.assembly_name
			prefix_name := old_assembly.prefix_name
			version := old_assembly.version
			culture := old_assembly.culture
			public_key_token := old_assembly.public_key_token
			dotnet_classes := old_assembly.dotnet_classes
			referenced_assemblies := old_assembly.referenced_assemblies
			is_local := old_assembly.is_local
			assembly_path := old_assembly.assembly_path
		end
		
feature -- Initialization

	import_data is
			-- Given current assembly description, found all
			-- available classes and initializes `classes'.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
			l_env: EIFFEL_ENV
			l_assembly_location, l_local_path: PATH_NAME
			l_path: STRING
			l_types_file, l_reference_file: FILE_NAME
			l_location: FILE_NAME
			
			l_types: CONSUMED_ASSEMBLY_TYPES
			l_referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			l_class: EXTERNAL_CLASS_I
			l_assembly: ASSEMBLY_I
			l_cons_assembly: CONSUMED_ASSEMBLY
			i, nb: INTEGER
			
			l_class_name, l_external_name: STRING
		do
			create l_reader
			create l_env
			
				-- We first read all XML files to ensure that they all exist, otherwise
				-- we raise an error.
			create l_types_file.make_from_string (clone (path))
			l_types_file.set_file_name (type_list_file_name)
			l_types ?= l_reader.new_object_from_file (l_types_file)

			create l_reference_file.make_from_string (clone (path))
			l_reference_file.set_file_name (referenced_assemblies_file_name)
			l_referenced_assemblies ?= l_reader.new_object_from_file (l_reference_file)

			if l_types = Void or l_referenced_assemblies = Void then
					-- Raise an error and stop processing as we cannot continue
					-- with missing information.
				if is_local then
					Error_handler.insert_error (create {VD61}.make (Current))	
					Error_handler.raise_error
				else
						-- Let's try to import it and see if it works this time
					initialize_from_gac_assembly
					l_types ?= l_reader.new_object_from_file (l_types_file)
					l_referenced_assemblies ?= l_reader.new_object_from_file (l_reference_file)
					if l_types = Void or l_referenced_assemblies = Void then
						Error_handler.insert_error (create {VD61}.make (Current))	
						Error_handler.raise_error
					end
				end
			end
			
			from
				i := l_types.eiffel_names.lower
				nb := l_types.eiffel_names.upper
				create classes.make (nb - i)
				create dotnet_classes.make (nb - i)
			until
				i > nb
			loop
				l_class_name := l_types.eiffel_names.item (i)
				if l_class_name /= Void then
					l_class_name := l_class_name.as_lower
					if prefix_name /= Void then
						l_class_name.prepend (prefix_name)
					end
					l_external_name := l_types.dotnet_names.item (i)
					create l_location.make_from_string (clone (path))
					l_location.extend (classes_directory)
					l_location.set_file_name (l_external_name)
					l_location.add_extension (xml_extension)
					create l_class.make (l_class_name, l_external_name, l_location)
					if not l_class.exists then
						Error_handler.insert_error (create {VD62}.make (Current, l_class))
					end
					l_class.set_cluster (Current)
					classes.put (l_class, l_class_name)
					dotnet_classes.put (l_class, l_external_name)
				end
				i := i + 1
			end
			
				-- Then we get list of referenced assemblies from this assembly.
				-- We raise a VD60 error when assembly is not found in surrounding
				-- universe.
			
			from
				i := l_referenced_assemblies.assemblies.lower
				nb := l_referenced_assemblies.assemblies.upper
				create referenced_assemblies.make (i, nb)
			until
				i > nb
			loop
				l_cons_assembly := l_referenced_assemblies.assemblies.item (i)
				l_assembly_location := clone (l_env.Assemblies_path)
				l_assembly_location.extend (build_assembly_path (
					l_cons_assembly.name, l_cons_assembly.version,
					l_cons_assembly.culture, l_cons_assembly.key))
				l_path := environ.interpreted_string (l_assembly_location)
					
				l_assembly ?= Universe.cluster_of_path (l_path)
				if l_assembly = Void then
					l_local_path := clone (Local_assembly_path)
					l_local_path.extend (build_assembly_path (
						l_cons_assembly.name, l_cons_assembly.version,
						l_cons_assembly.culture, l_cons_assembly.key))
					l_assembly ?= Universe.cluster_of_path (l_local_path)
					if l_assembly = Void then
							-- We did not find a global or a local matching assembly,
							-- we are going to try to add it as a global assembly and
							-- emit the missing XML.
						l_assembly ?= Lace.old_universe.cluster_of_path (l_path)
						if l_assembly = Void then
							create l_assembly.make_from_consumed_assembly (l_cons_assembly)
							Eiffel_system.add_sub_cluster (l_assembly)
							Universe.insert_cluster (l_assembly)
							l_assembly.import_data
							universe.add_new_assembly_in_ace (l_assembly)
						else
							Eiffel_system.add_sub_cluster (l_assembly)
							Universe.insert_cluster (l_assembly)
						end
					end
					referenced_assemblies.put (l_assembly, i)
				else
					referenced_assemblies.put (l_assembly, i)
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	consume_assemblies is
			-- Consume current if not yet generated by emitter.
		local
			l_emitter: IL_EMITTER
			l_vd64: VD64
		do
			if is_local then
				create l_emitter.make
				if not l_emitter.exists then
						-- IL_EMITTER component could not be loaded.
					create l_vd64
					Error_handler.insert_error (l_vd64)
				else			
						-- If `assembly_path' is Void, then an error has
						-- already been generated.
					if assembly_path /= Void then
							-- And call emitter to generate XML file if needed.
						l_emitter.consume_local_assembly (assembly_path, Local_assembly_path)
					end
				end
			end
		end

	initialize_from_gac_assembly is
			-- Try to generate associated XML file of current assembly.
		require
			is_local: is_local
		local
			l_vd64: VD64
			l_emitter: IL_EMITTER
		do
			create l_emitter.make
			if not l_emitter.exists then
					-- IL_EMITTER component could not be loaded.
				create l_vd64
				Error_handler.insert_error (l_vd64)
			else
				l_emitter.consume_gac_assembly (assembly_name, version, culture, public_key_token)
			end
		end
		
	initialize_from_local_assembly (an_assembly: STRING) is
			-- Given a local assembly `an_assembly' initializes Current with info
			-- we can retrieved from assembly file.
		require
			an_assembly_not_void: an_assembly /= Void
			is_local: is_local
		local
			l_file: RAW_FILE
			l_vd63: VD63
			l_vd64: VD64
			l_vd65: VD65
			l_emitter: IL_EMITTER
		do
				-- Check assembly existence.
			create l_file.make (an_assembly)
			if not l_file.exists then
					-- Assembly file was not found.
				create l_vd63.make (an_assembly)
				Error_handler.insert_error (l_vd63)
			else
				create l_emitter.make
				if not l_emitter.exists then
						-- IL_EMITTER component could not be loaded.
					create l_vd64
					Error_handler.insert_error (l_vd64)
				else
					l_emitter.retrieve_assembly_info (environ.interpreted_string (an_assembly))
					if not l_emitter.assembly_found then
							-- Looks like it is not a valid assembly file.
						create l_vd65.make (an_assembly)
						Error_handler.insert_error (l_vd65)
					else
							-- Initialize current with data.
						assembly_path := environ.interpreted_string (an_assembly)
						assembly_name := l_emitter.name
						version := l_emitter.version
						culture := l_emitter.culture
						public_key_token := l_emitter.public_key_token
						if
							public_key_token /= Void and then
							public_key_token.is_equal (null_key_string)
						then
							public_key_token := Void
						end
					end
				end
			end
		end

	build_assembly_path (a_name, a_version, a_culture, a_key: STRING): STRING is
			-- Build directory name corresponding to given assembly description.
		require
			a_name_not_void: a_name /= Void
		local
			l_version: STRING
		do
			create Result.make (a_name.count + 3)
			Result.append (a_name)
			Result.append_character ('-')
			
			if a_version /= Void then
				l_version := clone (a_version)
				l_version.replace_substring_all (".", "_")
				Result.append (l_version)
			end
			Result.append_character ('-')
			
			if a_culture /= Void and then not a_culture.is_equal (neutral_string) then
				Result.append (a_culture)
			end
			if a_key /= Void and then not a_key.is_equal (null_key_string) then
				Result.append_character ('-')
				Result.append (a_key)
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Constants

	classes_directory: STRING is "classes"
	type_list_file_name: STRING is "types.xml"
	xml_extension: STRING is "xml"
	neutral_string: STRING is "neutral"
	null_key_string: STRING is "null"
	referenced_assemblies_file_name: STRING is "referenced_assemblies.xml"
			-- String constants specific to layout of EAC.


invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void

end -- class ASSEMBLY_I
