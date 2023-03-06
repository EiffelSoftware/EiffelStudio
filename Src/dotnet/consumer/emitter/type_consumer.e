note
	description: "{CONSUMED_TYPE} factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CONSUMER

inherit
	REFLECTION

	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

	NAME_SOLVER

	METHOD_RETRIEVER

	ARGUMENT_SOLVER

	FIELD_CONSUMER_HELPER
		export
			{NONE} all
		end

	EC_CHECKED_ENTITY_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (t: SYSTEM_TYPE; en: STRING)
			-- Initialize type consumer for type `t' with eiffel name `en'.
		require
			non_void_type: t /= Void
			consumable_type: is_consumed_type (t)
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		local
			dotnet_name: STRING
			inter: NATIVE_ARRAY [detachable SYSTEM_TYPE]
			interfaces: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			parent: CONSUMED_REFERENCED_TYPE
			i, nb, count: INTEGER
			parent_type: SYSTEM_TYPE
			l_force_sealed: BOOLEAN
			l_members: NATIVE_ARRAY [detachable MEMBER_INFO]
			l_constructors: NATIVE_ARRAY [detachable CONSTRUCTOR_INFO]
			l_properties: NATIVE_ARRAY [detachable PROPERTY_INFO]
			l_events: NATIVE_ARRAY [detachable EVENT_INFO]
			l_members_count: INTEGER
		do
			create overload_solver.make
			create reserved_names.make (0)
			create dotnet_name.make_from_cil (t.full_name)
			if not t.is_interface then
				parent_type := consumed_parent (t)
				if parent_type /= Void then
					parent := referenced_type_from_type (parent_type)
				end
			end

			inter := t.get_interfaces
			if inter /= Void then
				from
					i := 0
					nb := inter.count - 1
					create interfaces.make (nb + 1)
			 	until
					i > nb
				loop
					if attached inter.item (i) as l_type and then is_consumed_type (l_type) then
						count := count + 1
						interfaces.extend (referenced_type_from_type (l_type))
					end
					i := i + 1
				end
			else
				create interfaces.make (0)
			end

			l_force_sealed := t.is_sealed
			if not l_force_sealed and then (t.is_interface or t.is_abstract) then
					-- Enum and ValueType should not be decended from in Eiffel
				l_force_sealed := t.equals_type (enum_type) or t.equals_type (value_type_type)
				if not l_force_sealed then
						-- For non-Eiffel compliant interfaces we need to force them to be frozen
						-- so they cannot be descended, which would result in an incomplete interface
						-- implementation, because of the non-compliant members
					if attached {EC_CHECKED_ABSTRACT_TYPE} checked_type (t) as l_ab_type then
						l_force_sealed := not l_ab_type.is_eiffel_compliant_interface
					end
				end
			end

			if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
					-- `t.declaring_type' contains enclosing type of current nested type.
				if attached t.declaring_type as l_decl_type then
					check
						is_declaring_type_consumed: is_consumed_type (l_decl_type)
					end
					create {CONSUMED_NESTED_TYPE} consumed_type.make (
						dotnet_name, en, t.is_interface, (not l_force_sealed and then t.is_abstract),
						l_force_sealed, t.is_value_type, t.is_enum, parent, interfaces,
						referenced_type_from_type (l_decl_type))
				else
					check
						declaring_type_attached: False
					then
					end
				end
			else
				create consumed_type.make (dotnet_name, en, t.is_interface, (not l_force_sealed and then t.is_abstract),
					l_force_sealed, t.is_value_type, t.is_enum, parent, interfaces)
			end

			if t.is_interface then
					-- Lookup members of current interface `t' but also add members coming
					-- from parent interfaces as `t.get_members_binding_flags' does not do it.
				update_interface_members (t)
			else
				l_members := t.get_members_binding_flags ({BINDING_FLAGS}.instance |
						{BINDING_FLAGS}.static | {BINDING_FLAGS}.public |
						{BINDING_FLAGS}.non_public)
				l_properties := t.get_properties_binding_flags ({BINDING_FLAGS}.instance |
						{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public |
						{BINDING_FLAGS}.static)
				l_events := t.get_events_binding_flags ({BINDING_FLAGS}.instance |
						{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public|
						{BINDING_FLAGS}.static)

					-- Add static features of System.Object for correct overload resolution (because of interfaces inheriting System.Object)
				if l_members /= Void then
					l_members_count := l_members.count
					if attached object_static_methods as l_obj_methods then
						create internal_members.make (l_obj_methods.count + l_members_count)
					else
						create internal_members.make (l_members_count)
					end
					{SYSTEM_ARRAY}.copy (l_members, internal_members, l_members_count)
				else
					create internal_members.make (0)
				end
				if not t.equals_type ({SYSTEM_OBJECT}) and attached object_static_methods as l_obj_methods then
					{SYSTEM_ARRAY}.copy (l_obj_methods, 0, internal_members, l_members_count, l_obj_methods.count)
				end

				if l_properties /= Void then
					create internal_properties.make (l_properties.count)
					{SYSTEM_ARRAY}.copy (l_properties, internal_properties, l_properties.count)
				else
					create internal_properties.make (0)
				end

				if l_events /= Void then
					create internal_events.make (l_events.count)
					{SYSTEM_ARRAY}.copy (l_events, internal_events, l_events.count)
				else
					create internal_events.make (0)
				end
			end

			l_constructors := t.get_constructors_binding_flags (
				{BINDING_FLAGS}.instance | {BINDING_FLAGS}.public |
				{BINDING_FLAGS}.non_public)
			if l_constructors /= Void then
				create internal_constructors.make (l_constructors.count)
				{SYSTEM_ARRAY}.copy (l_constructors, internal_constructors, l_constructors.count)
			else
				create internal_constructors.make (0)
			end

			internal_referenced_type := referenced_type_from_type (t)

			create properties_and_events.make
		ensure
			non_void_consumed_type: consumed_type /= Void
			non_void_internal_constructors: internal_constructors /= Void
			non_void_internal_members: internal_members /= Void
			non_void_internal_methods: internal_members /= Void
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

	initialize
			-- Initialize `consumed_type.functions', `consumed_type.procedures',
			-- `consumed_type.fields', `consumed_type.constructors',
			-- `consumed_type.properties' and `consumed_type.events'.
		require
			not_initialized: not initialized
		local
			rescued: BOOLEAN
			i, nb: INTEGER
			l_fields: ARRAYED_LIST [CONSUMED_FIELD]
			l_functions, l_other_functions: ARRAYED_LIST [CONSUMED_FUNCTION]
			l_procedures: ARRAYED_LIST [CONSUMED_PROCEDURE]
			cons: CONSTRUCTOR_INFO
			l_setter: CONSUMED_PROCEDURE
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]
			l_events: ARRAYED_LIST [CONSUMED_EVENT]
			l_properties: ARRAYED_LIST [CONSUMED_PROPERTY]
			is_enum: BOOLEAN
			underlying_enum_type: CONSUMED_REFERENCED_TYPE

			cp_function: CONSUMED_FUNCTION
			cp_procedure: CONSUMED_PROCEDURE
			cp_field: CONSUMED_FIELD
		do
			if not rescued then
				check
					non_void_internal_constructors: internal_constructors /= Void
					non_void_internal_member: internal_members /= Void
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

				is_enum := consumed_type.is_enum

					-- Add constructors.
				from
					i := 0
					nb := internal_constructors.count
				until
					i = nb
				loop
					cons := internal_constructors.item (i)
					if cons /= Void and then is_consumed_method (cons) then
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
					if attached internal_members.item (i) as l_member then
						if l_member.member_type = {MEMBER_TYPES}.method then
							if attached {METHOD_INFO} l_member as l_meth then
								if not is_property_or_event (l_meth) then
									if is_function (l_meth) then
										cp_function := consumed_function (l_meth, False)
										if cp_function /= Void then
											l_functions.extend (cp_function)
										end
									else
										cp_procedure := consumed_procedure (l_meth, False)
										if cp_procedure /= Void then
											l_procedures.extend (cp_procedure)
										end
									end
								else
									-- The method will be added at the same time than the property or the event.
								end
							else
								check
									is_method_info: False
								end
							end
						elseif l_member.member_type = {MEMBER_TYPES}.field then
							if attached {FIELD_INFO} l_member as l_field then
								if is_enum and then not l_field.is_literal and attached l_field.field_type as l_field_type then
										-- Get base type of enumeration
									underlying_enum_type := referenced_type_from_type (l_field_type)
								end
								if is_consumed_field (l_field) then
									cp_field := consumed_field (l_field)
									l_fields.extend (cp_field)
									if is_public_field (l_field) and not is_init_only_field (l_field) then
										l_setter := attribute_setter_feature (l_field, l_fields.last.eiffel_name)
										cp_field.set_setter (l_setter)
										l_procedures.extend (l_setter)
									end
								end
							else
								check
									is_field_info: False
								end
							end
						elseif l_member.member_type = {MEMBER_TYPES}.property then
							if attached {PROPERTY_INFO} l_member as l_property then
								if attached consumed_property (l_property) as cp_property then
									l_properties.extend (cp_property)
								end
							else
								check
									is_property_info: False
								end
							end
						elseif l_member.member_type = {MEMBER_TYPES}.event then
							if attached {EVENT_INFO} l_member as l_event then
								if attached consumed_event (l_event) as cp_event then
									l_events.extend (cp_event)
								end
							else
								check
									is_event_info: False
								end
							end
						end
					end
					i := i + 1
				end

				consumed_type.set_properties (l_properties)
				consumed_type.set_events (l_events)
				consumed_type.set_constructors (solved_constructors (tc))
				consumed_type.set_fields (l_fields)
				consumed_type.set_procedures (l_procedures)
				if is_enum then
					if underlying_enum_type = Void then
						underlying_enum_type := integer_type
					end
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
					l_functions.extend (infix_and_feature (internal_referenced_type))
					l_functions.extend (infix_or_feature (internal_referenced_type))
					l_functions.extend (from_integer_feature (internal_referenced_type, underlying_enum_type))
					l_functions.extend (to_integer_feature (internal_referenced_type, underlying_enum_type))
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
			debug ("log_exceptions")
				log_last_exception
			end
			rescued := True
			retry
		end

	initialize_overload_solver
			-- Initialize overload solver.
			-- Add all methods (properties, events, procedures and functions) in overload_solver.
		local
			i, nb: INTEGER
			l_member: MEMBER_INFO
			l_property: PROPERTY_INFO
			l_event: EVENT_INFO
			l_properties: NATIVE_ARRAY [detachable PROPERTY_INFO]
			l_events: NATIVE_ARRAY [detachable EVENT_INFO]
			l_members: NATIVE_ARRAY [detachable MEMBER_INFO]
			l_solver: like overload_solver
		do
			l_solver := overload_solver

				-- Add properties to `properties_and_events'.
			l_properties := internal_properties
			from
				i := 0
				nb := l_properties.count
			until
				i = nb
			loop
				l_property := l_properties.item (i)
				if l_property /= Void then
					add_property (l_property)
					l_solver.add_property (l_property)
				end
				i := i + 1
			end

				-- Add events to `properties_and_events'.
			l_events := internal_events
			from
				i := 0
				nb := l_events.count
			until
				i = nb
			loop
				l_event := l_events.item (i)
				if l_event /= Void then
					add_event (l_event)
					l_solver.add_event (l_event)
				end
				i := i + 1
			end

				-- Add methods (procedures, functions) in overload_solver
			l_members := internal_members
			from
				i := 0
				nb := l_members.count
			until
				i = nb
			loop
				l_member := l_members.item (i)
				if
					l_member /= Void and then l_member.member_type = {MEMBER_TYPES}.method and then
					attached {METHOD_INFO} l_member as l_meth
				then
					if not is_property_or_event (l_meth) then
						if is_consumed_method (l_meth) then
							l_solver.add_method (l_meth)
						end
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	consumed_field (info: FIELD_INFO): CONSUMED_FIELD
			-- Eiffel attribute from `info'.
		require
			non_void_field_info: info /= Void
			is_consumed_field: is_consumed_field (info)
		local
			dotnet_name: STRING
			l_value: SYSTEM_OBJECT
			l_code: TYPE_CODE
		do
			create dotnet_name.make_from_cil (info.name)
			if
				attached info.declaring_type as l_type and then
				attached info.field_type as l_field_type
			then
				if info.is_literal then
					l_value := field_value (info)
					if l_field_type.is_enum then
							-- Conversion to integer is required to get associated value of `info',
							-- Otherwise we simply get an object where calling `ToString' on it
							-- will print out field name.
						l_code := {SYSTEM_CONVERT}.get_type_code (l_value)
						inspect l_code
						when {TYPE_CODE}.int_16 then
							l_value := {SYSTEM_CONVERT}.to_int_16 (l_value)
						when {TYPE_CODE}.int_32 then
							l_value := {SYSTEM_CONVERT}.to_int_32 (l_value)
						when {TYPE_CODE}.int_64 then
							l_value := {SYSTEM_CONVERT}.to_int_64 (l_value)
						when {TYPE_CODE}.u_int_16 then
							l_value := {SYSTEM_CONVERT}.to_u_int_16 (l_value)
						when {TYPE_CODE}.u_int_32 then
							l_value := {SYSTEM_CONVERT}.to_u_int_32 (l_value)
						when {TYPE_CODE}.u_int_64 then
							l_value := {SYSTEM_CONVERT}.to_u_int_64 (l_value)
						when {TYPE_CODE}.double then
							l_value := {SYSTEM_CONVERT}.to_double (l_value)
						when {TYPE_CODE}.single then
							l_value := {SYSTEM_CONVERT}.to_single (l_value)
						when {TYPE_CODE}.char then
							l_value := {SYSTEM_CONVERT}.to_char (l_value)
						when {TYPE_CODE}.boolean then
							l_value := {SYSTEM_CONVERT}.to_boolean (l_value)
						else
							l_value := {SYSTEM_CONVERT}.to_int_32 (l_value)
						end
					end
					create {CONSUMED_LITERAL_FIELD} Result.make (
						unique_feature_name (dotnet_name),
						dotnet_name,
						referenced_type_from_type (l_field_type),
						info.is_static,
						info.is_public,
						literal_field_value (l_value),
						referenced_type_from_type (l_type))
				else
					create Result.make (
						unique_feature_name (dotnet_name),
						dotnet_name,
						referenced_type_from_type (l_field_type),
						info.is_static,
						info.is_public,
						info.is_init_only,
						referenced_type_from_type (l_type))
				end
			else
				check
					from_documentation: False
				then
				end
			end
		end

	consumed_procedure (info: METHOD_INFO; property_or_event: BOOLEAN): detachable CONSUMED_PROCEDURE
			-- Consumed procedure.
		require
			non_void_info: info /= Void
		local
			l_unique_eiffel_name: STRING
			l_dotnet_name: STRING
		do
			if is_consumed_method (info) then
				if
					attached info.name as l_info_name and then
					attached info.declaring_type as l_decl_type
				then
					create l_dotnet_name.make_from_cil (l_info_name)
					l_unique_eiffel_name := overload_solver.unique_eiffel_name (l_info_name, info.get_parameters, info.return_type, l_decl_type)
					if l_unique_eiffel_name = Void then
						create l_unique_eiffel_name.make_from_cil (l_info_name)
					end
					create Result.make (
						l_unique_eiffel_name,
						l_dotnet_name,
						formatted_feature_name (l_dotnet_name),
						arguments (info),
						info.is_final,
						info.is_static,
						info.is_abstract,
						info.is_public,
						(info.attributes.to_integer & {METHOD_ATTRIBUTES}.new_slot.to_integer) = {METHOD_ATTRIBUTES}.new_slot.to_integer,
						info.is_virtual,
						property_or_event,
						referenced_type_from_type (l_decl_type))
				else
					check
						from_documentation: False
					end
				end
			end
		end

	consumed_function (info: METHOD_INFO; property_or_event: BOOLEAN): detachable CONSUMED_FUNCTION
			-- Consumed function.
		require
			non_void_info: info /= Void
		local
			l_unique_eiffel_name: STRING
			l_dotnet_name: STRING
		do
			if is_consumed_method (info) then
				if
					attached info.name as l_info_name and then
					attached info.declaring_type as l_decl_type and then
					attached info.return_type as l_ret_type
				then
					create l_dotnet_name.make_from_cil (l_info_name)
					l_unique_eiffel_name := overload_solver.unique_eiffel_name (l_info_name, info.get_parameters, l_ret_type, l_decl_type)
					if l_unique_eiffel_name = Void then
						create l_unique_eiffel_name.make_from_cil (l_info_name)
					end
					create Result.make (
						l_unique_eiffel_name,
						l_dotnet_name,
						formatted_feature_name (l_dotnet_name),
						arguments (info),
						referenced_type_from_type (l_ret_type),
						info.is_final,
						info.is_static,
						info.is_abstract,
						is_infix (info),
						is_prefix (info),
						info.is_public,
						(info.attributes.to_integer & {METHOD_ATTRIBUTES}.new_slot.to_integer) = {METHOD_ATTRIBUTES}.new_slot.to_integer,
						info.is_virtual,
						property_or_event,
						referenced_type_from_type (l_decl_type))
				else
					check
						from_documentation: False
					end
				end
			end
		end

	consumed_property (info: PROPERTY_INFO): detachable CONSUMED_PROPERTY
			-- Process property `info'.
		require
			non_void_property_info: info /= Void
		local
			l_getter: CONSUMED_FUNCTION
			l_setter: CONSUMED_PROCEDURE
			l_info: METHOD_INFO
		do
			if info.can_read then
				l_info := property_getter (info)
				if l_info /= Void then
					l_getter := consumed_function (l_info, True)
				end
			end
			if info.can_write then
				l_info := property_setter (info)
				if l_info /= Void then
					l_setter := consumed_procedure (l_info, True)
				end
			end
			if attached l_info then
				if l_getter /= Void or l_setter /= Void then
					if attached info.declaring_type as l_type then
						create Result.make (
							create {STRING}.make_from_cil (info.name),
							l_info.is_public,
							l_info.is_static,
							referenced_type_from_type (l_type),
							l_getter,
							l_setter)
					else
						check
							from_documentation_declaring_type_attached: False
						end
					end
				end
			end
		end

	consumed_event (info: EVENT_INFO): detachable CONSUMED_EVENT
			-- Process event `info'.
		require
			non_void_event_info: info /= Void
		local
			l_add_method, l_remove_method, l_raise_method: METHOD_INFO
			dotnet_name: STRING
			l_raiser, l_adder, l_remover: CONSUMED_PROCEDURE
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

			create dotnet_name.make_from_cil (info.name)
			if l_remover /= Void or l_raiser /= Void or l_adder /= Void then
				if attached info.declaring_type as l_type then
					create Result.make (
						dotnet_name,
						True,
						referenced_type_from_type (l_type),
						l_raiser,
						l_adder,
						l_remover
						)
				else
					check
						from_documentation_declaring_type_attached: False
					end
				end
			end
		end

	consumed_parent (a_type: SYSTEM_TYPE): detachable SYSTEM_TYPE
			-- Retrieves a consume parent of `a_type'.
		require
			a_type_attached: a_type /= Void
		local
			l_base: SYSTEM_TYPE
		do
			l_base := a_type.base_type
			if l_base /= Void then
				if is_consumed_type (l_base) then
					Result := l_base
				else
					Result := consumed_parent (l_base)
				end
			end
		end

	solved_constructors (
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]): ARRAYED_LIST [CONSUMED_CONSTRUCTOR]

			-- Initialize `constructors' from `tc'.
		require
			non_void_constructors: tc /= Void
		local
			name: STRING
			i, nb: INTEGER
			args: ARRAY [CONSUMED_ARGUMENT]
			l_reserved: like reserved_names
		do
			create Result.make (tc.count)
			if tc.count > 0 then
				tc.start
				if tc.count = 1 then
						-- When there is only one constructor, let's call it make
						-- to avoid confusion.
					tc.item.set_name (Creation_routine_name)
					Result.extend (tc.item.consumed_constructor)
				else
						-- Compute all possible names for constructor.
					from
						l_reserved := reserved_names
						tc.start
						args := tc.item.arguments
						if args.count = 0 then
							tc.item.set_name (Creation_routine_name)
							Result.extend (tc.item.consumed_constructor)
							tc.forth
						else

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
						name := unique_feature_name (name)
						tc.item.set_name (name)
						Result.extend (tc.item.consumed_constructor)
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
							i > nb
							-- `or not l_reserved.has (name)`
							-- FIXME For now, append all argument names.
							--	see how to improve Eiffel to select feature in inheritance clause
							--	passing signature, instead of relying on argument names !							
						loop
							if i > 1 then
								name.append ("_and_")
							end
							name.append (args.item (i).eiffel_name)
							i := i + 1
						end
						name := unique_feature_name (name)
						tc.item.set_name (name)
						Result.extend (tc.item.consumed_constructor)
						tc.forth
					end
				end
			end
		ensure
			non_void_constructors: Result /= Void
		end

	internal_members: NATIVE_ARRAY [detachable MEMBER_INFO]
			-- Type members used to initialize `features'

	internal_properties: NATIVE_ARRAY [detachable PROPERTY_INFO]
			-- Properties from type and parents

	internal_events: NATIVE_ARRAY [detachable EVENT_INFO]
			-- Events from type and parents

	internal_constructors: NATIVE_ARRAY [detachable CONSTRUCTOR_INFO]
			-- Constructors of .NET type

	internal_referenced_type: CONSUMED_REFERENCED_TYPE
			-- Representation of Current if it was used
			-- for CONSUMED_REFERENCED_TYPE.

	Constructor_overload_resolution: INTEGER = 3
			-- Number of arguments in a constructor for which we always expand
			-- their name definition.

	Creation_routine_name: STRING = "make"
	Complete_creation_routine_name_prefix: STRING = "make_from_"
	Partial_creation_routine_name_prefix: STRING = "make_with_"
			-- Creation routine name prefix


feature {NONE} -- Status Setting.

--	properties_and_events: HASH_TABLE [LINKED_LIST [METHOD_INFO], STRING]
	properties_and_events: HASHTABLE --[METHOD_INFO, SYSTEM_STRING]
			-- List of properties and events.

	key_args (args: detachable NATIVE_ARRAY [detachable PARAMETER_INFO]): SYSTEM_STRING
			-- return signature corresponding to args.
		local
			i: INTEGER
			l_str: STRING
		do
			create l_str.make_empty
			if args /= Void then
				from
					i := 0
				until
					i = args.count
				loop
					if
						attached args.item (i) as l_arg and then attached l_arg.parameter_type as l_type and then
						attached l_type.name as l_name
					then
						l_str.append (create {STRING}.make_from_cil (l_name))
					end
					i := i + 1
				end
			end
			Result := l_str.to_cil
		ensure
			non_void_result: Result /= Void
		end


	add_property (info: PROPERTY_INFO)
			-- add property.
		require
			non_void_info: info /= Void
		local
			l_info: METHOD_INFO
		do
			if info.can_read then
				l_info := property_getter (info)
				if l_info /= Void then
					add_properties_or_events (l_info)
				end
			end
			if info.can_write then
				l_info := property_setter (info)
				if l_info /= Void then
					add_properties_or_events (l_info)
				end
			end
		end

	add_event (info:EVENT_INFO)
			-- Add event.
		require
			non_void_info: info /= Void
		local
			l_adder, l_remover, l_raiser: detachable METHOD_INFO
		do
			l_adder := event_adder (info)
			l_remover := event_remover (info)
			l_raiser := event_raiser (info)

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

	add_properties_or_events (info: METHOD_INFO)
			-- Add info to `properties_and_events'.
		require
			non_void_info: info /= Void
		local
			l_key: SYSTEM_STRING
			l_dotnet_name: SYSTEM_STRING
		do
			if is_consumed_method (info) then
				l_dotnet_name := info.name
				create l_key.make_from_c_and_count (' ', 0)
				l_key := l_key.concat_string_string (l_dotnet_name, key_args (info.get_parameters))
				if not properties_and_events.contains_key (l_key) then
					properties_and_events.add (l_key, info)
				end
			end
		ensure
