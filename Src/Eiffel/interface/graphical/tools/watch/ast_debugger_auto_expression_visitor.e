note
	description: "AST visitor to retrieve auto expressions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DEBUGGER_AUTO_EXPRESSION_VISITOR

inherit
	AST_ITERATOR
		redefine
			process_access_feat_as,
			process_array_as,
			process_assign_as,
			process_assigner_call_as,
			process_case_as,
			process_creation_as,
			process_creation_expr_as,
			process_eiffel_list,
			process_expr_call_as,
			process_inspect_as,
			process_instr_call_as,
			process_interval_as,
			process_loop_as,
			process_named_expression_as,
			process_parameter_list_as,
			process_reverse_as,
			process_separate_instruction_as,
			process_static_access_as,
			process_tuple_as,
			process_result_as
		end

	SHARED_SERVER

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Entry

	process (a_as: FEATURE_AS; cl: CLASS_C)
		do
			create_level
			leaf_as_list := match_list_server.item (cl.class_id)
			process_feature_as (a_as)
		end

	auto_expressions (a_bp_index: INTEGER; a_delta_lower, a_delta_upper: INTEGER; a_f: E_FEATURE; cl: CLASS_C): LIST [STRING]
		local
			l_as: FEATURE_AS
			fi, afi: FEATURE_I
			s: STRING
			c, i: INTEGER
			l_line_start, l_line_end: INTEGER
			lst: LIST [like null_text_span]
			strat: AST_BREAKABLE_SLOT_STRATEGY
			retried: BOOLEAN
		do
			if not retried then
				autos_span_heap.wipe_out
				if a_f /= Void then
					l_as := a_f.ast
					create strat.make
					strat.set_current_class (cl)
					fi := a_f.associated_feature_i
					strat.set_current_feature (fi)
					afi := ancestor_version_of (fi, cl)
					if afi = Void then
						afi := fi
					end
					strat.set_source_class (afi.written_class)
					strat.set_source_feature (afi)
					strat.reset
					l_as.process (strat)

					process (l_as, cl)

					c := strat.sorted_breakable_lines.count
					if c > 0 then
							--| Lower line index
						i := 1 + a_bp_index + a_delta_lower
						if i < 1 then
							i := 1
						elseif i > c then
							i := c
						end
						l_line_start := strat.sorted_breakable_lines.i_th (i)

							--| Upper line index
						i := 1 + a_bp_index + a_delta_upper
						if i > c then
							i := c
						elseif i < 1 then
							i := 1
						end
						l_line_end := strat.sorted_breakable_lines.i_th (i)
					else
						l_line_start := l_as.complete_start_location (leaf_as_list).line - 1
						l_line_end := l_as.last_token (leaf_as_list).line
					end

					from
						create {LINKED_LIST [STRING]} Result.make
						Result.compare_objects
						autos_span_heap.start
					until
						autos_span_heap.after
					loop
						i := autos_span_heap.key_for_iteration --| - first_line_index
						if i >= l_line_start and i <= l_line_end then
							lst := autos_span_heap.item_for_iteration
							from
								lst.start
							until
								lst.after
							loop
								s := lst.item.i_text
								if not Result.has (s) then
									Result.extend (s)
								end
								lst.forth
							end
						end
						autos_span_heap.forth
					end
				end
			end
		rescue
			retried := True
			retry
		end

	ancestor_version_of (fi: FEATURE_I; an_ancestor: CLASS_C): FEATURE_I
			-- Feature in `an_ancestor' of which `Current' is derived.
			-- `Void' if not present in that class.
			--| FIXME jfiat [2007/05/31] : duplication of DBG_EVALUATOR.ancestor_version_of (..)
		require
			fi_not_void: fi /= Void
			an_ancestor_not_void: an_ancestor /= Void
		local
			n, nb: INTEGER
			ris: ROUT_ID_SET
			rout_id: INTEGER
		do
			if
				an_ancestor.is_valid
				and then an_ancestor.has_feature_table
			then
				ris := fi.rout_id_set
				from
					n := ris.lower
					nb := ris.count
				until
					n > nb or else Result /= Void
				loop
					rout_id := ris.item (n)
					if rout_id > 0 then
						Result := an_ancestor.feature_table.feature_of_rout_id (rout_id)
					end
					n := n + 1
				end
			end
		end

feature -- Processing

	process_access_feat_as (a_as: ACCESS_FEAT_AS)
			-- Processes a feature access 'a.b.<access>'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			if can_add_auto_span and is_expression_instruction and a_as.parameter_count = 0 then
				add_auto_span (a_as)
			else
				Precursor (a_as)
			end
		end

	process_array_as (a_as: ARRAY_AS)
			-- Process manifest array '<<...>>'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			enter_brackets
			Precursor (a_as)
			leave_brackets
		end

	process_assign_as (a_as: ASSIGN_AS)
			-- Process assign 'a := <expression>'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			reset_auto_spans
			set_is_expression_instruction (True)
			a_as.target.process (Current)

			reset_auto_spans
			set_can_add_auto_span (True)
			a_as.source.process (Current)
		end

	process_assigner_call_as (a_as: ASSIGNER_CALL_AS)
			-- Process assigner call 'a.b := <expression>'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			reset_auto_spans
			set_is_expression_instruction (True)
			a_as.target.process (Current)

			reset_auto_spans
			set_can_add_auto_span (True)
			a_as.source.process (Current)
		end

	process_case_as (a_as: CASE_AS)
			-- Process an inspect's when case.
			--
			-- `a_as': Abstract syntax node to process.
		do
			enter_brackets
			set_is_expression_instruction (True)
			a_as.interval.process (Current)
			leave_brackets

			reset_auto_spans
			a_as.compound.process (Current)
		end

	process_creation_as (a_as: CREATION_AS)
			-- Processes a creation expression
			--
			-- `a_as': Abstract syntax node to process.
		local
			l_call: ACCESS_INV_AS
		do
			reset_auto_spans
			set_is_expression_instruction (True)
			a_as.target.process (Current)

			l_call := a_as.call
			if l_call /= Void then
				set_can_add_auto_span (False)
				l_call.process (Current)
			end
		end

	process_creation_expr_as (a_as: CREATION_EXPR_AS)
			-- Processes a creation expression.
			--
			-- `a_as': Abstract syntax node to process.
		local
			l_call: ACCESS_INV_AS
		do
			l_call := a_as.call
			if l_call /= Void then
				set_can_add_auto_span (False)
				l_call.process (Current)
			end
		end

	process_eiffel_list (a_as: EIFFEL_LIST [AST_EIFFEL])
			-- Processes a list of Eiffel abstract syntax nodes.
			--
			-- `a_as': Abstract syntax node to process.
		do
			from
				a_as.start
			until
				a_as.after
			loop
				reset_auto_spans
				set_can_add_auto_span (True)
				a_as.item.process (Current)
				a_as.forth
			end
		end

	process_expr_call_as (a_as: EXPR_CALL_AS)
			-- Processes an expression call where a receive is explicitly (' a := ...')  or
			-- implicitly ('a_f (..., ...)') defined.
			--
			-- `a_as': Abstract syntax node to process.
		do
			set_is_expression_instruction (True)
			Precursor (a_as)
		end

	process_inspect_as (a_as: INSPECT_AS)
			-- Processes an inspect clause.
			--
			-- `a_as': Abstract syntax node to process.
		do
			reset_auto_spans
			a_as.switch.process (Current)

			reset_auto_spans
			a_as.case_list.process (Current)
		end

	process_instr_call_as (a_as: INSTR_CALL_AS)
			-- Processes an instruction call.
			--
			-- `a_as': Abstract syntax node to process.
		do
			reset_auto_spans
			set_is_expression_instruction (False)
			a_as.call.process (Current)
		end

	process_interval_as (a_as: INTERVAL_AS)
			-- Processes an interval, found in inspect when cases.
			--
			-- `a_as': Abstract syntax node to process.
		local
			l_atomic: ATOMIC_AS
		do
			reset_auto_spans
			process_atomic_interval_as (a_as.lower)
			l_atomic := a_as.upper
			if l_atomic /= Void then
				reset_auto_spans
				process_atomic_interval_as (l_atomic)
			end
		end

	process_loop_as (a_as: LOOP_AS)
			-- Process a from loop.
			--
			-- `a_as': Abstract syntax node to process.
		do
			safe_process (a_as.iteration)
			safe_process (a_as.from_part)

			reset_auto_spans
			set_can_add_auto_span (True)
			set_is_expression_instruction (True)
			safe_process (a_as.variant_part)

			safe_process (a_as.invariant_part)

			reset_auto_spans
			set_can_add_auto_span (True)
			set_is_expression_instruction (True)
			safe_process (a_as.stop)

			safe_process (a_as.compound)
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
			-- Process an argument of inline separate instruction of the form "expression 'as' variable".
		do
			a_as.expression.process (Current)
			add_auto_span (a_as.name)
		end

	process_parameter_list_as (a_as: PARAMETER_LIST_AS)
			-- Processes a list of parameters
			--
			-- `a_as': Abstract syntax node to process.
		do
			enter_brackets
			reset_auto_spans
			Precursor (a_as)
			leave_brackets
			set_can_add_auto_span (False)
		end

	process_result_as (a_as: RESULT_AS)
			-- <Precursor>
		do
			Precursor (a_as)
			add_auto_span (a_as)
		end

	process_reverse_as (a_as: REVERSE_AS)
			-- Process reverse assignment 'a ?= b'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			reset_auto_spans
			set_is_expression_instruction (True)
			a_as.target.process (Current)

			reset_auto_spans
			set_can_add_auto_span (True)
			a_as.source.process (Current)
		end

	process_separate_instruction_as (a_as: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
			-- Process inline separate instruction of the form "separate ... do ... end".
		do
			a_as.arguments.process (Current)
			safe_process (a_as.compound)
		end

	process_static_access_as (a_as: STATIC_ACCESS_AS)
			-- Process static access instruction/expression '{TYPE}.feature'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			if can_add_auto_span and is_expression_instruction and a_as.parameter_count = 0 then
				add_auto_span (a_as)
			else
				Precursor (a_as)
			end
		end

	process_tuple_as (a_as: TUPLE_AS)
			-- Process manifest tuple '[]'.
			--
			-- `a_as': Abstract syntax node to process.
		do
			enter_brackets
			Precursor (a_as)
			leave_brackets
		end

