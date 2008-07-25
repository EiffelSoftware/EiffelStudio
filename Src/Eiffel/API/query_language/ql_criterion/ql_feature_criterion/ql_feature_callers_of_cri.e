indexing
	description: "[
					Criterion to test whether or not a feature is caller of another feature
					
					This criterion will use `data' attribute in every QL_FEATURE candidate object.
					IF a QL_FEATURE candidate is satisfied by this criterion. it's `data' attribute will
					be set with actual callee version which is also a QL_FEATURE object. This means
					the caller (which is the current candidate feature) calls the callee stored in `data'.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_CALLERS_OF_CRI

inherit
	QL_FEATURE_HIERARCHY_CRI
		rename
			make as old_make
		redefine
			reset,
			intrinsic_domain
		end

	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

create
	make

feature{NONE} -- Initialization

	make (a_feature: like criterion_domain; a_caller_type: like caller_type; only_current_version: BOOLEAN) is
			-- Initialize `criterion_domain' with `a_feature' and `caller_type' with `a_caller_type'.
			-- if `only_current_version' is True, only find callers of current version of features in `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_caller_type_valid: is_caller_type_valid (a_caller_type)
		do
			only_find_current_version := only_current_version
			caller_type := a_caller_type
			old_make (a_feature)
		ensure
			caller_type_set: caller_type = a_caller_type
			only_find_current_version_set: only_find_current_version = only_current_version
		end

feature -- Status report

	caller_type: NATURAL_16
			-- Feature caller type

	only_find_current_version: BOOLEAN
			-- Only caller of current versions (not descendant versions) of features in `criterion_domain'?

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_FEATURE_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		local
			l_feature_list: like feature_list
			l_feature: QL_FEATURE
			l_invariant_list: like invariant_list
			l_branch_id: INTEGER
			l_current_domain: like source_domain
			l_invariant_callee: like callee_list_for_invariant
			l_feature_callee: like callee_list_for_feature
			l_data_feature: QL_FEATURE
			l_e_feature: E_FEATURE
			l_generator: like used_in_domain_generator
		do
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
				-- For normal feature callers
			l_current_domain := source_domain
			l_current_domain.clear_cache
			l_feature_callee := callee_list_for_feature
			l_feature_list := feature_list
			l_generator := used_in_domain_generator
			create Result.make
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_e_feature := l_feature_list.item
				if l_e_feature /= Void then
					l_feature := query_feature_item (l_e_feature)
					l_data_feature := query_feature_item (l_feature_callee.i_th (l_feature_list.index))
					l_feature.set_data (l_data_feature)
					Result.extend (l_feature)
					l_generator.increase_internal_counter (l_feature)
				end
				l_feature_list.forth
			end
				-- For invariant callers
			l_invariant_list := invariant_list
			l_invariant_callee := callee_list_for_invariant
			if not l_invariant_list.is_empty then
				l_branch_id := 1
				from
					l_invariant_list.start
					l_invariant_callee.start
				until
					l_invariant_list.after
				loop
					l_feature := query_invariant_item (l_invariant_list.item)
					l_data_feature := query_feature_item (l_invariant_callee.item)
					l_feature.set_data (l_data_feature)
					Result.extend (l_feature)
					l_generator.increase_internal_counter (l_feature)
					l_invariant_list.forth
					l_invariant_callee.forth
				end
			end
		end

feature{NONE} -- Implementation

	find_result is
			-- Find callers to `criterion_domain'.
		do
			find_all_callers (caller_type)
			is_intrinsic_domain_cached_in_domain_generator := False
		end

	find_current_callers (l_class: CLASS_C; l_feat: E_FEATURE; a_flag: like caller_type) is
			-- Show the callers of `l_feat' in `l_class'.
		require
			l_class_not_void: l_class /= Void
			l_feat_not_void: l_feat /= Void
		local
			clients: ARRAYED_LIST [CLASS_C]
			cfeat: STRING
			client: CLASS_C
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_I]
			list: SORTED_LIST [STRING]
			table: HASH_TABLE [SORTED_LIST [STRING], INTEGER]
			invariant_name: STRING
			l_invariant_list: like invariant_list
			l_feature_list: like feature_list
			l_branch_id_list: like user_data_list
			l_invariant_callee: like callee_list_for_invariant
			l_feature_callee: like callee_list_for_feature
			l_domain_generator: like used_in_domain_generator
		do
			l_invariant_list := invariant_list
			l_feature_list := feature_list
			l_branch_id_list := user_data_list
			invariant_name := "_invariant"
			clients := l_class.clients
			create table.make (20)
			create classes.make
			l_domain_generator := used_in_domain_generator
			from
				clients.start
			until
				clients.after
			loop
				client := clients.item
				list := l_feat.callers (client, a_flag)
				if list /= Void then
					table.put (list, client.class_id)
					classes.put_front (client.lace_class)
				end
				clients.forth
				l_domain_generator.increase_internal_counter (Void)
			end
			l_invariant_callee := callee_list_for_invariant
			l_feature_callee := callee_list_for_feature
			from
				classes.sort
				classes.start
			until
				classes.after
			loop
				client := classes.item.compiled_representation
				from
					list := table.item (client.class_id)
					list.start
				until
					list.after
				loop
					cfeat := list.item
					if cfeat.is_equal (invariant_name) then
						l_invariant_list.extend (client)
						l_invariant_callee.extend (l_feat)
						l_domain_generator.increase_internal_counter (Void)
					else
						l_feature_list.extend (client.feature_with_name (cfeat))
						l_feature_callee.extend (l_feat)
						l_branch_id_list.extend (1)
						l_domain_generator.increase_internal_counter (Void)
					end
					list.forth
				end
				classes.forth
			end
		end

	find_all_callers (a_flag: like caller_type) is
			-- Show all the callers of `criterion_domain' and its descendants.
		local
			descendants: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			a_feat: E_FEATURE
			a_class: CLASS_C
			a_list: ARRAYED_LIST [CELL2 [CLASS_C,E_FEATURE]]
			cell: CELL2 [CLASS_C,E_FEATURE]
			rid: INTEGER
			l_feature_domain: like features_from_domain
			l_feature: QL_FEATURE
			l_e_feature: E_FEATURE
		do
			l_feature_domain := features_from_domain (criterion_domain)
			if not l_feature_domain.is_empty then
				from
					l_feature_domain.start
				until
					l_feature_domain.after
				loop
					l_feature := l_feature_domain.item
					if l_feature.is_real_feature then
						l_e_feature := l_feature.e_feature
						create descendants.make
						rid := l_e_feature.rout_id_set.item (1)
						if not only_find_current_version then
							record_descendants (descendants, l_e_feature.associated_class)
						else
							descendants.extend (l_e_feature.associated_class)
						end
						from
							create a_list.make (descendants.count)
							a_list.start
							descendants.start
						until
							descendants.after
						loop
							a_class := descendants.item
							if a_class.has_feature_table then
								a_feat := a_class.feature_with_rout_id (rid)
									-- FIXME: Manu: 03/25/2004:
									-- Temporary fix for .NET as .NET classes don't have yet
									-- the routine of ANY
								debug ("FIXME") check fixme: False end end
								if a_feat /= Void then
									create cell.make (a_class, a_feat)
									a_list.extend (cell)
								end
							end
							descendants.forth
						end

						from
							a_list.start
						until
							a_list.after
						loop
							cell := a_list.item
							find_current_callers (cell.item1, cell.item2, a_flag)
							a_list.forth
						end
					end
					l_feature_domain.forth
				end
			end
		end

	reset is
			-- Reset internal data structure.
		do
			Precursor
			if invariant_list = Void then
				create {ARRAYED_LIST [CLASS_C]}invariant_list.make (20)
			else
				invariant_list.wipe_out
			end
			if callee_list_for_invariant = Void then
				create {ARRAYED_LIST [E_FEATURE]}callee_list_for_invariant.make (20)
			else
				callee_list_for_invariant.wipe_out
			end
			if callee_list_for_feature = Void then
				create {ARRAYED_LIST [E_FEATURE]}callee_list_for_feature.make (20)
			else
				callee_list_for_feature.wipe_out
			end
		ensure then
			invariant_list_attached: invariant_list /= Void
			invariant_list_is_empty: invariant_list.is_empty
			callee_list_for_invariant_attached: callee_list_for_invariant /= Void
			callee_list_for_invariant_is_empty: callee_list_for_invariant.is_empty
			callee_list_for_feature_attached: callee_list_for_feature /= Void
			callee_list_for_feature_is_empty: callee_list_for_feature.is_empty
		end

	invariant_list: LIST [CLASS_C]
			-- List of invariant which are callers to `criterion_domain'

	callee_list_for_invariant: LIST [E_FEATURE]
			-- Internal callee list of an invariant

	callee_list_for_feature: LIST [E_FEATURE]
			-- Internal callee list of a feature

