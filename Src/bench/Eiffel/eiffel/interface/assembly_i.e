indexing
	description: "[
		Representation of an assembly as seen by universe. It simply inherits from CLUSTER_I
		and only adds information specific to an assembly, i.e. name, culture, version
		and public key token.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_I
	
inherit
	CLUSTER_I
		undefine
			format
		redefine
			classes, sub_clusters, old_cluster, parent_cluster,
			copy_old_cluster, is_assembly, class_anchor,
			insert_class_from_file, process_overrides
		end

	ASSEMBLY_INFO
		rename
			make as assembly_info_make
		export
			{NONE} assembly_info_make, set_culture, set_version, set_public_key_token
		end
		
	SHARED_IL_EMITTER
		export
			{NONE} all
		end

create
	make_from_ast,
	make_from_precompiled_cluster

create {ASSEMBLY_I}
	make_from_consumed_assembly

feature {NONE} -- Initialization

	make_from_ast (a: ASSEMBLY_SD) is
			-- Create Current from data in `a'.
		require
			a_not_void: a /= Void
		local
			l_assembly_location: PATH_NAME
			l_emitter: IL_EMITTER
			l_vd61: VD61
		do
				-- Initialize assembly info.
			cluster_name := a.cluster_name
			assembly_info_make (a.assembly_name)
			if a.version /= Void and a.culture /= Void and a.public_key_token /= Void then
				has_gac_specification := True
				set_version (a.version)
				set_culture (a.culture)
				set_public_key_token (a.public_key_token)
				l_emitter := il_emitter
				if l_emitter /= Void then
					consumed_folder_name := l_emitter.relative_folder_name (assembly_name, version, culture, public_key_token)
					if consumed_folder_name = Void then
						create l_vd61.make (Current)
						Error_handler.insert_error (l_vd61)
					else
						is_in_gac := True
					end
				end
			else
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
		
			l_assembly_location := assembly_cache_folder.twin

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
			assembly_name_set: has_gac_specification implies (assembly_name = a.assembly_name)
			version_set: has_gac_specification implies version = a.version
			culture: has_gac_specification implies culture = a.culture
			public_key_token: has_gac_specification implies public_key_token = a.public_key_token
		end

	make_from_consumed_assembly (l_ass: CONSUMED_ASSEMBLY) is
			-- Create Current from data in `l_ass'.
		local
			l_assembly_location: PATH_NAME
		do
				-- Initialize assembly info.
			cluster_name := l_ass.name.twin
			cluster_name.append (", Version=")
			cluster_name.append (l_ass.version)
			cluster_name.append (", Culture=")
			cluster_name.append (l_ass.culture)
			cluster_name.append (", PublicKeyToken=")
			cluster_name.append (l_ass.key)
			
			assembly_info_make (l_ass.location)
			
			is_in_gac := l_ass.is_in_gac
			initialize_from_assembly_path (l_ass.location)

			prefix_name := l_ass.name + "_"
			prefix_name.replace_substring_all (".", "_")
			prefix_name := prefix_name.as_upper

			is_library := True
			is_recursive := True
			hide_implementation := True

			if consumed_folder_name /= Void then
				l_assembly_location := assembly_cache_folder.twin
				l_assembly_location.extend (consumed_folder_name)
				create dollar_path.make_from_string (l_assembly_location)
				update_path
			end
			
				-- Necessary initialization to preserve inherited invariants.
			create sub_clusters.make (0)
			create classes.make (0)
			create overriden_classes.make (0)
		ensure
			cluster_name_set: cluster_name /= Void
			not_has_gac_specification: not has_gac_specification
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

	parent_cluster: ASSEMBLY_I
			-- Parent cluster of Current cluster
			-- (Void implies it is a top level cluster)

	sub_clusters: ARRAYED_LIST [ASSEMBLY_I]
			-- List of sub clusters for Current cluster

	dotnet_classes: HASH_TABLE [EXTERNAL_CLASS_I, STRING]
			-- List all classes available in current assemblly
			-- Indexed by theit Dotnet names.

	referenced_assemblies: ARRAY [ASSEMBLY_I]
			-- List of referenced assemblies in Current assembly. 
			-- Indexed by assembly ID.

	has_gac_specification: BOOLEAN
			-- Is current assembly referenced through an assembly fully qualified name?
			-- By opposition to just a path.
			
	is_in_gac: BOOLEAN
			-- Is current assembly located in GAC?
			
	assembly_path: STRING
			-- Path of current assembly (without environment variables).
			
	dollar_assembly_path: STRING
			-- Path of current assembly (with environment variables).
			
	consumed_folder_name: STRING
			-- name of consumed assembly folder in EAC

	is_assembly: BOOLEAN is True
			-- Is current an instance of ASSEMBLY_I?

