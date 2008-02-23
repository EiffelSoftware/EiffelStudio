indexing
	description: "Perform type checking for debugger's expression evaluator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR

inherit
	AST_FEATURE_CHECKER_GENERATOR
		redefine
			reset,
			process_un_old_as,
			process_access_feat_as,
			check_type,
			feature_with_name_using
		end

feature -- Settings

	reset is
			-- Reset all attributes to their default value
		do
			Precursor {AST_FEATURE_CHECKER_GENERATOR}
			expression_context := Void
		end

feature -- Properties

	expression_context: AST_CONTEXT
			-- Saved original Ast context when processing in the ancestor's context.

feature -- Type checking

	expression_type_check_and_code (a_feature: FEATURE_I; an_exp: EXPR_AS) is
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

	expression_or_instruction_type_check_and_code (a_feature: FEATURE_I; an_ast: AST_EIFFEL) is
			-- Type check `an_ast' in the context of `a_feature'.
		require
			an_ast_not_void: an_ast /= Void
		local
			l_cl, l_wc: CLASS_C
			l_ft: FEATURE_TABLE
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
					l_ft := context.current_feature_table
					l_ctx := context.twin
					expression_context := l_ctx
					context.initialize (l_wc, l_wc.actual_type, l_ft)
					type_a_checker.init_for_checking (a_feature, l_wc, Void, error_handler)
					an_ast.process (Current)
					reset
					is_inherited := True
					context.restore (l_ctx)
				end
				type_a_checker.init_for_checking (a_feature, l_cl, Void, error_handler)
			end
			if l_error_level = error_level then
				an_ast.process (Current)
			end
		end

feature {NONE} -- Implementation

	check_type (a_type: TYPE_AS) is
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
				l_type := type_a_generator.evaluate_type_if_possible (a_type, context.written_class)
			else
				l_type := type_a_generator.evaluate_type_if_possible (a_type, context.current_class)
			end

			if l_type = Void then
				context_hack_applied := True
				fixme ("2006-09-14: Is it correct to try to find the correct context ? Need more testing with class renaming. (Asked by Manu)")
					-- Check about dependencies
				l_class_type ?= a_type
				if l_class_type /= Void then
					l_classes := universe.classes_with_name (l_class_type.class_name.name)
					if l_classes.count = 1 then
						l_cl := l_classes.first
						if l_cl.is_compiled then
							l_type := type_a_generator.evaluate_type_if_possible (l_class_type, l_cl.compiled_class)
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

	process_un_old_as (l_as: UN_OLD_AS) is
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

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
