indexing
	description: "{CONSUMED_TYPE} factory"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CONSUMER

inherit
	REFLECTION

	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

	NAME_SOLVER

create
	make

feature {NONE} -- Initialization

	make (t: TYPE; en: STRING) is
			-- Initialize type consumer for type `t' with eiffel name `en'.
		require
			non_void_type: t /= Void
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		local
			dotnet_name: STRING
			parent_name: SYSTEM_STRING
			inter: NATIVE_ARRAY [TYPE]
			interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			parent: CONSUMED_REFERENCED_TYPE
			i, nb, count: INTEGER
			parent_type: TYPE
			l_is_nested: BOOLEAN
		do
			create dotnet_name.make_from_cil (t.get_full_name)
			parent_type := t.get_base_type
			if parent_type /= Void and then is_consumed_type (parent_type) then
				parent := referenced_type_from_type (parent_type)
			end 
			from
				inter := t.get_interfaces
				i := 0
				nb := inter.count - 1
				create interfaces.make (1, nb + 1)
		 	until
				i > nb
			loop
				parent_type := inter.item (i)
				if is_consumed_type (parent_type) then
					count := count + 1
					interfaces.force (referenced_type_from_type (parent_type), count)
				end
				i := i + 1
			end

			if count <= nb then
					-- Resize array only if needed.
				interfaces := interfaces.subarray (1, count)
			end

			if t.get_is_nested_public or t.get_is_nested_family or t.get_is_nested_fam_orassem then
					-- Let's initialize `l_is_nested' correctly and if it is set to
					-- true, update `parent_type' so that it contains the nested type
					-- enclosing type.
				parent_name := t.get_full_name
				parent_name := parent_name.substring_integer_32_integer_32 (0,
					parent_name.index_of_character ('+'))
				parent_type := t.get_assembly.get_type_string (parent_name)
				l_is_nested := parent_type /= Void and then parent_type.get_is_public
			end
			
			if l_is_nested then
					-- `parent_type' contains enclosing type of current nested type.
				create {CONSUMED_NESTED_TYPE} consumed_type.make (
					dotnet_name, en, t.get_is_interface, t.get_is_abstract,
					t.get_is_sealed, t.get_is_value_type, t.get_is_enum, parent, interfaces,
					referenced_type_from_type (parent_type))
			else	
				create consumed_type.make (dotnet_name, en, t.get_is_interface, t.get_is_abstract,
					t.get_is_sealed, t.get_is_value_type, t.get_is_enum, parent, interfaces)
			end

			if t.get_is_interface then
					-- Lookup members of current interface `t' but also add members coming
					-- from parent interfaces as `t.get_members_binding_flags' does not do it.
				update_interface_members (t)
--				internal_properties := t.get_properties_binding_flags (feature {BINDING_FLAGS}.instance |
--						feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public |
--						feature {BINDING_FLAGS}.flatten_hierarchy)
--				internal_events := t.get_events_binding_flags (feature {BINDING_FLAGS}.instance |
--						feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public |
--						feature {BINDING_FLAGS}.flatten_hierarchy)
			else
				internal_members := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
						feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
						feature {BINDING_FLAGS}.non_public)
--				internal_methods := t.get_methods_binding_flags (feature {BINDING_FLAGS}.instance |
--						feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
--						feature {BINDING_FLAGS}.non_public | feature {BINDING_FLAGS}.flatten_hierarchy)
--				internal_fields := t.get_fields_binding_flags (feature {BINDING_FLAGS}.instance |
--						feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
--						feature {BINDING_FLAGS}.non_public | feature {BINDING_FLAGS}.flatten_hierarchy)
				internal_properties := t.get_properties_binding_flags (feature {BINDING_FLAGS}.instance |
						feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public |
						feature {BINDING_FLAGS}.static)
				internal_events := t.get_events_binding_flags (feature {BINDING_FLAGS}.instance |
						feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public|
						feature {BINDING_FLAGS}.static)
			end
			
--			internal_properties := t.get_properties_binding_flags (feature {BINDING_FLAGS}.instance |
--					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
--					feature {BINDING_FLAGS}.flatten_hierarchy)
--			internal_events := t.get_events_binding_flags (feature {BINDING_FLAGS}.instance |
--					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
--					feature {BINDING_FLAGS}.flatten_hierarchy)

			internal_constructors := t.get_constructors
			internal_referenced_type := referenced_type_from_type (t)
			
			create properties_and_events.make
		ensure
			non_void_consumed_type: consumed_type /= Void
			non_void_internal_constructors: internal_constructors /= Void
			non_void_internal_fields: internal_fields /= Void
			non_void_internal_methods: internal_members /= Void