feature {NONE} -- Generic Node Processing

	process_atomic_interval_as (a_as: ATOMIC_AS)
			-- Process atomic interval value for inspect when cases.
			--
			-- `a_as': Abstract syntax node to process.
		require
			a_as_attached: a_as /= Void
		local
			l_static: STATIC_ACCESS_AS
			l_id: ID_AS
		do
			l_id ?= a_as
			if l_id /= Void then
				add_auto_span (l_id)
			else
				l_static ?= a_as
				if l_static /= Void then
					set_is_expression_instruction (True)
					process_static_access_as (l_static)
				end
			end
		end

feature {NONE} -- Access

	can_add_auto_span: BOOLEAN assign set_can_add_auto_span
			-- Can an expression be processed at this point?
		require
			level_manager_attached: level_stack /= Void
		do
			Result := current_level_item.can_add_auto_span
		end

	is_expression_instruction: BOOLEAN assign set_is_expression_instruction
			-- Is current instruction assumed to be an expression?
		require
			level_manager_attached: level_stack /= Void
		do
			Result := current_level_item.is_expression_instruction
		end

feature {NONE} -- Status Setting

	set_can_add_auto_span (a_can_add: like can_add_auto_span)
			-- Set `can_process_expression' with `a_can_add'.
			--
			-- `a_can_add': True if an auto expression can be added; False otherwise.
		require
			level_manager_attached: level_stack /= Void
		do
			current_level_item.can_add_auto_span := a_can_add
		ensure
			can_add_auto_span_set: can_add_auto_span = a_can_add
		end

	set_is_expression_instruction (a_expression: like is_expression_instruction)
			-- Set `is_expression_instruction' with `a_expression'.
			--
			-- `a_expression': True if current instruction is assumed to be an expression; False otherwise.
		require
			level_manager_attached: level_stack /= Void
		do
			current_level_item.is_expression_instruction := a_expression
		ensure
			is_expression_instruction_set: is_expression_instruction = a_expression
		end

feature {NONE} -- Level Process Management

	create_level
			-- Initialize level state manager
		do
			create level_stack.make (1)
			increase_level
		end

	level_stack: ARRAYED_STACK [like current_level_item]

	current_level_item: TUPLE [can_add_auto_span: BOOLEAN; is_expression_instruction: BOOLEAN]
		do
			Result := level_stack.item
		end

	current_level: INTEGER
			-- Level count of currently nested expression processing states
		do
			Result := level_stack.count
		end

	increase_level
			-- Increases expression processing level so instructions may be processes as if they were new instructions
		do
			level_stack.put ([False, False])
		ensure
			current_level_increased: current_level = old current_level + 1
		end

	decrease_level
			-- Decreases expression processing level so any last processed expression states are forgotton
			-- and state returns to that which it was before an increase.
		require
			current_level_big_enough: current_level > 0
		do
			level_stack.remove
		ensure
			current_level_increased: current_level = old current_level - 1
		end

--	level_manager: LEVEL_STATE_MANAGER [like current_level_item]
--			-- Level state manager for autos

	enter_brackets
			-- Enter a new bracketed block (paranthesis, manifest arrays or manifest tuples)
		do
			increase_level
			set_is_expression_instruction (True)
		end

	leave_brackets
			-- Enter a new bracketed block (paranthesis, manifest arrays or manifest tuples)
		do
			decrease_level
		end

feature {NONE} -- Auto Span Declaration

	start_as: AST_EIFFEL
			-- Starting as node of an autos expression

	reset_auto_spans
			-- Resets auto span so next added span will start anew.
		do
			start_as := Void
		ensure
			start_as_unattached: start_as = Void
		end

	add_auto_span (a_as: AST_EIFFEL)
			-- Adds a new auto expression span for `a_as' to autos span heap.
			--
			-- `a_as': Abstract syntax node to add span for.
		require
			a_as_attached: a_as /= Void
		local
			l_start: like start_as
			l_span: like null_text_span

			l_start_loc: LOCATION_AS
			l_end_loc: LOCATION_AS

			l_start_token, l_end_token: LEAF_AS
			l_id_as: ID_AS
			reg: ERT_TOKEN_REGION
		do
			l_start := start_as
			if l_start = Void then
					-- Set start span
				l_start := a_as
				start_as := l_start
			end
			l_start_loc := l_start.complete_start_location (leaf_as_list)
			l_end_loc := a_as.end_location

			l_span := text_span (l_start_loc.line, l_start_loc.column, l_end_loc.line, l_end_loc.final_column, Void)

			l_start_token := l_start.first_token (leaf_as_list)
			l_end_token := a_as.last_token (leaf_as_list)
			if l_start_token /= Void and l_end_token /= Void then
				if l_start_token = l_end_token then
					l_id_as ?= l_start_token
					if l_id_as /= Void then
						l_span.i_text := l_id_as.name
					else
						l_span.i_text := l_start_token.text (leaf_as_list)
					end
--					l_span.i_text := l_start_token.literal_text (leaf_as_list)
				else
					create reg.make (l_start_token.index, l_end_token.index)
					if leaf_as_list.valid_region (reg) then
						l_span.i_text := leaf_as_list.text (reg)
					else
						do_nothing
					end
				end
			end
			auto_expression (l_span)
		end

	text_span (a_line_start, a_index_start, a_line_end, a_index_end: INTEGER; a_text: STRING):
--				like null_text_span
				TUPLE [i_start_line: INTEGER; i_start_index: INTEGER;
						i_end_line: INTEGER; i_end_index: INTEGER;
						i_text: STRING]

		do
			Result := [a_line_start, a_index_start, a_line_end, a_index_end, a_text]
		end

	auto_expression (a_expr: like null_text_span)
			-- Adds the span of an expression to an internal list.
			--
			-- `a_expr': A TextSpan object indicating the expression to add.
		local
			l_end: INTEGER
			i: INTEGER
		do
			check not_a_expr_is_null: not is_null_text_span (a_expr) end

			i := a_expr.i_start_line
			l_end := a_expr.i_end_line
			if i < l_end then
					-- Expression spans multiple lines so add the other lines too.
				from until i > l_end loop
					add_span_to_line (a_expr, i)
					i := i + 1
				end
			else
				add_span_to_line (a_expr, i)
			end
		end

