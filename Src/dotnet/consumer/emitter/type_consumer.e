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
			else
				internal_members := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
					feature {BINDING_FLAGS}.non_public)
			end
			
			internal_properties := t.get_properties_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
					feature {BINDING_FLAGS}.non_public | feature {BINDING_FLAGS}.flatten_hierarchy)
			internal_events := t.get_events_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
					feature {BINDING_FLAGS}.non_public | feature {BINDING_FLAGS}.flatten_hierarchy)
			internal_constructors := t.get_constructors
			internal_referenced_type := referenced_type_from_type (t)
		ensure
			non_void_consumed_type: consumed_type /= Void
			non_void_internal_members: internal_members /= Void
			non_void_internal_constructors: internal_constructors /= Void
			non_void_internal_referenced_type: internal_referenced_type /= Void
		end
		
feature -- Access

	consumed_type: CONSUMED_TYPE
			-- Consumed type last created or initialized

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
			i, nb, arg_count, index: INTEGER
			fields: ARRAYED_LIST [CONSUMED_FIELD]
			l_functions, l_other_functions: ARRAY [CONSUMED_FUNCTION]
			cf: CONSUMED_FIELD
			cons: CONSTRUCTOR_INFO
			field: FIELD_INFO
			meth: METHOD_INFO
			member: MEMBER_INFO	
			overload_solver: OVERLOAD_SOLVER
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]
			l_events: ARRAY [CONSUMED_EVENT]
			l_properties: ARRAY [CONSUMED_PROPERTY]
		do
			check
				non_void_internal_members: internal_members /= Void
				non_void_internal_constructors: internal_constructors /= Void
			end
			create tc.make
			create fields.make (0)
			create reserved_names.make (100)
			create overload_solver.make

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
			
			from
				i := 0
				nb := internal_members.count
			until
				i = nb
			loop
				member := internal_members.item (i)
				if member.get_member_type = feature {MEMBER_TYPES}.field then
					field ?= member
					check
						is_field: field /= Void
					end
					if is_consumed_field (field) then
						fields.extend (consumed_field (field))						
					end
				elseif member.get_member_type = feature {MEMBER_TYPES}.method then
					meth ?= member
					check
						is_method: meth /= Void
					end
					if is_consumed_method (meth) then
						overload_solver.add_method (meth)
					end
				end
				i := i + 1
			end

			from
				i := 0
				nb := internal_properties.count
				create l_properties.make (1, internal_properties.count)
			until
				i = nb
			loop
				l_properties.put (consumed_property (internal_properties.item (i)), i + 1)
				i := i + 1
			end

			from
				i := 0
				nb := internal_events.count
				create l_events.make (1, internal_events.count)
			until
				i = nb
			loop
				l_events.put (consumed_event (internal_events.item (i)), i + 1)
				i := i + 1
			end

			consumed_type.set_properties (l_properties)
			consumed_type.set_events (l_events)
			consumed_type.set_constructors (solved_constructors (tc))
			consumed_type.set_fields (fields)
			overload_solver.set_reserved_names (reserved_names)
			overload_solver.solve
			consumed_type.set_procedures (overload_solver.procedures)
			l_functions := overload_solver.functions
			if consumed_type.is_enum then
				from
					i := 1
					l_other_functions := l_functions
					nb := l_other_functions.count
					create l_functions.make (1, nb + Additional_enum_features)
				until
					i > nb
				loop
					l_functions.put (l_other_functions.item (i), i)
					i := i + 1
				end
				l_functions.put (infix_or_feature (internal_referenced_type), i)
				l_functions.put (from_integer_feature (internal_referenced_type), i + 1)
				l_functions.put (to_integer_feature (internal_referenced_type), i + 2)
			end
			consumed_type.set_functions (l_functions)			
			initialized := True
		ensure
			initialized: initialized
			non_void_constructors: consumed_type.constructors /= Void
			non_void_fields: consumed_type.fields /= Void
			non_void_procedures: consumed_type.procedures /= Void
			non_void_functions: consumed_type.functions /= Void
			non_void_properties: consumed_type.properties /= Void
			non_void_events: consumed_type.events /= Void
		end

