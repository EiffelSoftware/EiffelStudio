indexing
	description: "Include all the information needed to produce class Eiffel code and XML file."
	external_name: "ISE.Reflection.EiffelClass"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	EIFFEL_CLASS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes."
			external_name: "Make"
		do
			create parents.make
			create creation_routines.make 
			create initialization_features.make
			create access_features.make
			create element_change_features.make
			create basic_operations.make
			create unary_operators_features.make
			create binary_operators_features.make
			create special_features.make
			create implementation_features.make
			create invariants.make
		ensure
			non_void_parents: parents /= Void
			non_void_creation_routines: creation_routines /= Void
			non_void_initialization_features: initialization_features /= Void
			non_void_access_features: access_features /= Void
			non_void_element_change_features: element_change_features /= Void
			non_void_basic_operations: basic_operations /= Void
			non_void_unary_operators_features: unary_operators_features /= Void
			non_void_binary_operators_features: binary_operators_features /= Void
			non_void_special_features: special_features /= Void
			non_void_implementation_features: implementation_features /= Void
			non_void_invariants: invariants /= Void
		end
			
feature -- Access
			
	eiffel_name: STRING
		indexing
			description: "Eiffel name"
			external_name: "EiffelName"
		end
	
	full_external_name: STRING
		indexing
			description: "Full external name (i.e. with namespace)"
			external_name: "FullExternalName"
		end
		
	external_name: STRING 
		indexing
			description: ".NET simple name"
			external_name: "ExternalName"
		end
	
	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Descriptor of assembly defining current type"
			external_name: "AssemblyDescriptor"
		end
		
	namespace: STRING	
		indexing
			description: "Namespace defining current class"
			external_name: "Namespace"
		end
		
	parents: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Parent Eiffel name
			-- Value: Inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCE_CLAUSE]]) 
			-- (array with rename, undefine, redefine, select and export clauses)
		indexing
			description: "Parents"
			external_name: "Parents"
		end
		
	creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Creation routines Eiffel names "
			external_name: "CreationRoutines"
		end
		
	initialization_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Initialization features"
			external_name: "InitializationFeatures"
		end
		
	access_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Access features"
			external_name: "AccessFeatures"
		end
		
	element_change_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Element change features"
			external_name: "ElementChangeFeatures"
		end
		
	basic_operations: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Basic operations"
			external_name: "BasicOperations"
		end
		
	unary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Unary operators"
			external_name: "UnaryOperatorsFeatures"
		end
		
	binary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Binary operators"
			external_name: "BinaryOperatorsFeatures"
		end
		
	special_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]	
		indexing
			description: "Special features"
			external_name: "SpecialFeatures"
		end
		
	implementation_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]		
		indexing
			description: "Implementation features"
			external_name: "ImplementationFeatures"
		end
		
	invariants: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ARRAY [STRING]] 
			-- | (Array with invariant tag and invariant text)
		indexing
			description: "Class invariants"
			external_name: "Invariants"
		end