feature {ASSEMBLY_I} -- Access

	old_cluster: ASSEMBLY_I
			-- Old version of the cluster

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
			is_in_gac := old_assembly.is_in_gac
			has_gac_specification := old_assembly.has_gac_specification
			assembly_path := old_assembly.assembly_path
			dollar_assembly_path := old_assembly.dollar_assembly_path
			consumed_folder_name := old_assembly.consumed_folder_name
		end
		
feature -- Initialization

	import_data is
			-- Given current assembly description, found all
			-- available classes and initializes `classes'.
		local
			l_reader: EIFFEL_DESERIALIZER
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
			l_reader.deserialize (l_types_file, 0)
			l_types ?= l_reader.deserialized_object

			create l_reference_file.make_from_string (path)
			l_reference_file.set_file_name (referenced_assemblies_file_name)
			l_reader.deserialize (l_reference_file, 0)
			l_referenced_assemblies ?= l_reader.deserialized_object

			if l_types = Void or l_referenced_assemblies = Void then
					-- Raise an error and stop processing as we cannot continue
					-- with missing information.
				if not has_gac_specification then
					Error_handler.insert_error (create {VD61}.make (Current))	
					Error_handler.raise_error
				else
						-- Let's try to import it and see if it works this time
					initialize_from_assembly
					l_reader.deserialize (l_types_file, 0)
					l_types ?= l_reader.deserialized_object
					l_reader.deserialize (l_reference_file, 0)
					l_referenced_assemblies ?= l_reader.deserialized_object
					if l_types = Void or l_referenced_assemblies = Void then
						Error_handler.insert_error (create {VD61}.make (Current))	
						Error_handler.raise_error
					end
				end
			end
			
			if l_types.eiffel_names /= Void then
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
						create l_class.make (Current, l_class_name, l_external_name, l_types.positions.item (i))
						if not l_class.exists then
							Error_handler.insert_error (create {VD62}.make (Current, l_class))
						end
						classes.put (l_class, l_class_name)
						dotnet_classes.put (l_class, l_external_name)
					end
					i := i + 1
				end
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
				l_assembly_location := assembly_cache_folder.twin
				l_path := il_emitter.relative_folder_name_from_path (l_cons_assembly.location)
				if l_path /= Void then
					l_assembly_location.extend (l_path)
				end
				l_path := environ.interpreted_string (l_assembly_location)
					
				l_assembly ?= Universe.cluster_of_path (l_path)
				if l_assembly = Void then
					l_assembly ?= Lace.old_universe.cluster_of_path (l_path)
					if l_assembly = Void then
							-- We did not find an assembly using a path. This can happen
							-- when using a precompiled library or a project who's previous cache
							-- has been wiped out.
						l_assembly ?= Universe.assembly_of_specification(
							l_cons_assembly.name,
							l_cons_assembly.culture,
							l_cons_assembly.key,
							l_cons_assembly.version)
						if l_assembly = Void then
								-- We did not find a global or a local matching assembly,
								-- we are going to try to add it as a global assembly and
								-- emit the missing XML.
							l_assembly ?= Lace.old_universe.assembly_of_specification(
								l_cons_assembly.name,
								l_cons_assembly.culture,
								l_cons_assembly.key,
								l_cons_assembly.version)
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
						check
							l_assembly_not_void:l_assembly /= Void
						end
						l_assembly.set_dollar_path (l_path)
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
			is_local: not has_gac_specification
			assembly_path_not_void: assembly_path /= Void
-- FIXME: Manu 06/28/2004: agent on attribute is not yet supported
--			are_locals: not l_assemblies.there_exists (agent has_gac_specification)
		local
			l_emitter: IL_EMITTER
			l_names: STRING
		do
			l_emitter := il_emitter
			if l_emitter /= Void then			
					-- And call emitter to generate XML file if needed.
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

feature {COMPILER_EXPORTER} -- Element change

	insert_class_from_file (file_name: STRING) is
		do
				-- Not applicable
				-- FIXME: Turn this check into precondition
			check
				not_applicable: False
			end
		end
		
	process_overrides (ovc: CLUSTER_I) is
			-- Check if some classes have been overriden
			-- and remove them from the system
		do
				-- Do nothing, because one cannot override .NET classes.
		end

feature {COMPILER_EXPORTER} -- Conveniences

	update_cache_path is
			-- Updates `Current's' assoicated metadata cache path
		require
			assembly_path_not_void: assembly_path /= Void
		local
			l_path: STRING
			l_assembly_location: PATH_NAME
		do
			if dollar_assembly_path /= Void then
				l_path := environ.interpreted_string (dollar_assembly_path)
				il_emitter.retrieve_assembly_info (l_path)
				l_path := il_emitter.relative_folder_name_from_path (l_path)
				if l_path /= Void then
					l_assembly_location := assembly_cache_folder.twin
					l_assembly_location.extend (l_path)
					l_path := environ.interpreted_string (l_assembly_location)
					consumed_folder_name := l_path.twin
					set_dollar_path (l_path)
					set_dollar_assembly_path (dollar_assembly_path)
					is_in_gac := il_emitter.is_in_gac
				end
			end
		end

	set_dollar_assembly_path (s: STRING) is
			-- Assign `s' to `assembly_path'.
		do
			dollar_assembly_path := s
			update_assembly_path
		end
		
	update_assembly_path is
		do
			if dollar_assembly_path /= Void then
				assembly_path := Environ.interpreted_string (dollar_assembly_path)
			end
		end