--			non_void_internal_methods: internal_methods /= Void
			non_void_internal_properties: internal_properties /= Void
			non_void_internal_events: internal_events /= Void
			non_void_internal_referenced_type: internal_referenced_type /= Void
		end
		
feature -- Access

	consumed_type: CONSUMED_TYPE
			-- Consumed type last created or initialized

feature {NONE} --Implementation

	overload_solver: OVERLOAD_SOLVER


feature -- Status Report

	initialized: BOOLEAN
			-- Was `consumed_type' initialized?


feature -- Basic Operation

	initialize is
			-- Initialize `consumed_type.functions', `consumed_type.procedures',
			-- `consumed_type.fields', `consumed_type.constructors',
			-- `consumed_type.properties' and `consumed_type.events'.
		require
			not_initialized: not initialized
		local
			rescued: BOOLEAN
			i, nb, arg_count, index: INTEGER
			l_fields: ARRAYED_LIST [CONSUMED_FIELD]
			l_functions, l_other_functions: ARRAYED_LIST [CONSUMED_FUNCTION]
			l_procedures: ARRAYED_LIST [CONSUMED_PROCEDURE]
			cf: CONSUMED_FIELD
			cons: CONSTRUCTOR_INFO
			l_field: FIELD_INFO
			l_meth: METHOD_INFO
			l_property: PROPERTY_INFO
			l_event: EVENT_INFO
			l_member: MEMBER_INFO
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]
			l_events: ARRAYED_LIST [CONSUMED_EVENT]
			l_properties: ARRAYED_LIST [CONSUMED_PROPERTY]
			
			cp_function: CONSUMED_FUNCTION
			cp_procedure: CONSUMED_PROCEDURE
			cp_property: CONSUMED_PROPERTY
			cp_event: CONSUMED_EVENT
		do
			if not rescued then
				check
					non_void_internal_constructors: internal_constructors /= Void
					non_void_internal_fields: internal_fields /= Void
					non_void_internal_methods: internal_members /= Void
					--non_void_internal_methods: internal_methods /= Void
					non_void_internal_properties: internal_properties /= Void
					non_void_internal_events: internal_events /= Void
				end
				create tc.make
				create l_fields.make (0)
				create l_functions.make (0)
				create l_procedures.make (0)
				create l_properties.make (0)
				create l_events.make (0)
				create reserved_names.make (100)
	
					-- Add constructors.
				from
					i := 0
					nb := internal_constructors.count
				until
					i = nb
				loop
					cons := internal_constructors.item (i)
					if is_consumed_method (cons) then
						tc.extend (create {CONSTRUCTOR_SOLVER}.make (cons))					
					end
					i := i + 1
				end
				
					-- Initialize overload solver.
				initialize_overload_solver
					-- Resolve oveload conflicts.
				overload_solver.set_reserved_names (reserved_names)
				overload_solver.solve
				
					-- Add methods and fields.
				from
					i := 0
					nb := internal_members.count
				until
					i = nb
				loop
					l_member := internal_members.item (i)
					if l_member.get_member_type = feature {MEMBER_TYPES}.method then
						l_meth ?= l_member
						check
							is_method: l_meth /= Void
						end
						if not is_property_or_event (l_meth) then
							if is_function (l_meth) then
								cp_function := consumed_function (l_meth, False)
								if cp_function /= Void then
									l_functions.extend (cp_function)
								end
							else
								cp_procedure := consumed_procedure (l_meth, False)
								if cp_function /= Void then
									l_procedures.extend (cp_procedure)
								end
							end
						else
							-- The method will be added at the same time than the property or the event.
						end
					elseif l_member.get_member_type = feature {MEMBER_TYPES}.field then
						l_field ?= l_member
						check
							is_field: l_field /= Void
						end
						if is_consumed_field (l_field) then
							l_fields.extend (consumed_field (l_field))						
						end
					elseif l_member.get_member_type = feature {MEMBER_TYPES}.property then
						l_property ?= l_member
						check
							is_property: l_property /= Void
						end
						cp_property := consumed_property (l_property)
						if cp_property /= Void then
							l_properties.extend (cp_property)	
						end
					elseif l_member.get_member_type = feature {MEMBER_TYPES}.event then
						l_event ?= l_member
						check
							is_event: l_event /= Void
						end
						cp_event := consumed_event (l_event)
						if cp_event /= Void then
							l_events.extend (cp_event)	
						end
					end
					i := i + 1
				end

				consumed_type.set_properties (l_properties)
				consumed_type.set_events (l_events)
				consumed_type.set_constructors (solved_constructors (tc))
				consumed_type.set_fields (l_fields)
				consumed_type.set_procedures (l_procedures)
				if consumed_type.is_enum then
					from
						l_other_functions := l_functions
						l_other_functions.start
						create l_functions.make (l_other_functions.count + Additional_enum_features)
					until
						l_other_functions.after
					loop
						l_functions.extend (l_other_functions.item)
						l_other_functions.forth
					end
					l_functions.extend (infix_or_feature (internal_referenced_type))
					l_functions.extend (from_integer_feature (internal_referenced_type))
					l_functions.extend (to_integer_feature (internal_referenced_type))
				end
				consumed_type.set_functions (l_functions)			
				initialized := True
			else
				initialized := False
			end
		ensure
			non_void_constructors: consumed_type.constructors /= Void
			non_void_fields: consumed_type.fields /= Void
			non_void_procedures: consumed_type.procedures /= Void
			non_void_functions: consumed_type.functions /= Void
			non_void_properties: consumed_type.properties /= Void
			non_void_events: consumed_type.events /= Void
		rescue
			rescued := True
			retry
		end


	initialize_overload_solver is
			-- Initialize overload solver.
			-- Add all methods (properties, events, procedures and functions) in overload_solver.
		local
			i, nb: INTEGER
			l_member: MEMBER_INFO
			l_meth: METHOD_INFO
			l_property: PROPERTY_INFO
			l_event: EVENT_INFO
		do
				-- Add properties in overload_solver.
			from
				i := 0
				nb := internal_properties.count
				create overload_solver.make
			until
				i = nb
			loop
				l_property := internal_properties.item (i)
				check
					non_void_l_propery: l_property /= Void
				end
				add_property (l_property)
				overload_solver.add_property (l_property)
				i := i + 1
			end

				-- Add events in overload_solver.
			from
				i := 0
				nb := internal_events.count
			until
				i = nb
			loop
				l_event := internal_events.item (i)
				check
					non_void_l_event: l_event /= Void
				end
				add_event (l_event)
				overload_solver.add_event (l_event)
				i := i + 1
			end				

				-- Add methods in overload_solver
			from
				i := 0
				nb := internal_members.count
			until
				i = nb
			loop
				l_member := internal_members.item (i)
				if l_member.get_member_type = feature {MEMBER_TYPES}.method then
					l_meth ?= l_member
					check
						is_method: l_meth /= Void
					end
					if is_consumed_method (l_meth) then
						if not is_property_or_event (l_meth) then
							overload_solver.add_method (l_meth)
						else
							-- The method will be added at the same time than the property or the event.
						end
					end
				end
				i := i + 1
			end
		end


