note
	description: "[
		This class is used as follows: 
		it is called on an IV_IMPLEMENTATION which contains at least one loop and tries to generate invariants for the loop by mutating the postcondition expression. 
		The results are stored in output.
	]"

class
	E2B_LOOP_INV_INFERENCE_BY_MUTATION

inherit

	IV_EXPRESSION_VISITOR

	IV_STATEMENT_VISITOR

	IV_UNIVERSE_VISITOR

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_universe: IV_UNIVERSE)
			-- Initialize the mutator
		do
			universe := a_universe
			reset
		end

feature -- Access

	output: LINKED_LIST[IV_EXPRESSION]
			-- list of invariant candidates. These are all verified to be invariants of SOME loop of the body of IV_IMPLEMENTATION

feature -- Semi Access

	body: IV_BLOCK
		--body of the implementation

	contracts: LINKED_LIST [IV_CONTRACT]
		--all the contracts of this implementation.

	postconditions: LINKED_LIST [IV_POSTCONDITION]
		--list of copy of all the postconditions of this implementation.

	outer_loops: LINKED_LIST [ARRAY[IV_BLOCK]]
		--list of outer loops in the procedure. Each loop is saved as an array of 3 items, loop_head_X, loop_body_(X+1), loop_end_(X+2)

	all_loops: LINKED_LIST [ARRAY[IV_BLOCK]]
		--list of all loops (inner and outer) in the procedure. Each loop is saved as an array of 3 items, loop_head_X, loop_body_(X+1), loop_end_(X+2)

	universe: IV_UNIVERSE
		--the complete universe that the AST for this implementation was taken from.

feature {NONE} -- {IV_MUTATOR}

	reset
			-- Reset universe visitor.
		do
			output := Void
			create output.make
		end

