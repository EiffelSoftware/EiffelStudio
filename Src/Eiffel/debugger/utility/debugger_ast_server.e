note
	description: "AST server for debugger."

class
	DEBUGGER_AST_SERVER

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_capacity: like capacity)
		require
			a_capacity_positive: a_capacity > 0
		do
			capacity := a_capacity
		end

feature -- Acces

	capacity: INTEGER
			-- Capacity of the FIFO storage

	reset
		do
			if attached breakable_feature_info_storage as l_storage then
				l_storage.clear_all
				breakable_feature_info_storage_index := breakable_feature_info_storage.lower
			end
		end

feature -- Report

	local_table (a_feat: E_FEATURE): detachable HASH_TABLE [LOCAL_INFO, INTEGER]
			-- locals from `a_feat' in the context of class `a_class_type'
		require
			a_feat /= Void
		local
			l_breakable_feature_info: detachable DBG_BREAKABLE_FEATURE_INFO
		do
			l_breakable_feature_info := breakable_feature_info (a_feat)
			if l_breakable_feature_info /= Void then
				if l_breakable_feature_info /= Void and then not l_breakable_feature_info.resolved then
					resolve_breakable_feature_info (l_breakable_feature_info)
				end
				Result := l_breakable_feature_info.local_table
			end
		end

	object_test_locals (a_feat: E_FEATURE; a_bp, a_bp_nested: INTEGER): ARRAYED_LIST [TUPLE [id: ID_AS; li: LOCAL_INFO]]
			-- Object test locals from `a_feat'
		require
			a_feat /= Void
		local
			l_breakable_feature_info: detachable DBG_BREAKABLE_FEATURE_INFO
		do
			l_breakable_feature_info := breakable_feature_info (a_feat)
			if l_breakable_feature_info /= Void then
				if l_breakable_feature_info /= Void and then not l_breakable_feature_info.resolved then
					resolve_breakable_feature_info (l_breakable_feature_info)
				end
				Result := l_breakable_feature_info.object_test_locals_resolved
			end
		end

	breakable_feature_info (a_feat: E_FEATURE): detachable DBG_BREAKABLE_FEATURE_INFO
			-- Breakable info on feature `a_feat'
		require
			a_feat_attached: a_feat /= Void
		local
			vis: like ast_debugger_breakable_strategy
			l_storage: like breakable_feature_info_storage
			i, j, l, u: INTEGER
			f: FEATURE_I
			cl_id: INTEGER
		do
			f := a_feat.associated_feature_i
			cl_id := a_feat.associated_class.class_id
			l_storage := breakable_feature_info_storage
			if l_storage /= Void then
				i := breakable_feature_info_index (f, cl_id)
				if i > 0 then
					check valid_index: l_storage.valid_index (i) end
					Result := l_storage [i]
					if i /= breakable_feature_info_storage_index then
						from
							j := i + 1
							l := l_storage.lower
							u := l_storage.upper
						until
							i = breakable_feature_info_storage_index
						loop
							if i = u then
								j := l
								l_storage [i] := l_storage [j]
							else
								l_storage [i] := l_storage [j]
							end
