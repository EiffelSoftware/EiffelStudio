indexing
	description: "ISE Assembly manager support"
	external_name: "ISE.AssemblyManager.Support"

class
	SUPPORT

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `done'."
			external_name: "Make"
		do
			create done.make
		ensure
			non_void_done: done /= Void
		end
			
feature -- Access


	dependancies_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME] is
		indexing
			description: "Dependancies of the assembly corresponding to `a_descriptor'"
			external_name: "DependanciesFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			conversion_support: ISE_REFLECTION_CONVERSIONSUPPORT
			an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			an_assembly: SYSTEM_REFLECTION_ASSEMBLY
			dependencies: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_dependency: SYSTEM_REFLECTION_ASSEMBLY
			a_dependency_name: SYSTEM_REFLECTION_ASSEMBLYNAME
			retried: BOOLEAN
		do
			if not retried then
				create conversion_support.make_conversionsupport
				an_assembly_name := conversion_support.assembly_name_from_descriptor (a_descriptor)
				an_assembly := an_assembly.load (an_assembly_name)
				dependencies := intern_dependencies_from_info (an_assembly)
				create Result.make (dependencies.get_count)
				from
				until
					i = dependencies.get_count
				loop
					a_dependency ?= dependencies.get_item (i)
					if a_dependency /= Void then
						a_dependency_name := a_dependency.get_name
						if a_dependency_name /= Void then
							Result.put (i, a_dependency.get_name)
						end
					end
					i := i + 1
				end
			else
				create Result.make (0)
			end
		rescue
			retried := True
			retry
		end				

	dependancies_string (dependancies: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]): STRING is
		indexing
			description: "String from `dependancies'"
			external_name: "DependanciesString"
		require
			non_void_dependancies: dependancies /= Void
			not_empty_dependancies: dependancies.count > 0
		local
			dependancies_list: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_dependancy: SYSTEM_REFLECTION_ASSEMBLYNAME		
			added: INTEGER
			a_name: STRING
		do
			create dependancies_list.make
			from
				i := 0
			until
				i = dependancies.count
			loop
				a_dependancy := dependancies.item (i)
				added := dependancies_list.add (a_dependancy.get_name)
				i := i + 1
			end
			dependancies_list.sort
			
			create Result.make_2 ('%U', 0)
			from
				i := 0
			until
				i = dependancies_list.get_Count
			loop
				a_name ?= dependancies_list.get_item (i)
				Result := Result.Concat_String_String (Result, a_name)
				if i < dependancies_list.get_Count - 1 then
					Result := Result.Concat_String_String (Result, ", ")
				end
				i := i + 1
			end		
		ensure
			string_created: Result /= Void
		end

	eiffel_feature: ISE_REFLECTION_EIFFELFEATURE
		indexing
			description: "Eiffel feature (Result of `has_feature')"
			external_name: "EiffelFeature"
		end
		
feature -- Status Report

	exists (a_class: ISE_REFLECTION_EIFFELCLASS; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does a feature with `a_feature_name' exist in `eiffel_class'?"
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
		do
			Result := has_feature (a_class.get_initialization_features, a_feature_name)
					or has_feature (a_class.get_access_features, a_feature_name)
					or has_feature (a_class.get_element_change_features, a_feature_name)
					or has_feature (a_class.get_basic_operations, a_feature_name)
					or has_feature (a_class.get_unary_operators_features, a_feature_name)
					or has_feature (a_class.get_binary_operators_features, a_feature_name)
					or has_feature (a_class.get_special_features, a_feature_name)
					or has_feature (a_class.get_implementation_features, a_feature_name)
		end

feature {NONE} -- Implementation

	has_feature (a_list: SYSTEM_COLLECTIONS_ARRAYLIST; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does `a_list' contain feature with name `a_feature_name'?"
			external_name: "HasFeature"
		require
			non_void_list: a_list /= Void
			non_void_feature_name: a_feature_name /= Void
		local
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
			until
				i = a_list.get_count or Result
			loop
				a_feature ?= a_list.get_item (i)
				if a_feature /= Void and then a_feature.get_eiffel_name.to_lower.equals_string (a_feature_name.to_lower) then
					eiffel_feature := a_feature
					Result := True
				end
				i := i + 1
			end
		end

	intern_dependencies_from_info (an_assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_REFLECTION_ASSEMBLY]
		indexing
			description: "Dependancies of the assembly corresponding to `a_descriptor'"
			external_name: "InternDependenciesFromInfo"
		require
			non_void_assembly: an_assembly /= Void
		local
			assembly_names: ARRAY [SYSTEM_REFLECTION_ASSEMBLYNAME]
			i: INTEGER
			a_dependency: SYSTEM_REFLECTION_ASSEMBLYNAME
			new_assembly: SYSTEM_REFLECTION_ASSEMBLY
			retried: BOOLEAN
			added: INTEGER
		do
			if not retried then
				assembly_names := an_assembly.get_referenced_assemblies
				create Result.make
				from
				until
					i = assembly_names.count
				loop
					a_dependency := assembly_names.item (i)
					if not done.contains (a_dependency.get_full_name) and not a_dependency.get_full_name.equals_string ("Microsoft.VisualC, Version=7.0.9249.59748, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" ) then
						new_assembly := new_assembly.load (a_dependency)
						added := done.add (a_dependency.get_full_name)
						Result.add_range (intern_dependencies_from_info (new_assembly))
						added := Result.add (new_assembly)
					end
					i := i + 1
				end
			else
				Result := Void
			end
		rescue
			retried := True
			retry
		end
	
	done: SYSTEM_COLLECTIONS_ARRAYLIST
		indexing
			description: "Loaded assemblies, used in `dependancies_from_info"
			external_name: "Done"
		end
		
end -- class SUPPORT