feature -- Basic operations

	invariants: LINKED_LIST [IV_EXPRESSION]
		-- This is adapted from the paper "Inferring Loop Invariants using Postconditions". It is called invariants there.
		-- It returns a list of expressions that are invariant of SOME loop in the procedure.
		local
			mutations: LINKED_LIST [IV_EXPRESSION]
			--expressions in this list are mutated, but not yet tested if they are valid invariants.
			res: LINKED_LIST[IV_EXPRESSION]
			-- TODO: replace res by Result sometime. I used this because for some strange reason EiffelStudio doesn't give me autocompletion suggestions for Result here.
			formula: IV_EXPRESSION
			any_loop: ARRAY [IV_BLOCK]
			tester: IV_EXPRESSION_2_EIFFEL_POSTCONDITION --TODO remove, used for testing purposes
		do
			create tester.make
			create res.make
			across postconditions as post loop
				across outer_loops as loops loop
					-- compute all mutations of post
					-- according to chosen strategies
					mutations := mutate(post, loops)

					if is_debugging_enabled then --print out all mutations to console.
						print("%Nmutations: ")
						print(mutations.count)
						print("%N")
						across mutations as ms loop
							tester.reset
							ms.process (tester)
							print(tester.output)
							print("%N")
						end
					end

					across mutations as ms loop
						formula:= ms
						across all_loops as al loop
							any_loop := al
							if is_invariant(formula, any_loop) then
								res.force (formula)
							end
						end
					end
				end
			end
			Result := res
		end

	replace_all (a_post: IV_POSTCONDITION; a_old, a_new: IV_EXPRESSION): IV_EXPRESSION
		-- replace every ocurrence of a_old in a_post with a_new
		-- uses class IV_EXPRESSION_REPLACER
		local
			replacer: IV_EXPRESSION_REPLACER
		do
			create replacer.make_nth (a_post.expression, a_old, a_new, 0)
			a_post.expression.process (replacer)
			Result := replacer.output
		end

	replace_nth (a_post: IV_POSTCONDITION; a_old, a_new: IV_EXPRESSION; n_th: INTEGER; a_loop: ARRAY [IV_BLOCK]): IV_EXPRESSION
		-- replace n_th ocurrence of a_old in a_post with a_new.
		-- uses class IV_EXPRESSION_REPLACER
		local
			replacer: IV_EXPRESSION_REPLACER
		do
			create replacer.make_nth (a_post.expression, a_old, a_new, n_th)
			a_post.expression.process (replacer)
			Result := replacer.output
		end

	coupled_mutations(a_post: IV_POSTCONDITION; a_constant, a_variable: IV_EXPRESSION; a_loop: ARRAY [IV_BLOCK]): LINKED_LIST[IV_EXPRESSION]
		-- adapted from paper
		-- a_loop is passed because it is needed when aging is called.
		local
			aged_variable: IV_EXPRESSION
			all_aged_variables: LINKED_LIST[IV_EXPRESSION]
		do
			create Result.make--line 5
			Result.force(replace_all (a_post, a_constant, a_variable))
			all_aged_variables := aging (a_variable, a_loop)--line6
			across all_aged_variables as av loop--line6
					Result.force (replace_all (a_post, a_constant, av))--lines7,8
			end
		end

	uncoupled_mutations (a_post: IV_POSTCONDITION; a_constant, a_variable: IV_EXPRESSION; a_loop: ARRAY [IV_BLOCK]): LINKED_LIST[IV_EXPRESSION]
		-- adapted from paper
		-- a_loop is passed because it is needed when aging is called.
		local
			index: INTEGER
			expression_replaced: IV_EXPRESSION
				-- the expression of a_post, with the i'th occurrence of a_constant replaced by a_variable (i'th = index)
			aged_variables: LINKED_LIST[IV_EXPRESSION]
		do
			create Result.make
			index := 1
			from -- loop until nothing is replaced, so until replace_nth gives the same result
				expression_replaced := replace_nth (a_post, a_constant, a_variable, index, a_loop)
			until
				are_equal (expression_replaced, a_post.expression)
			loop
				expression_replaced := replace_nth (a_post, a_constant, a_variable, index, a_loop)
				Result.force (expression_replaced)
				aged_variables := aging (a_variable, a_loop)
				across aged_variables as av loop
					Result.force (replace_nth (a_post, a_constant, av, index, a_loop))
				end
				index := index + 1
			end
		end

	aging(a_variable: IV_EXPRESSION; a_loop: ARRAY[IV_BLOCK]): LINKED_LIST[IV_EXPRESSION]
		-- taken from paper ..
		--
		-- for now, it should just decreament a_variable by 1 if a_variable is of type integer
		local
			bin: IV_BINARY_OPERATION
			val: IV_VALUE
			t: IV_BASIC_TYPE
		do
			create Result.make
			if options.is_aging_enabled then
				if a_variable.type.is_integer then
					create t.make_integer
					create val.make ("1", t)
					create bin.make (a_variable.twin, "-", val, t)
					Result.force (bin)