feature {NONE} -- Implementation

	consumed_field (info: FIELD_INFO): CONSUMED_FIELD is
			-- Eiffel attribute from `info'.
		require
			non_void_field_info: info /= Void
		local
			dotnet_name: STRING
			l_type: TYPE
			l_value: SYSTEM_OBJECT
		do
			create dotnet_name.make_from_cil (info.get_name)
			l_type := info.get_declaring_type
			if info.get_is_literal then
				if l_type.get_is_enum then
						-- Conversion to integer is required to get associated value of `info',
						-- Otherwise we simply get an object where calling `ToString' on it
						-- will print out field name.
					l_value := feature {CONVERT}.to_int_64_object (info.get_value (Void))
				else
					l_value := info.get_value (Void)
				end
				create {CONSUMED_LITERAL_FIELD} Result.make (
					unique_feature_name (dotnet_name),
					dotnet_name,
					referenced_type_from_type (info.get_field_type),
					info.get_is_static,
					info.get_is_public,
					literal_field_value (l_value),
					referenced_type_from_type (l_type))
			else
				create Result.make (
					unique_feature_name (dotnet_name),
					dotnet_name,
					referenced_type_from_type (info.get_field_type),
					info.get_is_static,
					info.get_is_public,
					info.get_is_init_only,
					referenced_type_from_type (l_type))
			end
		end

	consumed_arguments (info: METHOD_BASE): ARRAY [CONSUMED_ARGUMENT] is
			-- Argument of `info'.
		require
			non_void_method: info /= Void
		local
			i, count: INTEGER
			en, dn: STRING
			params: NATIVE_ARRAY [PARAMETER_INFO]
			p: PARAMETER_INFO
			t: TYPE
		do
			create Result.make (1, info.get_parameters.count)
			params := info.get_parameters
			from
				i := 0
				count := params.count
			until
				i >= count
			loop
				p := params.item (i)
				create dn.make_from_cil (p.get_name)
				en := formatted_argument_name (dn, i + 1)
				if dn = Void or dn.is_empty then
					dn := en.clone (en)
				end
				t := p.get_parameter_type
				Result.put (create {CONSUMED_ARGUMENT}.make (dn, en,
					referenced_type_from_type (t),
					p.get_is_out or t.get_is_by_ref), i + 1)
				i := i + 1
			end
		ensure
			non_void_arguments: Result /= Void
		end

	consumed_procedure (info: METHOD_INFO; property_or_event: BOOLEAN): CONSUMED_PROCEDURE is
			-- Consumed procedure.
		require
			non_void_info: info /= Void
		local
			l_arguments: ARRAYED_LIST [CONSUMED_ARGUMENT]
			l_unique_eiffel_name: STRING
		do
			if is_consumed_method (info) then
				l_unique_eiffel_name := overload_solver.unique_eiffel_name (info.get_name, info.get_parameters)
				check
					non_void_eiffel_name: l_unique_eiffel_name /= Void
				end
				create Result.make (
					l_unique_eiffel_name,
					create {STRING}.make_from_cil (info.get_name),
					consumed_arguments (info),
					info.get_is_final,
					info.get_is_static,
					info.get_is_abstract,
					info.get_is_public,
					property_or_event,
					referenced_type_from_type (info.get_declaring_type))
			end
		end
	
	consumed_function (info: METHOD_INFO; property_or_event: BOOLEAN): CONSUMED_FUNCTION is
			-- Consumed function.
		require
			non_void_info: info /= Void
		local
			l_unique_eiffel_name: STRING
		do
			if is_consumed_method (info) then
				l_unique_eiffel_name := overload_solver.unique_eiffel_name (info.get_name, info.get_parameters)
				check
					non_void_eiffel_name: l_unique_eiffel_name /= Void
				end
				create Result.make (
					l_unique_eiffel_name,
					create {STRING}.make_from_cil (info.get_name),
					consumed_arguments (info),
					referenced_type_from_type (info.get_return_type),
					info.get_is_final,
					info.get_is_static,
					info.get_is_abstract,
					is_infix (info),
					is_prefix (info),
					info.get_is_public,
					property_or_event,
					referenced_type_from_type (info.get_declaring_type))
			end
		end

	consumed_property (info: PROPERTY_INFO): CONSUMED_PROPERTY is
			-- Process property `info'.
		require
			non_void_property_info: info /= Void
		local
			dotnet_name: STRING
			l_getter: CONSUMED_FUNCTION
			l_setter: CONSUMED_PROCEDURE
			l_info, l_info_setter: METHOD_INFO
			l_eiffel_getter_property_name, l_eiffel_setter_property_name: STRING
		do
			create dotnet_name.make_from_cil (info.get_name)
			if info.get_can_read then
				l_info := info.get_get_method_boolean (True)
				check
					non_void_l_info: l_info /= Void
				end
				l_getter := consumed_function (l_info, True)
			end
			if info.get_can_write then
				l_info := info.get_set_method_boolean (True)
				check
					non_void_l_info: l_info /= Void
				end
				l_setter := consumed_procedure (l_info, True)
			end
			check
				is_property: l_info /= Void
			end
			if l_getter /= Void or l_setter /= Void then
				create Result.make (
					dotnet_name,
					l_info.get_is_public,
					l_info.get_is_static,
					referenced_type_from_type (info.get_declaring_type),
					l_getter,
					l_setter)
			end
		end

	consumed_event (info: EVENT_INFO): CONSUMED_EVENT is
			-- Process event `info'.
		require
			non_void_event_info: info /= Void
		local
			l_add_method, l_remove_method, l_raise_method: METHOD_INFO
			l_eiffel_raiser_event_name, l_eiffel_adder_event_name, l_eiffel_remover_event_name: STRING
			dotnet_name: STRING
			l_raiser, l_adder, l_remover: CONSUMED_PROCEDURE
			i, nb: INTEGER
			l_parameter_type: CONSUMED_REFERENCED_TYPE
		do
			l_add_method := info.get_add_method_boolean (True)
			l_remove_method := info.get_remove_method_boolean (True)
			l_raise_method := info.get_raise_method_boolean (True)

			if l_raise_method /= Void then
				l_raiser := consumed_procedure (l_raise_method, True)
			end
			if l_add_method /= Void then
				l_adder := consumed_procedure (l_add_method, True)
			end
			if l_remove_method /= Void then
				l_remover := consumed_procedure (l_remove_method, True)
			end

			create dotnet_name.make_from_cil (info.get_name)
			if l_raise_method /= Void then
				l_parameter_type := referenced_type_from_type (l_raise_method.get_parameters.item (0).get_parameter_type)
			elseif l_add_method /= Void then
				l_parameter_type := referenced_type_from_type (l_add_method.get_parameters.item (0).get_parameter_type)
			elseif l_remove_method /= Void then
				l_parameter_type := referenced_type_from_type (l_remove_method.get_parameters.item (0).get_parameter_type)
			end
			if l_remover /= Void or l_raiser /= Void or l_adder /= Void then
				create Result.make (
					dotnet_name,
					True,
					l_parameter_type,
					l_raiser,
					l_adder,
					l_remover
					)
			end
		end
		
	solved_constructors (
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]): ARRAY [CONSUMED_CONSTRUCTOR]
		is
			-- Initialize `constructors' from `tc'.
		require
			non_void_constructors: tc /= Void
		local
			arg, name: STRING
			i, j, nb: INTEGER
			args: ARRAY [CONSUMED_ARGUMENT]
			l_reserved: like reserved_names
		do
			create Result.make (1, tc.count)
			if tc.count > 0 then
				tc.start
				if tc.count = 1 then
						-- When there is only one constructor, let's call it make
						-- to avoid confusion.
					tc.item.set_name (Creation_routine_name)
					Result.put (tc.item.consumed_constructor, 1)
				else
						-- Compute all possible names for constructor.
					from
						l_reserved := reserved_names
						tc.start
						args := tc.item.arguments
						if args.count = 0 then
							tc.item.set_name (Creation_routine_name)
							Result.put (tc.item.consumed_constructor, 1)
							j := 2
							tc.forth
						else
							j := 1
						end
					until
						tc.after or tc.item.arguments.count > Constructor_overload_resolution
					loop
						args := tc.item.arguments
						create name.make (Complete_creation_routine_name_prefix.count)
						name.append (Complete_creation_routine_name_prefix)
						from
							i := 1
							nb := args.count
						until
							i > nb
						loop
							if i > 1 then
								name.append ("_and_")
							end
							name.append (args.item (i).eiffel_name)
							i := i + 1
						end
						l_reserved.put (name, name)
						tc.item.set_name (name)
						Result.put (tc.item.consumed_constructor, j)
						j := j + 1
						tc.forth
					end
					
					from
					until
						tc.after
					loop
						args := tc.item.arguments
						create name.make (Partial_creation_routine_name_prefix.count)
						name.append (Partial_creation_routine_name_prefix)
						name.append (args.item (1).eiffel_name)
						from
							i := 2
							nb := args.count
						until
							not l_reserved.has (name) or i > nb
						loop
							if i > 1 then
								name.append ("_and_")
							end
							name.append (args.item (i).eiffel_name)
							i := i + 1
						end
						l_reserved.put (name, name)
						tc.item.set_name (name)
						Result.put (tc.item.consumed_constructor, j)
						j := j + 1
						tc.forth
					end
				end
			end
		ensure
			non_void_constructors: Result /= Void
		end
		
	internal_members: NATIVE_ARRAY [MEMBER_INFO]
			-- Type members used to initialize `features'

--	internal_methods: NATIVE_ARRAY [METHOD_INFO]
			-- Methods.

	internal_fields: NATIVE_ARRAY [FIELD_INFO]
			-- Fields.

	internal_properties: NATIVE_ARRAY [PROPERTY_INFO]
			-- Properties from type and parents

	internal_events: NATIVE_ARRAY [EVENT_INFO]
			-- Events from type and parents

	internal_constructors: NATIVE_ARRAY [CONSTRUCTOR_INFO]
			-- Constructors of .NET type
			
	internal_referenced_type: CONSUMED_REFERENCED_TYPE
			-- Representation of Current if it was used 
			-- for CONSUMED_REFERENCED_TYPE.

	Default_creation_routine_name: STRING is "make"
			-- Default Eiffel creation routine name

	Argument_prefix: STRING is "arg_"
			-- Argument names prefix
	
	Constructor_overload_resolution: INTEGER is 3
			-- Number of arguments in a constructor for which we always expand
			-- their name definition.

	Creation_routine_name: STRING is "make"
	Complete_creation_routine_name_prefix: STRING is "make_from_"
	Partial_creation_routine_name_prefix: STRING is "make_with_"
			-- Creation routine name prefix


feature {NONE} -- Status Setting.

--	properties_and_events: HASH_TABLE [LINKED_LIST [METHOD_INFO], STRING]
	properties_and_events: HASHTABLE --[METHOD_INFO, SYSTEM_STRING]
			-- List of properties and events.

	key_args (args: NATIVE_ARRAY [PARAMETER_INFO]): SYSTEM_STRING is
			-- return signature corresponding to args.
		local
			i: INTEGER
			l_str: STRING
		do
			create l_str.make_empty
			from
				i := 0
			until
				args = Void or else i = args.count
			loop
				l_str.append (create {STRING}.make_from_cil (args.item (i).get_parameter_type.get_name))
				i := i + 1
			end
			Result := l_str.to_cil
		ensure
			non_void_result: Result /= Void
		end


	add_property (info: PROPERTY_INFO) is
			-- add property.
		require
			non_void_info: info /= Void
		do
			if info.get_can_read then
				add_properties_or_events (info.get_get_method_boolean (True))
			end
			if info.get_can_write then
				add_properties_or_events (info.get_set_method_boolean (True))
			end
		end
	
	add_event (info:EVENT_INFO) is
			-- Add event.
		require
			non_void_info: info /= Void
		local
			l_adder, l_remover, l_raiser: METHOD_INFO
		do
			l_adder := info.get_add_method
			l_remover := info.get_remove_method
			l_raiser := info.get_raise_method
			
			if l_adder /= Void then
				add_properties_or_events (l_adder)
			end
			if l_remover /= Void then
				add_properties_or_events (l_remover)
			end
			if l_raiser /= Void then
				add_properties_or_events (l_raiser)
			end
		end

	add_properties_or_events (info: METHOD_INFO) is
			-- Add info to `properties_and_events'.
		require
			non_void_info: info /= Void
		local
			i, nb: INTEGER
			l_key: SYSTEM_STRING
			l_dotnet_name: SYSTEM_STRING
		do
			if is_consumed_method (info) then
				l_dotnet_name := info.get_name
				create l_key.make_from_c_and_count (' ', 0)
				l_key := l_key.concat_string_string (l_dotnet_name, key_args (info.get_parameters))
				if not properties_and_events.contains_key (l_key) then
					properties_and_events.add (l_key, info)
				end
			end
		ensure
