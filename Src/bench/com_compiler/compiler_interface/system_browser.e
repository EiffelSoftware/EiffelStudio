indexing
	description: "Facilities for browsing through a system"
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
							create ass_prop.make (assembly_i.cluster_name, assembly_i.assembly_name, assembly_i.prefix_name,
														assembly_i.version, assembly_i.culture, assembly_i.public_key_token)
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

	search_classes (a_string: STRING; is_substring: BOOLEAN): CLASS_ENUMERATOR is
			-- Search classes with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		local
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			matching_classes: LIST [CLASS_I]
			classes: ARRAY [CLASS_C]
			class_desc: CLASS_DESCRIPTOR
			count, i: INTEGER
			matcher: KMP_MATCHER
		do
			if Eiffel_project.initialized and then a_string /= Void then
				if is_substring then
					classes := Eiffel_system.Workbench.system.classes.sorted_classes
					count := Eiffel_system.Workbench.system.classes.count
					create res.make (count)
					create matcher.make_empty
					matcher.disable_case_sensitive
					matcher.set_pattern (a_string)
					from
						i := 1
					until
						i > count
					loop
						matcher.set_text (classes.item (i).lace_class.name)
						if matcher.search_for_pattern then
							create class_desc.make_with_class_i (classes.item (i).lace_class)
							if not class_desc.is_external then
								res.extend (class_desc)
							end
						end
						i := i + 1
					end
				else
					matching_classes := Eiffel_universe.compiled_classes_with_name (a_string)
					create res.make (matching_classes.count)
					from
						matching_classes.start
					until
						matching_classes.after
					loop
						create class_desc.make_with_class_i (matching_classes.item)
						if not class_desc.is_external then
							res.extend (class_desc)
						end
						matching_classes.forth
					end
				end
				create Result.make (res)
			end
		end

	search_features (a_string: STRING; is_substring: BOOLEAN): FEATURE_ENUMERATOR is
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
		do
			if Eiffel_project.initialized and then a_string /= Void then
				classes := Eiffel_system.Workbench.system.classes.sorted_classes
				count := Eiffel_system.Workbench.system.classes.count
				create res.make (count * 5)
				create matcher.make_empty
				matcher.disable_case_sensitive
				matcher.set_pattern (a_string)
				from
					i := 1
				until
					i > count
				loop
					feature_table := classes.item (i).feature_table
					if is_substring then
						from
							feature_table.start
						until
							feature_table.after
						loop
							feature_i := feature_table.item_for_iteration
							matcher.set_text (feature_i.feature_name)
							if matcher.search_for_pattern then
								create feature_desc.make_with_class_i_and_feature_i (classes.item (i).lace_class, feature_i)
								res.extend (feature_desc)
							end
							feature_table.forth
						end
					else
						feature_table.search (a_string)
						if feature_table.found_item /= Void then
							create feature_desc.make_with_class_i_and_feature_i (classes.item (i).lace_class, feature_table.found_item)
							res.extend (feature_desc)
						end
					end
					i := i + 1
				end
				create Result.make (res)
			end
		end
		
	description_from_dotnet_type (a_assembly_name, a_full_dotnet_type: STRING): STRING is
			-- Retrieve summary information for a dotnet type.
		local
			a_member_info: MEMBER_INFORMATION
			a_description_string: STRING
		do
			--assembly_information.initialize (a_assembly_name)
			a_member_info := assembly_information.find_type (a_full_dotnet_type)
			Result := a_member_info.summary
			if a_member_info /= Void then
				a_description_string := "%NSummary%N"
				a_description_string := a_description_string + a_member_info.summary
			else
				a_description_string := ""
			end
			Result := a_description_string
		end
		
	description_from_dotnet_feature (a_assembly_name, a_full_dotnet_feature, a_feature_signature: STRING): STRING is
			-- Retrieve summary information for a dotnet feature.
		local
			a_member_info: MEMBER_INFORMATION
			a_description_string: STRING
		do
			--assembly_information.initialize (a_assembly_name)
			a_member_info := assembly_information.find_type (a_full_dotnet_feature + a_feature_signature)
			if a_member_info /= Void then
				a_description_string := "%NSummary%N"
				a_description_string := a_description_string + a_member_info.summary
				
				from
					a_member_info.parameters.start
					if a_member_info.parameters.count > 0 then
						a_description_string := a_description_string + "%N%NParameters:%N"
					end
				until
					a_member_info.parameters.off
				loop
					a_description_string := a_description_string + a_member_info.parameters.item.name + ":" + a_member_info.parameters.item.description + "%N"
					a_member_info.parameters.forth
				end
				
				if not a_member_info.returns.is_equal ("") then
					a_description_string := a_description_string + "%N%NReturns:%N" + a_member_info.returns
				end
			else
				a_description_string := ""
			end
			Result := a_description_string
		end

feature {NONE} -- Implementation

	classes_descriptors: HASH_TABLE [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE, STRING] is
			-- Buffer of class descriptors used in `class_descriptor'
		once
			create Result.make (10)
		end
		
	assembly_information: ASSEMBLY_INFORMATION is
			-- 
		once
			create Result.make
			
			--| FIXME IEK For testing only
			Result.initialize ("C:\WINDOWS\Microsoft.NET\Framework\v1.0.3705\mscorlib.xml")
		end

end -- class SYSTEM_BROWSER