--					create bin.make (a_variable.twin, "+", val, t) -- is hardly ever useful but generates a lot more mutations.
--					Result.force (bin)
				end
			end
		end

	is_invariant(a_formula: IV_EXPRESSION; a_loop: ARRAY[IV_BLOCK]): BOOLEAN
		--returns True iff a_formula is an invariant of a_loop.
		--this assumes that there is no incorrect invariant in the loop from before.
		local
			ver: E2B_VERIFIER
			gen: E2B_BOOGIE_GENERATOR
			ver_input: E2B_VERIFIER_INPUT
			new_universe: IV_UNIVERSE
			res: E2B_RESULT
			attacher: IV_ATTACH_INVARIANT
				--visitor to attach invariant to a_loop in the universe.
			printer: IV_EXPRESSION_2_EIFFEL_POSTCONDITION --TODO remove, tester to print the found variable
		do
			Result := False

			--this is slow
			new_universe := universe.deep_twin
			create attacher.make (a_loop.item (1), a_formula)
			new_universe.process (attacher)
			create gen.make (new_universe)
			gen.generate_verifier_input
			ver_input := gen.last_generated_verifier_input
			ver := Void
			create ver.make
			ver.set_input (ver_input)
			ver.verify
			ver.parse_verification_output
			res := ver.last_result

			if is_debugging_enabled then
				print("%Nverified procedures: ")
				print(res.verified_count)
	--			across res.verified_procedures as ver_results loop
	--				print("%N")
	--				print(ver_results.item.procedure_name)
	--				print(" in ")
	--				print(ver_results.item.time)
	--				print("s")
	--			end
				print("%Nfaulty procedures: ")
				print(res.verification_errors.count)
	--			across res.verification_errors as ver_errors loop
	--				print("%N")
	--				print(ver_errors.item.procedure_name)
	--				print(" in ")
	--				print(ver_errors.item.time)
	--				print("s")
	----				print(", Eiffel feature: ")
	----				print(ver_errors.item.eiffel_feature.external_name)
	--				print(", procedure name: ")
	--				print(ver_errors.item.procedure_name)
	--			end
			end

			if res.failed_count = 0 and res.verified_count > 0 then --trivially it must be an invariant, since no errors were detected anywhere. if both are 0 then something failed, such as invalid boogie code generated.
				Result := True
				if is_debugging_enabled then
					print("%NInvariant found! (none failed)")
					create printer.make
					a_formula.process (printer)
					print("%N")
					print(printer.output)
				end

			else
				--find out in which procedure a_loop is, then check if that procedure is in the verified list. if so, set Result to True.
				across res.verified_procedures as verified_procs loop
					if attacher.attached_to_procedure = Void then --this should never be the case.
						if is_debugging_enabled then
							print("%N!!WARNING!! invariant wasn't attached to any loop.")
						end
					end
					if (not (attacher.attached_to_procedure = Void)) and then (attacher.attached_to_procedure.name.is_equal (verified_procs.procedure_name)) then
						Result := True
						if is_debugging_enabled then
							print("%NInvariant found!")
							create printer.make
							a_formula.process (printer)
							print("%N")
							print(printer.output)

						end
					end
				end
			end

			-------------------new check
			if (not Result) and not (res.failed_count = 0 and res.verified_count = 0) then -- until now it was only added if the whole feature didn't have any errors. So if a postcondition couldn't be proven, it wasn't added. Add check here to see if no invariant was found to be false.
				Result := true --set to true, then see if it needs to be set to false.
				across res.verification_errors as ver_errors loop
					across ver_errors.errors as errs loop
--						if errs.item.code ~ "BP5001" or errs.item.code ~ "BP5004" or errs.item.code ~ "BP5005" or errs.item.code ~ "BP5001loop_inv" then
						if errs.code ~ "BP5004" or errs.code ~ "BP5005" or errs.code ~ "BP5001loop_inv" then
							--codes are taken from E2B_OUTPUT_PARSER.create_error
							if is_debugging_enabled then
								print("%NBoogie message: ")
								print(errs.boogie_message)
								print(", code: ")
								print(errs.code)
								if errs.has_tag then
									print(", tag: ")
									print(errs.tag)
								end
							end
							Result := false
						elseif errs.boogie_message.has_substring ("invariant") then
							if is_debugging_enabled then
								print("%NBoogie message: ")
								print(errs.boogie_message)
							end
							Result := false
						end
					end
				end

				if Result then
					if is_debugging_enabled then
						print("%NInvariant found!(new)")
						create printer.make
						a_formula.process (printer)
						print("%N")
						print(printer.output)
						print("%NErrors: %N")
						across res.verification_errors as ver_errors loop
							across ver_errors.errors as errs loop
								print(errs.boogie_message)
								print(", code: ")
								print(errs.code)
								if errs.has_tag then
									print(", tag: ")
									print(errs.tag)
								end
								print("%N")
							end
						end
						print("attached to procedure: ")
						print(attacher.attached_to_procedure.name)
					end
				end
			end

			if is_debugging_enabled then
				print("%N---------------------------------")
			end

		end

	mutate (a_post:IV_POSTCONDITION; a_loop: ARRAY [IV_BLOCK]): LINKED_LIST [IV_EXPRESSION]
		-- Taken from paper..
		local
			all_subexpressions: LINKED_LIST[IV_EXPRESSION]
			bool_type: IV_BASIC_TYPE
			all_types: IV_TYPES
			targets_l: LINKED_LIST[IV_EXPRESSION]
				--list of all the targets in the loop
			constants_l: LINKED_LIST[IV_EXPRESSION]
				--list of all_subexpressions minus list of targets
			constant: IV_EXPRESSION
				--same as in paper
			variable: IV_EXPRESSION
				--same as in paper
			tester: IV_EXPRESSION_2_EIFFEL_POSTCONDITION
			is_target: BOOLEAN

		do
			create Result.make
			Result.force (a_post.expression)
			create all_subexpressions.make

			create all_types
			--line 5,6,7
			all_subexpressions.append (subexp (a_post.expression, all_types.bool))
			--TODO also field types?
			all_subexpressions.append (subexp (a_post.expression, all_types.int))
			all_subexpressions.append (subexp (a_post.expression, all_types.real))
			all_subexpressions.append (subexp (a_post.expression, all_types.heap_type))

