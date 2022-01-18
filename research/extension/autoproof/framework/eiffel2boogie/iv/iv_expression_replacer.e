note
	description: "Replaces the nth occurence (or all occurences, if nth<=0) of a_old with a_new in a_post. It DOES NOT change a_post.expression. it stores the result in output."

class
	IV_EXPRESSION_REPLACER

inherit

	IV_EXPRESSION_VISITOR
create
	make_nth


feature {NONE} -- Initialization

	make_nth(a_post_expression: IV_EXPRESSION; a_old, a_new: IV_EXPRESSION; a_n_th: INTEGER)
			-- replace the n_th occurence of a_old in a_post with a_new
			-- if n_th is <=0, replace all occurences of a_old
			-- DOES NOT change a_post. it stores the result in output. output will always be a new object (twin).
		require
			post_not_void: a_post_expression /= Void
			a_old_not_void: a_old /= Void
			a_newt_not_void: a_new /= Void
		do
			if a_n_th <= 0 then
				replace_all := True
			else
				replace_all := False
				set_i_th (1)
				n_th := a_n_th
			end
			postcondition_expression := a_post_expression
			old_expression := a_old
			new_expression := a_new
			output := a_post_expression.twin
		end

feature {IV_EXPRESSION_REPLACER} --Implementation

		replace_all: BOOLEAN
		postcondition_expression: IV_EXPRESSION
		old_expression: IV_EXPRESSION
		new_expression: IV_EXPRESSION
		n_th: INTEGER
		i_th: INTEGER
			-- Everytime there is an occurrence of old_expression, i_th is incremented by 1. it starts at 1. This is only needed if only the n_th occurrence should be changed.

feature -- result is saved in output

	output: IV_EXPRESSION

feature --VISITOR

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- Process `a_operation'.
		local
			left_replacer: IV_EXPRESSION_REPLACER
			right_replacer: IV_EXPRESSION_REPLACER
			new_left: IV_EXPRESSION
			new_right: IV_EXPRESSION
			new_binary: IV_BINARY_OPERATION
		do
			if replace_all then
--				if old_expression.is_deep_equal(a_operation) then --this expression needs to be replaced, and we are finished.
				if are_equal(old_expression, a_operation) then --this expression needs to be replaced, and we are finished.
					output:= new_expression.twin
				else -- check if left or right has to be replaced.
					create left_replacer.make_nth (a_operation.left, old_expression, new_expression, 0)
					a_operation.left.process (left_replacer)
					new_left := left_replacer.output
					create right_replacer.make_nth (a_operation.right, old_expression, new_expression, 0)
					a_operation.right.process (right_replacer)
					new_right := right_replacer.output

					create new_binary.make (new_left, a_operation.operator, new_right, a_operation.type)
					output := new_binary.twin
				end
			else --code to replace n_th occurrence
--				if old_expression.is_deep_equal(a_operation) then
				if are_equal(old_expression, a_operation) then
					if i_th = n_th then --this occurrence needs to be replaced, and we are finished.
						output := new_expression.twin
						increment_i_th
					else --increment i_th and then process children
						create left_replacer.make_nth (a_operation.left, old_expression, new_expression, n_th)
						left_replacer.set_i_th (i_th+1)
						a_operation.left.process (left_replacer)
						set_i_th (left_replacer.i_th)
						new_left := left_replacer.output

						create right_replacer.make_nth (a_operation.right, old_expression, new_expression, n_th)
						right_replacer.set_i_th (i_th+1)
						a_operation.right.process (right_replacer)
						set_i_th (right_replacer.i_th)
						new_right := right_replacer.output

						create new_binary.make (new_left, a_operation.operator, new_right, a_operation.type)
						output := new_binary.twin
					end
				else --this expression doesn't match the one that has to be replaced, so i_th is NOT incremented.
					create left_replacer.make_nth (a_operation.left, old_expression, new_expression, n_th)
					left_replacer.set_i_th (i_th)
					a_operation.left.process (left_replacer)
					set_i_th (left_replacer.i_th)
					new_left := left_replacer.output

					create right_replacer.make_nth (a_operation.right, old_expression, new_expression, n_th)
					right_replacer.set_i_th (i_th)
					a_operation.right.process (right_replacer)
					set_i_th (right_replacer.i_th)
					new_right := right_replacer.output

					create new_binary.make (new_left, a_operation.operator, new_right, a_operation.type)
					output := new_binary.twin
				end
			end
		end

	process_conditional_expression (a_conditional: IV_CONDITIONAL_EXPRESSION)
			-- <Precursor>
		do
			check False end
		end

	process_entity (a_entity: IV_ENTITY)
			-- Process `a_entity'.
		do
			if replace_all then