feature {NONE} -- Implementation

	consumed_field (info: FIELD_INFO): CONSUMED_FIELD is
			-- Eiffel attribute from `info'
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

	consumed_property (info: PROPERTY_INFO): CONSUMED_PROPERTY is
			-- Process property `info'.
		require
			non_void_property_info: info /= Void
		local
			dotnet_name: STRING
		do
			create dotnet_name.make_from_cil (info.get_name)
			create Result.make (
				formatted_feature_name (dotnet_name),
				dotnet_name,
				True,
				info.get_can_read,
				info.get_can_write,
				referenced_type_from_type (info.get_property_type),
				referenced_type_from_type (info.get_declaring_type))				
		ensure
			non_void_property: Result /= Void
		end
		
	consumed_event (info: EVENT_INFO): CONSUMED_EVENT is
			-- Process event `info'.
		require
			non_void_event_info: info /= Void
		local
			l_add_method, l_remove_method, l_raise_method: METHOD_INFO
			dotnet_name: STRING
			l_raiser: CONSUMED_PROCEDURE
			l_args: ARRAY [CONSUMED_ARGUMENT]
			l_dotnet_args: NATIVE_ARRAY [PARAMETER_INFO]
			i, nb: INTEGER
		do
			l_add_method := info.get_add_method
			l_remove_method := info.get_remove_method
			l_raise_method := info.get_raise_method
			if l_raise_method /= Void then
				l_dotnet_args := l_raise_method.get_parameters
				nb := l_dotnet_args.get_length
				create l_args.make (1, nb + 1)
				from
					i := 0
				until
					i = nb
				loop
					create dotnet_name.make_from_cil (l_dotnet_args.item (i).get_name)
					l_args.put (create {CONSUMED_ARGUMENT}.make (
									dotnet_name,
									formatted_variable_name (dotnet_name),
									referenced_type_from_type (l_dotnet_args.item (i).get_parameter_type),
									False), i + 1)
					i := i + 1
				end
				create dotnet_name.make_from_cil (l_raise_method.get_name)
				create l_raiser.make (
					formatted_feature_name (dotnet_name),
					dotnet_name,
					l_args,
					l_raise_method.get_is_final,
					l_raise_method.get_is_static,
					l_raise_method.get_is_abstract,
					l_raise_method.get_is_public,
					True,
					referenced_type_from_type (l_raise_method.get_declaring_type))
			end
			create dotnet_name.make_from_cil (info.get_name)
			create Result.make (
				formatted_feature_name (dotnet_name),
				dotnet_name,
				True,
				(l_add_method /= Void),
				(l_remove_method /= Void),
				referenced_type_from_type (l_add_method.get_parameters.item (0).get_parameter_type),
				l_raiser,
				referenced_type_from_type (info.get_declaring_type))
		ensure
			non_void_event: Result /= Void
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

feature {NONE} -- Added features of System.Object to Interfaces

	update_interface_members (t: TYPE) is
			-- 
		local
			l_members: NATIVE_ARRAY [MEMBER_INFO]
			l_processed: HASHTABLE
		do
			create l_processed.make_from_capacity (10)
			internal_members := internal_update_interface_members (t, l_processed)

			create l_members.make (internal_members.count + Object_members.count)
			feature {SYSTEM_ARRAY}.copy (internal_members, l_members, internal_members.count)
			feature {SYSTEM_ARRAY}.copy_array_integer_32 (Object_members, 0, l_members,
				internal_members.count, Object_members.count)
			internal_members := l_members
		end

	internal_update_interface_members (t: TYPE; processed: HASHTABLE): NATIVE_ARRAY [MEMBER_INFO] is
			-- Update `internal_members' and recursively explores parent interface
			-- if not already in `processed'.
		local
			l_members, l_merged_members: NATIVE_ARRAY [MEMBER_INFO]
			l_interfaces: NATIVE_ARRAY [TYPE]
			i, nb: INTEGER
			l_interface: TYPE
		do
			from
				l_interfaces := t.get_interfaces
				Result := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
					feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public |
					feature {BINDING_FLAGS}.non_public)
				processed.Add (t, t)
				i := 0
				nb := l_interfaces.count - 1
			until
				i > nb
			loop
				l_interface := l_interfaces.item (i)
				if not processed.Contains (l_interface) then
					l_members := internal_update_interface_members (l_interface, processed)
					create l_merged_members.make (Result.count + l_members.count)
					feature {SYSTEM_ARRAY}.copy (Result, l_merged_members, Result.count)
					feature {SYSTEM_ARRAY}.copy_array_integer_32 (l_members, 0, l_merged_members,
						Result.count, l_members.count)
					Result := l_merged_members
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