--			all_subexpressions.append (subexp (a_post.expression, all_types.generic_type))
--			all_subexpressions.append (subexp (a_post.expression, all_types.type))

			targets_l := targets (a_loop.item (2))--targets of the body of a_loop

			------------------------------------
			--add bound variables of "across" statments to targets. Creates a more mutations, but some are syntactically wrong and the verifier notices it correctly.
--			if attached {IV_FORALL} a_post.expression as forall then
--				targets_l.force (forall.bound_variables.i_th (1).entity)
--				print("%NFORALL added to targets: ")
--				print(forall.bound_variables.i_th (1).entity.name)
--			end
			-----------------------------------

			--create constants
			create constants_l.make
			across all_subexpressions as subs loop

				is_target := False
				across targets_l as ts loop
					if are_equal (ts, subs) then

						is_target := True
					------------------------------
--					if ts.item.is_deep_equal (subs.item) then
--						is_target := True
--					elseif attached {IV_MAP_ACCESS} ts.item as tma and then (attached {IV_MAP_ACCESS} subs.item as ignoreme) then
--						if attached {IV_MAP_ACCESS} subs.item as subma then
--							if subma.is_the_same(tma) then
--								is_target := True
--								print("%Nmap access equal")
--							else
--								create tester.make
--								print("%NNot equal: target: ")
--								ts.item.process (tester)
--								print(tester.output)
--								print(", and subexpression: ")
--								tester.reset
--								subs.item.process (tester)
--								print(tester.output)
--							end
--						end
--					elseif attached {IV_ENTITY_DECLARATION} subs.item as ent_decl then
--						print("%NEntity Declaration found: ")
--						print(ent_decl.entity.name)
--						if attached {IV_ENTITY} ts.item as tma then
--							if ent_decl.entity.name.is_equal (tma.name) then
--								is_target := true
--							end
--						end
					else
						--nothing
					end
				end
				if not is_target then
					constants_l.force (subs)
				end
			end


			if is_debugging_enabled then
				print("%N---------------------------------")
				print("%NAll subexpressions(without duplicates): ")
				across remove_duplicates (all_subexpressions) as  subs loop
					create tester.make
					subs.process (tester)
					print("%N")
					print(tester.output)
					if tester.output.has_substring ("Heap") then
						print(", generator: ")
						print(subs.generator)
					end
				end

				print("%NAll targets(without duplicates): ")
				across  remove_duplicates (targets_l) as  ts loop
					create tester.make
					ts.process (tester)
					print("%N")
					print(tester.output)
				end

				print("%NAll constants(without duplicates): ")
				across remove_duplicates (constants_l) as  cs loop
					create tester.make
					cs.process (tester)
					print("%N")
					print(tester.output)
				end
				if all_subexpressions.is_equal (constants_l) then
					print("%Nsubexpressions and constants are equal!")
				end
				print("%N==================================")
			end


			--line 8
