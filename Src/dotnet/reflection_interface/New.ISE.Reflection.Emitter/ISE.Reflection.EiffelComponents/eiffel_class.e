indexing
	description: "Include all the information needed to produce class Eiffel code and XML file."
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	EIFFEL_CLASS

inherit 
	HASHABLE

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes."
		do
			create parents.make (1)
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
		end
	
	full_external_name: STRING
		indexing
			description: "Full external name (i.e. with namespace)"
		end
		
	external_name: STRING 
		indexing
			description: ".NET simple name"
		end
	
	enum_type: STRING
		indexing
			description: "Enum type (in case current type is an enum)"
		end
		
	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Descriptor of assembly defining current type"
		end
		
	namespace: STRING	
		indexing
			description: "Namespace defining current class"
		end
		
	parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			--[ARRAY [INHERITANCE_CLAUSE]]
			-- Key: Parent Eiffel name
			-- Value: Inheritance clauses (ARRAY [ARRAY_LIST [INHERITANCE_CLAUSE]]) 
			-- (array with rename, undefine, redefine, select and export clauses)
		indexing
			description: "Parents"
		end
		
	initialization_features: LINKED_LIST [EIFFEL_FEATURE]
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Initialization features"
		end
		
	access_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Access features"
		end
		
	element_change_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Element change features"
		end
		
	basic_operations: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Basic operations"
		end
		
	unary_operators_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Unary operators"
		end
		
	binary_operators_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]
		indexing
			description: "Binary operators"
		end
		
	special_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]	
		indexing
			description: "Special features"
		end
		
	implementation_features: LINKED_LIST [EIFFEL_FEATURE] 
			-- | ARRAY_LIST [EIFFEL_FEATURE]		
		indexing
			description: "Implementation features"
		end
		
	invariants: LINKED_LIST [ARRAY [STRING]]
			-- | ARRAY_LIST [ARRAY [STRING]] 
			-- | (Array with invariant tag and invariant text)
		indexing
			description: "Class invariants"
		end
	
	generic_derivations: ARRAY [GENERIC_DERIVATION]
		indexing
			description: "List of derivations of the class if it is generic"
		end
	
	constraints: ARRAY [STRING]
		indexing
			description: "Constraints corresponding to the generic types"
		end
	
	hash_code: INTEGER is
		do
			Result := Current.get_hash_code
		end
		
		