--				if old_expression.is_deep_equal(a_entity) then
				if are_equal(old_expression, a_entity) then
					output := new_expression.twin
				else
					output := a_entity.twin
				end
			else--code for replace n_th
--				if i_th = n_th and old_expression.is_deep_equal(a_entity) then
				if i_th = n_th and are_equal(old_expression, a_entity) then
					output := new_expression.twin
					increment_i_th
--				elseif old_expression.is_deep_equal(a_entity) then --but i_th /= n_th
				elseif are_equal(old_expression, a_entity) then
					increment_i_th
					output := a_entity.twin
				else
					output := a_entity.twin
				end
			end

		end

	process_exists (a_exists: IV_EXISTS)
			-- Process `a_exists'.
		local
			rep: IV_EXPRESSION_REPLACER -- replace the expression of this exist if necessary
			new_exists: IV_EXISTS
		do --TODO. isn't needed in my case.
			if replace_all then
				if old_expression.is_deep_equal(a_exists) then
					output := new_expression.twin;
				else
					create rep.make_nth (a_exists.expression, old_expression, new_expression, 0)
					a_exists.expression.process (rep)
					-- TODO FIXME need to edit bound and free variables
					create new_exists.make (rep.output)
					-- TODO  FIXME add new bound variables to new_exists
					output := new_exists.twin
				end
			else --replace nth
			end
		end

	process_forall (a_forall: IV_FORALL)
			-- Process `a_forall'.
		local
			rep: IV_EXPRESSION_REPLACER
			lower_bound_processed: IV_EXPRESSION_REPLACER
			upper_bound_processed: IV_EXPRESSION_REPLACER
			new_bounds: IV_BINARY_OPERATION
			new_bin: IV_BINARY_OPERATION
			new_lower_bound: IV_BINARY_OPERATION
			new_upper_bound: IV_BINARY_OPERATION
			new_forall: IV_FORALL
		do
			if replace_all then