--			across  constants_l as cs loop -- FIXME
			across remove_duplicates (constants_l)  as cs loop
				constant := cs
--				across targets_l as ts loop --line 9
				across  remove_duplicates (targets_l) as ts loop
					variable := ts

					--lines 10,11,12
					if options.is_coupled_mutations_enabled then
--						Result.append (coupled_mutations (a_post, constant, variable, a_loop))
						Result.append (remove_duplicates(coupled_mutations (a_post, constant, variable, a_loop)))
					end
					if options.is_uncoupled_mutations_enabled then
--						Result.append (uncoupled_mutations (a_post, constant, variable, a_loop))
						Result.append (remove_duplicates(uncoupled_mutations (a_post, constant, variable, a_loop)))
					end

				end
			end

			Result := remove_duplicates (Result)
		end

	subExp(an_expression: IV_EXPRESSION; a_type:IV_TYPE): LINKED_LIST[IV_EXPRESSION]
		-- returns "basic building blocks"
		-- this is UNTESTED.
		local
			tester: IV_EXPRESSION_2_EIFFEL_POSTCONDITION
			i:INTEGER
		do
			create Result.make
			if attached {IV_BINARY_OPERATION} an_expression as bin_op then
				Result.append (subexp (bin_op.left, a_type))
				Result.append (subexp (bin_op.right, a_type))
			end

			if attached {IV_ENTITY} an_expression as en_op then
				if not en_op.name.is_case_insensitive_equal_general ("Heap") then
					Result.force(en_op)
				end

			end

			if attached {IV_FUNCTION_CALL} an_expression as fun_call then
				Result.force (fun_call)
				from i:=3
				until i> fun_call.arguments.count
				loop
					Result.append(subexp (fun_call.arguments.i_th (i), a_type))
					i:=i+1
				end
			end

			if attached {IV_MAP_ACCESS} an_expression as map_acc then

				Result.force (map_acc)
			end

			if attached {IV_EXISTS} an_expression as ex then --
				Result.append (subexp (ex.expression, a_type))
			end

			if attached {IV_FORALL} an_expression as fa then
--				Result.append (fa.)
				Result.append (subexp (fa.expression, a_type))
			end

			if attached {IV_UNARY_OPERATION} an_expression as uo then --or add the unary operation itself?
				Result.append (subexp (uo.expression, a_type))
			end

			if attached {IV_VALUE} an_expression as val then
				--stop recursion.
				Result.force (val)
			end


		end


feature -- Universe visitor

	current_implementation: IV_IMPLEMENTATION
		--the implementation that is currently being processed.


	process_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Process implementation `a_implementation'.
			-- this sould be the first one called.
		local
			invariants_l: LINKED_LIST[IV_EXPRESSION]
			irrelevant: IV_EXPRESSION_2_EIFFEL_POSTCONDITION --TODO remove this later, just for testing purposes.
		do
			current_implementation := a_implementation
			body := a_implementation.body
			contracts := a_implementation.procedure.contracts
			postconditions := get_postconditions
			outer_loops := get_outer_loops(body)
			all_loops := get_all_loops (a_implementation.body)
			invariants_l := invariants
			output := invariants_l
		end

	process_function (a_function: IV_FUNCTION)
			-- Process function `a_function'.
		do
			--TODO
		end

	process_variable (a_variable: IV_VARIABLE)
			-- Process variable `a_variable'.
		do
			--TODO
		end

	process_constant (a_variable: IV_CONSTANT)
			-- Process variable `a_constant'.
		do
			--TODO
		end

	process_axiom (a_axiom: IV_AXIOM)
			-- Process axiom `a_axiom'.
		do
			--TODO
		end

	process_procedure (a_procedure: IV_PROCEDURE)
			-- Process procedure `a_procedure'.
		do
			--TODO
		end

