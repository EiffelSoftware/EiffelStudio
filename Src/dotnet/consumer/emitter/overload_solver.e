indexing
	description: "Solve overloading for a given .NET type"

class
	OVERLOAD_SOLVER

inherit
	NAME_FORMATTER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize solver
		do
			create method_table.make (20)
			create reserved_names.make (20)
			create methods.make (1, 0)
			create functions.make (1, 0)
		end

feature -- Access

	methods: ARRAY [CONSUMED_METHOD]
			-- Methods with appropriate (non-overloaded) Eiffel names
	
	functions: ARRAY [CONSUMED_FUNCTION]
			-- Functions with appropriate (non-overloaded) Eiffel names

feature -- Basic Operations

	solve is
			-- Initialize `methods' and `functions'.
			-- Can only be called once.
		require
			not_solved: not solved
		local
			method: METHOD_INFO
			method_index, function_index: INTEGER
		do
			from
				method_table.start
				method_index := 1
				function_index := 1
			until
				method_table.after
			loop
				method_table.item_for_iteration.start
				method := method_table.item_for_iteration.item.item
				if method.get_return_type.equals (Void_type) then
					methods.force (consumed_method (method), method_index)
					method_index := method_index + 1
				else
					functions.force (consumed_function (method), function_index)
					function_index := function_index + 1
				end
				method_table.forth
			end
			solved := True
		ensure
			solved: solved
		end

feature -- Status Report

	solved: BOOLEAN
			-- Was `solve' called?

feature -- Element Settings

	add_method (meth: METHOD_INFO) is
			-- Include `meth' in overload solving process.
		local
			name: STRING
		do
			create name.make_from_cil (meth.get_name)
			method_table.search (name)
			if not method_table.found then
				method_table.put (create {LINKED_LIST [CLI_CELL [METHOD_INFO]]}.make, name)
				method_table.item (name).extend (create {CLI_CELL [METHOD_INFO]}.put (meth))
			else
				method_table.found_item.extend (create {CLI_CELL [METHOD_INFO]}.put (meth))
			end
		end

	add_reserved_name (name: STRING) is
			-- Extend `reserved_names' with `name' .
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			if not reserved_names.has (name.hash_code) then
				reserved_names.put (name, name.hash_code)
			end
		ensure
			extended: reserved_names.has (name.hash_code)
		end
		
feature {NONE} -- Implementation

	method_table: HASH_TABLE [LINKED_LIST [CLI_CELL [METHOD_INFO]], STRING]
			-- Table of methods

	reserved_names: HASH_TABLE [STRING, INTEGER]
			-- Reserved names for overload solving

	consumed_function (info: METHOD_INFO): CONSUMED_FUNCTION is
			-- Eiffel function from `info'
		require
			non_void_method_info: info /= Void
			valid_function: not info.get_return_type.equals (Void_type)
		local
			dotnet_name: STRING
			is_infix, is_prefix: BOOLEAN
 		do
			create dotnet_name.make_from_cil (info.get_name)
			if info.get_name.get_length > 3 and then
						info.get_is_special_name and then
						info.get_name.starts_with (Operator_name_prefix.to_cil) then
				if info.get_parameters.get_length = 1 then
					is_prefix := True
				else
					check
						valid_operator: info.get_parameters.get_length = 2
					end
					is_infix := True
				end
			end
			create Result.make (
								format_feature_name (dotnet_name),
								dotnet_name,
								arguments (info),
								create {CONSUMED_REFERENCED_TYPE}.make (info.get_return_type),
								info.get_is_final,
								info.get_is_static,
								info.get_is_abstract,
								is_infix,
								is_prefix)
		ensure
			non_void_feature: Result /= Void
		end

	consumed_method (info: METHOD_INFO): CONSUMED_METHOD is
			-- Eiffel function from `info'
		require
			non_void_method_info: info /= Void
			valid_method: info.get_return_type.equals (Void_type)
		local
			dotnet_name: STRING
 		do
			create dotnet_name.make_from_cil (info.get_name)
			create Result.make (
								format_feature_name (dotnet_name),
								dotnet_name,
								arguments (info),
								info.get_is_final,
								info.get_is_static,
								info.get_is_abstract)
		ensure
			non_void_feature: Result /= Void
		end

	Void_type: TYPE is
			-- Void .NET type
		once
			Result := feature {TYPE}.get_type_string (("System.Void").to_cil)
		end

	Operator_name_prefix: STRING is "op_"
			-- Special prefix for .NET operators

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

end -- class OVERLOAD_SOLVER