--			info_added: is_consumed_method (info) implies properties_and_events.contains_key (info.name + key_args (info.get_parameters))
		end

	is_property_or_event (info: METHOD_INFO): BOOLEAN
			-- Is `internal_method' a property or event related feature?
		require
			non_void_info: info /= Void
		local
			l_key: SYSTEM_STRING
			l_dotnet_name: SYSTEM_STRING
			l_index: INTEGER
		do
			l_dotnet_name := info.name
			if attached l_dotnet_name then
				l_index := l_dotnet_name.last_index_of_character ('.')
				if l_index > 0 then
					l_dotnet_name := l_dotnet_name.substring (l_index + 1)
				end
				create l_key.make_from_c_and_count (' ', 0)
				l_key := l_key.concat_string_string (l_dotnet_name, key_args (info.get_parameters))
				Result := properties_and_events.contains_key (l_key)
			else
				check
					from_documentation_name_attached: False
				end
			end
		end

	is_infix (info: METHOD_INFO): BOOLEAN
			-- Is function an infix function?
		require
			is_function: is_function (info)
		do
			Result := attached info.name as l_info_name and then
				l_info_name.length > 3 and then
				info.is_special_name and then
				l_info_name.starts_with (Operator_name_prefix) and then
				attached info.get_parameters as l_params and then
				l_params.count = 2 and then
				attached l_params.item (0) as l_param and then
				l_param.parameter_type ~ info.reflected_type and then
				not l_info_name.equals (Op_implicit) and then
				not l_info_name.equals (Op_explicit)
		end

	is_prefix (info: METHOD_INFO): BOOLEAN
			-- Is function a prefix function?
		require
			is_function: is_function (info)
		do
			Result := attached info.name as l_info_name and then
				l_info_name.length > 3 and then
				info.is_special_name and then
				l_info_name.starts_with (Operator_name_prefix) and then
				attached info.get_parameters as l_params and then
				l_params.count = 1 and then
				attached l_params.item (0) as l_param and then
				l_param.parameter_type ~ info.reflected_type and then
				not l_info_name.equals (Op_implicit) and then
				not l_info_name.equals (Op_explicit)
		end

	is_function (info: METHOD_INFO): BOOLEAN
			-- Is method a function?
		do
			Result := not Void_type.equals_type (info.return_type)
		end

	Void_type: SYSTEM_TYPE
			-- Void .NET type
		once
			Result := {SYSTEM_TYPE}.get_type ("System.Void")
			if not attached Result then
				check
					void_type_exists: False
				then
				end
			end
		end

	Operator_name_prefix: SYSTEM_STRING = "op_"
	Op_implicit: SYSTEM_STRING = "op_implicit"
	Op_explicit: SYSTEM_STRING = "op_Explicit"
			-- Special prefix for .NET operators


feature {NONE} -- Added features of System.Object to Interfaces

	update_interface_members (t: SYSTEM_TYPE)
			-- Updates members of interface to present a flat list of members and to include members of System.Object.
		local
			l_members: like internal_members
			l_obj_method: METHOD_INFO
			l_processed: HASHTABLE
			i, j, k, nb: INTEGER
			l_matched: BOOLEAN
			l_object_methods: like Object_methods
			l_meth_name: STRING
			l_params, l_obj_params: NATIVE_ARRAY [detachable PARAMETER_INFO]
		do
			create l_processed.make_from_capacity (10)

			create internal_members.make (0)
			create internal_properties.make (0)
			create internal_events.make (0)

			internal_update_interface_members (t, l_processed)

			from
				l_object_methods := Object_methods.twin
				l_members := internal_members
				i := l_members.lower
				nb := l_members.upper
			until
				i > nb
			loop
				if attached {METHOD_INFO} l_members.item (i) as l_method then
					l_meth_name := object_key_name (l_method)
					l_obj_method := l_object_methods.item (l_meth_name)
					if l_obj_method /= Void then
							-- Let's check return type and arguments type.
						l_obj_params := l_obj_method.get_parameters
						l_params := l_method.get_parameters
						if
							(l_params /= Void and l_obj_params /= Void) and then
							l_obj_method.return_type ~ l_method.return_type and then
							l_obj_params.count = l_params.count
						then
							from
								j := l_obj_params.lower
								k := l_obj_params.upper
								l_matched := True
							until
								j > k or not l_matched
							loop
								l_matched := attached l_obj_params.item (j) as l_obj_param and then
									attached l_params.item (j) as l_param and then
									l_obj_param.parameter_type ~ l_param.parameter_type
								j := j + 1
							end
							if l_matched then
								l_object_methods.remove (l_meth_name)
							end
						end
					end
				end
				i := i + 1
			end

			create l_members.make (internal_members.count + l_object_methods.count)
 			{SYSTEM_ARRAY}.copy (internal_members, l_members, internal_members.count)

			from
				l_object_methods.start
				i := internal_members.count
			until
				l_object_methods.after
			loop
				l_members.put (i, l_object_methods.item_for_iteration)
				i := i + 1
				l_object_methods.forth
			end

			internal_members := l_members
		end

	internal_update_interface_members (t: SYSTEM_TYPE; processed: HASHTABLE)
			-- Update `internal_members', `internal_properties' and `internal_events' and recursively explores parent interface
			-- if not already in `processed'.
		require
			t_attached: t /= Void
			processed_attached: processed /= Void
		local
			l_merged_members: NATIVE_ARRAY [MEMBER_INFO]
			l_merged_properties: NATIVE_ARRAY [PROPERTY_INFO]
			l_merged_events: NATIVE_ARRAY [EVENT_INFO]
			l_interfaces: NATIVE_ARRAY [detachable SYSTEM_TYPE]
			i, nb: INTEGER
			l_interface: SYSTEM_TYPE
			l_members: NATIVE_ARRAY [detachable MEMBER_INFO]
			l_properties: NATIVE_ARRAY [detachable PROPERTY_INFO]
			l_events: NATIVE_ARRAY [detachable EVENT_INFO]
		do
			l_members := t.get_members_binding_flags ({BINDING_FLAGS}.instance |
					{BINDING_FLAGS}.static | {BINDING_FLAGS}.public |
					{BINDING_FLAGS}.non_public)
			l_properties := t.get_properties_binding_flags ({BINDING_FLAGS}.instance |
					{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public |
					{BINDING_FLAGS}.static)
			l_events := t.get_events_binding_flags ({BINDING_FLAGS}.instance |
					{BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public |
					{BINDING_FLAGS}.static)

				-- merge members.
			if l_members /= Void then
				create l_merged_members.make (internal_members.count + l_members.count)
				{SYSTEM_ARRAY}.copy (l_members, 0, l_merged_members, internal_members.count, l_members.count)
			else
				create l_merged_members.make (internal_members.count)
			end
			{SYSTEM_ARRAY}.copy (internal_members, l_merged_members, internal_members.count)
			internal_members := l_merged_members

				-- merge properties.
			if l_properties /= Void then
				create l_merged_properties.make (internal_properties.count + l_properties.count)
				{SYSTEM_ARRAY}.copy (l_properties, 0, l_merged_properties, internal_properties.count, l_properties.count)
			else
				create l_merged_properties.make (internal_properties.count)
			end
			{SYSTEM_ARRAY}.copy (internal_properties, l_merged_properties, internal_properties.count)
			internal_properties := l_merged_properties

				-- merge events.
			if l_events /= Void then
				create l_merged_events.make (internal_events.count + l_events.count)
				{SYSTEM_ARRAY}.copy (l_events, 0, l_merged_events, internal_events.count, l_events.count)
			else
				create l_merged_events.make (internal_events.count)
			end
			{SYSTEM_ARRAY}.copy (internal_events, l_merged_events, internal_events.count)
			internal_events := l_merged_events

			l_interfaces := t.get_interfaces
			if l_interfaces /= Void then
				from
					processed.Add (t, t)
					i := 0
					nb := l_interfaces.count - 1
				until
					i > nb
				loop
					l_interface := l_interfaces.item (i)
					if l_interface /= Void and then not processed.Contains (l_interface) then
						internal_update_interface_members (l_interface, processed)
					end
					i := i + 1
				end
			end
		end

	object_methods: HASH_TABLE [METHOD_INFO, STRING]
			-- List of members of System.Object.
		local
			l_type: SYSTEM_TYPE
			l_methods: NATIVE_ARRAY [detachable METHOD_INFO]
			l_meth: METHOD_INFO
			i, nb: INTEGER
		once
			l_type := {SYSTEM_OBJECT}
			l_methods := l_type.get_methods_binding_flags ({BINDING_FLAGS}.instance | {BINDING_FLAGS}.static | {BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
			if l_methods /= Void then
				create Result.make (l_methods.count)
				from
					i := l_methods.lower
					nb := l_methods.upper
				until
					i > nb
				loop
					l_meth := l_methods.item (i)
					if l_meth /= Void and then (l_meth.is_public or l_meth.is_family or l_meth.is_family_or_assembly) then
						Result.put (l_meth, object_key_name (l_meth))
					end
					i := i + 1
				end
			else
				create Result.make (0)
			end
		ensure
			object_methods: Result /= Void
		end

	object_static_methods: detachable NATIVE_ARRAY [detachable METHOD_INFO]
			-- List of members of System.Object static methods
		local
			l_type: SYSTEM_TYPE
		once
			l_type := {SYSTEM_OBJECT}
			Result := l_type.get_methods_binding_flags ({BINDING_FLAGS}.static | {BINDING_FLAGS}.public | {BINDING_FLAGS}.non_public)
		end

	object_key_name (a_method: METHOD_INFO): STRING
			-- Retrieves a key for use with `object_methods' given method `a_method'
		require
			a_method_attached: a_method /= Void
		local
			l_count, i: INTEGER
		do
			create Result.make_from_cil (a_method.name)
			Result.append_character ('(')
			if attached a_method.get_parameters as l_params then
				from
					l_count := l_params.length
				until
					i = l_count
				loop
					if attached l_params.item (i) as l_param and then attached l_param.parameter_type as l_type then
						if i > 0 then
							Result.append_character (',')
						end
						Result.append (create {STRING}.make_from_cil (l_type.name))
					end
					i := i + 1
				end
			end
			Result.append_character (')')
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Added features for ENUM types.

	Additional_enum_features: INTEGER = 3
			-- Number of additional features for enum types.

	infix_and_feature (a_enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION
			-- Create instance of CONSUMED_FUNCTION for `&' in enum type `t'.
		require
			a_enum_type_not_void: a_enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
		do
			create l_arg.make ("other", "other", a_enum_type)
			l_args := <<l_arg>>
			create Result.make ("&", "&", "&", l_args, a_enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				True,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public
				False,  -- is_new_slot
				True,	-- is_virtual
				False,	-- is_property_or_event
				a_enum_type)
			Result.set_is_artificially_added (True)
		end

	infix_or_feature (a_enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION
			-- Create instance of CONSUMED_FUNCTION for `|' in enum type `t'.
		require
			a_enum_type_not_void: a_enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
		do
			create l_arg.make ("other", "other", a_enum_type)
			l_args := <<l_arg>>
			create Result.make ("|", "|", "|", l_args, a_enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				True,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public
				False,  -- is_new_slot
				True,	-- is_virtual
				False,	-- is_property_or_event
				a_enum_type)
			Result.set_is_artificially_added (True)
		end

	from_integer_feature (a_enum_type: CONSUMED_REFERENCED_TYPE; a_underlying_enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION
			-- Create instance of CONSUMED_FUNCTION for`from_integer' in enum type `t'.
		require
			a_enum_type_not_void: a_enum_type /= Void
			a_underlying_enum_type_void: a_underlying_enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_arg: CONSUMED_ARGUMENT
		do
			create l_arg.make ("a_value", "a_value", a_underlying_enum_type)
			l_args := <<l_arg>>
			create Result.make ("from_integer", "from_integer", "from_integer", l_args, a_enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				False,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public,
				False,	-- is_new_slot
				True,	-- is_virtual
				False,	-- is_property_or_event
				a_enum_type)
			Result.set_is_artificially_added (True)
		end

	to_integer_feature (a_enum_type: CONSUMED_REFERENCED_TYPE; a_underlying_enum_type: CONSUMED_REFERENCED_TYPE): CONSUMED_FUNCTION
			-- Create instance of CONSUMED_FUNCTION for`to_integer' in enum type `t'.
		require
			a_enum_type_not_void: a_enum_type /= Void
		local
			l_args: ARRAY [CONSUMED_ARGUMENT]
		do
			create l_args.make_empty
			create Result.make ("to_integer", "to_integer", "to_integer", l_args, a_underlying_enum_type,
				True,	-- is_frozen
				False,	-- is_static
				False,	-- is_deferred
				False,	-- is_infix
				False,	-- is_prefix
				True,	-- is_public,
				False,	-- is_new_slot
				True,	-- is_virtual
				False,	-- is_property_or_event
				a_enum_type)
			Result.set_is_artificially_added (True)
		end

	attribute_setter_feature (a_field: FIELD_INFO; a_field_name: STRING): CONSUMED_PROCEDURE
			-- attribute setter feature.
		require
			non_void_field: a_field /= Void and then a_field.name /= Void
			public_field: is_public_field (a_field)
			valid_field_name: a_field_name /= Void and then not a_field_name.is_empty
		do
			if
				attached a_field.field_type as l_type and then
				attached a_field.name as l_dotnet_field_name
			then
				create Result.make_attribute_setter
					("set_" + a_field_name + "_field",
					l_dotnet_field_name,
					create {CONSUMED_ARGUMENT}.make ("a_value", "a_value", referenced_type_from_type (l_type)),
					internal_referenced_type,
					a_field.is_static)
			else
				check
					from_documentation_field_type_and_name_attached: False
				then
				end
			end
		end

	integer_type: CONSUMED_REFERENCED_TYPE
			-- Referenced type of `System.Int32'.
		do
			if attached {SYSTEM_TYPE}.get_type ("System.Int32") as t then
				Result := referenced_type_from_type (t)
			else
				check
					has_int_32: False
				then
				end
			end
		ensure
			integer_type_not_void: integer_type /= Void
		end

	literal_field_value (val: SYSTEM_OBJECT): STRING
			-- Convert `val' into a STRING representation.
		require
			val_not_void: val /= Void
		local
			l_type: SYSTEM_TYPE
		do
			l_type := val.get_type
				-- Note: The following code still use assignment attempt because
				-- using object test does not work as it test for exact types whereas
				-- assignment attempt was also doing some magic conversion.
			if l_type ~ Double_type and then attached {REAL_64} val as d then
				Result := bytes_to_string ({BIT_CONVERTER}.get_bytes_double (d))
			elseif l_type ~ Real_type and then attached {REAL_32} val as r then
				Result := bytes_to_string ({BIT_CONVERTER}.get_bytes_real (r))
			else
				create Result.make_from_cil (val.to_string)
			end
		end

	bytes_to_string (a: detachable NATIVE_ARRAY [NATURAL_8]): STRING
			-- Convert `a' into an hexadecimal string.
		local
			i, nb: INTEGER
			l_hex: INTEGER
			l_hex_string: STRING
		do
			if a /= Void then
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
			else
				create Result.make_empty
			end
		ensure
			converted: Result /= Void
		end

	Double_type: detachable SYSTEM_TYPE
			-- typeof (double)
		once
			Result := {SYSTEM_TYPE}.get_type_string (("System.Double").to_cil)
		end

	Real_type: detachable SYSTEM_TYPE
			-- typeof (float)
		once
			Result := {SYSTEM_TYPE}.get_type_string (("System.Single").to_cil)
		end

	enum_type: SYSTEM_TYPE
			-- typeof (System.Enum)
		once
			Result := {ENUM}
		ensure
			result_attached: Result /= Void
		end

	value_type_type: SYSTEM_TYPE
			-- typeof (System.ValueType)
		once
			Result := {VALUE_TYPE}
		ensure
			result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