feature -- {NONE} -- Autos Heap

	autos_span_heap: HASH_TABLE [ARRAYED_LIST [like null_text_span], INTEGER]
			-- Table of spans index by line number
			-- Key: Line number where auto expressions were found.
			-- Value: Mutable list of text spans.
		do
			Result := internal_autos_span_heap
			if Result = Void then
				create Result.make (13)
				internal_autos_span_heap := Result
			end
		ensure
			result_attached: Result /= Void
			internal_autos_span_heap_attached: internal_autos_span_heap /= Void
		end

	add_span_to_line (a_span: like null_text_span; a_line: INTEGER)
			-- Add text span `a_span' for line `a_line' to autos span heap.
			--
			-- `a_span': TextSpan to add to autos heap.
			-- `a_line': Zero-based line `a_span' is at.
		require
			a_span_not_null: not is_null_text_span (a_span)
			a_line_non_negative: a_line >= 0
		local
			l_list: ARRAYED_LIST [like null_text_span]
		do
			l_list := autos_span_heap [a_line]
			if l_list = Void then
				create l_list.make (1)
				autos_span_heap.force (l_list, a_line)
			end
			l_list.extend (a_span)
		ensure
			autos_span_heap_has_a_line: autos_span_heap[a_line] /= Void
			not_autos_span_heap_item_is_empty: not autos_span_heap [a_line].is_empty
			autos_span_heap_has_a_span: autos_span_heap [a_line].last.is_equal (a_span)
		end

