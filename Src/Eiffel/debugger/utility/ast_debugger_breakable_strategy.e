note
	description: "Debugger AST processor."

class
	AST_DEBUGGER_BREAKABLE_STRATEGY

inherit
	AST_ITERATOR
		redefine
			process_routine_as,
			process_inline_agent_creation_as,
			process_assign_as,
			process_assigner_call_as,
			process_creation_as,
			process_elseif_as,
			process_guard_as,
			process_if_as,
			process_inspect_as,
			process_instr_call_as,
			process_iteration_as,
			process_loop_as,
			process_variant_as,
			process_retry_as,
			process_reverse_as,
			process_separate_instruction_as,
			process_tagged_as,
			process_object_test_as,
			process_named_expression_as
		end

	REFACTORING_HELPER

	SHARED_SERVER

	SHARED_EIFFEL_PROJECT

	INTERNAL_COMPILER_STRING_EXPORTER

	DEBUGGER_COMPILER_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize
		do
		end

feature -- Reset

	reset
		do
			breakable_feature_info := Void
			current_class := Void
			current_feature_i := Void
			current_source_class := Void
			current_source_feature_i := Void
			leaf_as_list := Void
		end

feature -- Basic operations	

	get_breakable_info (a_feat: FEATURE_I; a_class: CLASS_C; a_info: like breakable_feature_info)
		require
			a_feat_attached: a_feat /= Void
			a_class_attached: a_class /= Void
			a_info_attached: a_info /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				breakable_feature_info := a_info
				initialize_current_context (a_feat, a_class)
				if attached a_feat.real_body as l_as then
					l_as.process (Current)
				end
				debug ("debugger_trace_breakable")
					display_breakable_feature_info
				end
			else
				a_info.set_error_occurred (True)
			end
			breakable_feature_info := Void
		ensure
			breakable_feature_info_void: breakable_feature_info = Void
		rescue
			retried := True
			retry
		end

	display_breakable_feature_info
		do
			debug ("debugger_trace_breakable")
				if
					attached breakable_feature_info as l_info and then
					attached l_info.points as l_points
				then
					from
						l_points.start
					until
						l_points.after
					loop
						if attached l_points.item as l_item then
							io.put_string (l_item.debug_output)
							io.put_new_line
						else
							check no_void_item: False end
						end
						l_points.forth
					end
				end
			end
		end

	display_object_test_locals
		local
			fi: FORMAT_INTEGER
			l_item: detachable DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO
			l_type: detachable TYPE_AS
			l_expr: detachable EXPR_AS
		do
			debug ("debugger_trace_breakable")
				if attached breakable_feature_info.object_test_locals as l_lst then
					create fi.make (3)
					from
						l_lst.start
					until
						l_lst.after
					loop
						l_item := l_lst.item
						if l_item /= Void then
							io.put_string (fi.formatted (l_item.breakable_index))
							if l_item.breakable_nested_index > 0 then
								io.put_character ('+')
								io.put_integer (l_item.breakable_nested_index)
							end
							io.put_string (": OT local %'" + l_item.name_id.name + "%'")
							l_type := l_item.type
							if l_type /= Void then
								io.put_string (" {" + l_type.dump + "}")
							else
								l_expr := l_item.expression
								if l_expr /= Void then
									io.put_string (" {like " + text_of (l_expr) + "}")
								end
							end
							io.put_new_line
						else
							check no_void_item: False end
						end
						l_lst.forth
					end
				end
			end
		end

feature -- Query

	text_at (a_bp, a_bp_nested: INTEGER): detachable STRING
			-- Text at location a_bp, a_bp_nested
		require
			current_breakable_info_table_attached: breakable_feature_info /= Void
		do
			if attached breakable_point_info (a_bp, a_bp_nested) as l_info then
				Result := l_info.text
			end
		end

	breakable_point_info (a_bp, a_bp_nested: INTEGER): DBG_BREAKABLE_POINT_INFO
		require
			current_breakable_info_table_attached: breakable_feature_info /= Void
		do
			if
				attached breakable_feature_info as l_info and then
				attached l_info.points as l_points
			then
				from
					l_points.start
				until
					l_points.after or Result /= Void
				loop
					if attached l_points.item as l_item then
						if
							l_item.bp = a_bp and then
							l_item.bp_nested = a_bp_nested
						then
							Result := l_item
						end
					end
					l_points.forth
				end
			end
		end

feature -- Access

	breakable_feature_info: detachable DBG_BREAKABLE_FEATURE_INFO
			-- Current breakable feature info