feature -- Statement visitor

	process_assert (a_assert: IV_ASSERT)
			-- Process `a_assert'.
		do
			--TODO
		end

	process_assume (a_assume: IV_ASSERT)
			-- Process `a_assume'.
		do
			--TODO
		end

	process_assignment (a_assignment: IV_ASSIGNMENT)
			-- Process `a_assignment'.
		do
			--TODO
		end

	process_block (a_block: IV_BLOCK)
			-- Process `a_block'.
		do
			--TODO
		end

	process_conditional (a_conditional: IV_CONDITIONAL)
			-- Process `a_conditional'.
		do
			--TODO
		end

	process_havoc (a_havoc: IV_HAVOC)
			-- Process `a_havoc'.
		do
			--TODO
		end

	process_label (a_label: IV_LABEL)
			-- Process `a_label'.
		do
			--TODO
		end

	process_loop (a_loop: IV_LOOP)
			-- Process `a_loop'.
		do
			--TODO
		end

	process_goto (a_goto: IV_GOTO)
			-- Process `a_goto'.
		do
			--TODO
		end

	process_procedure_call (a_call: IV_PROCEDURE_CALL)
			-- Process `a_call'.
		do
			--TODO
		end

	process_return (a_return: IV_RETURN)
			-- Process `a_return'.
		do
			--TODO
		end

feature --Expression visitor

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- Process `a_operation'.
		do
			--TODO
		end

	process_conditional_expression (a_conditional: IV_CONDITIONAL_EXPRESSION)
			-- <Precursor>
		do
			--TODO
		end

	process_entity (a_entity: IV_ENTITY)
			-- Process `a_entity'.
		do
			--TODO
		end

	process_exists (a_exists: IV_EXISTS)
			-- Process `a_exists'.
		do
			--TODO
		end

	process_forall (a_forall: IV_FORALL)
			-- Process `a_forall'.
		do
			--TODO
		end
	process_function_call (a_call: IV_FUNCTION_CALL)
			-- Process `a_call'.
		do
			--TODO
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- Process `a_map_access'.
		do
			--TODO
		end

	process_map_update (a_map_update: IV_MAP_UPDATE)
			-- Process `a_map_update'.
		do
			check not_implemented: False end
		end

	process_unary_operation (a_operation: IV_UNARY_OPERATION)
			-- Process `a_operation'.
		do
			--TODO
		end

	process_value (a_value: IV_VALUE)
			-- Process `a_value'.
		do
			--TODO
		end

feature --assisting operations

	get_postconditions: LINKED_LIST [IV_POSTCONDITION]
		--this only works if contracts list has already been filled in.
		require
			contracts /= Void
		do
			create Result.make
			across contracts as cs loop
				if attached {IV_POSTCONDITION} cs as a_postcondition then
					if a_postcondition.information.type.has_substring ("post") then
						Result.force (a_postcondition)
					end