--			info_added: is_consumed_method (info) implies properties_and_events.contains_key (info.get_name + key_args (info.get_parameters))
		end

	is_property_or_event (info: METHOD_INFO): BOOLEAN is
			-- Is `internal_method' a property or event related feature?
		require
			non_void_info: info /= Void
		local
			i, nb: INTEGER
			l_key: SYSTEM_STRING
			l_dotnet_name: SYSTEM_STRING
			l_method: METHOD_INFO
			l_method_list: NATIVE_ARRAY [METHOD_INFO]
			l_index: INTEGER
		do
			l_dotnet_name := info.get_name
			l_index := l_dotnet_name.last_index_of_character ('.')
			if l_index > 0 then
				l_dotnet_name := l_dotnet_name.substring (l_index + 1)
			end
			create l_key.make_from_c_and_count (' ', 0)
			l_key := l_key.concat_string_string (l_dotnet_name, key_args (info.get_parameters))
			if properties_and_events.contains_key (l_key) then
				Result := True
			else
				Result := False
			end
		end

	is_infix (info: METHOD_INFO): BOOLEAN is
			-- Is function an infix function?
		require
			is_function: is_function (info)
		do
			Result := info.get_name.get_length > 3 and then
						info.get_is_special_name and then
						info.get_name.starts_with (Operator_name_prefix.to_cil) and then
						info.get_parameters.item (0).get_parameter_type.equals_type (info.get_reflected_type)
		end

	is_prefix (info: METHOD_INFO): BOOLEAN is
			-- Is function a prefix function?
		require
			is_function: is_function (info)
		do
			Result := info.get_name.get_length > 3 and then
						info.get_is_special_name and then
						info.get_name.starts_with (Operator_name_prefix.to_cil) and then
						info.get_parameters.count = 1
		end

	is_function (info: METHOD_INFO): BOOLEAN is
			-- Is method a function?
		do
			Result := not info.get_return_type.equals_type (Void_type)
		end
		
	Void_type: TYPE is
			-- Void .NET type
		once
			Result := feature {TYPE}.get_type_string (("System.Void").to_cil)
		end

	Operator_name_prefix: STRING is "op_"
			-- Special prefix for .NET operators

--	internal_is_prefix_set: BOOLEAN
--			-- Was `internal_is_prefix' calculated?
--	
--	internal_is_prefix: BOOLEAN
--			-- Cached value for `is_prefix'
--	
--	internal_is_infix_set: BOOLEAN
--			-- Was `internal_is_infix' calculated?
--		
--	internal_is_infix: BOOLEAN
--			-- Cached value for `is_infix'
--	
--	internal_is_function_set: BOOLEAN
--			-- Was `internal_is_function' calculated?
--	
--	internal_is_function: BOOLEAN
--			-- Cached value for `is_function'


feature {NONE} -- Added features of System.Object to Interfaces

	update_interface_members (t: TYPE) is
			-- 
		local
			l_members: NATIVE_ARRAY [MEMBER_INFO]
--			l_methods: NATIVE_ARRAY [METHOD_INFO]
			l_processed: HASHTABLE
		do
			create l_processed.make_from_capacity (10)
			
--			create internal_fields.make (0)
			create internal_members.make (0)
--			create internal_methods.make (0)
			create internal_properties.make (0)
			create internal_events.make (0)
			
			internal_update_interface_members (t, l_processed)

			create l_members.make (internal_members.count + object_members.count)
			feature {SYSTEM_ARRAY}.copy (internal_members, l_members, internal_members.count)
			feature {SYSTEM_ARRAY}.copy_array_integer_32 (object_members, 0, l_members,
				internal_members.count, object_members.count)
			internal_members := l_members

--			create l_methods.make (internal_methods.count + Object_methods.count)
--			feature {SYSTEM_ARRAY}.copy (internal_methods, l_methods, internal_methods.count)
--			feature {SYSTEM_ARRAY}.copy_array_integer_32 (Object_methods, 0, l_methods,
--				internal_methods.count, Object_methods.count)
--			internal_methods := l_methods
		end

	internal_update_interface_members (t: TYPE; processed: HASHTABLE) is
			-- Update `internal_methods', `internal_properties' and `internal_events' and recursively explores parent interface
			-- if not already in `processed'.
		local
			l_merged_members: NATIVE_ARRAY [MEMBER_INFO]