feature -- Element change

	initialize_current_context (f: like current_feature_i; c: like current_class)
		require
			f_attached: f /= Void
		local
			l_written_in: INTEGER
		do
			l_written_in := f.written_in
			leaf_as_list := match_list_server.item (l_written_in)

			current_feature_i := f
			current_source_class := f.written_class
			current_source_feature_i := current_source_class.feature_of_rout_id_set (f.rout_id_set)

			if c /= Void then
				current_class := c
			else
				current_class := current_source_class
			end
		ensure
			current_context_set: current_feature_i /= Void and
								 current_class /= Void and
								 current_source_feature_i /= Void and
								 current_source_class /= Void
			leaf_as_list_attached: leaf_as_list /= Void
		end

feature {NONE} -- Context

	current_class: CLASS_C
	current_feature_i: FEATURE_I

	current_source_class: CLASS_C
	current_source_feature_i: FEATURE_I

	leaf_as_list: LEAF_AS_LIST
			-- Leaf for processed AST

	context_data: TUPLE [leaf: like leaf_as_list; c: CLASS_C; f: FEATURE_I; sc: CLASS_C; sf: FEATURE_I]
		do
			Result := [leaf_as_list, current_class, current_feature_i, current_source_class, current_source_feature_i]
		ensure
			Result_attached: Result /= Void
		end

feature {NONE} -- Element change

	restore_context_data (a_data: like context_data)
		require
			a_data_attached: a_data /= Void
		do
			leaf_as_list := a_data.leaf
			current_class := a_data.c
			current_feature_i := a_data.f
			current_source_class := a_data.sc
			current_source_feature_i := a_data.sf
		end

	register_breakable (l_as: AST_EIFFEL)
		do
			register_breakable_as (l_as, 0, Void)
		end

	register_breakable_as (l_as: AST_EIFFEL; a_line: INTEGER; a_text: detachable STRING)
		local
			s: STRING
			i, l_line: INTEGER
			fi: FORMAT_INTEGER
			l_info: like breakable_feature_info
		do
			l_info := breakable_feature_info
			if l_info /= Void then
				if a_text /= Void then
					s := a_text
				else
					s := text_of (l_as)
					i := s.index_of ('%N', 1)
					if i > 0 then
						s := s.substring (1, i - 1)
					else
						s := s.string
					end
				end
				create fi.make (3)
				l_line := a_line
				if l_line = 0 then
					l_line := l_as.start_location.line
				end
				l_info.add_point (current_source_class, l_line, s)
			end
		end

	register_nested_breakable (l_as: AST_EIFFEL)
		do
			register_nested_breakable_as (l_as, 0, Void)
		end

	register_nested_breakable_as (l_as: AST_EIFFEL; a_line: INTEGER; a_text: detachable STRING)
		local
			s: STRING
			i, l_line: INTEGER
		do
			if attached breakable_feature_info as l_info then
				if a_text /= Void then
					s := a_text
				else
					s := text_of (l_as)
					i := s.index_of ('%N', 1)
					if i > 0 then
						s := s.substring (1, i - 1)
					else
						s := s.string
					end
				end
				l_line := a_line
				if l_line = 0 then
					l_line := l_as.start_location.line
				end
				l_info.add_nested_point (current_source_class, l_line, s)
			end
		end

	register_object_test_local (a_name: detachable ID_AS; a_type: detachable TYPE_AS; a_exp: detachable EXPR_AS)
			-- Register object test local info
		do
			if attached breakable_feature_info as l_info then
				l_info.add_object_test_local (a_name, a_type, a_exp)
			end
		end

	register_named_expression_local (a_name: ID_AS; a_exp: detachable EXPR_AS)
			-- Register object test local info
		do
			if attached breakable_feature_info as l_info then
				l_info.add_object_test_local (a_name, Void, a_exp)
			end
		end

	register_variant_local (a_variant_as: VARIANT_AS)
			-- Register variant local info
		local
--			s: STRING
--			l_id: ID_AS
		do
			--| FIXME:jfiat: due to bug#15572, we can not have a nice way to handle the variant's values
