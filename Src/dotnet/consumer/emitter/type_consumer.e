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
			-- Initialize type consumer for `type' with eiffel name `en'.
		require
			non_void_type: t /= Void
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		local
			dotnet_name: STRING
			inter: NATIVE_ARRAY [TYPE]
			interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			parent: CONSUMED_REFERENCED_TYPE
			i, count: INTEGER
			parent_type: TYPE
			members, constructors: NATIVE_ARRAY [MEMBER_INFO]
		do
			create dotnet_name.make_from_cil (t.get_full_name)
			parent_type := t.get_base_type
			if parent_type /= Void and then is_consumed_type (parent_type) then
				parent := referenced_type_from_type (parent_type)
			end 
			inter := t.get_interfaces
			create interfaces.make (1, 0)
			from
				i := 1
		 	until
				i > inter.get_length
			loop
				parent_type := inter.item (i - 1)
				if is_consumed_type (parent_type) then
					count := count + 1
					interfaces.force (referenced_type_from_type (parent_type), count)
				end
				i := i + 1
			end
			create consumed_type.make (dotnet_name,
										en,
										t.get_is_interface,
										t.get_is_abstract,
										t.get_is_sealed,
										t.get_is_value_type,
										t.get_is_enum,
										parent,
										interfaces)
			internal_members := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
													feature {BINDING_FLAGS}.static |
													feature {BINDING_FLAGS}.public |
													feature {BINDING_FLAGS}.non_public)
			internal_constructors := t.get_constructors
		ensure
			non_void_consumed_type: consumed_type /= Void
			non_void_internal_members: internal_members /= Void
			non_void_internal_constructors: internal_constructors /= Void
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
			-- `consumed_type.fields' and `consumed_type.constructors'.
		require
			not_initialized: not initialized
		local
			i, arg_count, index: INTEGER
			fields: ARRAYED_LIST [CONSUMED_FIELD]
			cf: CONSUMED_FIELD
			cons: CONSTRUCTOR_INFO
			field: FIELD_INFO
			meth: METHOD_INFO
			member: MEMBER_INFO	
			overload_solver: OVERLOAD_SOLVER
			tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]
		do
			check
				non_void_internal_members: internal_members /= Void
				non_void_internal_constructors: internal_constructors /= Void
			end
			create tc.make
			create fields.make (0)
			create {SORTED_TWO_WAY_LIST [STRING]} reserved_names.make
			reserved_names.compare_objects
			create overload_solver.make

			from
				i := 0
			until
				i = internal_constructors.get_length
			loop
				cons := internal_constructors.item (i)
				if is_consumed_method (cons) then
					tc.extend (create {CONSTRUCTOR_SOLVER}.make (cons))					
				end
				i := i + 1
			end
			
			from
				i := 0
			until
				i = internal_members.get_length
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

			consumed_type.set_constructors (solved_constructors (tc))
			consumed_type.set_fields (fields)
			overload_solver.set_reserved_names (reserved_names)
			overload_solver.solve
			consumed_type.set_procedures (overload_solver.procedures)
			consumed_type.set_functions (overload_solver.functions)
			initialized := True
		ensure
			initialized: initialized
			non_void_constructors: consumed_type.constructors /= Void
			non_void_fields: consumed_type.fields /= Void
			non_void_procedures: consumed_type.procedures /= Void
			non_void_functions: consumed_type.functions /= Void
		end

feature {NONE} -- Implementation

	consumed_field (info: FIELD_INFO): CONSUMED_FIELD is
			-- Eiffel attribute from `info'
		require
			non_void_field_info: info /= Void
		local
			dotnet_name: STRING
			field_type: TYPE
		do
			create dotnet_name.make_from_cil (info.get_name)
			field_type := info.get_field_type
			create Result.make (
								unique_feature_name (dotnet_name),
								dotnet_name,
								create {CONSUMED_REFERENCED_TYPE}.make (
										create {STRING}.make_from_cil (field_type.get_full_name),
										assembly_mapping.item (create {STRING}.make_from_cil (field_type.get_assembly.to_string))),
								info.get_is_static)
		end

	solved_constructors (tc: SORTED_TWO_WAY_LIST [CONSTRUCTOR_SOLVER]): ARRAY [CONSUMED_CONSTRUCTOR] is
			-- Initialize `constructors' from `tc'.
		require
			non_void_constructors: tc /= Void
		local
			arg, name: STRING
			i: INTEGER
			args: ARRAY [CONSUMED_ARGUMENT]
		do
			create Result.make (1, tc.count)
			if tc.count > 0 then
				tc.start
				tc.item.set_name (unique_feature_name (Default_creation_routine_name))
				from
					tc.forth
				until
					tc.after
				loop
					args := tc.item.arguments
					arg := args.item (1).eiffel_name
					create name.make (arg.count + Creation_routine_name_prefix.count)
					name.append (Creation_routine_name_prefix)
					name.append (arg)
					from
						i := 2
					until
						not reserved_names.has (name) or i > args.count
					loop
						name.append ("_and_")
						name.append (args.item (i).eiffel_name)
						i := i + 1
					end
					reserved_names.extend (name)
					tc.item.set_name (name)
					tc.forth
				end
				from
					tc.start
					i := 1
				until
					tc.after
				loop
					Result.put (tc.item.consumed_constructor, i)
					i := i + 1
					tc.forth
				end
			end
		ensure
			non_void_constructors: Result /= Void
		end
		
	internal_members: NATIVE_ARRAY [MEMBER_INFO]
			-- Type members used to initialize `features'

	internal_constructors: NATIVE_ARRAY [CONSTRUCTOR_INFO]
			-- Constructors of .NET type

	Default_creation_routine_name: STRING is "make"
			-- Default Eiffel creation routine name

	Argument_prefix: STRING is "arg_"
			-- Argument names prefix
	
	Creation_routine_name_prefix: STRING is "make_from_"
			-- Creation routine name prefix

end -- class TYPE_CONSUMER