--			l_merged_methods: NATIVE_ARRAY [METHOD_INFO]
			l_merged_properties: NATIVE_ARRAY [PROPERTY_INFO]
			l_merged_events: NATIVE_ARRAY [EVENT_INFO]
			l_interfaces: NATIVE_ARRAY [TYPE]
			i, nb: INTEGER
			l_interface: TYPE
			l_members: NATIVE_ARRAY [MEMBER_INFO]
--			l_methods: NATIVE_ARRAY [METHOD_INFO]
			l_properties: NATIVE_ARRAY [PROPERTY_INFO] 
			l_events: NATIVE_ARRAY [EVENT_INFO]
		do
			l_members := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
					feature {BINDING_FLAGS}.non_public)
--			l_methods := t.get_methods_binding_flags (feature {BINDING_FLAGS}.instance |
--					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
--					feature {BINDING_FLAGS}.non_public | feature {BINDING_FLAGS}.flatten_hierarchy)
			l_properties := t.get_properties_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public |
					feature {BINDING_FLAGS}.static)
			l_events := t.get_events_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public |
					feature {BINDING_FLAGS}.static)
			

				-- merge members.
			create l_merged_members.make (internal_members.count + l_members.count)
			feature {SYSTEM_ARRAY}.copy (internal_members, l_merged_members, internal_members.count)
			feature {SYSTEM_ARRAY}.copy_array_integer_32 (l_members, 0, l_merged_members, internal_members.count, l_members.count)
			internal_members := l_merged_members