--			create s.make_from_string (once "_loop_variant")
--			l_id := l_as.tag
--			if l_id /= Void then
--				s.append_character ('_')
--				s.append_string (l_id.name)
--			end
--			create l_id.initialize (s)
--			register_object_test_local (l_id, Void, l_as.expr)
		end

	text_of (a_as: AST_EIFFEL): STRING
			-- Text associated with `a_as'
		local
			retried: BOOLEAN
		do
			if not retried then
				if
					a_as.is_text_available (leaf_as_list) and then
					attached a_as.text (leaf_as_list) as s
				then
					Result := s
				else
					create Result.make_empty
				end
			else
				create Result.make_empty
			end
		ensure
			Result_attached: Result /= Void
		rescue
			retried := True
			retry
		end


feature {NONE} -- Iteration

	process_assign_as (l_as: ASSIGN_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_assigner_call_as (l_as: ASSIGNER_CALL_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_creation_as (l_as: CREATION_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_elseif_as (l_as: ELSIF_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_guard_as (l_as: GUARD_AS)
		do
			Precursor (l_as)
		end

	process_if_as (l_as: IF_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_inspect_as (l_as: INSPECT_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_instr_call_as (l_as: INSTR_CALL_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_iteration_as (l_as: ITERATION_AS)
		do
			register_object_test_local (l_as.identifier, Void, Void)
			Precursor (l_as)
		end

	process_loop_as (l_as: LOOP_AS)
		do
			safe_process (l_as.iteration)
			safe_process (l_as.from_part)
			safe_process (l_as.invariant_part)
			safe_process (l_as.variant_part)
			if attached l_as.stop as s then
				register_breakable (s)
				s.process (Current)
			end
			safe_process (l_as.compound)
		end

	process_variant_as (l_as: VARIANT_AS)
		do
			register_breakable (l_as)
			register_variant_local (l_as)
			Precursor (l_as)
		end

	process_retry_as (l_as: RETRY_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_reverse_as (l_as: REVERSE_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_separate_instruction_as (a: SEPARATE_INSTRUCTION_AS)
			-- <Precursor>
		do
			a.arguments.process (Current)
			safe_process (a.compound)
		end

	process_routine_as (l_as: ROUTINE_AS)
		local
			l_info: like breakable_feature_info
			l_body_ot_lst, l_inherited_ot_lst: ARRAYED_LIST [DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO]
			l_locals: EIFFEL_LIST [LIST_DEC_AS]
			l_id_list: IDENTIFIER_LIST
			l_local_vars: detachable ARRAYED_LIST [TUPLE [id: INTEGER; type: detachable TYPE_AS]]
		do
			l_info := breakable_feature_info
			if l_info /= Void then --and not current_feature_i.is_inline_agent then
					--| Get locals info
				l_locals := l_as.locals
				if l_locals /= Void and not l_locals.is_empty then
					from
						create l_local_vars.make (2 * l_locals.count)
						l_locals.start
					until
						l_locals.after
					loop
						from
							l_id_list := l_locals.item.id_list
							l_id_list.start
						until
							l_id_list.after
						loop
							l_local_vars.force ([l_id_list.item, l_locals.item.type])
							l_id_list.forth
						end
						l_locals.forth
					end
				end
				l_info.set_locals (l_local_vars)

					--| Get other info, such as object test locals
				if attached flatten_inherited_assertions (current_feature_i, current_class) as l_flatten_inherited_assertions then
					l_body_ot_lst := l_info.object_test_locals
					--| Due to compiler behavior, the object test locals' order is not AST logical.
					--| So let's handle the good order for the debugger.

					l_info.change_object_test_locals (Void)
					l_inherited_ot_lst := l_info.object_test_locals
					process_inherited_preconditions (l_flatten_inherited_assertions)
					l_info.change_object_test_locals (l_body_ot_lst)

					safe_process (l_as.precondition)
					safe_process (l_as.locals)
					l_as.routine_body.process (Current)

					l_info.change_object_test_locals (l_inherited_ot_lst)
					process_inherited_postconditions (l_flatten_inherited_assertions)
					l_info.change_object_test_locals (l_body_ot_lst)

					safe_process (l_as.postcondition)
					safe_process (l_as.rescue_clause)
					l_info.append_object_test_locals (l_inherited_ot_lst)
				else
					Precursor (l_as)
				end
			end
			if not l_as.is_deferred then
					--| end
				register_breakable_as (l_as, l_as.end_location.line, "end")
			end
		end

	process_inline_agent_creation_as (l_as: INLINE_AGENT_CREATION_AS)
		local
			l_info: like breakable_feature_info
		do
			l_info := breakable_feature_info

			if l_info /= Void then
				breakable_feature_info := Void
				Precursor (l_as)
				breakable_feature_info := l_info
			else
				check False end
			end
		end

	process_tagged_as (l_as: TAGGED_AS)
		do
			register_breakable (l_as)
			Precursor (l_as)
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
			-- Process `l_as'.
		do
			register_object_test_local (l_as.name, l_as.type, l_as.expression)
			Precursor (l_as)
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
		do
			register_breakable (a_as)
			register_named_expression_local (a_as.name, a_as.expression)
			Precursor (a_as)
		end

