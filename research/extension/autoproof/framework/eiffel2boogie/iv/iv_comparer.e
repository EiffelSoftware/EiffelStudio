note
	description: "[
		Compares the expression that is being processed with the expression 'compare_to_expression'. Types are generally ignored.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_COMPARER

inherit

	IV_EXPRESSION_VISITOR

create
	make_with_comparee

feature {NONE}

	make_with_comparee(an_expression: IV_EXPRESSION)
		-- the expression that gets processed will be compared to this.
		require
			an_expression /= Void
		do
			compare_to_expression := an_expression
			output := False
		end

feature --Access

	reset(an_expression: IV_EXPRESSION)
		--the expression that gets processed will be compared to this.
		require
			an_expression /= Void
		do
			compare_to_expression := an_expression
			output := False
		end

	output: BOOLEAN
			--true if processed expression equals compare_to_expression

	compare_to_expression: IV_EXPRESSION

feature -- Visitor

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- Process `a_operation'.
		local
			tmp_bin: IV_BINARY_OPERATION
			left_comparer: IV_COMPARER
			right_comparer: IV_COMPARER
		do
			if attached {IV_BINARY_OPERATION} compare_to_expression as compare_to_bin then
			--return true if operator, left and right are equal. type is ignored for now.
				if a_operation.operator.is_equal(compare_to_bin.operator) then
					--TODO compare type of binary operator? ignore it for now.

					create left_comparer.make_with_comparee(compare_to_bin.left)
					a_operation.left.process(left_comparer)

					create right_comparer.make_with_comparee(compare_to_bin.right)
					a_operation.right.process(right_comparer)

					output := right_comparer.output and left_comparer.output
				else
					output := False
				end
			else
				output := False
			end
		end

	process_conditional_expression (a_conditional: IV_CONDITIONAL_EXPRESSION)
			-- <Precursor>
		do
			check False end
		end

	process_entity (a_entity: IV_ENTITY)
			-- Process `a_entity'.
		local

		do
			if attached {IV_ENTITY} compare_to_expression as compare_to_entity then
				--TODO type is ignored.
				output := compare_to_entity.name.is_equal(a_entity.name)
			else
				output:= False
			end
		end

	process_exists (a_exists: IV_EXISTS)
			-- Process `a_exists'.
		do
			--TODO not needed in my case.
		end

	process_forall (a_forall: IV_FORALL)
			-- Process `a_forall'.
		local
			expr_comparer: IV_COMPARER --compare the expressions of the forall clauses.
		do
			if attached {IV_FORALL} compare_to_expression as compare_to_forall then
				--first check if bound variables are the same. we only check first bound variable.
				--TODO this might need to be adjusted for different use cases. In my cases where only across statements form Eiffel are translated to forall there can only be 1 bound variable
				------------------testing
				if a_forall.bound_variables.count > 1 or compare_to_forall.bound_variables.count > 1 then
					print("%NERROR in IV_COMPARER, more than one bound variable.")
				end
				---------------------

				--we are satisfied if the name is the same. TODO might need to be adjusted.
				if a_forall.bound_variables.i_th(1).name.is_equal(compare_to_forall.bound_variables.i_th(1).name) then
					--here we know the bound variable is the same.
					-- now check expression
					create expr_comparer.make_with_comparee(compare_to_forall.expression)
					a_forall.expression.process (expr_comparer)
					--TODO triggers are ignored.
					output := expr_comparer.output
				else
					output := False
				end
			else
				output:= False
			end
		end

	process_function_call (a_call: IV_FUNCTION_CALL)
			-- Process `a_call'.
		local
			argument_comparer: IV_COMPARER
			i: INTEGER
			arguments_equal: BOOLEAN
		do

			if attached {IV_FUNCTION_CALL} compare_to_expression as compare_to_fun_call then
			--type is ignored TODO
				--check that name is equal
				if a_call.name.is_equal(compare_to_fun_call.name) then
					--compare arguments. have to be in the same order.
					arguments_equal := True

					if a_call.arguments.count = compare_to_fun_call.arguments.count then
						from i:= 1
						until (i > a_call.arguments.count) or (not arguments_equal)
						loop
							create argument_comparer.make_with_comparee(compare_to_fun_call.arguments.i_th(i))
							a_call.arguments.i_th(i).process(argument_comparer)
							arguments_equal := argument_comparer.output
							i:= i+1
						end
						output := arguments_equal
					else
						output := False
					end
				else
					output := False
				end
			else
				output := False
			end
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- Process `a_map_access'.
		local
			i: INTEGER
			indexes_same: BOOLEAN
			index_comparer: IV_COMPARER
			target_comparer: IV_COMPARER
		do
		--this is the main reason for this class, since comparing objects of type IV_MAP_ACCESS doesn't work with is_equal, is_deep_equal, =.
		--Might be more elegant to redefine is_equal in class IV_EXPRESSION to use this class to check for equality, and have children of IV_EXPRESSION inherit it.
			if attached {IV_MAP_ACCESS} compare_to_expression as compare_to_map_access then
				--TODO type is ignored, names are checked.
				-- indexes have to be in the same order.
				if compare_to_map_access.indexes.count = a_map_access.indexes.count then

					indexes_same := True
					from --check if indexes are the same. assumes indexes must be in the same order. If indexes are entities, it just checks the name.
						i:= 1
					until
						i > a_map_access.indexes.count or (not indexes_same)
					loop
						create index_comparer.make_with_comparee(compare_to_map_access.indexes.i_th(i))
						a_map_access.indexes.i_th(i).process(index_comparer)
						indexes_same := index_comparer.output
						i:= i+1
					end

					if indexes_same then
						--check targets.
						create target_comparer.make_with_comparee(compare_to_map_access.target)
						a_map_access.target.process(target_comparer)
						--here we know both are IV_MAP_ACCESS with same indexes and same target, so we consider them to be the same.
						output := target_comparer.output
					else
						output := False
					end
				else
					output := False
				end
			else
				output := False
			end
		end

	process_map_update (a_map_update: IV_MAP_UPDATE)
			-- Process `a_map_update'.
		do
			check not_implemented: False end
		end

	process_unary_operation (a_operation: IV_UNARY_OPERATION)
			-- Process `a_operation'.
		local
			expr_comparer: IV_COMPARER
		do
			if attached {IV_UNARY_OPERATION} compare_to_expression as compare_to_unary then
				--type is ignored
				if a_operation.operator.is_equal(compare_to_unary.operator) then
					--operators are the same, compare the expressions
					create expr_comparer.make_with_comparee(compare_to_unary.expression)
					a_operation.expression.process(expr_comparer)
					output := expr_comparer.output
				else
					output := False
				end
			else
				output := False
			end
		end

	process_value (a_value: IV_VALUE)
			-- Process `a_value'.
		local
		do
			--TODO type is ignored.
			if attached {IV_VALUE} compare_to_expression as compare_to_value then
				output := a_value.value.is_equal(compare_to_value.value)
			else
				output := False
			end
		end

end
