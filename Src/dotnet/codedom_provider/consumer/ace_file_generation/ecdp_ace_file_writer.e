indexing
	description: "[
					Generate Ace file for system resulting from 
					consumption of CodeDOM tree.
					]"
	date: "$$"
	revision: "$$"

class
	ECDP_ACE_FILE_WRITER

inherit
	ECDP_REFERENCED_ASSEMBLIES

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize attributes to default values
		do
			create system_name.make_from_string ("codedom_generated")
			create root_class_name.make_empty
			create root_class_creation_routine.make_empty
			create path_to_generated_src.make_empty
			create namespace.make_empty
			create extension.make_from_string ("dll")
		ensure
			non_void_system: system_name /= Void
			non_void_root_class_name: root_class_name /= Void
			non_void_root_class_creation_routine: root_class_creation_routine /= Void
			non_void_path_to_generated_src: path_to_generated_src /= Void
			non_void_namespace: namespace /= Void
			non_void_extension: extension /= Void
			valid_extension: valid_extension (extension)
		end

feature -- Access

	text_writer: TEXT_WRITER
			-- Ace file text writer

	system_name: STRING
			-- System name

	root_class_name: STRING
			-- Root class name

	root_class_creation_routine: STRING
			-- root creation routine
			
	path_to_generated_src: STRING
			-- Path to generated source
			
	namespace: STRING
			-- Namespace
	
	extension: STRING
			-- File extension ("exe" or "dll")

	base_clusters: LINKED_LIST [ECDP_LACE_CLUSTER] is
			-- EiffelBase for .NET clusters
		local
			l_cluster: ECDP_LACE_CLUSTER
		once
			create Result.make

			create l_cluster.make_with_name_and_path ("base_net", create {FILE_NAME}.make_from_string ("$ISE_EIFFEL\library.net\base"))
			l_cluster.set_all_sub_dir (True)
			Result.extend (l_cluster)

			create l_cluster.make_with_name_and_path ("base", create {FILE_NAME}.make_from_string ("$ISE_EIFFEL\library\base"))
			l_cluster.add_exclude ("table_eiffel3")
			l_cluster.add_exclude ("desc")
			l_cluster.add_exclude ("classic")
			l_cluster.set_all_sub_dir (True)
			Result.extend (l_cluster)
		ensure
			non_void_base_clusters: Result /= Void
		end

	user_clusters: LINKED_LIST [ECDP_LACE_CLUSTER] is
			-- list of clusters added by users (for pagelets, controls, etc).
		once
			create Result.make
			Result.compare_objects
		ensure
			non_void_user_clusters: Result /= Void
		end

	precompiled_path: STRING is
			-- Precompiled library path
		do
			Result := internal_precompiled_path.item
		ensure
			non_void_precompiled_path: Result /= Void
		end

	precompiled_referenced_assemblies: HASH_TABLE [STRING, STRING] is
			-- list of referenced_assemblies of the precompiled.
			-- key : short assembly name
		once
			create Result.make (14)
			Result.put ("mscorlib", "mscorlib")
			Result.put ("system_", "System")
			Result.put ("system_xml", "System.Xml")
			Result.put ("system_web", "System.Web")
			Result.put ("system_drawing", "System.Drawing")
			Result.put ("system_data", "System.Data")
			Result.put ("system_entreprise_services", "System.EnterpriseServices")
			Result.put ("system_web_regular_expressions", "System.Web.RegularExpressions")
			Result.put ("system_directory_services", "System.DirectoryServices")
			Result.put ("system_runtime_remoting", "System.Runtime.Remoting")
			Result.put ("system_runtime_serialization_formatters_soap", "System.Runtime.Serialization.Formatters.Soap")
			Result.put ("system_web_services", "System.Web.Services")
			Result.put ("system_ms_visual_c", "Microsoft.VisualC")
			Result.put ("cscompmgd", "cscompmgd")
		end
	
	include_debug_info: BOOLEAN
			-- Should project include debug information?

	dictionary: ECDP_DICTIONARY is
			-- Eiffel keywords and useful strings
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end

	code: STRING is
			-- | Result := "system	"`system_name'"
			-- |			root	ANY
			-- | 			default
			-- |			[namespace (`namespace')]
			-- |			extension (`extension')
			-- |			precompiled (`precompiled_path')
			-- | 			cluster	loop on `clusters'
			-- | 			external	loop on `general_referenced_assemblies'	"
			-- Generation code
		require
			not_empty_system_name: not system_name.is_empty
			not_empty_root_class_name: not root_class_name.is_empty
			not_empty_root_class_creation_routine: not root_class_creation_routine.is_empty
			not_empty_path_to_generated_src: not path_to_generated_src.is_empty
			not_empty_extension: not extension.is_empty
		local
			l_precompiled_path: STRING
		do
			create Result.make (2000)
			Result.append ("system") 
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.Tab)
			Result.append (Dictionary.Double_quotes)
			Result.append (system_name)
			Result.append (Dictionary.Double_quotes)
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.New_line)

			Result.append ("root")
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.Tab)
			Result.append ("ANY")
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.New_line)

			Result.append (default_setting)
			Result.append (Dictionary.New_line)
			if namespace /= Void and then namespace.count > 0 then
				Result.append (Dictionary.Tab)
				Result.append ("namespace (%"")
				Result.append (namespace)
				Result.append ("%")")
				Result.append (Dictionary.New_line)
			end
			if extension /= Void and then extension.count > 0 then
				Result.append (Dictionary.Tab)
				Result.append ("msil_generation_type (%"")
				Result.append (extension)
				Result.append ("%")")
				Result.append (Dictionary.New_line)
			end
			Result.append (Dictionary.Tab)
			Result.append ("line_generation (")
			if include_debug_info then
				Result.append ("yes")
			else
				Result.append ("no")
			end
			Result.append (")")
			Result.append (Dictionary.New_line)

			if not precompiled_path.is_empty then
				Result.append (Dictionary.Tab)
				Result.append ("precompiled (")
				Result.append (Dictionary.Double_quotes)

				l_precompiled_path := precompiled_path.twin
					-- delete ...\EIFGen\w_code\....extension
				l_precompiled_path.keep_head (precompiled_path.last_index_of ('\', precompiled_path.last_index_of ('\', precompiled_path.last_index_of ('\', precompiled_path.count) - 1) - 1) - 1)
				Result.append (l_precompiled_path)
				Result.append (Dictionary.Double_quotes)
				Result.append (")")
				Result.append (Dictionary.New_line)
			end

			Result.append (Dictionary.New_line)

			Result.append (clusters_clause_code)
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.New_line)

			Result.append (assemblies_clause)

			Result.append (Dictionary.End_keyword)
		end

	out_code is
			-- Write code in ace file
		do
			text_writer.write_string (code)
			text_writer.flush
		end
		
feature -- Status Setting
	
	set_system_name (a_system_name: like system_name) is
			-- Set `system_name' with `a_system_name'.
		require
			non_void_system_name: a_system_name /= Void
			non_empty_system_name: not a_system_name.is_empty
		do
			system_name := a_system_name
		ensure
			system_name_set: system_name = a_system_name
		end

	set_namespace (a_namespace: like namespace) is
			-- Set `namespace' with `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

	set_extension (an_extension: like extension) is
			-- Set `extension' with `a_extension'.
		require
			non_void_an_extension: an_extension /= Void
			non_empty_an_extension: not an_extension.is_empty
			valid_extension: valid_extension (an_extension)
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

	set_text_writer (a_text_writer: like text_writer) is
			-- Set `text_writer' with `a_text_writer'.
		require
			non_void_text_writer: a_text_writer /= Void
		do
			text_writer := a_text_writer
		ensure
			text_writer_set: text_writer = a_text_writer
		end

	set_root_class_name (a_root_class_name: like root_class_name) is
			-- Set `root_class_name' with `a_root_class_name'.
		require
			non_void_root_class_name: a_root_class_name /= Void
			non_empty_a_root_class_name: not a_root_class_name.is_empty
		do
				-- FIXME: should be formatted in eiffel convention.
			root_class_name := a_root_class_name
			root_class_name.to_upper
		ensure
			root_class_name_set: root_class_name = a_root_class_name
		end

	set_root_class_creation_routine (a_root_class_creation_routine: like root_class_creation_routine) is
			-- Set `root_class_creation_routine' with `a_root_class_creation_routine'.
		require
			non_void_root_class_creation_routine: a_root_class_creation_routine /= Void
			non_empty_root_class_creation_routine: not a_root_class_creation_routine.is_empty
		do
			root_class_creation_routine := a_root_class_creation_routine			
		ensure
			root_class_creation_routine_set: root_class_creation_routine = a_root_class_creation_routine
		end

	set_include_debug_info (a_bool: BOOLEAN) is
			-- Set `include_debug_info' with a_bool.
		do
			include_debug_info := a_bool
		ensure
			include_debug_info_set: include_debug_info = a_bool
		end
	
	set_path_to_generated_src (a_path: STRING) is
			-- Set `path_to_generated_src' with `a_path'.
		require
			non_void_a_path: a_path /= Void
			not_empty_a_path: not a_path.is_empty
		do
			path_to_generated_src := a_path
		ensure
			path_to_generated_src_set: path_to_generated_src = a_path
		end

	set_precompiled_path (a_path: STRING) is
			-- Set `precompiled_path' with `a_path'.
		require
			non_void_a_path: a_path /= Void
			not_empty_a_path: not a_path.is_empty
			valid_path: a_path.has_substring (".dll")
		do
			internal_precompiled_path.put (a_path)
		ensure
			precompiled_path_set: precompiled_path = a_path
		end

feature -- Basic Operation

	add_cluster (a_name, a_directory_path: STRING) is
			-- Add a cluster to system at path 'a_directory_path'
		require
			non_void_directory_path: a_directory_path /= Void
			a_directory_exists: (create {DIRECTORY}.make (a_directory_path)).exists
		local
			l_cluster: ECDP_LACE_CLUSTER
			exists: BOOLEAN
		do
			a_name.replace_substring_all ("%"%"", "%"")
			a_directory_path.replace_substring_all ("%"%"", "%"")
			create l_cluster.make_with_name_and_path (a_name, create {FILE_NAME}.make_from_string (a_directory_path))
			
			from
				User_clusters.start
			until
				User_clusters.after or exists
			loop
				if User_clusters.item.name.is_equal (a_name) then
					exists := True
				end
				User_clusters.forth
			end
			
			if not exists then
				user_clusters.extend (l_cluster)
			end
		end
	
	reset is
			-- Re-initialize object as it was at first creation.
		do
			make
			set_precompiled_path (Codedom_installation_path + "precomp\spec\dotnet\base\EifGen\w_code\base.dll")
		end

feature -- Status Repport

	asssemblies_initialized: BOOLEAN
			-- Has `Assemblies' been initialized?

	has (a_path: STRING): BOOLEAN is
			-- return true if `a_path' is a subdirectory of one of the clusters path.
		require
			non_void_path: a_path /= Void
			non_empty_path: not a_path.is_empty
		do
			Result := true
		end

	Codedom_key: STRING is "codedom"
			-- Name of registry key holding path to Eiffel CodeDOM Provider dll

	Codedom_installation_path: STRING is
			-- Where is Eiffel CodeDOM Provider installed?
		local   
			l_str: SYSTEM_STRING
			l_registry_key: REGISTRY_KEY   
			l_obj: SYSTEM_OBJECT
		once
			if Result = Void then   
				l_registry_key := feature {REGISTRY}.local_machine   
				l_registry_key := l_registry_key.open_sub_key ("SOFTWARE")
				l_registry_key := l_registry_key.open_sub_key ("ISE")
				l_registry_key := l_registry_key.open_sub_key ("CodeDom")   
				l_obj := l_registry_key.get_value (Codedom_key)   
				l_str ?= l_obj   

				if l_str /= Void then   
					create Result.make_from_cil (l_str)  
				end   
			end 

			check
				Codedom_defined: Result /= Void
			end
			if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator 
		end

feature -- Basic Operation

	valid_extension (an_extension: STRING): BOOLEAN is
			-- Is `an_extension' a valid file extension for the generated assembly?
		require
			non_void_an_extension: an_extension /= Void
			non_empty_an_extension: not an_extension.is_empty
		do
			Result := an_extension.as_lower.is_equal ("exe") or an_extension.as_lower.is_equal ("dll")
		end

feature {NONE} -- Code Generation

	internal_precompiled_path: CELL [STRING] is
			-- Internal representation of `precompiled_path'
		once
			create Result.put (Codedom_installation_path + "precomp\spec\dotnet\base\EIFGEN\W_code\base.dll")
		ensure
			non_void_internal_precompiled_path: Result /= Void
		end
		
	default_setting: STRING is
	"[
default
	assertion (no)
	msil_generation (yes)
	arguments (" ")
	disabled_debug (yes)
	debug (no)
	il_verifiable (yes)
	cls_compliant (yes)
	dotnet_naming_convention (no)
	use_cluster_name_as_namespace (no)
	use_all_cluster_name_as_namespace (no)
	check_vape (yes)
	console_application (no)
	address_expression (no)
]"

	clusters_clause_code: STRING is
			-- | Result := "cluster
			-- |				all `cluster_name': "`cluster_path'"
			-- |					cluster_excludes"

			-- Clusters clause code
		local
			a_cluster: ECDP_LACE_CLUSTER
		do
			create Result.make (600)
			Result.append ("cluster")
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.New_line)

				-- Source generated cluster.
			create a_cluster.make_with_name_and_path (system_name + "_generated_sources", create {FILE_NAME}.make_from_string (path_to_generated_src))
			Result.append (cluster_declaration_code (a_cluster))

			if precompiled_path.is_empty then
					-- Eiffel base clusters.
				from
					base_clusters.start
				until
					base_clusters.after
				loop
					a_cluster := base_clusters.item
					if a_cluster /= Void then
						Result.append (cluster_declaration_code (a_cluster))
					end
					base_clusters.forth
				end
			end

				-- User defined clusters
			from
				user_clusters.start
			until
				user_clusters.after
			loop
				a_cluster := user_clusters.item
				if a_cluster /= Void then
					Result.append (cluster_declaration_code (a_cluster))
				end
				user_clusters.forth
			end
		end
	
	cluster_declaration_code (a_cluster: ECDP_LACE_CLUSTER): STRING is
			-- Code corresponding to `a_cluster'
		require
			non_void_a_cluster: a_cluster /= Void
		do
			create Result.make (500)
			Result.append (Dictionary.Tab)
			if a_cluster.all_sub_dir then
				Result.append (Dictionary.All_keyword)
				Result.append (Dictionary.Space)
			end
			Result.append (Dictionary.Double_quotes)
			Result.append (a_cluster.name)
			Result.append (Dictionary.Double_quotes)
			Result.append (Dictionary.colon)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Double_quotes)
			Result.append (a_cluster.path)
			Result.append (Dictionary.Double_quotes)
			Result.append (Dictionary.New_line)
			Result.append (cluster_excludes_code (a_cluster))
			Result.append (Dictionary.New_line)
		ensure
			non_void_generate_cluster: Result /= Void
			not_empty_generate_cluster: Result /= Void
		end	

	cluster_excludes_code (a_cluster: ECDP_LACE_CLUSTER): STRING is
			-- | Result := "exclude
			-- |				`an_exclude' [, `an_other_exclude']
			-- |			end"
			-- Cluster `a_cluster' exclude clause source code
		require
			non_void_cluster: a_cluster /= Void
		local
			an_exclude: STRING
			first_element: BOOLEAN
		do
			create Result.make (200)
			from
				a_cluster.excludes.start
				first_element := true
			until
				a_cluster.excludes.after
			loop
				an_exclude := a_cluster.excludes.item
				if an_exclude /= Void then
					if first_element then
						Result.append (Dictionary.Tab)
						Result.append (Dictionary.Tab)
						Result.append ("exclude")
						Result.append (Dictionary.New_line)
						Result.append (Dictionary.Tab)
						Result.append (Dictionary.Tab)
						Result.append (Dictionary.Tab)
						first_element := false
					end
					Result.append (Dictionary.Space)
					Result.append (Dictionary.Double_quotes)
					Result.append (an_exclude)
					Result.append (Dictionary.Double_quotes)
					Result.append (Dictionary.Semi_colon)
				end
				a_cluster.excludes.forth
			end
			if not first_element then
				Result.append (Dictionary.New_line)
				Result.append (Dictionary.Tab)
				Result.append (Dictionary.Tab)
				Result.append (Dictionary.End_keyword)
				Result.append (Dictionary.New_line)
			end
		end

	assemblies_clause: STRING is
			-- Result := "assembly:
			--					`an_external_path' [,
			--					`an_other_external_path']	" 
		local
			l_assembly: ASSEMBLY
			l_counter: INTEGER
			l_assembly_name: ASSEMBLY_NAME
			l_name, l_culture, l_version, l_public_key_token: STRING
			l_public_key_token_array: NATIVE_ARRAY [INTEGER_8]
			l_encoder: KEY_ENCODER
		do
			create Result.make (400)
			
			Result.append ("assembly")
			Result.append (Dictionary.New_line)

			create l_encoder
			from
				referenced_assemblies.start
			until
				referenced_assemblies.after
			loop
				l_assembly := referenced_assemblies.item.assembly
				l_assembly_name := l_assembly.get_name
				l_public_key_token_array := l_assembly_name.get_public_key_token
				l_public_key_token := l_encoder.encoded_key (l_public_key_token_array)
				if l_public_key_token /= Void and then not l_public_key_token.is_empty then
					create l_name.make_from_cil (l_assembly_name.name)
					create l_version.make_from_cil (l_assembly_name.version.to_string)
					create l_culture.make_from_cil (l_assembly_name.culture_info.name)
					if l_culture.is_empty then
						l_culture := "neutral"
					end
					create l_public_key_token.make_from_cil (l_public_key_token.to_cil)

					Result.append (Dictionary.Tab)
					if precompiled_referenced_assemblies.has (l_name) then
						Result.append (precompiled_referenced_assemblies.item (l_name))
					else
						l_counter := l_counter + 1
						Result.append ("assembly_" + l_counter.out)
					end
					Result.append (Dictionary.Colon)
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Double_quotes)
					Result.append (l_name)
					Result.append (Dictionary.Double_quotes)
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Double_quotes)
					Result.append (l_version)
					Result.append (Dictionary.Double_quotes)
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Double_quotes)
					Result.append (l_culture)
					Result.append (Dictionary.Double_quotes)
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Double_quotes)
					Result.append (l_public_key_token)
					Result.append (Dictionary.Double_quotes)
					Result.append (Dictionary.New_line)
	
						-- Add assembly prefix
					if not referenced_assemblies.item.assembly_prefix.is_empty then
						Result.append (Dictionary.Tab + Dictionary.Tab + "prefix")
						Result.append (Dictionary.New_line)
						Result.append (Dictionary.Tab + Dictionary.Tab + Dictionary.Tab + referenced_assemblies.item.assembly_prefix)
						Result.append (Dictionary.New_line)
						Result.append (Dictionary.Tab + Dictionary.Tab + Dictionary.End_keyword )
						Result.append (Dictionary.New_line)
					end
	
					Result.append (Dictionary.New_line)
				end
				referenced_assemblies.forth

			end
		end

invariant
	non_void_system: system_name /= Void
	non_void_root_class_name: root_class_name /= Void
	non_void_root_class_creation_routine: root_class_creation_routine /= Void
	non_void_path_to_generated_src: path_to_generated_src /= Void
	non_void_namespace: namespace /= Void
	non_void_extension: extension /= Void
	valid_extension: valid_extension (extension)
	
end -- class ECDP_ACE_FILE_WRITER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------