feature {NONE} -- Implementation: Iteration

	process_inherited_preconditions (a_lst_assert: like flatten_inherited_assertions)
		require
			a_lst_assert_attached: a_lst_assert /= Void
		local
			l_as: detachable REQUIRE_AS
			l_old_data: like context_data
			l_old_leaf_as_list: like leaf_as_list
			l_old_current_feature_i: like current_feature_i
			l_written_in: INTEGER
		do
			if a_lst_assert /= Void then
				l_old_data := context_data
				l_old_leaf_as_list := leaf_as_list
				l_old_current_feature_i := current_feature_i
				from
					a_lst_assert.start
				until
					a_lst_assert.after
				loop
					check no_void_item: a_lst_assert.item /= Void end
					l_as := a_lst_assert.item.precondition
					if l_as /= Void then
						l_written_in := a_lst_assert.item.written_in
						current_source_class := Eiffel_system.class_of_id (l_written_in)
						check class_exists: current_source_class /= Void end
						leaf_as_list := match_list_server.item (l_written_in)
						current_feature_i := current_source_class.feature_of_rout_id_set (l_old_current_feature_i.rout_id_set)
						check feature_found: current_feature_i /= Void end
						l_as.process (Current)
					end
					a_lst_assert.forth
				end
				leaf_as_list := l_old_leaf_as_list
				restore_context_data (l_old_data)
			end
		end

	process_inherited_postconditions (a_lst_assert: like flatten_inherited_assertions)
		require
			a_lst_assert_attached: a_lst_assert /= Void
			not_inline_agent: not current_feature_i.is_inline_agent
		local
			l_as: detachable ENSURE_AS
			l_old_data: like context_data
			l_old_leaf_as_list: like leaf_as_list
			l_old_current_feature_i: like current_feature_i
			l_written_in: INTEGER
		do
			if a_lst_assert /= Void then
				l_old_data := context_data
				l_old_leaf_as_list := leaf_as_list
				l_old_current_feature_i := current_feature_i
				from
					a_lst_assert.start
				until
					a_lst_assert.after
				loop
					check no_void_item: a_lst_assert.item /= Void end
					l_as := a_lst_assert.item.postcondition
					if l_as /= Void then
						l_written_in := a_lst_assert.item.written_in
						current_source_class := Eiffel_system.class_of_id (l_written_in)
						check class_exists: current_source_class /= Void end
						leaf_as_list := match_list_server.item (l_written_in)
						current_feature_i := current_source_class.feature_of_rout_id_set (l_old_current_feature_i.rout_id_set)
						check feature_found: current_feature_i /= Void end
						l_as.process (Current)
					end
					a_lst_assert.forth
				end
				leaf_as_list := l_old_leaf_as_list
				restore_context_data (l_old_data)
			end
		end

	flatten_inherited_assertions (a_feat: FEATURE_I; a_class: CLASS_C): detachable LIST [DBG_CHAINED_ASSERTIONS]
		require
			a_feat_attached: a_feat /= Void
			a_class_attached: a_class /= Void
		local
			i: INTEGER
			l_inh_info: INH_ASSERT_INFO
			l_written_in: INTEGER
			l_inh_written_class: CLASS_C
			l_inh_feat: detachable FEATURE_I
			l_assertions: detachable ARRAYED_LIST [DBG_CHAINED_ASSERTIONS]
			l_assert_id_set: detachable ASSERT_ID_SET
		do
			l_assert_id_set := a_feat.assert_id_set
			if
				l_assert_id_set /= Void and then
				not l_assert_id_set.is_empty
			then
				from
					i := l_assert_id_set.lower
					create l_assertions.make (l_assert_id_set.count)
					l_written_in := a_feat.written_in
				until
					i > l_assert_id_set.upper
				loop
					l_inh_info := l_assert_id_set.item (i)
					if l_inh_info /= Void and then l_inh_info.written_in /= l_written_in then
						l_inh_written_class := l_inh_info.written_class
						if l_inh_written_class.has_feature_table then
							l_inh_feat := l_inh_written_class.feature_of_body_index (l_inh_info.body_index)
							if
								l_inh_feat /= Void and then attached l_inh_feat.body as l_inh_feat_as and then
								attached {ROUTINE_AS} l_inh_feat_as.body.content as l_inh_rout_as
							then
								if l_inh_rout_as.has_assertion then
									l_assertions.force (create {DBG_CHAINED_ASSERTIONS}.make (
										l_inh_info.written_in,
										l_inh_rout_as.precondition, l_inh_rout_as.postcondition))
								end
							end
						end
					end
					i := i + 1
				end
				if not l_assertions.is_empty then
					Result := l_assertions
				end
			end
		end

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