--				if old_expression.is_deep_equal(a_forall) then --I don't think this is ever needed in my case, a_forall should never have to be replaced. not sure though, doesn't hurt.
				if are_equal(old_expression, a_forall) then
					output := new_expression.twin
				else
					-- shouldn't mess with the bound variable within the bounds. so if (1 <= i and i <= n) => (a[i] bla bla), don't mess with the i in the bounds on the left side of implication.
					-- so when translated back to across, it's still fine.
					if attached {IV_BINARY_OPERATION} a_forall.expression as totbin then
						if attached {IV_BINARY_OPERATION} totbin.left as bounds then
								if attached {IV_BINARY_OPERATION} bounds.left as lower_bound then
									-- process left side of lower bound, but not right side
									create lower_bound_processed.make_nth (lower_bound.left, old_expression, new_expression, 0)
									lower_bound.left.process (lower_bound_processed)
									create new_lower_bound.make (lower_bound_processed.output, lower_bound.operator, lower_bound.right, lower_bound.type)

									if attached {IV_BINARY_OPERATION} bounds.right as upper_bound then
										-- process righ side of upper bound, but not left side
										create upper_bound_processed.make_nth (upper_bound.right, old_expression, new_expression, 0)
										upper_bound.right.process (upper_bound_processed)
										create new_upper_bound.make (upper_bound.left, upper_bound.operator, upper_bound_processed.output, upper_bound.type)

										create new_bounds.make (new_lower_bound, bounds.operator, new_upper_bound, bounds.type)

										-- process right side of bin expression
										create rep.make_nth (totbin.right, old_expression, new_expression, 0)
										totbin.right.process (rep)
										create new_bin.make (new_bounds, totbin.operator, rep.output, totbin.type)
										create new_forall.make (new_bin)
										across a_forall.bound_variables as bvs loop  --assumes bound variables weren't replaced.
					--						new_forall.add_bound_variable (a_forall.bound_variables.item.name, bvs.item.type)
											new_forall.bound_variables.force (bvs)
										end
										output := new_forall.twin
									end
								else -- old code backup
									create rep.make_nth (a_forall.expression, old_expression, new_expression, 0)
									a_forall.expression.process (rep)
									create new_forall.make (rep.output)

									across a_forall.bound_variables as bvs loop  --assumes bound variables weren't replaced.
				--						new_forall.add_bound_variable (a_forall.bound_variables.item.name, bvs.item.type)
										new_forall.bound_variables.force (bvs)
									end
									output := new_forall.twin;
								end
						elseif attached {IV_FUNCTION_CALL} totbin.left as bounds_expression then
								-- forall structure
								create rep.make_nth (a_forall.expression, old_expression, new_expression, 0)
								a_forall.expression.process (rep)
								create new_forall.make (rep.output)

								across a_forall.bound_variables as bvs loop  --assumes bound variables weren't replaced.
			--						new_forall.add_bound_variable (a_forall.bound_variables.item.name, bvs.item.type)
									new_forall.bound_variables.force (bvs)
								end
								output := new_forall.twin;
						end

					else --old code backup
						create rep.make_nth (a_forall.expression, old_expression, new_expression, 0)
						a_forall.expression.process (rep)
						create new_forall.make (rep.output)

						across a_forall.bound_variables as bvs loop  --assumes bound variables weren't replaced.
	--						new_forall.add_bound_variable (a_forall.bound_variables.item.name, bvs.item.type)
							new_forall.bound_variables.force (bvs)
						end
						output := new_forall.twin;
					end
				end
			else --replace nth.

--				if old_expression.is_deep_equal (a_forall) and i_th = n_th then
				if are_equal(old_expression, a_forall) and i_th = n_th then
					output := new_expression.twin
					increment_i_th