feature -- Eiffel names from .NET reflection info

	creation_routine_from_info (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): EIFFEL_FEATURE is
		indexing
			description: "Creation routine corresponding to .NET `info'"
			external_name: "CreationRoutineFromInfo"
		require
			non_void_info: info /= Void
		do
			if creation_routines.Count = 0 then
				Result := Void
			else
				if has_creation_routine (info) then
					Result := routine
				else
					Result := Void
				end
			end
		ensure
			non_void_feature_if_creation_routine_found: has_creation_routine (info) implies Result /= Void	
			void_feature_if_no_creation_routine_or_not_found: (creation_routines.Count = 0 or else not has_creation_routine (info)) implies Result = Void
		end
		
	attribute_from_info (info: SYSTEM_REFLECTION_MEMBERINFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel attribute corresponding to .NET `info'"
			external_name: "AttributeFromInfo"
		require
			non_void_info: info /= Void
		do
			if has_attribute (info, initialization_features) then
				Result := attribute
			elseif has_attribute (info, access_features) then
				Result := attribute
			elseif has_attribute (info, element_change_features) then
				Result := attribute
			elseif has_attribute (info, basic_operations) then
				Result := attribute
			elseif has_attribute (info, unary_operators_features) then
				Result := attribute
			elseif has_attribute (info, binary_operators_features) then
				Result := attribute
			elseif has_attribute (info, special_features) then
				Result := attribute
			elseif has_attribute (info, implementation_features) then
				Result := attribute
			else
				Result := Void
			end
		ensure
			non_void_attribute_if_is_initialization_feature: has_attribute (info, initialization_features) implies Result /= Void
			non_void_attribute_if_is_access_feature: has_attribute (info, access_features) implies Result /= Void
			non_void_attribute_if_is_element_change_feature: has_attribute (info, element_change_features) implies Result /= Void
			non_void_attribute_if_is_basic_operation: has_attribute (info, basic_operations) implies Result /= Void
			non_void_attribute_if_is_unary_operator: has_attribute (info, unary_operators_features) implies Result /= Void
			non_void_attribute_if_is_binary_operator: has_attribute (info, binary_operators_features) implies Result /= Void
			non_void_attribute_if_is_special_feature: has_attribute (info, special_features) implies Result /= Void
			non_void_attribute_if_is_implementation_feature: has_attribute (info, implementation_features) implies Result /= Void
			not_found_implies_void_result: (not has_attribute (info, initialization_features) 
									and not has_attribute (info, access_features)
									and not has_attribute (info, element_change_features)
									and not has_attribute (info, basic_operations)
									and not has_attribute (info, unary_operators_features)
									and not has_attribute (info, binary_operators_features)
									and not has_attribute (info, special_features)
									and not has_attribute (info, implementation_features)
									)
									implies Result = Void
		end
		
	routine_from_info (info: SYSTEM_REFLECTION_METHODINFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel routine corresponding to .NET `info'"
			external_name: "RoutineFromInfo"
		require
			non_void_info: info /= Void
		do
			if has_routine (info, initialization_features) then
				Result := routine
			elseif has_routine (info, access_features) then
				Result := routine
			elseif has_routine (info, element_change_features) then
				Result := routine
			elseif has_routine (info, basic_operations) then
				Result := routine
			elseif has_routine (info, unary_operators_features) then
				Result := routine
			elseif has_routine (info, binary_operators_features) then
				Result := routine
			elseif has_routine (info, special_features) then
				Result := routine
			elseif has_routine (info, implementation_features) then
				Result := routine
			else
				Result := Void
			end			
		ensure
			non_void_routine_if_is_initialization_feature: has_routine (info, initialization_features) implies Result /= Void
			non_void_routine_if_is_access_feature: has_routine (info, access_features) implies Result /= Void
			non_void_routine_if_is_element_change_feature: has_routine (info, element_change_features) implies Result /= Void
			non_void_routine_if_is_basic_operation: has_routine (info, basic_operations) implies Result /= Void
			non_void_routine_if_is_unary_operator: has_routine (info, unary_operators_features) implies Result /= Void
			non_void_routine_if_is_binary_operator: has_routine (info, binary_operators_features) implies Result /= Void
			non_void_routine_if_is_special_feature: has_routine (info, special_features) implies Result /= Void
			non_void_routine_if_is_implementation_feature: has_routine (info, implementation_features) implies Result /= Void
			not_found_implies_void_result: (not has_routine (info, initialization_features) 
									and not has_routine (info, access_features)
									and not has_routine (info, element_change_features)
									and not has_routine (info, basic_operations)
									and not has_routine (info, unary_operators_features)
									and not has_routine (info, binary_operators_features)
									and not has_routine (info, special_features)
									and not has_routine (info, implementation_features)
									)
									implies Result = Void
		end
		
feature -- Status Report

	is_frozen: BOOLEAN
		indexing
			description: "Is class frozen?"
			external_name: "IsFrozen"
		end
		
	is_expanded: BOOLEAN
		indexing
			description: "Is class expanded?"
			external_name: "IsExpanded"
		end
		
	is_deferred: BOOLEAN
		indexing
			description: "Is class deferred?"
			external_name: "IsDeferred"
		end
		
	create_none: BOOLEAN
		indexing
			description: "Does class have `create{NONE}' creation declaration?"
			external_name: "CreateNone"
		end
	
	modified: BOOLEAN
		indexing
			description: "Has current class been modified (i.e. have features been renamed)?"
			external_name: "Modified"
		end
		
feature -- Status Setting

	set_frozen (a_value: like is_frozen) is
		indexing
			description: "Set `is_frozen' with `a_value'."
			external_name: "SetFrozen"
		do
			is_frozen := a_value
		ensure
			frozen_set: is_frozen = a_value
		end
		
	set_expanded (a_value: like is_expanded) is
		indexing
			description: "Set `is_expanded' with `expanded'."
			external_name: "SetExpanded"
		do
			is_expanded := a_value
		ensure
			expanded_set: is_expanded = a_value
		end
	
	set_deferred (a_value: like is_deferred) is
		indexing
			description: "Set `is_deferred' with `deferred'."
			external_name: "SetDeferred"
		do
			is_deferred := a_value
		ensure
			deferred_set: is_deferred = a_value
		end

	set_create_none (a_value: like create_none) is
		indexing
			description: "Set `create_none' with `a_value'."
			external_name: "SetCreateNone"
		do
			create_none := a_value
		ensure
			create_none_set: create_none = a_value
		end
	
	set_modified is
		indexing
			description: "Set `modified' with `True'."
			external_name: "SetModified"
		do
			modified := True
		ensure
			modified: modified
		end
		
	set_eiffel_name (a_name: like eiffel_name) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.Equals_String (a_name)
		end
	
	set_external_name (a_name: like external_name) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.Equals_String (a_name)
		end	
	
	set_namespace (a_name: like namespace) is
		indexing
			description: "Set `namespace' with `a_name'."
			external_name: "SetNamespace"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
		do
			namespace := a_name
		ensure
			namespace_set: namespace.Equals_String (a_name)
		end	

	set_external_names (a_full_name: like full_external_name) is 
		indexing
			description: "[Set `full_external_name' from `a_full_name'.%
						%Set `external_name' and `namespace' from `a_full_name'.]"
			external_name: "SetExternalNames"
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.Length > 0
		local
			dot_index: INTEGER
			full_name: STRING
		do
			full_external_name := a_full_name
			full_name ?= a_full_name.Clone
			if full_name /= Void then
				full_name := full_name.Trim				
				dot_index := full_name.LastIndexOf_Char ('.')
				if dot_index > -1 then
					set_namespace (full_name.Substring_Int32_Int32 (0, dot_index))
					set_external_name (full_name.Substring (dot_index + 1))
				else
					set_external_name (full_name)
				end
			end
		ensure
			full_external_name_set: full_external_name.Equals_String (a_full_name)
		end

	set_assembly_descriptor (a_descriptor: like assembly_descriptor) is
		indexing
			description: "Set `descriptor' with `a_descriptor'."
			external_name: "SetAssemblyDescriptor"
		require
			non_void_descriptor: a_descriptor /= Void
		do
			assembly_descriptor := a_descriptor
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
		end
		
	set_full_external_name (a_full_name: like full_external_name) is
		indexing
			description: "Set `full_external_name' from `a_full_name'."
			external_name: "SetFullExternalName"
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.Length > 0
		do
			full_external_name := a_full_name
		ensure
			full_external_name_set: full_external_name.Equals_String (a_full_name)
		end
	
	set_parents (a_table: like parents) is
		indexing
			description: "Set `parents' with `a_table'."
			external_name: "SetParents"
		require
			non_void_table: a_table /= Void
		do
			parents := a_table
		ensure
			parents_set: parents = a_table
		end
		