feature {NONE} -- Implementation

	initialize_from_assembly is
			-- Try to generate associated XML file of current assembly.
		require
			has_gac_specification: has_gac_specification
		local
			l_emitter: IL_EMITTER
		do
			l_emitter := il_emitter
			if l_emitter /= Void then
				l_emitter.consume_assembly (assembly_name, version, culture, public_key_token)
			end
		end
		
	initialize_from_assembly_path (an_assembly: STRING) is
			-- Given an assembly given by its path `an_assembly' initializes Current with info
			-- we can retrieved from assembly file.
		require
			an_assembly_not_void: an_assembly /= Void
			not_has_gac_specification: not has_gac_specification
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
				create l_vd63.make (an_assembly, environ.interpreted_string (an_assembly))
				Error_handler.insert_error (l_vd63)
			else
				l_emitter := il_emitter
				if l_emitter /= Void then
					l_emitter.retrieve_assembly_info (environ.interpreted_string (an_assembly))
					if not l_emitter.assembly_found then
							-- Looks like it is not a valid assembly file.
						create l_vd65.make (an_assembly, environ.interpreted_string (an_assembly))
						Error_handler.insert_error (l_vd65)
					else
							-- Initialize current with data.
						set_dollar_assembly_path (an_assembly)
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
						consumed_folder_name := l_emitter.relative_folder_name_from_path (assembly_path)
						is_in_gac := l_emitter.is_in_gac
					end
				end
			end
		ensure
			not_has_gac_specification: not has_gac_specification
		end

feature {NONE} -- Constants

	type_list_file_name: STRING is "types.info"
	null_key_string: STRING is "null"
	referenced_assemblies_file_name: STRING is "referenced_assemblies.info"
			-- String constants specific to layout of EAC.

feature {NONE} -- Type anchors

	class_anchor: EXTERNAL_CLASS_I is
			-- Type of classes one can insert in Current
		do
		end
		
invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void
	consumed_folder_name_not_void: consumed_folder_name /= Void

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

end -- class ASSEMBLY_I
