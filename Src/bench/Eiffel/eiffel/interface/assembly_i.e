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
		redefine
			classes
		end
	
create
	make_from_ast
	
feature {NONE} -- Initialization

	make_from_ast (a: ASSEMBLY_SD) is
			-- Create Current from data in `a'.
		require
			a_not_void: a /= Void
		local
			l_assembly_directory: STRING
			l_assembly_location: FILE_NAME
			l_env: EIFFEL_ENV
		do
				-- Initialize assembly info.
			cluster_name := a.cluster_name
			assembly_name := a.assembly_name
			version := a.version
			culture := a.culture
			public_key_token := a.public_key_token
			is_library := True
			is_recursive := True
			hide_implementation := True
			
				-- Initialize location of XML files representing classes
				-- of current assembly.
			create l_env
			l_assembly_directory := build_assembly_path (assembly_name, version, culture,
				public_key_token)
			l_assembly_location := clone (l_env.Assemblies_path)
			l_assembly_location.extend (l_assembly_directory)
			create path.make_from_string (l_assembly_location)

				-- Necessary initialization to preserve inherited invariants.
			dollar_path := path
			create renamings.make
			create ignore.make
			create sub_clusters.make (0)
		ensure
			cluster_name_set: cluster_name = a.cluster_name
			assembly_name_set: assembly_name = a.assembly_name
			version_set: version = a.version
			culture: culture = a.culture
			public_key_token: public_key_token = a.public_key_token
		end

feature -- Comparison

	same_assembly_as (other: like Current): BOOLEAN is
			-- Compare assembly info only.
		require
			other_not_void: other /= Void
		do
			Result := assembly_name.is_equal (other.assembly_name) and then
				equal (version, other.version) and then
				equal (culture, other.culture) and then
				equal (public_key_token, other.public_key_token)
		end
		
feature -- Access

	assembly_name: STRING
			-- Assembly name or file location of assembly if local assembly.

	version, culture, public_key_token: STRING
			-- Specification of current assembly.

	classes: HASH_TABLE [EXTERNAL_CLASS_I, STRING]
			-- List all classes available in current assembly
			-- indexed by their Eiffel names.

	dotnet_classes: HASH_TABLE [EXTERNAL_CLASS_I, STRING]
			-- List all classes available in current assemblly
			-- Indexed by theit Dotnet names.

	referenced_assemblies: ARRAY [ASSEMBLY_I]
			-- List of referenced assemblies in Current assembly. 
			-- Indexed by assembly ID.

feature -- Initialization

	import_data is
			-- Given current assembly description, found all
			-- available classes and initializes `classes'.
		local
			l_reader: EIFFEL_XML_DESERIALIZER
			l_env: EIFFEL_ENV
			l_assembly_location, l_mapping: FILE_NAME
			l_location: FILE_NAME
			
			l_types: CONSUMED_ASSEMBLY_TYPES
			l_referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			l_class: EXTERNAL_CLASS_I
			l_assembly: ASSEMBLY_I
			l_cons_assembly: CONSUMED_ASSEMBLY
			i, nb: INTEGER
			
			l_class_name, l_external_name: STRING
			
			l_vd60: VD60
		do
			create l_reader
			create l_env
			
				-- We first read all XML files to ensure that they all exist, otherwise
				-- we raise an error.
			create l_mapping.make_from_string (clone (path))
			l_mapping.set_file_name (type_list_file_name)
			l_types ?= l_reader.new_object_from_file (l_mapping)

			create l_mapping.make_from_string (clone (path))
			l_mapping.set_file_name (referenced_assemblies_file_name)
			l_referenced_assemblies ?= l_reader.new_object_from_file (l_mapping)

			if l_types = Void or l_referenced_assemblies = Void then
					-- Raise an error and stop processing as we cannot continue
					-- with missing information.
				Error_handler.insert_error (create {VD61}.make (Current))	
				Error_handler.raise_error
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
					
				l_assembly ?= Universe.cluster_of_path (l_assembly_location)
				if l_assembly = Void then
					create l_vd60.make (Current, l_cons_assembly)
					Error_handler.insert_error (Void)
				else
					referenced_assemblies.put (l_assembly, i)
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

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
			
			if a_culture /= Void then
				if not a_culture.is_equal (neutral_string) then
					Result.append (a_culture)
				end
			end
			Result.append_character ('-')
			
			if a_key /= Void then
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
	referenced_assemblies_file_name: STRING is "referenced_assemblies.xml"
			-- String constants specific to layout of EAC.


invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void

end -- class ASSEMBLY_I