feature{NONE} -- Evaluate

	is_satisfied_by_internal (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_invariant_list: like invariant_list
			l_branch_id: INTEGER
			l_feature_callee: like callee_list_for_feature
			l_invariant_callee: like callee_list_for_invariant
			l_user_data_list: like user_data_list
			l_feature_list: like feature_list
			l_feature: E_FEATURE
			l_current_domain: like source_domain
		do
			l_current_domain := source_domain
			if a_item.is_real_feature then
					-- For normal feature
				l_feature_callee := callee_list_for_feature
				l_user_data_list := user_data_list
				l_feature_list := feature_list
				l_feature := a_item.e_feature
				check l_feature /= Void end
				from
					l_feature_list.start
				until
					l_feature_list.after or Result
				loop
					if l_feature_list.item.same_as (l_feature) then
						a_item.set_data (query_feature_item (l_feature_callee.i_th (l_feature_list.index)))
						Result := True
					end
					l_feature_list.forth
				end
			else
					-- For invariant
				l_invariant_list := invariant_list
				l_invariant_callee := callee_list_for_invariant
				l_branch_id := 1
				from
					l_invariant_list.start
				until
					l_invariant_list.after or Result
				loop
					if a_item.written_class.class_id = l_invariant_list.item.class_id then
						a_item.set_data (query_feature_item (l_invariant_callee.i_th (l_invariant_list.index)))
						Result := True
					end
					l_invariant_list.forth
				end
			end
		end

invariant
	caller_type_valid: is_caller_type_valid (caller_type)
	feature_callee_valid:
		(callee_list_for_feature /= Void and then feature_list /= Void) implies (callee_list_for_feature.count = feature_list.count)
	invariant_callee_valid:
		(callee_list_for_invariant /= Void and then invariant_list /= Void) implies (callee_list_for_invariant.count = invariant_list.count)

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
