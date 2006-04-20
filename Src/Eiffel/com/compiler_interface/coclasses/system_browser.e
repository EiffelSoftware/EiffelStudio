indexing
	description: "Facilities for browsing through a system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_BROWSER

inherit
	IEIFFEL_SYSTEM_BROWSER_IMPL_STUB
		redefine
			system_classes,
			class_count,
			system_clusters,
			external_clusters,
			cluster_count,
			root_cluster,
			class_descriptor,
			feature_descriptor,
			cluster_descriptor,
			search_classes,
			search_features,
			description_from_dotnet_type,
			description_from_dotnet_feature,
			assemblies
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
		end
		
feature -- Access

	system_classes: CLASS_ENUMERATOR is
			-- List of classes in system.
		local
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			classes: ARRAY [CLASS_C]
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING]
			class_table: HASH_TABLE [CLASS_C, STRING]
			class_c: CLASS_C
			class_desc: CLASS_DESCRIPTOR
			count, i: INTEGER
		do
			if Eiffel_project.initialized then
				classes := Eiffel_system.Workbench.system.classes.sorted_classes
				count := Eiffel_system.Workbench.system.classes.count
				from
					create sorted_class_names.make
					create class_table.make (count)
					i := 1
				until
					i > count
				loop
					class_table.put (classes.item (i), classes.item (i).name)
					sorted_class_names.extend (classes.item (i).name)
					i := i + 1
				end
				sorted_class_names.compare_objects
				sorted_class_names.sort
				create res.make (count)
				from
					sorted_class_names.start
				until
					sorted_class_names.after
				loop
					class_c := class_table.item (sorted_class_names.item)
					create class_desc.make_with_class_i (class_c.lace_class)
					res.extend (class_desc)
					sorted_class_names.forth
				end
				create Result.make (res)
			end
		end

	class_count: INTEGER is
			-- Number of classes in system.
		do
			if Eiffel_project.initialized then
				Result := Eiffel_system.Workbench.system.classes.count
			end
		end

	system_clusters: CLUSTER_ENUMERATOR is
			-- List of system's top-level clusters.
		local
			list: LIST [CLUSTER_I]
			cluster_desc: CLUSTER_DESCRIPTOR
			res: ARRAYED_LIST [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
		do
			if Eiffel_project.initialized then
				list := Eiffel_universe.clusters
				create res.make (list.count)
				from
					list.start
				until
					list.after
				loop
					if list.item.parent_cluster = Void then
						create cluster_desc.make_with_cluster_i (list.item)
						if not cluster_desc.is_external_cluster then
							res.extend (cluster_desc)
						end
						
					end
					list.forth
				end
				create Result.make (res)
			end
		end
		
	assemblies: ASSEMBLY_ENUMERATOR is
			-- List of system's assemblies.
		local
			list: LIST [CLUSTER_I]
			res: ARRAYED_LIST [ASSEMBLY_PROPERTIES]
			assembly_i: ASSEMBLY_I
			ass_prop: ASSEMBLY_PROPERTIES
		do
			if Eiffel_project.initialized then
				list := Eiffel_universe.clusters
				create res.make (list.count)
				from
					list.start
				until
					list.after
				loop
					if list.item.parent_cluster = Void then
						assembly_i ?= list.item
						if assembly_i /= Void then
							if assembly_i.public_key_token /= Void then
								create ass_prop.make (assembly_i.cluster_name, assembly_i.assembly_name, assembly_i.prefix_name,
															assembly_i.version, assembly_i.culture, assembly_i.public_key_token)
							else
								create ass_prop.make_local (assembly_i.cluster_name, assembly_i.assembly_name, assembly_i.prefix_name)
							end
							res.extend (ass_prop)
						end
						
					end
					list.forth
				end
				create Result.make (res)
			end
		end
		
	external_clusters: CLUSTER_ENUMERATOR is
			-- List of system's top-level external clusters.
		local
			list: LIST [CLUSTER_I]
			cluster_desc: CLUSTER_DESCRIPTOR
			res: ARRAYED_LIST [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
		do
			if Eiffel_project.initialized then
				list := Eiffel_universe.clusters
				create res.make (list.count)
				from
					list.start
				until
					list.after
				loop
					if list.item.parent_cluster = Void then
						create cluster_desc.make_with_cluster_i (list.item)
						if cluster_desc.is_external_cluster then
							res.extend (cluster_desc)
						end
						
					end
					list.forth
				end
				create Result.make (res)
			end
		end
		
	cluster_count: INTEGER is
			-- Number of top-level clusters in system.
		local
			list: LIST [CLUSTER_I]
			cluster_desc: CLUSTER_DESCRIPTOR
		do
			if Eiffel_project.initialized then
				list := Eiffel_universe.clusters
				from
					list.start
				until
					list.after
				loop
					if list.item.parent_cluster = Void then
						create cluster_desc.make_with_cluster_i (list.item)
						if not cluster_desc.is_external_cluster then
							Result := Result + 1
						end
						
					end
					list.forth
				end
			end
		end
		
	root_cluster: IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Root cluster of current project
		local
			rc: CLASS_I
			ci: CLUSTER_I
		do
			if Eiffel_project.initialized then
				rc := Eiffel_project.system.root_class
				if rc /= Void then
					ci := rc.cluster	
				end
				if ci /= Void then
					create {CLUSTER_DESCRIPTOR} Result.make_with_cluster_i (ci)
				end
			end
		end
		
feature -- Basic Operations

	cluster_descriptor (cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
			-- Void if no matches.
		local
			ci: CLUSTER_I
		do
			if Eiffel_project.initialized and then cluster_name /= Void then
				ci := Eiffel_universe.cluster_of_name (cluster_name)
				if ci /= Void then
					create {CLUSTER_DESCRIPTOR} Result.make_with_cluster_i (ci)
				end
			end
		end

	class_descriptor (class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
			-- Void if no matches.
		local
			matching_classes: LIST [CLASS_I]
			index: INTEGER
			a_name: STRING
		do
			classes_descriptors.search (class_name1)
			if classes_descriptors.found then
				Result := classes_descriptors.found_item
			else
				if Eiffel_project.initialized and then class_name1 /= Void then
					index := class_name1.last_index_of ('[', class_name1.count)
					if index > 0 then
						a_name := class_name1.substring (1, index - 1)
						from
						until
							a_name.item (a_name.count) /= ' '
						loop
							a_name.keep_head (a_name.count - 1)
						end
					else
						a_name := class_name1
					end
					matching_classes := Eiffel_universe.compiled_classes_with_name (a_name)
					if not matching_classes.is_empty then
							--| FIXME What if matching_classes.count > 1 ?
						create {CLASS_DESCRIPTOR} Result.make_with_class_i (matching_classes.first)
					end
				end
				classes_descriptors.put (Result, class_name1)
			end
		end

	feature_descriptor (class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
			-- Void if no matches.
		local
			class_desc: CLASS_DESCRIPTOR
		do
			if Eiffel_project.initialized then
				class_desc ?= class_descriptor (class_name1)
				if class_desc /= Void then
					Result := class_desc.feature_with_name (feature_name)
				end
			end
		end

	search_classes (a_string: STRING; match_case: BOOLEAN; is_substring: BOOLEAN; is_prefix: BOOLEAN): CLASS_ENUMERATOR is
			-- Search classes with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		local
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			class_desc: CLASS_DESCRIPTOR
			matcher: KMP_MATCHER
			eiffel_class: CLASS_I
			dotnet_class: EXTERNAL_CLASS_I		
			cur: CURSOR
			cluster_classes: HASH_TABLE [CLASS_I, STRING]
			string_to_match, class_name_string: STRING
		do
			if Eiffel_project.initialized and then a_string /= Void then
				-- Retrieve a list of all the CLASS_I objects in the Eiffel Universe.
					create matcher.make_empty
					if not match_case then
						matcher.disable_case_sensitive
						string_to_match := a_string.as_lower
					else
						string_to_match := a_string.twin
					end
					matcher.set_pattern (string_to_match)
					create res.make (100)
				from
					cur := Eiffel_universe.clusters.cursor
					Eiffel_universe.clusters.start
				until
					Eiffel_universe.clusters.after
				loop
					cluster_classes := Eiffel_universe.clusters.item.classes
					from
						cluster_classes.start
					until
						cluster_classes.after
					loop
						eiffel_class := cluster_classes.item_for_iteration
						if is_substring then
							matcher.set_text (eiffel_class.name)
							if matcher.search_for_pattern then
								create class_desc.make_with_class_i (eiffel_class)
								res.extend (class_desc)
							else
								dotnet_class ?= eiffel_class
								if dotnet_class /= Void then
									if dotnet_class.is_compiled then
										matcher.set_text (dotnet_class.compiled_class.name)
									else
										matcher.set_text (dotnet_class.external_name)
									end
									if matcher.search_for_pattern then
										create class_desc.make_with_class_i (dotnet_class)
										res.extend (class_desc)
									end
								end
							end		
						else
							if not match_case then
								class_name_string := eiffel_class.name.as_lower
							else
								class_name_string := eiffel_class.name.twin
							end
							if is_prefix then
								class_name_string.keep_head (string_to_match.count.min (class_name_string.count))
							end
							if class_name_string.is_equal (string_to_match) then
								create class_desc.make_with_class_i (eiffel_class)
								res.extend (class_desc)
							else
								dotnet_class ?= eiffel_class
								if dotnet_class /= Void then
									if dotnet_class.is_compiled then
										class_name_string := dotnet_class.compiled_class.name.as_lower
										if class_name_string.is_equal (string_to_match) then
											create class_desc.make_with_class_i (eiffel_class)
											res.extend (class_desc)
										end -- if
									else
										class_name_string := dotnet_class.external_name.as_lower
										if class_name_string.is_equal (string_to_match) then
											create class_desc.make_with_class_i (eiffel_class)
											res.extend (class_desc)
										end -- if
									end -- if
								end -- if
							end -- if
						end -- if	
						cluster_classes.forth
					end -- loop
					Eiffel_universe.clusters.forth
				end -- loop
				Eiffel_universe.clusters.go_to (cur)
				create Result.make (res)
			end -- if
		end -- search_classes

	search_features (a_string: STRING; match_case: BOOLEAN; is_substring: BOOLEAN; is_prefix: BOOLEAN): FEATURE_ENUMERATOR is
			-- Search feature with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			classes: ARRAY [CLASS_C]
			feature_table: FEATURE_TABLE
			feature_i: FEATURE_I
			count, i: INTEGER
			matcher: KMP_MATCHER
			feature_desc: FEATURE_DESCRIPTOR
			string_to_match, feature_name_string: STRING
		do
			if Eiffel_project.initialized and then a_string /= Void then
				classes := Eiffel_system.Workbench.system.classes.sorted_classes
				count := Eiffel_system.Workbench.system.classes.count
				create res.make (count * 5)
				create matcher.make_empty
				if not match_case then
					matcher.disable_case_sensitive
					string_to_match := a_string.as_lower
				else
					string_to_match := a_string.twin
				end
				if is_substring then
					matcher.set_pattern (string_to_match)
				end
				create res.make (100)
				from
					i := 1
				until
					i > count
				loop
					feature_table := classes.item (i).feature_table
					
					from
						feature_table.start
					until
						feature_table.after
					loop
						feature_i := feature_table.item_for_iteration
						if feature_i.written_in = classes.item (i).class_id then
							if is_substring then
								matcher.set_text (feature_i.feature_name)
								if matcher.search_for_pattern then
									create feature_desc.make_with_class_i_and_feature_i (classes.item (i).lace_class, feature_i)
									res.extend (feature_desc)
								end
							else
								if not match_case then
									feature_name_string := feature_i.feature_name.as_lower
								else
									feature_name_string := feature_i.feature_name.twin
								end
								if is_prefix then
									feature_name_string.keep_head (string_to_match.count.min (feature_name_string.count))
								end
								if string_to_match.is_equal (feature_name_string) then
									create feature_desc.make_with_class_i_and_feature_i (classes.item (i).lace_class, feature_i)
									res.extend (feature_desc)
								end
							end
						end
						feature_table.forth
					end
					i := i + 1
				end
				create Result.make (res)
			end
		end
		
	description_from_dotnet_type (a_assembly_name, a_full_dotnet_type: STRING): STRING is
			-- Retrieve summary information for a dotnet type.
		local
			l_dictionary: IDM_DICTIONARY_INTERFACE
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_dictionary := dictionary_for_assembly (a_assembly_name)
				if l_dictionary /= Void then
					Result := l_dictionary.type_documentation (a_full_dotnet_type)
				end
				if Result = Void then
					Result := ""
				end
			end
		rescue
			l_retried := True
			retry
		end
		
	description_from_dotnet_feature (a_assembly_name, a_full_dotnet_feature, a_feature_signature: STRING): STRING is
			-- Retrieve summary information for a dotnet feature.
		local
			l_dictionary: IDM_DICTIONARY_INTERFACE
			l_type_name, l_feature_name: STRING
			l_description: IDM_FEATURE_DESCRIPTION_INTERFACE
			l_index: INTEGER
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_dictionary := dictionary_for_assembly (a_assembly_name)
				if l_dictionary /= Void then
					l_index := a_full_dotnet_feature.last_index_of ('.', a_full_dotnet_feature.count)
					if l_index > 0 then
						l_type_name := a_full_dotnet_feature.substring (1, l_index - 1)
						l_feature_name := a_full_dotnet_feature.substring (l_index + 1, a_full_dotnet_feature.count)
						l_description := l_dictionary.feature_documentation (l_type_name, l_feature_name, a_feature_signature)
						if l_description /= Void then
							Result := l_description.summary
						end
					end
				end
				if Result = Void then
					Result := ""
				end
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	classes_descriptors: HASH_TABLE [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE, STRING] is
			-- Buffer of class descriptors used in `class_descriptor'
		once
			create Result.make (10)
		end

	Documentation_manager: CDM_DOCUMENTATION_MANAGER_PROXY is
			-- 	Documentation manager
		once
			create Result.make
		end

	dictionary_for_assembly (a_assembly_name: STRING): IDM_DICTIONARY_INTERFACE is
			-- Dictionary if any for assembly `a_assembly_name'.
			-- `a_assembly_name' may be a path (for local assemblies) or a simple name
			-- (for EAC assemblies)
		require
			non_void_assembly_name: a_assembly_name /= Void
		local
			l_xml_file, l_dll_file, l_suffix, l_framework_path: STRING
		do
			if a_assembly_name.count > 3 then
				l_suffix := a_assembly_name.substring (a_assembly_name.count - 3, a_assembly_name.count)
				if l_suffix.is_equal (".dll") or l_suffix.is_equal (".exe") then
					l_xml_file := a_assembly_name.substring (1, a_assembly_name.count - 4) + ".xml"
					if (create {RAW_FILE}.make (l_xml_file)).exists then
						l_dll_file := a_assembly_name
					end
				end
			end
			if l_dll_file = Void then
				-- Try with PIA assembly
				l_framework_path := (create {IL_ENVIRONMENT}.make (Eiffel_project.system.System.clr_runtime_version)).dotnet_framework_path
				create l_xml_file.make (l_framework_path.count + 1 + a_assembly_name.count + 4)
				l_xml_file.append (l_framework_path)
				l_xml_file.append_character ('\')
				l_xml_file.append (a_assembly_name)
				l_xml_file.append (".xml")
				if (create {RAW_FILE}.make (l_xml_file)).exists then
					create l_dll_file.make (l_framework_path.count + 1 + a_assembly_name.count + 4)
					l_dll_file.append (l_framework_path)
					l_dll_file.append_character ('\')
					l_dll_file.append (a_assembly_name)
					l_dll_file.append (".dll")
				end
			end
			if l_dll_file /= Void then
				Result := Documentation_manager.dictionary (l_dll_file)
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class SYSTEM_BROWSER