--				-- merge methods.
--			create l_merged_methods.make (internal_methods.count + l_methods.count)
--			feature {SYSTEM_ARRAY}.copy (internal_methods, l_merged_methods, internal_methods.count)
--			feature {SYSTEM_ARRAY}.copy_array_integer_32 (l_methods, 0, l_merged_methods, internal_methods.count, l_methods.count)
--			internal_methods := l_merged_methods

				-- merge properties.
			create l_merged_properties.make (internal_properties.count + l_properties.count)
			feature {SYSTEM_ARRAY}.copy (internal_properties, l_merged_properties, internal_properties.count)
			feature {SYSTEM_ARRAY}.copy_array_integer_32 (l_properties, 0, l_merged_properties, internal_properties.count, l_properties.count)
			internal_properties := l_merged_properties

				-- merge events.
			create l_merged_events.make (internal_events.count + l_events.count)
			feature {SYSTEM_ARRAY}.copy (internal_events, l_merged_events, internal_events.count)
			feature {SYSTEM_ARRAY}.copy_array_integer_32 (l_events, 0, l_merged_events, internal_events.count, l_events.count)
			internal_events := l_merged_events
			from
				l_interfaces := t.get_interfaces
				processed.Add (t, t)
				i := 0
				nb := l_interfaces.count - 1
			until
				i > nb
			loop
				l_interface := l_interfaces.item (i)
				if not processed.Contains (l_interface) then
					internal_update_interface_members (l_interface, processed)
				end
				i := i + 1
			end
		end

	object_members: NATIVE_ARRAY [MEMBER_INFO] is
			-- List of members of System.Object.
		local
			l_type: TYPE
		once
			l_type := feature {TYPE}.get_type_string (("System.Object").to_cil)
			Result := l_type.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
				feature {BINDING_FLAGS}.public)
		ensure
			object_members_not_void: Result /= Void
		end
		