feature -- Eiffel names from .NET reflection info

	creation_routine_from_info (info: CONSTRUCTOR_INFO): EIFFEL_FEATURE is
		indexing
			description: "Creation routine corresponding to .NET `info'"
		require
			non_void_info: info /= Void
		do
			if initialization_features.count = 0 then
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
			void_feature_if_no_creation_routine_or_not_found: (initialization_features.count = 0 or else not has_creation_routine (info)) implies Result = Void
		end
		
	attribute_from_info (info:MEMBER_INFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel attribute corresponding to .NET `info'"
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
		
	routine_from_info (info: METHOD_INFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel routine corresponding to .NET `info'"
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
		end
		
	is_expanded: BOOLEAN
		indexing
			description: "Is class expanded?"
		end
		
	is_deferred: BOOLEAN
		indexing
			description: "Is class deferred?"
		end
		
	create_none: BOOLEAN
		indexing
			description: "Does class have `create{NONE}' creation declaration?"
		end
	
	modified: BOOLEAN
		indexing
			description: "Has current class been modified (i.e. have features been renamed)?"
		end
	
	bit_or_infix: BOOLEAN
		indexing
			description: "Has a `bit_or' feature to be generated in current type?"
		end
	
	is_generic: BOOLEAN
		indexing
			description: "Is class generic?"
		end
	
feature -- Status Setting

	set_frozen (a_value: BOOLEAN) is
		indexing
			description: "Set `is_frozen' with `a_value'."
		do
			is_frozen := a_value
		ensure
			frozen_set: is_frozen = a_value
		end
		
	set_expanded (a_value: BOOLEAN) is
		indexing
			description: "Set `is_expanded' with `expanded'."
		do
			is_expanded := a_value
		ensure
			expanded_set: is_expanded = a_value
		end
	
	set_deferred (a_value: BOOLEAN) is
		indexing
			description: "Set `is_deferred' with `deferred'."
		do
			is_deferred := a_value
		ensure
			deferred_set: is_deferred = a_value
		end

	set_create_none (a_value: BOOLEAN) is
		indexing
			description: "Set `create_none' with `a_value'."
		do
			create_none := a_value
		ensure
			create_none_set: create_none = a_value
		end
	
	set_modified (a_value: BOOLEAN) is
		indexing
			description: "Set `modified' with `a_value'."
		do
			modified := a_value
		ensure
			modified_set: modified = a_value
		end

	set_bit_or_infix (a_value: BOOLEAN) is
		indexing
			description: "Set `bit_or_infix' with `a_value'."
		do
			bit_or_infix := a_value
		ensure
			bit_or_infix_set: bit_or_infix = a_value
		end

	set_generic (a_value: BOOLEAN) is
		indexing
			description: "Set `is_generic' with `a_value'."
		do
			is_generic := a_value
		ensure
			is_generic_set: is_generic = a_value
		end
		
	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.is_equal (a_name)
		end
	
	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.is_equal (a_name)
		end	
	
	set_enum_type (an_enum_type: STRING) is
		indexing
			description: "Set `enum_type' with `an_enum_type'."
		require
			non_void_enum_type: an_enum_type /= Void
			not_empty_enum_type: an_enum_type.count > 0
		do
			enum_type := an_enum_type
		ensure
			enum_type_set: enum_type.is_equal (an_enum_type)
		end
		
	set_namespace (a_name: STRING) is
		indexing
			description: "Set `namespace' with `a_name'."
		require
			non_void_name: a_name /= Void
		do
			namespace := a_name
		ensure
			namespace_set: namespace.is_equal (a_name)
		end	

	set_external_names (a_full_name: STRING) is 
		indexing
			description: "[
						Set `full_external_name' from `a_full_name'.
						Set `external_name' and `namespace' from `a_full_name'.
					  ]"
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.count > 0
		local
			namespace_string: STRING
			name_elements: LIST [STRING]
			--namespace_elements: ARRAY [STRING]
			i: INTEGER
		do
			full_external_name := a_full_name
			name_elements := a_full_name.split ('.')
			set_external_name (name_elements.i_th (name_elements.count))
			if name_elements.count > 1 then
			--	create namespace_elements.make (1, name_elements.count )
			--	namespace_string := ""
			--	from
			--		i := 1
			--	until
			--		i > name_elements.count - 1
			--	loop
			--		namespace_elements.put (name_elements.i_th (i), i)
			--		i := i + 1
			--	end
			--	
			--	from
			--		i := 1
			--	until
			---		i > namespace_elements.count
			--	loop
			--		if i > 1 and i < namespace_elements.count then
			--			namespace_string.append (".")
			--		end
			--		namespace_string.append (namespace_elements.item (i))
			---		i := i + 1
			--	end
				
				-- maybe use
				-- namespace_string := a_full_name.clone (a_full_name)
				 namespace_string := a_full_name.substring (1, a_full_name.last_index_of ('.', a_full_name.count) - 1)
				
				set_namespace (namespace_string)
			else
				set_namespace ("")
			end
		ensure
			full_external_name_set: full_external_name.is_equal (a_full_name)
		end

	set_assembly_descriptor (a_descriptor: like assembly_descriptor) is
		indexing
			description: "Set `descriptor' with `a_descriptor'."
		require
			non_void_descriptor: a_descriptor /= Void
		do
			assembly_descriptor := a_descriptor
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
		end
		
	set_full_external_name (a_full_name: STRING) is
		indexing
			description: "Set `full_external_name' from `a_full_name'."
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.count > 0
		do
			full_external_name := a_full_name
		ensure
			full_external_name_set: full_external_name.is_equal (a_full_name)
		end
	
	set_parents (a_table: like parents) is
		indexing
			description: "Set `parents' with `a_table'."
		require
			non_void_table: a_table /= Void
		do
			parents := a_table
		ensure
			parents_set: parents = a_table
		end

	set_generic_derivations (derivations_table: like generic_derivations) is
		indexing
			description: "Set `generic_derivations' with `derivations_table'."
		require
			is_generic: is_generic
			non_void_derivations_table: derivations_table /= Void
		do
			generic_derivations := derivations_table
		ensure
			generic_derivations_set: generic_derivations = derivations_table
		end
	
	set_constraints (constraints_table: like constraints) is
		indexing
			description: "Set `constraints' with `constraints_table'."
		require
			is_generic
			non_void_constraints_table: constraints_table /= Void
		do
			constraints	:= constraints_table
		ensure
			constraints_set: constraints = constraints_table
		end
		