--					print("%Npostcondition added: ")
--					print(a_postcondition.information.type)
				end
			end
		end

	get_outer_loops(the_block:IV_BLOCK): LINKED_LIST[ARRAY[IV_BLOCK]]
		-- fill the list outer_loops with the outer loops of a_implementation.
		-- IMPORTANT: this only works, if a loop is stored as loop_head_X, loop_body_(X+1), loop_end_(X+2) after each other in the statements. Otherwise the implementation needs to be adjusted.
		require
			body_set: the_block /= Void
		local
			temp_array: ARRAY[IV_BLOCK]
			i: INTEGER
		do
			create Result.make
			across the_block.statements as st loop
				if attached {IV_BLOCK} st as possible_loop_block then
					if possible_loop_block.name.has_substring ("loop_head") then
						create temp_array.make_filled (possible_loop_block, 1, 3)
						if attached {IV_BLOCK} the_block.statements [@ st.cursor_index + 1] as b then
							temp_array [2] := b
						end
						if attached {IV_BLOCK} the_block.statements [@ st.cursor_index + 2] as b then
							temp_array [3] := b
						end
						Result.force (temp_array)
					end
				elseif attached {IV_CONDITIONAL} st as cond then
					Result.append (get_outer_loops (cond.then_block))
					Result.append (get_outer_loops (cond.else_block))
				end
			end
		end

	get_all_loops(the_block: IV_BLOCK): LINKED_LIST[ARRAY[IV_BLOCK]]
		-- fill the list all_loops with all loops of a_implementation.
		-- IMPORTANT: this only works, if a loop is stored as loop_head_X, loop_body_(X+1), loop_end_(X+2) after eachother in the statements of a block. Otherwise this implementation needs to be adjusted.
		-- works recursively. First call should give the body of this implementation as the argument.

		require
			body_set: body /= Void
		local
			temp_array: ARRAY[IV_BLOCK]
			i,j: INTEGER
			loop_head_index: INTEGER -- is 7 for loop_head_7
			loop_body_index: INTEGER
			body_name: STRING
		do
			create Result.make

			if the_block = void then
				print("%Nthe_block is void")

			end

			across the_block.statements as st loop
				if attached {IV_BLOCK} st as possible_loop_block then
					if possible_loop_block.name.has_substring ("loop_head") then

						loop_head_index := possible_loop_block.name.substring (possible_loop_block.name.count, possible_loop_block.name.count).to_integer
						temp_array := Void
						create temp_array.make_filled (possible_loop_block, 1, 3)
						if attached {IV_BLOCK} the_block.statements [@ st.cursor_index + 1] as b then
								-- This is the body block, call function recursively on it.
								-- Get the loops of the body block.
							Result.append (get_all_loops (b))
							temp_array [2] := b
						elseif is_debugging_enabled then
							print("%Nproblem, a_block is void. statements array size: ")
							print(body.statements.count)
							print(", cursor_index+1: ")
							print(@ st.cursor_index+1)
							print(", last loop_head index: ")
							print(loop_head_index)
						end
						if attached {IV_BLOCK} the_block.statements [@ st.cursor_index + 2] as b then
							temp_array [3] := b
						end
						Result.force (temp_array)
					end
				elseif attached {IV_CONDITIONAL} st as cnd then
					Result.append (get_all_loops (cnd.then_block))
					Result.append (get_all_loops (cnd.else_block))
				end
			end
		end

	targets(a_block: IV_BLOCK):LINKED_LIST[IV_EXPRESSION]
		-- returns all the (possible) targets (lhs of an assignment) of the block a_block
		local
			a_body: IV_BLOCK --body of the loop
		do
			create Result.make
--			a_body := a_loop.item (2)
			a_body := a_block
			across a_body.statements as st loop
				if attached {IV_ASSIGNMENT} st as ass then
					Result.force(ass.target)

				end
				if attached {IV_FORALL} st as forall then
					Result.force (forall.bound_variables.i_th (1).entity)
				end
				if attached {IV_CONDITIONAL} st as cond then
					Result.append(targets (cond.then_block))
					Result.append(targets (cond.else_block))
				end

				if attached {IV_BLOCK} st as bl then
					Result.append(targets (bl))
				end
			end
		end

	remove_duplicates(a_list: LINKED_LIST[IV_EXPRESSION]): LINKED_LIST[IV_EXPRESSION]
		--takes a list of expression, returns a list that contains all expressions in a_list, but without duplicates. doesn't use twin.
		require
			not_void: a_list /= Void
		local
			contains: BOOLEAN -- true, if curr is already in the list
			curr: IV_EXPRESSION --the current expression that might be transferred to Result
		do
			create Result.make
			across a_list as al loop

				curr := al
				contains := False
				across Result as res loop
--					if curr.is_deep_equal(res.item) then
					if are_equal (curr, res) then
						contains := True
					end
				end
				if not contains then
					Result.force(curr)
				end
			end
		ensure
			Result.count <= a_list.count
			across Result as res all a_list.has (res) end
		end

feature

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

feature {NONE}

	is_debugging_enabled: BOOLEAN = False

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
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