feature -- Basic Operations

	add_parent (a_name: STRING; rename_clauses, undefine_clauses, redefine_clauses, select_clauses, export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | Inheritance clauses: SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCE_CLAUSE]
		indexing
			description: "Add new parent to `parents' with `a_name' as key and inheritance clauses as value.%
					%Inheritance clauses are built from `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses', `export_clauses'.]"
			external_name: "AddParent"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
			non_void_rename_clauses: rename_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
			non_void_export_clauses: export_clauses /= Void
		local
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			create inheritance_clauses.make (5)
			inheritance_clauses.put (0, rename_clauses)
			inheritance_clauses.put (1, undefine_clauses)
			inheritance_clauses.put (2, redefine_clauses)
			inheritance_clauses.put (3, select_clauses)
			inheritance_clauses.put (4, export_clauses)
			
			parents.Add (a_name, inheritance_clauses)
		ensure
			parent_added: parents.ContainsKey (a_name)
		end
	
	add_creation_routine (a_name: STRING) is
		indexing
			description: "Add `a_name' to `creation_routines'."
			external_name: "AddCreationRoutine"
		require
			non_void_routine_name: a_name /= Void
			not_empty_routine_name: a_name.Length > 0
		local
			routine_added: INTEGER
		do
			routine_added := creation_routines.Add (a_name)
		ensure
			routine_added: creation_routines.Contains (a_name)
		end

	add_initialization_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `initialization_features'."
			external_name: "AddInitializationFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := initialization_features.Add (a_feature)
		ensure
			feature_added: initialization_features.Contains (a_feature)
		end
		
	add_access_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `access_features'."
			external_name: "AddAccessFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := access_features.Add (a_feature)
		ensure
			feature_added: access_features.Contains (a_feature)
		end
		
	add_element_change_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `element_change_features'."
			external_name: "AddElementChangeFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := element_change_features.Add (a_feature)
		ensure
			feature_added: element_change_features.Contains (a_feature)
		end
		
	add_basic_operation (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `basic_operations'."
			external_name: "AddBasicOperation"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := basic_operations.Add (a_feature)
		ensure
			feature_added: basic_operations.Contains (a_feature)
		end
		
	add_unary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `unary_operator_features'."
			external_name: "AddUnaryOperator"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := unary_operators_features.Add (a_feature)
		ensure
			feature_added: unary_operators_features.Contains (a_feature)
		end
		
	add_binary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `binary_operator_features'."
			external_name: "AddBinaryOperator"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := binary_operators_features.Add (a_feature)
		ensure
			feature_added: binary_operators_features.Contains (a_feature)
		end
		
	add_special_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `special_features'."
			external_name: "AddSpecialFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := special_features.Add (a_feature)
		ensure
			feature_added: special_features.Contains (a_feature)
		end
		
	add_implementation_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `implementation_features'."
			external_name: "AddImplementationFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := implementation_features.Add (a_feature)
		ensure
			feature_added: implementation_features.Contains (a_feature)
		end
	
	add_invariant (a_tag, a_text: STRING) is
		indexing
			description: "Add new invariant (built from `a_tag' and `a_text'  to `invariants'."
			external_name: "AddInvariant"
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.Length > 0
		local
			invariant_added: INTEGER
			an_invariant: ARRAY [STRING]
		do
			create an_invariant.make (2)
			an_invariant.put (0, a_tag)
			an_invariant.put (1, a_text)
			invariant_added := invariants.Add (an_invariant)	
		end