--				elseif old_expression.is_deep_equal (a_forall) then -- but i_th /= n_th
				elseif are_equal(old_expression, a_forall) then
					increment_i_th
					create rep.make_nth (a_forall.expression, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_forall.expression.process (rep)
					set_i_th (rep.i_th)
					create new_forall.make (rep.output)
					across a_forall.bound_variables as bvs loop
						new_forall.add_bound_variable (bvs.name, bvs.type)
						new_forall.bound_variables.last.set_property (bvs.property) --assumes bound variables are always added to the end of the list.
					end
					output := new_forall.twin
				else --a_forall is NOT equal to old_expression
					create rep.make_nth (a_forall.expression, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_forall.expression.process (rep)
					set_i_th (rep.i_th)
					create new_forall.make (rep.output)
					across a_forall.bound_variables as bvs loop
						new_forall.add_bound_variable (bvs.name, bvs.type)
						new_forall.bound_variables.last.set_property (bvs.property) --assumes bound variables are always added to the end of the list.
					end
					output := new_forall.twin
				end
			end

		end

	process_function_call (a_call: IV_FUNCTION_CALL)
			-- Process `a_call'

		local
			rep:IV_EXPRESSION_REPLACER
			new_fun_call: IV_FUNCTION_CALL
		do
			if replace_all then
--				if old_expression.is_deep_equal(a_call) then
				if are_equal(old_expression, a_call) then
					output := new_expression.twin
				else
					create new_fun_call.make (a_call.name, a_call.type)
					across a_call.arguments as args loop
						create rep.make_nth (args, old_expression, new_expression, 0)
						args.process (rep)
						new_fun_call.add_argument (rep.output)
					end

					output := new_fun_call.twin
				end

			else --replace nth
--				if old_expression.is_deep_equal(a_call) and i_th = n_th then
				if are_equal(old_expression, a_call) and i_th = n_th then
					increment_i_th
					output := new_expression.twin
--				elseif old_expression.is_deep_equal(a_call) then -- but i_th /= n_th
				elseif are_equal(old_expression, a_call) then
					increment_i_th
					--not sure if it is necessary to process children in this case? can children be equal if this is equal?
					create new_fun_call.make (a_call.name, a_call.type)
					across a_call.arguments as args loop
						create rep.make_nth (args, old_expression, new_expression, n_th)
						rep.set_i_th (i_th)
						args.process(rep)
						set_i_th (rep.i_th)
						new_fun_call.add_argument (rep.output)
					end
					output := new_fun_call.twin
				else --a_call is NOT equal to old_expression, check children
					create new_fun_call.make (a_call.name, a_call.type)
					across a_call.arguments as args loop
						create rep.make_nth (args, old_expression, new_expression, n_th)
						rep.set_i_th (i_th)
						args.process(rep)
						set_i_th (rep.i_th)
						new_fun_call.add_argument (rep.output)
					end
					output := new_fun_call.twin
				end
			end
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- Process `a_map_access'.
		local
			rep: IV_EXPRESSION_REPLACER
			new_map_access: IV_MAP_ACCESS
			new_target: IV_EXPRESSION
			i: INTEGER

		do
			if replace_all then
--				if a_map_access.is_the_same (old_expression) then
--				if old_expression.is_deep_equal(a_map_access) then --perhaps change to is_the_same
				if are_equal(old_expression, a_map_access) then
					output := new_expression.twin;
				else
					--replace target if needed.
					create rep.make_nth (a_map_access.target, old_expression, new_expression, 0)
					a_map_access.target.process (rep)
					new_target := rep.output

					create new_map_access.make (new_target, a_map_access.indexes.i_th (1))
					--replace expression of first index if needed
					create rep.make_nth (new_map_access.indexes.i_th (1), old_expression, new_expression, 0)
					new_map_access.indexes.i_th (1).process (rep)
					new_map_access.indexes.put_i_th (rep.output, 1)
					--replace expressions of rest of indexes
					from i:=2
					until
						i>a_map_access.indexes.count
					loop
						create rep.make_nth (a_map_access.indexes.i_th (i), old_expression, new_expression, 0)
						a_map_access.indexes.i_th (i).process (rep)
						new_map_access.indexes.force (rep.output)
						i:=i+1
					end
				end
			else--replace nth
--				if (old_expression.is_deep_equal(a_map_access)) and i_th = n_th then
				if are_equal(old_expression, a_map_access) and i_th = n_th then
					increment_i_th
					output := new_expression.twin
--				elseif old_expression.is_deep_equal(a_map_access) then -- but i_th /= n_th
				elseif are_equal(old_expression, a_map_access) then
					increment_i_th
					-- this is probably not needed, since children cant be equal if current node is equal?
					create rep.make_nth (a_map_access.target, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_map_access.target.process (rep)
					set_i_th (rep.i_th)
					new_target := rep.output

					create new_map_access.make (new_target, a_map_access.indexes.i_th (1))
					--replace expression of first index if nedded.
					create rep.make_nth (new_map_access.indexes.i_th (1), old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					new_map_access.indexes.i_th (1).process (rep)
					set_i_th (rep.i_th)
					new_map_access.indexes.put_i_th (rep.output, 1)
					--replace expressions of rest of indexes
					from i:=2
					until
						i> a_map_access.indexes.count
					loop
						create rep.make_nth (a_map_access.indexes.i_th (i), old_expression, new_expression, n_th)
						rep.set_i_th (i_th)
						a_map_access.indexes.i_th (i).process (rep)
						set_i_th (rep.i_th)
						new_map_access.indexes.force (rep.output)
						i:= i+1
					end
					output := new_map_access.twin
				else --a_map_access is NOT equal to old_expression, check children
					--this creates duplicates since IV_MAP_ACCESS has problems with checking equality.
					--if this is uncommented, some mutations are generated twice.
					--remove_duplicates in IV_MUTATOR can't remove these duplicates, because IV_MAP_ACCESS are not considered equal with is_deep_equal or any other method.
					create rep.make_nth (a_map_access.target, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_map_access.target.process (rep)
					set_i_th (rep.i_th)
					new_target := rep.output

					create new_map_access.make (new_target, a_map_access.indexes.i_th (1))
					--replace expression of first index if nedded.
					create rep.make_nth (new_map_access.indexes.i_th (1), old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					new_map_access.indexes.i_th (1).process (rep)
					set_i_th (rep.i_th)
					new_map_access.indexes.put_i_th (rep.output, 1)
					--replace expressions of rest of indexes
					from i:=2
					until
						i> a_map_access.indexes.count
					loop
						create rep.make_nth (a_map_access.indexes.i_th (i), old_expression, new_expression, n_th)
						rep.set_i_th (i_th)
						a_map_access.indexes.i_th (i).process (rep)
						set_i_th (rep.i_th)
						new_map_access.indexes.force (rep.output)
						i:= i+1
					end
					output := new_map_access.twin
				end



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
			rep: IV_EXPRESSION_REPLACER
			new_unary: IV_UNARY_OPERATION
		do
			if replace_all then
--				if old_expression.is_deep_equal(a_operation) then
				if are_equal(old_expression, a_operation) then
					output := new_expression.twin
				else
					create rep.make_nth (a_operation.expression, old_expression, new_expression, 0)
					a_operation.expression.process (rep)
					create new_unary.make (a_operation.operator, rep.output, a_operation.type)
					output := new_unary.twin
				end
			else
				--code for replace nth
--				if old_expression.is_deep_equal(a_operation) and i_th = n_th then
				if are_equal(old_expression, a_operation) and i_th = n_th then
					output:= new_expression.twin
					increment_i_th
--				elseif old_expression.is_deep_equal(a_operation) then -- but i_th /= n_th
				elseif are_equal(old_expression, a_operation) then
					increment_i_th
					--should children be processed in this case? can children at all equal old_expression if this equals old expression?
					create rep.make_nth (a_operation.expression, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_operation.expression.process (rep)
					set_i_th (rep.i_th)
					create new_unary.make (a_operation.operator, rep.output, a_operation.type)
					output := new_unary.twin
				else -- a_operation is NOT equal to old_expression
					create rep.make_nth (a_operation.expression, old_expression, new_expression, n_th)
					rep.set_i_th (i_th)
					a_operation.expression.process (rep)
					set_i_th (rep.i_th)
					create new_unary.make (a_operation.operator, rep.output, a_operation.type)
					output := new_unary.twin
				end
			end
		end

	process_value (a_value: IV_VALUE)
			-- Process `a_value'.
		do --
			if replace_all then
--				if old_expression.is_deep_equal(a_value) then
				if are_equal(old_expression, a_value) then
					output := new_expression.twin
				else
					output := a_value.twin
				end
			else
				--code for replace nth
--				if old_expression.is_deep_equal(a_value) and i_th = n_th then
				if are_equal(old_expression, a_value) and i_th = n_th then
					output := new_expression.twin
					increment_i_th
--				elseif old_expression.is_deep_equal(a_value) then -- but i_th /= n_th
				elseif are_equal(old_expression, a_value) then
					output := a_value.twin
					increment_i_th
				else
					output := a_value.twin
				end
			end
		end

feature --setter

	set_i_th(a_i: INTEGER)
		-- set i_th to a_i
		do
			i_th:= a_i
		end

	increment_i_th
		--increment i_th by 1
		do
			i_th:= i_th+1
		end

feature -- check for equality

	are_equal(e1, e2: IV_EXPRESSION): BOOLEAN
		require
			e1 /= Void
			e2 /= Void

		local
			the_comparer: IV_COMPARER
		do
			create the_comparer.make_with_comparee (e2)
			e1.process (the_comparer)
			Result := the_comparer.output
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
