note
	description: "Perform type checking for debugger's expression evaluator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR

inherit
	AST_FEATURE_CHECKER_GENERATOR
		export {DEBUGGER_AST_SERVER}
			set_current_feature
		redefine
			reset,
			process_un_old_as,
			process_access_feat_as,
			check_type,
			feature_with_name_using,
			match_list_of_class,
			is_void_safe_call,
			is_void_safe_initialization,
			is_void_safe_conformance,
			is_void_safe_construct,
			set_routine_ids
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_AST_CONTEXT
		rename
			Context as Ast_context
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Settings

	reset
			-- Reset all attributes to their default value
		do
			Precursor {AST_FEATURE_CHECKER_GENERATOR}
			expression_context := Void
		end

feature {NONE} -- Properties

	expression_context: AST_CONTEXT
			-- Saved original Ast context when processing in the ancestor's context.

feature -- Access: byte node

	expression_byte_node (a_expression: DBG_EXPRESSION; a_context: DBG_EXPRESSION_EVALUATION_CONTEXT; a_dbg_error_handler: DBG_ERROR_HANDLER): like last_byte_node
		require
			a_expression_attached: a_expression /= Void
			a_context_attached: a_context /= Void
			a_dbg_error_handler_attached: a_dbg_error_handler /= Void
		local
			retried: BOOLEAN

			l_byte_code: BYTE_CODE
			bak_byte_code: BYTE_CODE
			bak_cc, l_cl: CLASS_C
		do
			a_context.reset_evaluation_data
			dbg_error_handler := a_dbg_error_handler
			if not retried then
				error_handler.wipe_out

				debug ("debugger_trace_eval_data")
					io.put_string_32 ({STRING_32} "" + generator + ".get_expression_byte_node from [" + a_expression.text + "]%N")
					print (a_context.to_string)
				end
					--| If we want to recompute the `byte_node',
					--| we need to call `reset_byte_node'

				l_cl := a_context.class_c
				if l_cl /= Void then
					ast_context.clear_all

						--| backup previous data
					bak_cc := System.current_class
					bak_byte_code := Byte_context.byte_code
					if a_context.on_context and then attached a_context.feature_i as fi then
						if not l_cl.conform_to (fi.written_class) then
							debug ("debugger_trace_eval_data")
								io.put_string ("Context class {" + l_cl.name_in_upper	+ "} does not has context feature %"" + fi.feature_name + "%"%N")
							end
							--| This issue occurs for instance in {TEST}.twin
							--| where {ISE_RUNTIME} check_assert (boolean) is called
							--| at this point the context class is TEST,
							--| and the context feature is `check_assert (BOOLEAN)'
							--| but TEST doesn't conform to ISE_RUNTIME.
							l_cl := fi.written_class
							prepare_contexts (l_cl, Void)
						else
							prepare_contexts (l_cl, a_context.class_type)
						end
						System.set_current_class (l_cl)
						Ast_context.set_current_feature (fi)
						Ast_context.set_written_class (fi.written_class)
						l_byte_code := fi.byte_server.item (fi.body_index)
						if l_byte_code /= Void then
							Byte_context.set_byte_code (l_byte_code)
						end

						a_context.set_byte_code (l_byte_code)
							--| Locals and object test locals
						add_local_info_to_ast_context (fi.e_feature, ast_context, a_context)
					elseif a_context.on_object then
						prepare_contexts (l_cl, Void)
						System.set_current_class (l_cl)
						ast_context.set_written_class (l_cl)
					else
						prepare_contexts (l_cl, a_context.class_type)
						System.set_current_class (l_cl)
					end

						--| Compute and get `expression_byte_node'
					if attached a_expression.ast as l_expr_as then
						Result := byte_node_from_ast (l_expr_as, a_context)
					else
							--| How come it is Void ?
							--| for instance, expression: create {STRING}.make_empty
						dbg_error_handler.notify_error_expression_during_analyse
					end

						--| Revert Compiler context
					if bak_cc /= Void then
						System.set_current_class (bak_cc)
					end
					if bak_byte_code /= Void then
						Byte_context.set_byte_code (bak_byte_code)
					end
					Ast_context.clear_all
					error_handler.wipe_out
				else
					dbg_error_handler.notify_error_exception_context_corrupted_or_not_found
					Ast_context.clear_all
				end
			else
				a_dbg_error_handler.notify_error_expression_during_analyse
				error_handler.wipe_out
			end
			dbg_error_handler := Void
		ensure
			error_handler_cleaned: not error_handler.has_error
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: byte node	

	dbg_error_handler: DBG_ERROR_HANDLER
			-- Debugger error handler

	prepare_contexts (cl: CLASS_C; ct: CLASS_TYPE)
			-- Prepare AST shared context  with `cl' and `ct'
		require
			cl_not_void: cl /= Void
			ct_associated_to_cl: ct /= Void implies ct.associated_class.is_equal (cl)
		local
			l_ta: CL_TYPE_A
		do
			if ct /= Void then
				l_ta := ct.type
			else
				l_ta := cl.actual_type
			end
			Ast_context.initialize (cl, l_ta)
			feature_table := cl.feature_table
			if ct /= Void then
				byte_context.init (ct)
			end
			Inst_context.set_group (cl.group)
		end

	byte_node_from_ast (a_expr_as: EXPR_AS; a_context: DBG_EXPRESSION_EVALUATION_CONTEXT): like last_byte_node
			-- compute expression_byte_node from EXPR_AS `a_expr_as'
		require
			exp_attached: a_expr_as /= Void
			context_feature_not_void: a_context.on_context implies a_context.feature_i /= Void
		local
			retried: BOOLEAN
			type_check_succeed: BOOLEAN
			old_is_ignoring_export: BOOLEAN
		do
			if not retried then
				debug ("debugger_trace_eval_data")
					io.put_string (generator + ".expression_byte_node_from_ast (..) %N")
					io.put_string ("   Ast_context -> {" + ast_context.current_class.name_in_upper + "}")
					if ast_context.current_feature /= Void then
						io.put_string ("." + ast_context.current_feature.feature_name)
					end
					io.put_string ("%N")
				end

					--| compute byte node from AST
				old_is_ignoring_export := ast_context.is_ignoring_export
				Ast_context.set_is_ignoring_export (True)
				init (ast_context)
				expression_type_check_and_code (a_context.feature_i, a_expr_as)
				Ast_context.set_is_ignoring_export (old_is_ignoring_export)

					--| check results
				if error_handler.has_error then
					type_check_succeed := True
					dbg_error_handler.notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
					Result := Void
				else
					Result := last_byte_node
				end
			else
					--| revert change and notify errors
				ast_context.set_is_ignoring_export (old_is_ignoring_export)
				if not type_check_succeed then
					dbg_error_handler.notify_error_expression_type_checking_failed
				end
				if error_handler.has_error then
					dbg_error_handler.notify_error_list_expression_and_tag (error_handler.error_list)
					error_handler.wipe_out
				else
					if not dbg_error_handler.error_occurred then
						dbg_error_handler.notify_error_expression (Void)
					end
				end
				Result := Void
			end
		ensure
			error_handler_cleaned: not error_handler.has_error
		rescue
			retried := True
			retry
		end

	add_local_info_to_ast_context (f: E_FEATURE; ctx: AST_CONTEXT; a_context: DBG_EXPRESSION_EVALUATION_CONTEXT)
			-- Add local variable info to the context (local, object test locals, ...)
		require
			f_not_void: f /= Void
			ctx_attached: ctx /= Void
		local
			tu: TUPLE [id: ID_AS; li: LOCAL_INFO]
			l_name_id: INTEGER
			ct: CLASS_TYPE
			lst: detachable LIST [TUPLE [id: ID_AS; li: LOCAL_INFO]]
			l_names: HASH_TABLE [STRING, INTEGER]
			l_local_table: HASH_TABLE [LOCAL_INFO, INTEGER]
		do
			ct := a_context.class_type
			if ct = Void then
				ct := f.associated_class.types.first
			end

			l_local_table := a_context.local_table
			if l_local_table /= Void then
				ctx.set_locals (l_local_table.twin)
				ctx.init_local_scopes

				if not l_local_table.is_empty then
					--| if it failed .. let's continue anyway for now

						--| Last local is a cached value, so let's twin it
					from
						l_local_table.start
					until
						l_local_table.after
					loop
						ctx.add_local_expression_scope (l_local_table.key_for_iteration)
						l_local_table.forth
					end
				end
			else
				ctx.init_local_scopes
			end
			if f.has_return_value then
				ctx.add_result_expression_scope
			end

			lst := a_context.object_test_locals
			if lst /= Void and then	not lst.is_empty then
				from
					create l_names.make (lst.count)
					lst.start
				until
					lst.after
				loop
					tu := lst.item_for_iteration
					l_name_id := tu.id.name_id
					if l_names.has_key (l_name_id) then
						--| Same object test local name !!!
						-- For now, let's ignore it.
						-- kind of fixed bug#15708
						debug ("debugger_evaluator")
							print ("To avoid VUOT error, ignore object test local name with existing name%N")
						end
						debug ("to_implement")
							to_implement ("Support object test locals of the same name.")
						end
					else
						l_names.force (tu.id.name, l_name_id)
						ctx.add_inline_local (tu.li, tu.id)
						ctx.add_object_test_expression_scope (tu.id)
					end

					lst.forth
				end
			end
		end

feature {NONE} -- Type checking

	expression_type_check_and_code (a_feature: FEATURE_I; an_exp: EXPR_AS)
			-- Type check `an_exp' in the context of `a_feature'.
		require
			an_exp_not_void: an_exp /= Void
		local
			l_exp_call: EXPR_CALL_AS
			l_instr_as: INSTR_CALL_AS
			errlst: LIST [ERROR]
			errcur: CURSOR
			l_vkcn_error: VKCN
			l_has_vkcn_error: BOOLEAN
			l_error_level: NATURAL_32
		do
			l_error_level := error_level
			expression_or_instruction_type_check_and_code (a_feature, an_exp)
			if error_level /= l_error_level then
					--| Check if any VKCN error
				errlst := error_handler.error_list
				errcur := errlst.cursor
				from
					errlst.start
					l_has_vkcn_error := False
				until
					errlst.after or l_has_vkcn_error
				loop
					l_vkcn_error ?= errlst.item
					l_has_vkcn_error := l_vkcn_error /= Void
					errlst.forth
				end
				errlst.go_to (errcur)

					--| If any VKCN .. then let's try to check it as an instruction
				if l_has_vkcn_error then
					l_exp_call ?= an_exp
					if l_exp_call /= Void then
						error_handler.wipe_out
						create l_instr_as.initialize (l_exp_call.call)
						expression_or_instruction_type_check_and_code (a_feature, l_instr_as)
					end
				end
			end
		end

	expression_or_instruction_type_check_and_code (a_feature: FEATURE_I; an_ast: AST_EIFFEL)
			-- Type check `an_ast' in the context of `a_feature'.
		require
			an_ast_not_void: an_ast /= Void
		local
			l_cl, l_wc: CLASS_C
			l_ctx: AST_CONTEXT
			l_error_level: like error_level
		do
			reset
			is_byte_node_enabled := True
			current_feature := a_feature

			l_cl := context.current_class
			l_error_level := error_level
			if current_feature /= Void then
				l_wc := current_feature.written_class
				if l_wc /= l_cl then
						--| The context's feature is an inherited feature
						--| thus we need to first process in the ancestor to set specific
						--| data (after resolving in ancestor's context .. such as formal..)
						--| then reprocess in current class, note `is_inherited' is set to True
						--| to avoid recomputing (and lost) data computed in first processing.
					l_ctx := context.twin
					expression_context := l_ctx
					context.initialize (l_wc, l_wc.actual_type)
					context.init_attribute_scopes
					context.init_local_scopes
					type_a_checker.init_for_checking (a_feature, l_wc, Void, error_handler)
					an_ast.process (Current)
					reset
					context.restore (l_ctx)
				end
				context.init_attribute_scopes
				context.init_local_scopes
				type_a_checker.init_for_checking (a_feature, l_cl, Void, error_handler)
			end
			if l_error_level = error_level then
				an_ast.process (Current)
			end
		end

feature -- Type checking

	type_a_from_type_as (a_type_as: TYPE_AS): TYPE_A
			-- TYPE_A related to `a_type_as'.
		require
			a_type_as_attached: a_type_as /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				reset
				context.init_attribute_scopes
				context.init_local_scopes
				type_a_checker.init_for_checking (context.current_feature, context.current_class, Void, error_handler)
				check_type (a_type_as)
				Result := last_type
				error_handler.wipe_out
			end
			reset
			error_handler.wipe_out
		ensure
			error_handler_cleaned: not error_handler.has_error
		rescue
			retried := True
			retry
		end

	type_a_from_expr_as (a_expr_as: EXPR_AS): TYPE_A
			-- TYPE_A related to `a_expr_as'.
		require
			a_expr_as_attached: a_expr_as /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				reset
				context.init_attribute_scopes
				context.init_local_scopes
				type_a_checker.init_for_checking (context.current_feature, context.current_class, Void, error_handler)
				a_expr_as.process (Current)
				Result := last_type
			end
			reset
			error_handler.wipe_out
		ensure
			error_handler_cleaned: not error_handler.has_error
		rescue
			retried := True
			retry
		end

feature {AST_FEATURE_CHECKER_GENERATOR}

	is_void_safe_call: BOOLEAN
			-- <Precursor>
			-- Never check void safety for debugger's expressions.
		do
			-- Result := False
		end

	is_void_safe_initialization: BOOLEAN
			-- <Precursor>
			-- Never check void safety for debugger's expressions.
		do
			-- Result := False
		end

	is_void_safe_conformance: BOOLEAN
			-- <Precursor>
			-- Never check void safety for debugger's expressions.
		do
			-- Result := False
		end

	is_void_safe_construct: BOOLEAN
			-- <Precursor>
			-- Never check void safety for debugger's expressions.
		do
			-- Result := False
		end

feature {NONE} -- Implementation

	match_list_of_class (a_class_id: INTEGER): LEAF_AS_LIST
			-- <Precursor>
			--| The match_list is created for a class
			--| but expression analysing is not inside a class
			--| thus it returns Void
		do
			Result := Void
		end

	check_type (a_type: TYPE_AS)
			-- Evaluate `a_type' into a TYPE_A instance if valid.
			-- If not valid, raise a compiler error and return Void.
		local
			l_type: TYPE_A
			l_class_type: CLASS_TYPE_AS
			l_vtct: VTCT
			l_vd29: VD29
			l_classes: LIST [CLASS_I]
			l_cl: CLASS_I
			l_error_level: NATURAL
			context_hack_applied: BOOLEAN
		do
			l_error_level := error_level
			if is_inherited then
					-- Convert TYPE_AS into TYPE_A.
				l_type := type_a_generator.evaluate_type (a_type, context.written_class)
			else
				l_type := type_a_generator.evaluate_type (a_type, context.current_class)
			end

			if l_type = Void then
				context_hack_applied := True
				debug ("refactor_fixme")
					fixme ("2006-09-14: Is it correct to try to find the correct context ? Need more testing with class renaming. (Asked by Manu)")
				end
					-- Check about dependencies
				l_class_type ?= a_type
				if l_class_type /= Void then
					l_classes := universe.classes_with_name (l_class_type.class_name.name)
					if l_classes.count = 1 then
						l_cl := l_classes.first
						if l_cl.is_compiled then
							l_type := type_a_generator.evaluate_type (l_class_type, l_cl.compiled_class)
						end
					elseif l_classes.count > 1 then
						create l_vd29
						l_vd29.set_location (a_type.start_location)
						l_vd29.set_root_class_name (l_class_type.class_name.name)

						l_classes.start
						l_vd29.set_cluster (l_classes.item.group)
						l_classes.forth
						l_vd29.set_second_cluster_name (l_classes.item.group.name)
						error_handler.insert_error (l_vd29)
						error_handler.raise_error
					end
				end
			end

				-- Check validity of type declaration for static access
			if l_type = Void then
				create l_vtct
				l_vtct.set_class_name (a_type.dump)
				l_vtct.set_location (a_type.start_location)
				l_vtct.set_class (context.current_class)
				error_handler.insert_error (l_vtct)
				error_handler.raise_error
			else
				if is_inherited then
						-- Perform simple check that TYPE_A is valid, `l_type' should not be
						-- Void after this call since it was not Void when checking the parent
						-- class
					l_type := inherited_type_a_checker.solved (l_type, a_type)
					check l_type_not_void: l_type /= Void end
					l_type := l_type.evaluated_type_in_descendant (context.written_class,
									context.current_class, current_feature)
				else
						-- Perform simple check that TYPE_A is valid.
					l_type := type_a_checker.check_and_solved (l_type, a_type)
				end
				if error_level = l_error_level then
						-- Check validity of type declaration
					type_a_checker.check_type_validity (l_type, a_type)
						-- Update `last_type' with found type.
					last_type := l_type
				end
			end

				-- If there was an error, we simply throw an error.
			if error_level /= l_error_level then
				last_type := Void
				error_handler.raise_error
			end
		end

	feature_with_name_using (a_feature_name: ID_AS; a_feature_table: FEATURE_TABLE): FEATURE_I
			-- Feature with feature_name `a_feature_name' using among other means `a_feature_table'
		local
			cl: CLASS_C
		do
			Result := Precursor {AST_FEATURE_CHECKER_GENERATOR} (a_feature_name, a_feature_table)
			if Result = Void and then expression_context /= Void then
				cl := expression_context.current_class
				if cl /= Void then
					Result := cl.feature_of_name_id (a_feature_name.name_id)
				end
			end
		end

	process_un_old_as (l_as: UN_OLD_AS)
		local
			b: BOOLEAN
		do
			b := is_checking_postcondition
			if not b then
				set_is_checking_postcondition (True)
			end
			Precursor (l_as)
			if not b then
				set_is_checking_postcondition (b)
			end
		end

	process_access_feat_as (l_as: ACCESS_FEAT_AS)
		local
			l_dbg_err: DBG_EXPRESSION_TYPE_CHECKER_ERROR
		do
			if last_type.actual_type.is_formal and not context.current_class.is_generic then
				create l_dbg_err
				context.init_error (l_dbg_err)
				error_handler.insert_error (l_dbg_err)
			else
				Precursor {AST_FEATURE_CHECKER_GENERATOR} (l_as)
			end
		end

feature {INSPECT_CONTROL} -- AST modification

	set_routine_ids (ids: ID_SET; a: ID_SET_ACCESSOR)
			-- <Precursor/>
			--| Redefined to avoid doing the `touch' for expression evaluation
		do
			if not ids.is_equal_id_list (a) then
				a.set_routine_ids (ids)
--					-- Record that AST node is modified.
--				tmp_ast_server.touch (context.current_class.class_id)
--				is_ast_modified := True
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
