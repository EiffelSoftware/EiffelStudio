indexing
	description	: "Byte code for conditional instruction."
	date		: "$Date$"
	revision	: "$Revision$"

class IF_B 

inherit
	INSTR_B
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result, make_byte_code,
			assigns_to, is_unsafe, generate_il,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code, enlarged, need_enlarging
		end

	VOID_REGISTER
		export
			{NONE} all
		end
	
feature -- Access

	condition: EXPR_B
			-- Conditional expression

	compound: BYTE_LIST [BYTE_NODE]
			-- Main compound {list of INSTR_B}

	elsif_list: BYTE_LIST [BYTE_NODE]
			-- Alternatives {list of ELSIF_B}

	else_part: BYTE_LIST [BYTE_NODE]
			-- Default compound {list of INSTR_B}

feature -- Settings

	set_condition (c: like condition) is
			-- Assign `c' to `condition'.
		do
			condition := c
		end

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	set_elsif_list (e: like elsif_list) is
			-- Assign `e' to `elsif_list'.
		do
			elsif_list := e
		end

	set_else_part (e: like else_part) is
			-- Assign `e' to `elsif_list'.
		do
			else_part := e
		end

	need_enlarging: BOOLEAN is
			-- Does current need to be modified for improved code generation?
 		do
				-- Made `need_enlarging' return True in final mode. This enables us to implement
				-- `enlarged' that will simplify current IF_B node into something simpler if
				-- associated boolean expressions can be simplified.
			Result := context.final_mode
		end
		
	enlarged: INSTR_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		local
			l_value: VALUE_I
			l_if_b: IF_B
			l_elseif_b: ELSIF_B
			l_expr: EXPR_B
		do
			check
				final_mode: context.final_mode
			end
			condition := condition.enlarged
			l_value := condition.evaluate
			if l_value.is_boolean then
				if l_value.boolean_value then
					compound.enlarge_tree
					create {INSTR_LIST_B} Result.make (compound)
				else
					if elsif_list = Void and else_part = Void then
						create {INSTR_LIST_B} Result.make (null_byte_node)
					elseif elsif_list = Void then
						else_part.enlarge_tree
						create {INSTR_LIST_B} Result.make (else_part)
					else
						check
							not_elsif_list_empty: not elsif_list.is_empty
						end
						
							-- Now remove useless `elseif' statements.
						from
							elsif_list.start
						until
							elsif_list.after
						loop
							l_elseif_b ?= elsif_list.item
							l_expr := l_elseif_b.expr.enlarged
							l_value := l_expr.evaluate
							if l_value.is_boolean then
								if l_value.boolean_value then
										-- Code will always be executed, get rid of remaining items.
									l_elseif_b.enlarge_tree
									elsif_list.forth
									from
									until
										elsif_list.after
									loop
										elsif_list.remove
									end
									else_part := Void
								else
										-- Code will never be executed, get rid of it.
									elsif_list.remove
								end
							else
								l_elseif_b.enlarge_tree
								elsif_list.forth
							end
						end
						
							-- Create new node.
						if not elsif_list.is_empty then
							create l_if_b
							l_elseif_b ?= elsif_list.first
							l_if_b.set_condition (l_elseif_b.expr)
							l_if_b.set_compound (l_elseif_b.compound)
							elsif_list.start
							elsif_list.remove
							if not elsif_list.is_empty then
								l_if_b.set_elsif_list (elsif_list)
							end
							else_part.enlarge_tree
							l_if_b.set_else_part (else_part)
							Result := l_if_b
						else
							if else_part = Void then
								create {INSTR_LIST_B} Result.make (null_byte_node)
							else
								else_part.enlarge_tree
								create {INSTR_LIST_B} Result.make (else_part)
							end
						end
					end
				end
			else
					-- We could not simplify first if statment, let's see if we can simplifiy
					-- remaining `elsif_list'.
				Result := Current
				if compound /= Void then
					compound.enlarge_tree
				end
				if elsif_list /= Void then
					check
						not_elsif_list_empty: not elsif_list.is_empty
					end
					
						-- Now remove useless `elseif' statements.
					from
						elsif_list.start
					until
						elsif_list.after
					loop
						l_elseif_b ?= elsif_list.item
						l_expr := l_elseif_b.expr.enlarged
						l_value := l_expr.evaluate
						if l_value.is_boolean then
							if l_value.boolean_value then
									-- Code will always be executed, get rid of remaining items.
								l_elseif_b.enlarge_tree
								elsif_list.forth
								from
								until
									elsif_list.after
								loop
									elsif_list.remove
								end
								else_part := Void
							else
									-- Code will never be executed, get rid of it.
								elsif_list.remove
							end
						else
							l_elseif_b.enlarge_tree
							elsif_list.forth
						end
					end
					
					if elsif_list.is_empty then
						elsif_list := Void
					end
				end
				if else_part /= Void then
					else_part.enlarge_tree
				end
			end
		end
		
	enlarge_tree is
			-- Enlarge the if construct
		do
			condition := condition.enlarged
			if compound /= Void then
				compound.enlarge_tree
			end
			if elsif_list /= Void then
				elsif_list.enlarge_tree
			end
			if else_part /= Void then
				else_part.enlarge_tree
			end
		end

	find_assign_result is
			-- Find all terminal assignments made to Result
		do
			if compound /= Void then
				compound.finish
				compound.item.find_assign_result
			end
			if elsif_list /= Void then
				elsif_list.finish
				elsif_list.item.find_assign_result
			end
			if else_part /= Void then
				else_part.finish
				else_part.item.find_assign_result
			end
		end

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in the function assignments
			-- in a Result entity ?
		do
			if compound /= Void then
				compound.finish
				Result := compound.item.last_all_in_result
			end
			if elsif_list /= Void and Result then
				from
					elsif_list.start
				until
					elsif_list.after or not Result
				loop
					Result := Result and elsif_list.item.last_all_in_result
					elsif_list.forth
				end
			end
			if else_part /= Void and Result then
				else_part.finish
				Result := Result and else_part.item.last_all_in_result
			else
					-- No else part, so we may continue.
					-- As this is the LAST compound statement, this
					-- means we are followed by an implicit return Result.
				Result := false
			end
			Result := Result and not context.has_postcondition and
					not context.has_invariant
		end

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			condition.propagate (No_register)
			condition.analyze
			condition.free_register
			if compound /= Void then
				compound.analyze
			end
			if elsif_list /= Void then
				elsif_list.analyze
			end
			if else_part /= Void then
				else_part.analyze
			end
		end

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info
				-- Outstanding of if..then..else..end
			buf.new_line

				-- Generate the hook for "if cond then"
			generate_frozen_debugger_hook

			condition.generate
			buf.putstring (gc_if_l_paran)
			condition.print_register
			buf.putstring (") {")
			buf.new_line
			if compound /= Void then
				buf.indent
				compound.generate
				buf.exdent
			end
			buf.putchar ('}')
			if elsif_list /= Void then
				elsif_list.generate
			end
			if else_part /= Void then
				buf.putstring (" else {")
				buf.new_line
				buf.indent
				else_part.generate
				buf.exdent
				buf.putchar ('}')
			end
			generate_closing_brakets
			buf.new_line
				-- Leave one blank line after the construct
			buf.new_line
		end

	generate_closing_brakets is
			-- Generate one closing braket for each generated elsif
		local
			i: INTEGER
			buf: GENERATION_BUFFER
		do
			if elsif_list /= Void then
				from
					buf := buffer
					i := elsif_list.count
				until
					i = 0
				loop
					buf.putchar ('}')
					i := i - 1
				end
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for conditional instruction.
		local
			elsif_clause: ELSIF_B
			cmp: like compound
			nb_jumps: INTEGER
			else_label, end_label, elsif_label: IL_LABEL
			has_elses: BOOLEAN
		do
			has_elses := else_part /= Void or elsif_list /= Void
			
			generate_il_line_info
			
				-- Generated byte code for condition
			condition.generate_il
			
				-- Generated a test
			else_label := il_label_factory.new_label
			il_generator.branch_on_false (else_label)

			if compound /= Void then
					-- Generated IL code for first compound (if any).
				compound.generate_il
			end

			if has_elses then
				end_label := il_label_factory.new_label
				il_generator.branch_to (end_label)
			end

			nb_jumps := nb_jumps + 1
	
				-- Else label
			il_generator.mark_label (else_label)

			if elsif_list /= Void then
					-- Generates IL code for alternatives
				from
					elsif_list.start
				until
					elsif_list.after
				loop
					elsif_clause ?= elsif_list.item
						-- Generate byte code for expression
					elsif_clause.generate_il_line_info
					elsif_clause.expr.generate_il

						-- Test if false
					elsif_label := il_label_factory.new_label
					il_generator.branch_on_false (elsif_label)

					cmp := elsif_clause.compound
					if cmp /= Void then
							-- Generate alternative compound byte code
						cmp.generate_il
					end

					il_generator.branch_to (end_label)

					il_generator.mark_label (elsif_label)
					elsif_list.forth
				end
			end
						
			if else_part /= Void then
					-- Generates byte code for default compound.
				else_part.generate_il
			end

			if has_elses then
					-- End of `if' statement.
				il_generator.mark_label (end_label)
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for a conditional instruction.
		local
			elsif_clause: ELSIF_B
			cmp: like compound
			i, nb_jumps: INTEGER
		do	
				-- Generate hook for the condition test
			generate_melted_debugger_hook (ba)

				-- Generated byte code for condition
			condition.make_byte_code (ba)

				-- Generated a test
			ba.append (Bc_jmp_f)

				-- Deferred writing of the jump value
			ba.mark_forward

			if compound /= Void then
					-- Generated byte code for first compound (if any).
				compound.make_byte_code (ba)
			end
			ba.append (Bc_jmp)
			ba.mark_forward2
			nb_jumps := nb_jumps + 1
	
				-- Writes the relative jump value.
			ba.write_forward

			if elsif_list /= Void then
					-- Generates byte code for alternatives
				from
					elsif_list.start
				until
					elsif_list.after
				loop
					elsif_clause ?= elsif_list.item
					
						-- Generate hook for the condition test
					generate_melted_debugger_hook (ba)
	
						-- Generate byte code for expression
					elsif_clause.expr.make_byte_code (ba)

						-- Test if false
					ba.append (Bc_jmp_f)
					ba.mark_forward

					cmp:= elsif_clause.compound
					if cmp /= Void then
							-- Generate alternative compound byte code
						cmp.make_byte_code (ba)
					end
					ba.append (Bc_jmp)
					ba.mark_forward2
					nb_jumps := nb_jumps + 1

					ba.write_forward
				
					elsif_list.forth
				end
			end
						
			if else_part /= Void then
					-- Generates byte code for default compound.
				else_part.make_byte_code (ba)
			end

			from
					-- Generate jump values for unconditional jumps
					-- after the `nb_jumps' compounds encountered in the
					-- entire instruction.
				i := 1
			until
				i > nb_jumps
			loop
				ba.write_forward2
				i := i + 1
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result :=
				(compound /= Void and then compound.assigns_to (i)) or else
				(else_part /= Void and then else_part.assigns_to (i)) or else
				(elsif_list /= Void and then elsif_list.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := condition.calls_special_features (array_desc) or else
				(compound /= Void and then compound.calls_special_features (array_desc)) or else
				(else_part /= Void and then else_part.calls_special_features (array_desc)) or else
				(elsif_list /= Void and then elsif_list.calls_special_features (array_desc))
		end

	is_unsafe: BOOLEAN is
		do
			Result := condition.is_unsafe or else
				(compound /= Void and then compound.is_unsafe) or else
				(else_part /= Void and then else_part.is_unsafe) or else
				(elsif_list /= Void and then elsif_list.is_unsafe)
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			condition := condition.optimized_byte_node
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
			if else_part /= Void then
				else_part := else_part.optimized_byte_node
			end
			if elsif_list /= Void then
				elsif_list := elsif_list.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + condition.size
			if compound /= Void then
				Result := Result + compound.size
			end
			if else_part /= Void then
				Result := Result + else_part.size
			end
			if elsif_list /= Void then
				Result := Result + elsif_list.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			condition := condition.pre_inlined_code
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
			if else_part /= Void then
				else_part := else_part.pre_inlined_code
			end
			if elsif_list /= Void then
				elsif_list := elsif_list.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			condition := condition.inlined_byte_code
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
			if else_part /= Void then
				else_part := else_part.inlined_byte_code
			end
			if elsif_list /= Void then
				elsif_list := elsif_list.inlined_byte_code
			end
		end

end