feature {NONE} -- Internal Implementation Cache

	internal_autos_span_heap: like autos_span_heap
			-- Cached version of `autos_span_heap'
			-- Note: Do not use directly!

feature -- Conversion

	null_text_span: TUPLE [i_start_line: INTEGER; i_start_index: INTEGER;
						i_end_line: INTEGER; i_end_index: INTEGER;
						i_text: STRING]

			-- A null TextSpan
		once
			Result := [0,0,0,0, Void]
		ensure
			result_set: Result.i_start_line = 0 and Result.i_start_index = 0 and
					Result.i_end_line = 0 and Result.i_end_index = 0
		end

	is_null_text_span (a_span: like null_text_span): BOOLEAN
			-- Is `a_span' considered a null TextSpan?
		do
			Result := is_text_span_equal (a_span, null_text_span)
		end

	is_text_span_equal (a_span: like null_text_span; a_other_span: like null_text_span): BOOLEAN
			-- Determins if `a_span' and `a_other_span' are equal.
			--
			-- `a_span': A source text span to test with.
			-- `a_other_span': Another text span to test `a_span' for equality with.
			-- `Result': True if `a_span' and `a_other_span' are equal, False otherwise.
		do
			Result := a_span.i_end_index = a_other_span.i_end_index and
					a_span.i_end_line = a_other_span.i_end_line and
					a_span.i_start_index = a_other_span.i_start_index and
					a_span.i_start_line = a_other_span.i_start_line
			check
				use_equal_operator: a_span /= a_other_span
			end
		end

feature {NONE} -- Implementation

	leaf_as_list: LEAF_AS_LIST;

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
