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
			l_assembly_location: PATH_NAME
			l_emitter: IL_EMITTER
		do
				-- Initialize assembly info.
			cluster_name := a.cluster_name
			assembly_info_make (a.assembly_name)
			if a.version /= Void and a.culture /= Void and a.public_key_token /= Void then
				set_version (a.version)
				set_culture (a.culture)
				set_public_key_token (a.public_key_token)
				l_emitter := new_il_emitter
				if l_emitter /= Void then
					consumed_folder_name := l_emitter.relative_folder_name (assembly_name, version, culture, public_key_token)
				end
			else
				is_local := True
				initialize_from_assembly_path (a.assembly_name)
			end

			prefix_name := a.prefix_name
			if prefix_name /= Void then
				prefix_name := prefix_name.as_upper
			end

			is_library := True
			is_recursive := True
			hide_implementation := True
			
				-- Initialize location of XML files representing classes
				-- of current assembly.
		
			l_assembly_location := versioned_assembly_cache_folder.twin

			if consumed_folder_name /= Void then
				l_assembly_location.extend (consumed_folder_name)
				create dollar_path.make_from_string (l_assembly_location)
				update_path
			end

				-- Necessary initialization to preserve inherited invariants.
			create sub_clusters.make (0)
			create classes.make (0)
			create overriden_classes.make (0)
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
			l_assembly_location: PATH_NAME
		do
				-- Initialize assembly info.
			cluster_name := l_ass.out
			assembly_info_make (l_ass.location)
			
			is_local := True
			initialize_from_assembly_path (l_ass.location)

			prefix_name := l_ass.name + "_"
			prefix_name.replace_substring_all (".", "_")
			prefix_name := prefix_name.as_upper

			is_library := True
			is_recursive := True
			hide_implementation := True
			
				-- Initialize location of XML files representing classes
				-- of current assembly.
			if consumed_folder_name /= Void then
				l_assembly_location := versioned_assembly_cache_folder.twin
				l_assembly_location.extend (l_ass.folder_name)
				create dollar_path.make_from_string (l_assembly_location)
				update_path
			end
			
				-- Necessary initialization to preserve inherited invariants.
			create sub_clusters.make (0)
			create classes.make (0)
			create overriden_classes.make (0)
		ensure
			cluster_name_set: cluster_name /= Void
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
				equal (public_key_token, other.public_key_token) and then 
				equal (consumed_folder_name, other.consumed_folder_name)
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
			
	consumed_folder_name: STRING
			-- name of consumed assembly folder in EAC

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
			consumed_folder_name := old_assembly.consumed_folder_name
		end
		
feature -- Initialization

	import_data is
			-- Given current assembly description, found all
			-- available classes and initializes `classes'.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
			l_env: EIFFEL_ENV
			l_assembly_location: PATH_NAME
			l_path: STRING
			l_types_file, l_reference_file: FILE_NAME
			
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
			create l_types_file.make_from_string (path)
			l_types_file.set_file_name (type_list_file_name)
			l_types ?= l_reader.new_object_from_file (l_types_file)

			create l_reference_file.make_from_string (path)
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
					initialize_from_assembly
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
					if prefix_name /= Void then
						l_class_name.prepend (prefix_name)
					end
					l_external_name := l_types.dotnet_names.item (i)
					l_path := l_external_name.twin
					l_path.append (xml_extension)
					create l_class.make (Current, l_class_name, l_external_name, l_path)
					if not l_class.exists then
						Error_handler.insert_error (create {VD62}.make (Current, l_class))
					end
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
				l_assembly_location := versioned_assembly_cache_folder.twin
				l_assembly_location.extend (l_cons_assembly.folder_name)
				l_path := environ.interpreted_string (l_assembly_location)
					
				l_assembly ?= Universe.cluster_of_path (l_path)
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
				i := i + 1
			end
		end

	consume_assemblies (l_assemblies: ARRAYED_LIST [ASSEMBLY_I]) is
			-- Consume current local assembly along with local assemblies `l_assemblies'.
		require
			is_local: is_local
			assembly_path_not_void: assembly_path /= Void