feature {NONE} -- Implementation
		
	has_creation_routine (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): BOOLEAN is
		indexing
			description: "[Does current class has creation routine corresponding to `info'?%
						%If found, make Eiffel feature available in `routine'.]"
			external_name: "HasCreationRoutine"
		require
			non_void_info: info /= Void
		local
			i: INTEGER
			a_routine_name: STRING
		do
			from
				routine := Void
			until
				i = creation_routines.Count or Result 
			loop
				a_routine_name ?= creation_routines.Item (i)
				if a_routine_name /= Void then
					Result := has_routine (info, initialization_features)
				end
				i := i + 1
			end
		end

	attribute: EIFFEL_FEATURE
		indexing
			description: "Attribute (Result of `has_attribute' if attribute was found)"
			external_name: "Attribute"
		end
		
	has_attribute (info: SYSTEM_REFLECTION_MEMBERINFO; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "[Has `a_table' feature corresponding to `info'?%
						%If found, make Eiffel feature available in `attribute'.]"
			external_name: "HasAttribute"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			i: INTEGER
			eiffel_feature: EIFFEL_FEATURE
			retried: BOOLEAN
		do
			if not retried then
				from
					attribute := Void
				until
					i = a_list.Count or Result
				loop
					eiffel_feature ?= a_list.Item (i)
					if eiffel_feature /= Void then
						if info.Name.Equals_String (eiffel_feature.external_name) then
							attribute := eiffel_feature
							Result := True
						end
					end
					i := i + 1
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	routine: EIFFEL_FEATURE
		indexing
			description: "Routine (Result of `has_routine' if routine was found)"
			external_name: "Routine"
		end
	
	has_routine (info: SYSTEM_REFLECTION_METHODBASE; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "[Has `a_table' feature corresponding to `info'?%
					%If found, make Eiffel feature available in `routine'.]"
			external_name: "HasRoutine"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			i: INTEGER
			eiffel_feature: EIFFEL_FEATURE
			constructor_info: SYSTEM_REFLECTION_CONSTRUCTORINFO
			retried: BOOLEAN
		do
			if not retried then
				constructor_info ?= info
				from
					routine := Void
				until
					i = a_list.Count or Result
				loop
					eiffel_feature ?= a_list.Item (i)
					if eiffel_feature /= Void then
						if info.Name.Equals_String (eiffel_feature.external_name) then
							Result := intern_has_routine (eiffel_feature, info)
						elseif constructor_info /= Void then	
							Result := intern_has_routine (eiffel_feature, constructor_info)
						end
					end
					i := i + 1
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
	intern_has_routine (eiffel_feature: EIFFEL_FEATURE; info: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		indexing
			description: "[Does `eiffel_feature' match with `info'?%
					%If matching, set `routine' with `eiffel_feature'.]"
			external_name: "InternHasRoutine"
		require
			non_void_eiffel_feature: eiffel_feature /= Void
			non_void_info: info /= Void
		local
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			matching: BOOLEAN		
		do
			arguments := eiffel_feature.arguments
			if arguments.Count > 0 then
				matching := matching_arguments (info, arguments)
				if matching then
					routine := eiffel_feature
					Result := True
				end
			else
				routine := eiffel_feature
				Result := True
			end
		end
	
	matching_arguments (info: SYSTEM_REFLECTION_METHODBASE; arguments: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "Do Eiffel `arguments' match with .NET arguments of `info'?"
			external_name: "MatchingArguments"
		require
			non_void_info: info /= Void
			non_void_arguments: arguments /= Void		
		local
			j: INTEGER	
			an_argument: NAMED_SIGNATURE_TYPE
			retried: BOOLEAN
		do
			if not retried then
				if info.GetParameters /= Void then
					if info.GetParameters.count /= arguments.count then
						Result := False
					else
						from
							Result := True
							j := 0
						until
							j = arguments.Count or not Result
						loop
							an_argument ?= arguments.Item (j)
							if an_argument /= Void then
								Result := info.GetParameters.item (j).ParameterType.FullName.Equals_String (an_argument.type_full_external_name)
							else
								Result := False
							end
							j := j + 1
						end
					end
				else
					Result := False
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
invariant
	non_void_parents: parents /= Void
	non_void_creation_routines: creation_routines /= Void
	non_void_initialization_features: initialization_features /= Void
	non_void_access_features: access_features /= Void
	non_void_element_change_features: element_change_features /= Void
	non_void_basic_operations: basic_operations /= Void
	non_void_unary_operators_features: unary_operators_features /= Void
	non_void_binary_operators_features: binary_operators_features /= Void
	non_void_special_features: special_features /= Void
	non_void_implementation_features: implementation_features /= Void
	non_void_invariants: invariants /= Void
	frozen_xor_deferred: is_frozen xor is_deferred
	is_expanded_implies_no_creation_routine: is_expanded implies creation_routines.count = 0

end -- class EIFFEL_CLASS
