indexing
	description: "Solve overloading for a given .NET type"
	date: "$Date$"
	revision: "$Revision$"

class
	OVERLOAD_SOLVER

inherit
	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

	NAME_SOLVER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize solver
		do
			create method_table.make (20)
			create procedures.make (1, 0)
			create functions.make (1, 0)
		end

feature -- Access

	procedures: ARRAY [CONSUMED_PROCEDURE]
			-- procedures with appropriate (non-overloaded) Eiffel names
	
	functions: ARRAY [CONSUMED_FUNCTION]
			-- Functions with appropriate (non-overloaded) Eiffel names

feature -- Basic Operations

	solve is
			-- Initialize `procedures' and `functions'.
			-- Can only be called once.
		require
			not_solved: not solved
		local
			procedure_index, function_index: INTEGER
			method_list: SORTED_TWO_WAY_LIST [METHOD_SOLVER]
			first_method, method: METHOD_SOLVER
			name, type: STRING
			i, index, param_count: INTEGER
			is_unique, same_param_count: BOOLEAN
		do
			from
				method_table.start
			until
				method_table.after
			loop
				method_list := method_table.item_for_iteration
				method_list.start
				first_method := method_list.item
				param_count := first_method.arguments.count
				if first_method.is_function then
					function_index := function_index + 1
				else
					procedure_index := procedure_index + 1
				end
				from
					method_list.forth
					if method_list.after then
						same_param_count := False
					else
						same_param_count := method_list.item.arguments.count = param_count
					end
				until
					method_list.after
				loop
					method := method_list.item
					same_param_count := same_param_count and method.arguments.count = param_count
					from
						name := formatted_feature_name (method.dotnet_name)
						is_unique := is_unique_signature (method, method_list, 0)
						i := 1
					until
						is_unique or i > method.arguments.count
					loop
						name.append_character ('_')
						name.append (
							formatted_variable_type_name (method.arguments.item (i).type.name))
						is_unique := is_unique_signature (method, method_list, i)
						i := i + 1
					end
					method.set_eiffel_name (unique_feature_name (name))
					if method.is_function then
						function_index := function_index + 1
					else
						procedure_index := procedure_index + 1
					end
					method_list.forth
				end
				if same_param_count then
					from
						name := formatted_feature_name (first_method.dotnet_name)
						i := 1
					until
						i > param_count
					loop
						name.append_character ('_')
						name.append (
							formatted_variable_type_name (first_method.arguments.item (i).type.name))
						i := i + 1
					end
					first_method.set_eiffel_name (unique_feature_name (name))
				else
					first_method.set_eiffel_name (unique_feature_name (first_method.dotnet_name))
				end
				method_table.forth
			end
			create functions.make (1, function_index)
			create procedures.make (1, procedure_index)
			from
				method_table.start
				function_index := 1
				procedure_index := 1
			until
				method_table.after
			loop
				method_list := method_table.item_for_iteration
				from
					method_list.start
				until
					method_list.after
				loop
					method := method_list.item
					if method.is_function then
						functions.put (method.consumed_function, function_index)
						function_index := function_index + 1
					else
						procedures.put (method.consumed_procedure, procedure_index)
						procedure_index := procedure_index + 1						
					end
					method_list.forth
				end
				method_table.forth
			end
			solved := True
		ensure
			solved: solved
		end
			
	is_unique_signature (method: METHOD_SOLVER; method_list: LIST [METHOD_SOLVER]; index: INTEGER): BOOLEAN is
			-- Are parameter types starting from index `index' in `method' unique in `method_list'?
		require
			non_void_method: method /= Void
			non_void_list: method_list /= Void
			valid_list: method_list.has (method)
			valid_index: index >= 0
		local
			meth: METHOD_SOLVER
			count, i: INTEGER
			cursor: CURSOR
		do
			Result := True
			if method.arguments.count /= 0 then
				cursor := method_list.cursor
				from
					method_list.start
				until
					method_list.after or not Result
				loop
					meth := method_list.item
					count := meth.arguments.count.min (method.arguments.count)
					if count >= index then
						from
							i := index
						until
							i > count or not Result
						loop
							Result := method_list.item = method or i > 0 and then
										not method_list.item.arguments.item (i).type.is_equal (method.arguments.item (i).type)
							i := i + 1
						end
					end
					method_list.forth
				end
				method_list.go_to (cursor)
			end
		ensure
			method_list_position_identical: method_list.cursor.is_equal (old method_list.cursor)
		end

feature -- Status Report

	solved: BOOLEAN
			-- Was `solve' called?

feature -- Element Settings

	add_method (meth: METHOD_INFO) is
			-- Include `meth' in overload solving process.
			-- Remove `get_' for properties getters.
		local
			name: STRING
		do
			if meth.get_is_special_name and meth.get_name.starts_with (("get_").to_cil) then
				create name.make_from_cil (meth.get_name.substring (4))
			else
				create name.make_from_cil (meth.get_name)
			end
			method_table.search (name)
			if not method_table.found then
				method_table.put (create {SORTED_TWO_WAY_LIST [METHOD_SOLVER]}.make, name)
				method_table.item (name).extend (create {METHOD_SOLVER}.make (meth))
			else
				method_table.found_item.extend (create {METHOD_SOLVER}.make (meth))
			end
		end
		
feature {NONE} -- Implementation

	method_table: HASH_TABLE [SORTED_TWO_WAY_LIST [METHOD_SOLVER], STRING]
			-- Table of methods

end -- class OVERLOAD_SOLVER