--							l_storage [j] := Void
							i := j
							j := i + 1
						end
						l_storage [breakable_feature_info_storage_index] := Result
					end
				end
			end
			if Result = Void then
				create Result.make (a_feat)
				vis := ast_debugger_breakable_strategy
				if vis = Void then
					create vis.make
					ast_debugger_breakable_strategy := vis
				end
				vis.get_breakable_info (f, a_feat.associated_class, Result)
				record_breakable_feature_info (Result)
			end
		end

	resolve_breakable_feature_info (a_bfi: DBG_BREAKABLE_FEATURE_INFO)
		require
			a_bfi_attached: a_bfi /= Void
			a_bfi_not_yet_resolved: not a_bfi.resolved
		local
			i: INTEGER
			l_old_ast_context, l_ast_context: like ast_context
			fi: FEATURE_I
			cl: CLASS_C
			l_local_table_resolved: like local_table
			l_object_test_locals_resolved: like object_test_locals

			l_locals: LIST [TUPLE [id: INTEGER; type: detachable TYPE_AS]]
			l_loc: TUPLE [id: INTEGER; type: TYPE_AS]

			l_object_test_locals: detachable LIST [DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO]
			l_ot_loc: DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO

			l_id: ID_AS
			l_name_id: INTEGER
			l_cl_type_a: CL_TYPE_A
			l_solved_type_a: detachable TYPE_A
			li: LOCAL_INFO
			l_feat_tbl: FEATURE_TABLE
			l_dbg_type_checker: like dbg_type_checker
			l_type_a_checker: like type_a_checker
			l_type_a_generator: like type_a_generator
			retried: BOOLEAN
		do
			if not retried then
				l_ast_context := ast_context
				if l_ast_context.current_class /= Void then
					l_old_ast_context := l_ast_context.save
				else
					l_old_ast_context := l_ast_context.twin
				end

				fi := a_bfi.feature_i
				cl := a_bfi.class_c
				l_cl_type_a := cl.actual_type
				l_feat_tbl := cl.feature_table --| fi.written_class.feature_table

				l_ast_context.clear_all
				l_ast_context.initialize (cl, l_cl_type_a)
				l_ast_context.set_current_feature (fi)

				l_type_a_checker := type_a_checker
				l_type_a_generator := type_a_generator

				l_dbg_type_checker := dbg_type_checker
				l_dbg_type_checker.init (l_ast_context)
				l_dbg_type_checker.set_current_feature (fi)

				l_type_a_checker.init_for_checking (fi, l_feat_tbl.associated_class, Void, Void)

				l_locals := a_bfi.locals
				if l_locals /= Void then
					from
						create l_local_table_resolved.make (l_locals.count)
						a_bfi.set_local_table (l_local_table_resolved)
						l_locals.start
						i := 1
					until
						l_locals.after
					loop
						l_loc := l_locals.item
						if attached l_loc.type as l_type_as then
							l_solved_type_a := l_type_a_generator.evaluate_type (l_type_as, cl)
							l_solved_type_a := l_type_a_checker.solved (l_solved_type_a, l_type_as)
						else
							l_solved_type_a := eiffel_project.workbench.system.any_type
						end
						l_name_id := l_loc.id
						create li.make (l_solved_type_a, i)
						l_local_table_resolved.put (li, l_name_id)
						l_locals.forth
						i := i + 1
					end
				end
				if l_local_table_resolved /= Void then
					l_ast_context.set_locals (l_local_table_resolved.twin)
				end

				l_object_test_locals := a_bfi.object_test_locals
				if l_object_test_locals /= Void then
					from
						create l_object_test_locals_resolved.make (l_object_test_locals.count)
						a_bfi.set_object_table_locals_resolved (l_object_test_locals_resolved)
						l_object_test_locals.start
					until
						l_object_test_locals.after
					loop
						l_ot_loc := l_object_test_locals.item
						if l_ot_loc /= Void then
							if attached l_ot_loc.type as t then
								l_solved_type_a := l_dbg_type_checker.type_a_from_type_as (t)
							elseif attached l_ot_loc.expression as e then
								l_solved_type_a := l_dbg_type_checker.type_a_from_expr_as (e)
							else
								l_solved_type_a := eiffel_project.workbench.system.any_type
							end
							l_id := l_ot_loc.name_id
							create li.make (l_solved_type_a, l_ast_context.next_inline_local_position)
							l_object_test_locals_resolved.force ([l_id, li])
							l_ast_context.add_inline_local (li, l_id)
							l_ast_context.add_object_test_expression_scope (l_id)
						else
							check should_not_occur: False end
						end
						l_object_test_locals.forth
					end
				end
				l_ast_context.restore (l_old_ast_context)
			else
				if l_ast_context /= Void and l_old_ast_context /= Void then
					l_ast_context.restore (l_old_ast_context)
				end
			end
			a_bfi.set_resolved (True)
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	dbg_type_checker: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR
		once
			create Result
		end

	ast_debugger_breakable_strategy: detachable AST_DEBUGGER_BREAKABLE_STRATEGY
			-- Visitor to get debugger's data from AST

	breakable_feature_info_index (a_feat: FEATURE_I; a_cl_id: INTEGER): INTEGER
			-- If already computed, return index of result for `a_feat'
			-- from `breakable_feature_info_storage'	
		local
			i: INTEGER
			l_storage: like breakable_feature_info_storage
			l_item: DBG_BREAKABLE_FEATURE_INFO
		do
			l_storage := breakable_feature_info_storage
			if l_storage /= Void then
				from
					i := l_storage.lower
				until
					i > l_storage.upper or Result > 0
				loop
					l_item := l_storage[i]
					if
						l_item /= Void and then
						l_item.feature_id = a_feat.feature_id and then
						l_item.class_id = a_cl_id
--						l_item.class_id = a_feat.written_in
					then
						Result := i
					end
					i := i + 1
				end
			end
		ensure
			Result_is_valid: Result = 0 xor attached breakable_feature_info_storage as el_storage and then el_storage.valid_index (Result)
		end

	record_breakable_feature_info (a_info: like breakable_feature_info)
			-- Record `a_info' into `breakable_feature_info_storage'
		require
			a_info_attached: a_info /= Void
		local
			l_storage: like breakable_feature_info_storage
		do
			l_storage := breakable_feature_info_storage
			if l_storage = Void then
				create l_storage.make_filled (Void, 1, capacity)
				breakable_feature_info_storage := l_storage
				breakable_feature_info_storage_index := 1
			end
			if l_storage [breakable_feature_info_storage_index] /= Void then
				if breakable_feature_info_storage_index = l_storage.upper then
					breakable_feature_info_storage_index := l_storage.lower
				else
					breakable_feature_info_storage_index := breakable_feature_info_storage_index + 1
				end
			end
			l_storage [breakable_feature_info_storage_index] := a_info
		end

	breakable_feature_info_storage: ARRAY [detachable DBG_BREAKABLE_FEATURE_INFO]
			-- storage to cache/queue results

	breakable_feature_info_storage_index: INTEGER
			-- current index for FIFO `breakable_feature_info_storage'

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