feature -- Basic Operations

	add_parent (a_parent: PARENT) is
		indexing
			description: "[
						Add new parent to `parents' with `a_parent' name as key and inheritance clauses as value.
						Inheritance clauses are built from `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses', `export_clauses' of `a_parent'.
					  ]"
		require
			non_void_parent: a_parent /= Void
			non_void_name: a_parent.name /= Void
			not_empty_name: a_parent.name.count > 0
			non_void_rename_clauses: a_parent.rename_clauses /= Void
			non_void_undefine_clauses: a_parent.undefine_clauses /= Void
			non_void_redefine_clauses: a_parent.redefine_clauses /= Void
			non_void_select_clauses: a_parent.select_clauses /= Void
			non_void_export_clauses: a_parent.export_clauses /= Void
		local
			inheritance_clauses: ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]]
		do
			create inheritance_clauses.make (0, 4)
			inheritance_clauses.put (a_parent.rename_clauses, 0)
			inheritance_clauses.put (a_parent.undefine_clauses, 1)
			inheritance_clauses.put (a_parent.redefine_clauses, 2)
			inheritance_clauses.put (a_parent.select_clauses, 3)
			inheritance_clauses.put (a_parent.export_clauses, 4)
			
			--parents.extend(
			
			parents.extend (inheritance_clauses, a_parent.name)
		ensure
			parent_added: parents.valid_key (a_parent.name)
		end
	
	add_initialization_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `initialization_features'."
		require
			non_void_feature: a_feature /= Void
		do
			initialization_features.extend (a_feature)
		ensure
			feature_added: initialization_features.has (a_feature)
		end
		
	add_access_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `access_features'."
		require
			non_void_feature: a_feature /= Void
		do
			access_features.extend (a_feature)
		ensure
			feature_added: access_features.has (a_feature)
		end
		
	add_element_change_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `element_change_features'."
		require
			non_void_feature: a_feature /= Void
		do
			element_change_features.extend (a_feature)
		ensure
			feature_added: element_change_features.has (a_feature)
		end
		
	add_basic_operation (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `basic_operations'."
		require
			non_void_feature: a_feature /= Void
		do
			basic_operations.extend (a_feature)
		ensure
			feature_added: basic_operations.has (a_feature)
		end
		
	add_unary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `unary_operator_features'."
		require
			non_void_feature: a_feature /= Void
		do
			unary_operators_features.extend (a_feature)
		ensure
			feature_added: unary_operators_features.has (a_feature)
		end
		
	add_binary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `binary_operator_features'."
		require
			non_void_feature: a_feature /= Void
		do
			binary_operators_features.extend (a_feature)
		ensure
			feature_added: binary_operators_features.has (a_feature)
		end
		
	add_special_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `special_features'."
		require
			non_void_feature: a_feature /= Void
		do
			special_features.extend (a_feature)
		ensure
			feature_added: special_features.has (a_feature)
		end
		
	add_implementation_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `implementation_features'."
		require
			non_void_feature: a_feature /= Void
		do
			implementation_features.extend (a_feature)
		ensure
			feature_added: implementation_features.has (a_feature)
		end
	
	add_invariant (a_tag, a_text: STRING) is
		indexing
			description: "Add new invariant (built from `a_tag' and `a_text'  to `invariants'."
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			an_invariant: ARRAY [STRING]
		do
			create an_invariant.make (0, 1)
			an_invariant.put (a_tag, 0)
			an_invariant.put (a_text, 1)
			invariants.extend (an_invariant)
		ensure
			invariant_added: invariants.count = old (invariants.count + 1)
		end
		
feature {NONE} -- Implementation
		
	has_creation_routine (info: CONSTRUCTOR_INFO): BOOLEAN is
		indexing
			description: "[
						Does current class has creation routine corresponding to `info'?
						If found, make Eiffel feature available in `routine'.
					  ]"
		require
			non_void_info: info /= Void
		do
			Result := has_routine (info, initialization_features)
		end

	attribute: EIFFEL_FEATURE
		indexing
			description: "Attribute (Result of `has_attribute' if attribute was found)"
		end
		
	has_attribute (info: MEMBER_INFO; a_list: LINKED_LIST [EIFFEL_FEATURE]): BOOLEAN is
		indexing
			description: "[
						Has `a_table' feature corresponding to `info'?
						If found, make Eiffel feature available in `attribute'.
					  ]"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			eiffel_feature: EIFFEL_FEATURE
			retried: BOOLEAN
		do
			if not retried then
				from
					attribute := Void
					a_list.start
				until
					a_list.after or Result
				loop
					eiffel_feature ?= a_list.item
					if eiffel_feature /= Void then
						if info.get_name.equals (eiffel_feature.external_name.to_cil) then
							attribute := eiffel_feature
							Result := True
						end
					end
					a_list.forth
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
		end
	
	has_routine (info: METHOD_BASE; a_list: LINKED_LIST[EIFFEL_FEATURE]): BOOLEAN is
		indexing
			description: "[
						Has `a_table' feature corresponding to `info'?
						If found, make Eiffel feature available in `routine'.
					  ]"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			eiffel_feature: EIFFEL_FEATURE
			constructor_info: CONSTRUCTOR_INFO
			retried: BOOLEAN
		do
			if not retried then
				constructor_info ?= info
				from
					routine := Void
					a_list.start
				until
					a_list.after or Result
				loop
					eiffel_feature ?= a_list.item
					if eiffel_feature /= Void then
						if info.get_name.equals (eiffel_feature.external_name.to_cil) then
							Result := intern_has_routine (eiffel_feature, info)
						elseif constructor_info /= Void then	
							Result := intern_has_routine (eiffel_feature, constructor_info)
						end
					end
					a_list.forth
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
	intern_has_routine (eiffel_feature: EIFFEL_FEATURE; info: METHOD_BASE): BOOLEAN is
		indexing
			description: "[
						Does `eiffel_feature' match with `info'?
						If matching, set `routine' with `eiffel_feature'.
					  ]"
		require
			non_void_eiffel_feature: eiffel_feature /= Void
			non_void_info: info /= Void
		local
			arguments: LINKED_LIST [NAMED_SIGNATURE_TYPE_INTERFACE]
			matching: BOOLEAN		
		do
			arguments := eiffel_feature.arguments
			if arguments.count > 0 then
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
	
	matching_arguments (info: METHOD_BASE; arguments: LINKED_LIST[NAMED_SIGNATURE_TYPE_INTERFACE]): BOOLEAN is
		indexing
			description: "Do Eiffel `arguments' match with .NET arguments of `info'?"
		require
			non_void_info: info /= Void
			non_void_arguments: arguments /= Void		
		local
			j: INTEGER	
			an_argument: NAMED_SIGNATURE_TYPE_INTERFACE
			retried: BOOLEAN
		do
			if not retried then
				if info.get_parameters /= Void then
					if info.get_parameters.count /= arguments.count then
						Result := False
					else
						from
							Result := True
							arguments.start
						until
							arguments.after or not Result
						loop
							an_argument ?= arguments.item
							if an_argument /= Void then
								Result := info.get_parameters.item (j).get_parameter_type.get_full_name.equals (an_argument.type_full_external_name.to_cil)
							else
								Result := False
							end
							j := j + 1
							arguments.forth
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
	is_expanded_implies_no_creation_routine: is_expanded implies initialization_features.count = 0
	not_generic_implies_no_generic_derivations: not is_generic implies generic_derivations = Void
	generic_derivations_implies_generic: generic_derivations /= Void implies is_generic
	
end -- class EIFFEL_CLASS
