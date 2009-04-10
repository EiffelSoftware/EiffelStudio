note
	description: "Summary description for {DEBUGGER_AST_SERVER}."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_AST_SERVER

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_AST_CONTEXT
		rename
			context as ast_context
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

	object_test_locals (a_class_type: CLASS_TYPE; a_feat: E_FEATURE; a_bp, a_bp_nested: INTEGER): ARRAYED_LIST [TUPLE [id: ID_AS; type: TYPE_A]]
			-- Object test locals from `a_feat' in the context of class `a_class_type'
		require
			a_class_type /= Void
			a_feat /= Void
		do
--			if attached create {AST_DEBUGGER_OBJECT_TEST_LOCAL_VISITOR} as vis then
--				vis.get_object_test_locals (a_feat.ast)
--				if attached vis.object_test_locals as l_object_test_locals then
--						--| FIXME jfiat [2009/03/16] : we should cache `vis.object_test_locals', to avoid recomputation...
--					Result := resolved_object_test_locals (a_class_type, a_feat, l_object_test_locals)
--				end
--			end

			if attached breakable_feature_info (a_feat) as l_info then
				if attached l_info.object_test_locals as l_locals then
						--| FIXME jfiat [2009/03/16] : we should cache `vis.object_test_locals', to avoid recomputation...
					Result := resolved_object_test_locals (a_class_type, a_feat, l_locals)
				end
			end
		end

	breakable_feature_info (a_feat: E_FEATURE): detachable DBG_BREAKABLE_FEATURE_INFO
			-- Breakable info on feature `a_feat'
		local
			vis: like ast_debugger_breakable_strategy
			l_storage: like breakable_feature_info_storage
			i, j, l, u: INTEGER
			f: FEATURE_I
		do
			f := a_feat.associated_feature_i
			l_storage := breakable_feature_info_storage
			if l_storage /= Void then
				i := breakable_feature_info_index (f)
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

	resolved_object_test_locals (a_class_type: CLASS_TYPE; a_feat: E_FEATURE; a_ot_lst: LIST [DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO]): ARRAYED_LIST [TUPLE [id: ID_AS; type: TYPE_A]]
			-- Object test locals from `a_feat' in the context of class `a_class_type'
		require
			a_ot_lst_attached: a_ot_lst /= Void
			a_class_type /= Void
			a_feat /= Void
		local
			type_vis: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR
			l_item: DBG_BREAKABLE_OBJECT_TEST_LOCAL_INFO
			l_type_as: TYPE_AS
			l_cl_type_a: CL_TYPE_A
			l_type_a: TYPE_A
			fi: FEATURE_I
			li: LOCAL_INFO
			l_old_ast_context, l_ast_context: like ast_context
			retried: BOOLEAN
			cl: CLASS_C
			l_locals: HASH_TABLE [LOCAL_INFO, INTEGER]
		do
			if not retried then
					--| FIXME jfiat [2009/03/16] : we should cache `vis.object_test_locals', to avoid recomputation...
				create type_vis
				l_ast_context := ast_context
				if l_ast_context.current_class /= Void then
					l_old_ast_context := l_ast_context.save
				else
					l_old_ast_context := l_ast_context.twin
				end
				if a_class_type = Void then
					cl := a_feat.associated_class
					l_cl_type_a := cl.actual_type
				else
					cl := a_class_type.associated_class
					l_cl_type_a := a_class_type.type
				end
				fi := a_feat.associated_feature_i
				l_ast_context.clear_all
				l_ast_context.initialize (cl, l_cl_type_a, cl.feature_table)
				l_ast_context.set_current_feature (fi)

				l_locals := type_vis.locals_builder.local_table (cl, fi, fi.real_body)
				if l_locals /= Void then
					l_ast_context.set_locals (l_locals)
				end
				type_vis.init (l_ast_context)
				type_vis.set_current_feature (a_feat.associated_feature_i)
				from
					create Result.make (a_ot_lst.count)
					a_ot_lst.start
				until
					a_ot_lst.after
				loop
					l_item := a_ot_lst.item
					if l_item /= Void then
						l_type_as := l_item.type
						if l_type_as /= Void then
							l_type_a := type_vis.type_a_from_type_as (l_type_as)
						else
							l_type_a := type_vis.type_a_from_expr_as (a_ot_lst.item.expression)
						end
						Result.force ([l_item.name_id, l_type_a])
						create li
						li.set_position (l_ast_context.next_object_test_local_position)
						li.set_type (l_type_a)
						li.set_is_used (True)

						l_ast_context.add_object_test_local (li, l_item.name_id)
						l_ast_context.add_object_test_expression_scope (l_item.name_id)
					else
						check should_not_occur: False end
					end
					a_ot_lst.forth
				end
				l_ast_context.restore (l_old_ast_context)
			else
				if l_ast_context /= Void and l_old_ast_context /= Void then
					l_ast_context.restore (l_old_ast_context)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	ast_debugger_breakable_strategy: detachable AST_DEBUGGER_BREAKABLE_STRATEGY
			-- Visitor to get debugger's data from AST

	breakable_feature_info_index (a_feat: FEATURE_I): INTEGER
			-- Is already computed, return index of result for `a_feat'
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
						l_item.class_id = a_feat.written_in
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
				create l_storage.make (1, capacity)
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

	breakable_feature_info_storage: ARRAY [DBG_BREAKABLE_FEATURE_INFO]
			-- storage to cache/queue results

	breakable_feature_info_storage_index: INTEGER
			-- current index for FIFO `breakable_feature_info_storage'

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
