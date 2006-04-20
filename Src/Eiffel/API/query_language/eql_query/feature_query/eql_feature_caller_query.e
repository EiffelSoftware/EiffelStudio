indexing
	description: "Object that represents a query for different kinds of callers in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE_CALLER_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

	EQL_CLASS_DESCENDANTS

feature -- Status report

	to_show_all_callers: BOOLEAN;
			-- Is the format going to show all callers?

	flag: INTEGER_8
			-- Type of callers we are looking for.

feature -- Status setting

	set_all_callers is
			-- Set `to_show_all_callers' with True;
		do
			to_show_all_callers := True
		ensure
			show_all_callers: to_show_all_callers
		end

	set_flag (a_flag: INTEGER_8) is
			-- Set `flag' with `a_flag'.
		do
			flag := a_flag
		ensure
			flag_set: flag = a_flag
		end

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_CALLER]
			-- Last Result

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_feature: EQL_FEATURE
		do
			if a_single_scope.is_feature_scope then
				l_feature ?= a_single_scope
				if to_show_all_callers then
					find_all_callers (l_feature.e_feature, a_criterion)
				else
					find_current_callers (l_feature.e_feature, a_criterion)
				end
			end
		end

feature {NONE} -- Implementation

	find_current_callers (a_feat: E_FEATURE; a_criterion: EQL_CRITERION) is
			-- Find all callers of `l_feat'.
		require
			a_feat_not_void: a_feat /= Void
			last_result_not_void: last_result /= Void
			a_criterion_not_void: a_criterion /= Void
		local
			clients: ARRAYED_LIST [CLASS_C]
			client: CLASS_C
			list: SORTED_LIST [STRING]
			l_ctxt: EQL_CONTEXT
			l_invariant_name: STRING
			l_feat: E_FEATURE
			l_inv: INVARIANT_AS
			l_is_feature: BOOLEAN
			l_caller: EQL_CALLER
		do
			l_invariant_name := "_invariant"
			clients := a_feat.associated_class.clients
			create l_ctxt
			from
				clients.start
			until
				clients.after
			loop
				client := clients.item
				list := a_feat.callers (client, flag)
				if list /= Void then
					from
						list.start
					until
						list.after
					loop
						if list.item.is_equal (l_invariant_name) then
							l_inv := client.invariant_ast
							l_ctxt.set_invariant_part (l_inv)
							l_is_feature := False
						else
							l_feat := client.feature_with_name (list.item)
							l_ctxt.set_e_feature (l_feat)
							l_is_feature := True
						end
						if a_criterion.evaluate (l_ctxt) then
							if l_is_feature then
								create {EQL_FEATURE}l_caller.make_with_feature (l_feat)
							else
								create {EQL_INVARIANT}l_caller.make_with_invariant (l_inv)
							end
							last_result.extend (create {EQL_TREE_NODE [EQL_CALLER]}.make_with_data (last_result, l_caller))
						end
						list.forth
					end
				end
				clients.forth
			end
		end

	find_all_callers (a_feat: E_FEATURE; a_criterion: EQL_CRITERION) is
			-- Find all the callers of `a_feat' and its descendants.
		require
			to_show_all_callers: to_show_all_callers
			a_feat_not_void: a_feat /= Void
			last_result_not_void: last_result /= Void
			a_criterion_not_void: a_criterion /= Void
		local
			l_feat: E_FEATURE
			a_class: CLASS_C
			rid: INTEGER
			l_descendants: LIST [CLASS_C]
		do
			rid := a_feat.rout_id_set.item (1)
			l_descendants := recursive_classes (a_feat.associated_class)

			from
				l_descendants.start
			until
				l_descendants.after
			loop
				a_class := l_descendants.item
				if a_class.has_feature_table then
					l_feat := a_class.feature_with_rout_id (rid)
						-- FIXME: Manu: 03/25/2004:
						-- Temporary fix for .NET as .NET classes don't have yet
						-- the routine of ANY
					debug ("FIXME") check fixme: False end end
					if l_feat /= Void then
						find_current_callers (l_feat, a_criterion)
					end
				end
				l_descendants.forth
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
