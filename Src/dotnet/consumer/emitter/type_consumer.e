indexing
	description: "{CONSUMED_TYPE} factory"

class
	TYPE_CONSUMER

inherit
	REFLECTION

	NAME_FORMATTER

create
	make

feature {NONE} -- Initialization

	make (t: TYPE) is
			-- Initialize type consumer for `type'.
		require
			non_void_type: t /= Void
		local
			dotnet_name: STRING
			inter: NATIVE_ARRAY [TYPE]
			interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			parent: CONSUMED_REFERENCED_TYPE
			i: INTEGER
		do
			create dotnet_name.make_from_cil (t.get_full_name)
			if t.get_base_type /= Void then
				create parent.make (t.get_base_type)				
			end 
			inter := t.get_interfaces
			create interfaces.make (1, inter.get_length)
			from
				i := 1
		 	until
				i > inter.get_length
			loop
				interfaces.put (create {CONSUMED_REFERENCED_TYPE}.make (inter.item (i - 1)), i)
				i := i + 1
			end
			create consumed_type.make (
				dotnet_name,
				format_type_name (dotnet_name),
				t.get_is_interface,
				t.get_is_abstract,
				t.get_is_sealed,
				t.get_is_value_type,
				parent,
				interfaces)
			internal_features := t.get_members_binding_flags (feature {BINDING_FLAGS}.instance |
																feature {BINDING_FLAGS}.static |
																feature {BINDING_FLAGS}.public |
																feature {BINDING_FLAGS}.non_public)
		ensure
			non_void_consumed_type: consumed_type /= Void
			non_void_internal_features: internal_features /= Void
		end
		
feature -- Access

	consumed_type: CONSUMED_TYPE
			-- Consumed type last created or initialized

feature -- Status Report

	initialized: BOOLEAN
			-- Was `consumed_type' initialized?

feature -- Basic Operation

	initialize is
			-- Initialize `consumed_type.functions', `consumed_type.methods',
			-- `consumed_type.fields' and `consumed_type.constructors'.
		require
			not_initialized: not initialized
		local
			i, arg_count, index: INTEGER
			fields: ARRAY [CONSUMED_FIELD]
			cf: CONSUMED_FIELD
			cons: CONSTRUCTOR_INFO
			field: FIELD_INFO
			meth: METHOD_INFO
			member: MEMBER_INFO	
			field_list, constructor_list: ARRAY_LIST
			overload_solver: OVERLOAD_SOLVER
		do
			check
				non_void_internal_features: internal_features /= Void
			end
			create constructor_list.make
			create field_list.make
			create overload_solver.make
			from
				i := 0
			until
				i = internal_features.get_length
			loop
				member := internal_features.item (i)
				cons ?= member
				if cons /= Void and then is_consumed_method (cons) then
					index := constructor_list.add (cons)
				else
					field ?= member
					if field /= Void then
						index := field_list.add (field)
					else
						meth ?= member
						if meth /= Void and then is_consumed_method (meth) then
							overload_solver.add_method (meth)
						end
					end
				end
				i := i + 1
			end
			create type_constructors.make
			from
				i := 0
			until
				i = constructor_list.get_count
			loop
				from
					cons ?= constructor_list.get_item (i)
					check
						valid_constructor_array: cons /= Void
					end
					arg_count := cons.get_parameters.get_length
					type_constructors.start
				until
					type_constructors.after
				loop
					if cons.get_parameters.get_length > arg_count then
						type_constructors.put_left (create {CLI_CELL [CONSTRUCTOR_INFO]}.put (cons))
						type_constructors.finish
					end
					type_constructors.forth
				end
				i := i + 1
			end	
			create fields.make (1, field_list.get_count)
			from
				i := 0
			until
				i = field_list.get_count
			loop
				field ?= field_list.get_item (i)
				check
					valid_field_list: field /= Void
				end
				cf := consumed_field (field)
				fields.put (cf, i + 1)
				overload_solver.add_reserved_name (cf.eiffel_name)
				i := i + 1
			end
			overload_solver.solve
			consumed_type.set_constructors (constructors)
			consumed_type.set_fields (fields)
			consumed_type.set_methods (overload_solver.methods)
			consumed_type.set_functions (overload_solver.functions)
		ensure
			initialized: initialized
			non_void_constructors: consumed_type.constructors /= Void
			non_void_fields: consumed_type.fields /= Void
			non_void_methods: consumed_type.methods /= Void
			non_void_functions: consumed_type.functions /= Void
		end

feature {NONE} -- Implementation

	consumed_field (info: FIELD_INFO): CONSUMED_FIELD is
			-- Eiffel attribute from `info'
		require
			non_void_field_info: info /= Void
		local
			dotnet_name: STRING
		do
			create dotnet_name.make_from_cil (info.get_name)
			create Result.make (
								format_feature_name (dotnet_name),
								dotnet_name,
								create {CONSUMED_REFERENCED_TYPE}.make (info.get_field_type),
								info.get_is_static)
		end

	constructors: ARRAY [CONSUMED_CONSTRUCTOR] is
			-- Eiffel creation routines
		require
			non_void_constructors: type_constructors /= Void
		local
			name: STRING
			sname: SYSTEM_STRING
			params: NATIVE_ARRAY [PARAMETER_INFO]
			i, counter: INTEGER
 		do
 			if type_constructors.is_empty then
 				create Result.make (1, 0)
 			else
	 			create Result.make (1, type_constructors.count)
 				type_constructors.start
	 			Result.put (create {CONSUMED_CONSTRUCTOR}.make (Default_creation_routine_name, arguments (type_constructors.item.item)), 1)
 				counter := 2
	 			from
	 				type_constructors.forth
	 			until
	 				type_constructors.after
	 			loop
	 				check
	 					at_least_one_argument: type_constructors.item.item.get_parameters.get_length > 0
	 				end
	 				name := Default_creation_routine_name + "_from_"
	 				from
	 					i := 0
	 					params := type_constructors.item.item.get_parameters
	 				until
	 					i > params.get_length
	 				loop
	 					sname := params.item (i).get_name
	 					if sname /= Void then
	 						name := name + create {STRING}.make_from_cil (sname)
	 					else
		 					name := name + "arg_" + (i + 1).out
		 				end
		 				Result.put (create {CONSUMED_CONSTRUCTOR}.make (name, arguments (type_constructors.item.item)), counter)
	 				end
	 				counter := counter + 1
	 			end
	 		end
		ensure
			non_void_feature: Result /= Void
		end

	arguments (info: METHOD_BASE): ARRAY [CONSUMED_ARGUMENT] is
			-- Argument of `info'
		require
			non_void_method: info /= Void
		local
			i: INTEGER
		do
			from
				create Result.make (1, info.get_parameters.get_length)
				i := 0
			until
				i >= info.get_parameters.get_length
			loop
				Result.put (create {CONSUMED_ARGUMENT}.make (info.get_parameters.item (i)), i + 1)
				i := i + 1
			end
		end

	type_constructors: LINKED_LIST [CLI_CELL [CONSTRUCTOR_INFO]]
			-- Type constructors sorted by parameters count
			--| Need to process constructors together

	internal_features: NATIVE_ARRAY [MEMBER_INFO]
			-- Type members used to initialize `features'

	Default_creation_routine_name: STRING is "make"
			-- Default Eiffel creation routine name

end -- class TYPE_CONSUMER