--			are_locals: l_assemblies.for_all (agent is_local)
		local
			l_emitter: IL_EMITTER
			l_dir: DIRECTORY
			l_names: STRING
		do
			l_emitter := new_il_emitter
			if l_emitter /= Void then			
					-- And call emitter to generate XML file if needed.
				create l_dir.make (Local_assembly_path)
				if not l_dir.exists then
					l_dir.create_dir
				end
				from
					l_assemblies.start
					l_names := assembly_path.twin
				until
					l_assemblies.after
				loop
						-- If `assembly_path' is Void, then an error has
						-- already been generated.						
					if l_assemblies.item.assembly_path /= Void then
						l_names.append_character (';')
						l_names.append_string (l_assemblies.item.assembly_path)
					end
					l_assemblies.forth
				end
				l_emitter.consume_assembly_from_path (l_names)
			end
		end

feature {NONE} -- Implementation

	initialize_from_assembly is
			-- Try to generate associated XML file of current assembly.
		require
			not_is_local: not is_local
		local
			l_emitter: IL_EMITTER
		do
				l_emitter := new_il_emitter
				if l_emitter /= Void then
				l_emitter.consume_assembly (assembly_name, version, culture, public_key_token)
			end
		end
		
	initialize_from_assembly_path (an_assembly: STRING) is
			-- Given a local assembly `an_assembly' initializes Current with info
			-- we can retrieved from assembly file.
		require
			an_assembly_not_void: an_assembly /= Void
			is_local: is_local
		local
			l_file: RAW_FILE
			l_vd63: VD63
			l_vd65: VD65
			l_emitter: IL_EMITTER
		do
				-- Check assembly existence.
			create l_file.make (environ.interpreted_string (an_assembly))
			if not l_file.exists then
					-- Assembly file was not found.
				create l_vd63.make (an_assembly)
				Error_handler.insert_error (l_vd63)
			else
				l_emitter := new_il_emitter
				if l_emitter /= Void then
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
						consumed_folder_name := l_emitter.consumed_folder_name
					end
				end
			end
		end
	
	assembly_cache_folder: DIRECTORY_NAME is
			-- Absolute path to path of EAC
		once
			if system.metadata_cache_path /= Void and then not system.metadata_cache_path.is_empty then
				create Result.make_from_string (environ.interpreted_string (system.metadata_cache_path))
			else
				create Result.make_from_string (environ.interpreted_string ((create {EIFFEL_ENV}).assemblies_path))
			end
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	versioned_assembly_cache_folder: DIRECTORY_NAME is
			-- Absolute path to versioned path of EAC
		once
			Result := assembly_cache_folder.twin
			Result.extend (system.clr_runtime_version)
		end
		
	new_il_emitter: IL_EMITTER is
			-- Creates a new IL_EMITTER
		local
			l_dir: DIRECTORY
			l_vd64: VD64
			l_vd67: VD67
		do
			create l_dir.make (assembly_cache_folder)
			if l_dir.exists then
				create Result.make (versioned_assembly_cache_folder, system.clr_runtime_version)
				if not Result.exists then
						-- IL_EMITTER component could not be loaded.
					create l_vd64
					Error_handler.insert_error (l_vd64)
					Result := Void
				else
					if not Result.is_initialized then
							-- Path to cache is not valid
						create l_vd67.make (assembly_cache_folder)
						Error_handler.insert_error (l_vd67)
						Result := Void	
					end
				end
			else
					-- Path to cache is not valid
				create l_vd67.make (assembly_cache_folder)
				Error_handler.insert_error (l_vd67)
				Result := Void					
			end
		ensure
			valid_result: Result /= Void implies Result.exists and then Result.is_initialized
		end

feature {NONE} -- Constants

	type_list_file_name: STRING is "types.xml"
	xml_extension: STRING is ".xml"
	neutral_string: STRING is "neutral"
	null_key_string: STRING is "null"
	referenced_assemblies_file_name: STRING is "referenced_assemblies.xml"
			-- String constants specific to layout of EAC.

invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void
	consumed_folder_name_not_void: consumed_folder_name /= Void

end -- class ASSEMBLY_I