indexing
	description: "ISE Assembly manager support"
	external_name: "ISE.AssemblyManager.Support"

class
	ASSEMBLY_SUPPORT

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


	dependancies_from_info (a_descriptor: ASSEMBLY_DESCRIPTOR): ARRAY [CLI_CELL [ASSEMBLY_NAME]] is
		indexing
			description: "Dependancies of the assembly corresponding to `a_descriptor'"
			external_name: "DependanciesFromInfo"
		require
			non_void_assembly_descriptor: a_descriptor /= Void
		local
			conversion_support: CONVERSION_SUPPORT
			an_assembly_name: ASSEMBLY_NAME
			an_assembly: ASSEMBLY
			dependencies: LINKED_LIST [ CLI_CELL[ASSEMBLY]]
			i: INTEGER
			a_dependency: CLI_CELL [ASSEMBLY]
			a_dependency_name: ASSEMBLY_NAME
			retried: BOOLEAN
			item: CLI_CELL [ASSEMBLY_NAME]
		do
			if not retried then
				create conversion_support
				an_assembly_name := conversion_support.assembly_name_from_descriptor (a_descriptor)
				an_assembly := an_assembly.load (an_assembly_name)
				dependencies := intern_dependencies_from_info (an_assembly)
				create Result.make (1, dependencies.count)
				from
					i := 1
				until
					i > dependencies.count
				loop
					a_dependency ?= dependencies.i_th (i)
					if a_dependency /= Void then
						a_dependency_name := a_dependency.item.get_name
						if a_dependency_name /= Void then
							create item.put (a_dependency.item.get_name)
							Result.put (item, i)
						end
					end
					i := i + 1
				end
			else
				--create Result.make (0, 0)
			end
		rescue
			retried := True
			retry
		end				

	dependancies_string (dependancies: ARRAY [CLI_CELL[ASSEMBLY_NAME]]): STRING is
		indexing
			description: "String from `dependancies'"
			external_name: "DependanciesString"
		require
			non_void_dependancies: dependancies /= Void
			not_empty_dependancies: dependancies.count > 0
		local
			dependancies_list: SORTED_TWO_WAY_LIST [STRING]
			i: INTEGER
			a_dependancy: ASSEMBLY_NAME		
			a_name: STRING
		do
			create dependancies_list.make
			from
				i := 1
			until
				i > dependancies.count
			loop
				a_dependancy := dependancies.item (i).item
				dependancies_list.extend ( create {STRING}.make_from_cil (a_dependancy.get_name))
				i := i + 1
			end
			dependancies_list.sort
			
			Result := ""
			from
				dependancies_list.start
			until
				dependancies_list.after
			loop
				a_name := dependancies_list.item
				Result.append (a_name)
				if not dependancies_list.islast then
					Result.append (", ")
				end
				dependancies_list.forth
			end		
		ensure
			string_created: Result /= Void
		end

	eiffel_feature: EIFFEL_FEATURE
		indexing
			description: "Eiffel feature (Result of `has_feature')"
			external_name: "EiffelFeature"
		end
		
feature -- Status Report

	exists (a_class: EIFFEL_CLASS; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does a feature with `a_feature_name' exist in `eiffel_class'?"
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
		do
			Result := has_feature (a_class.initialization_features, a_feature_name)
					or has_feature (a_class.access_features, a_feature_name)
					or has_feature (a_class.element_change_features, a_feature_name)
					or has_feature (a_class.basic_operations, a_feature_name)
					or has_feature (a_class.unary_operators_features, a_feature_name)
					or has_feature (a_class.binary_operators_features, a_feature_name)
					or has_feature (a_class.special_features, a_feature_name)
					or has_feature (a_class.implementation_features, a_feature_name)
		end

feature {NONE} -- Implementation

	has_feature (a_list: LINKED_LIST [EIFFEL_FEATURE]; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does `a_list' contain feature with name `a_feature_name'?"
			external_name: "HasFeature"
		require
			non_void_list: a_list /= Void
			non_void_feature_name: a_feature_name /= Void
		local
			i: INTEGER
			a_feature: EIFFEL_FEATURE
			feature_name: STRING
			other_feature_name: STRING
		do
			from
				a_list.start
			until
				a_list.after or Result = True
			loop
				a_feature ?= a_list.item
				if a_feature /= Void then 
					feature_name := a_feature.eiffel_name.clone (a_feature.eiffel_name)
					feature_name.to_lower
					other_feature_name := a_feature_name.clone (a_feature_name)
					other_feature_name.to_lower
					if feature_name.is_equal (other_feature_name) then
						eiffel_feature := a_feature
						Result := True
					end
				end
				i := i + 1
			end
		end

	intern_dependencies_from_info (an_assembly: ASSEMBLY): LINKED_LIST [CLI_CELL[ASSEMBLY]]  is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_REFLECTION_ASSEMBLY]
		indexing
			description: "Dependancies of the assembly corresponding to `a_descriptor'"
			external_name: "InternDependenciesFromInfo"
		require
			non_void_assembly: an_assembly /= Void
		local
			assembly_names: NATIVE_ARRAY [ASSEMBLY_NAME]
			i: INTEGER
			a_dependency: ASSEMBLY_NAME
			new_assembly: ASSEMBLY
			retried: BOOLEAN
			added: INTEGER
			item: CLI_CELL[ASSEMBLY]
			assembly_string: STRING
			assembly_full_name: STRING
		do
			if not retried then
				assembly_string := "Microsoft.VisualC, Version=7.0.9249.59748, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
				assembly_names ?= an_assembly.get_referenced_assemblies
				create Result.make
				from
					i := 0
				until
					i = assembly_names.count
				loop
					a_dependency := assembly_names.item (i)
					create assembly_full_name.make_from_cil (a_dependency.get_full_name)
					if not is_done (assembly_full_name) then
						if not assembly_full_name.is_equal (assembly_string) then
							new_assembly := load_assembly_from_name (a_dependency)
							done.extend (assembly_full_name)
							if new_assembly /= Void then
								Result.append (intern_dependencies_from_info (new_assembly))
								create item.put (new_assembly)
								Result.extend (item)								
							end
						end
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
		
	load_assembly_from_name (assembly_name: ASSEMBLY_NAME): ASSEMBLY is
			-- attempts to load an assembly from and assembly name
		local
			rescued: BOOLEAN
		do
			if not rescued then
				Result := Result.load (assembly_name)
			else
				Result := Void
			end
		rescue
			rescued := true
			retry
		end
		
	
	done: LINKED_LIST [STRING]
		indexing
			description: "Loaded assemblies, used in `dependancies_from_info"
			external_name: "Done"
		end
		
	is_done (value: STRING): BOOLEAN is
			-- checks to see if the assembly has been done
		do
			from
				done.start
			until
				done.after or Result
			loop
				if done.item.is_equal (value) then
					Result := true
				end
				done.forth
			end
		end
		
		
end -- class ASSEMBLY_SUPPORT