feature {NONE} -- Added features for ENUM types.

	Additional_enum_features: INTEGER is 3
			-- Number of additional features for enum types.

	infix_or_feature (enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION is
			-- Create instance of CONSUMED_FUNCTION for`|' in enum type `t'.
		require
			enum_type_not_void: enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
		do
			create l_arg.make ("other", "other", enum_type, False)
			l_args := <<l_arg>>
			create Result.make ("infix %"|%"", "|", l_args, enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				True,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public
				False,	-- is_property_or_event
				enum_type)
			Result.set_is_artificially_added (True)				
		end

	from_integer_feature (enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION is
			-- Create instance of CONSUMED_FUNCTION for`from_integer' in enum type `t'.
		require
			enum_type_not_void: enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
		do
			create l_arg.make ("a_value", "a_value", integer_type, False)
			l_args := <<l_arg>>
			create Result.make ("from_integer", "from_integer", l_args, enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				True,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public
				False,	-- is_property_or_event
				enum_type)
			Result.set_is_artificially_added (True)
		end

	to_integer_feature (enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION is
			-- Create instance of CONSUMED_FUNCTION for`to_integer' in enum type `t'.
		require
			enum_type_not_void: enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
		do
			create l_args.make (1, 0)
			create Result.make ("to_integer", "to_integer", l_args, integer_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				True,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public
				False,	-- is_property_or_event
				enum_type)
			Result.set_is_artificially_added (True)				
		end
				
	integer_type: CONSUMED_REFERENCED_TYPE is
			-- Referenced type of `System.Int32'.
		once
			Result := referenced_type_from_type (
				feature {TYPE}.get_type_string (("System.Int32").to_cil))
		ensure
			integer_type_not_void: integer_type /= Void
		end

	literal_field_value (val: SYSTEM_OBJECT): STRING is
			-- Convert `val' into a STRING representation.
		require
			val_not_void: val /= Void
		local
			d: DOUBLE
			r: REAL
			a: NATIVE_ARRAY [INTEGER_8]
		do
			if val.get_type.equals_type (Double_type) then
				d ?= val
				check
					is_double: d /= Void
				end
				Result := bytes_to_string (feature {BIT_CONVERTER}.get_bytes_double (d))
			elseif val.get_type.equals_type (Real_type) then
				r ?= val
				check
					is_real: r /= Void
				end
				Result := bytes_to_string (feature {BIT_CONVERTER}.get_bytes_real (r))
			else
				create Result.make_from_cil (val.to_string)
			end

		end

	bytes_to_string (a: NATIVE_ARRAY [INTEGER_8]): STRING is
			-- Convert `a' into an hexadecimal string.
		require
			non_void_array: a /= Void
		local
			i, nb: INTEGER
			l_hex: INTEGER
			l_hex_string: STRING
		do
			from
				nb := a.count
				create Result.make (nb * 2)
			until
				i >= nb
			loop
				l_hex := a.item (i)
				l_hex_string := l_hex.to_hex_string
				l_hex_string.keep_tail (2)
				Result.append (l_hex_string)
				i := i + 1
			end
		ensure
			converted: Result /= Void and then not Result.is_empty
		end
		
	Double_type: TYPE is
			-- typeof (double)
		once
			Result := feature {TYPE}.get_type_string (("System.Double").to_cil)
		end
		
	Real_type: TYPE is
			-- typeof (float)
		once
			Result := feature {TYPE}.get_type_string (("System.Float").to_cil)
		end
		
end -- class TYPE_CONSUMER
