indexing
	description: "[
					Criterion to test whether or not a feature is called by another feature

					This criterion will use `data' attribute in every QL_FEATURE candidate object.
					IF a QL_FEATURE candidate is satisfied by this criterion. it's `data' attribute will
					be set with actual caller version which is also a QL_FEATURE object. This means
					the caller stored in `data' calls the callee (which is the current candidate feature).
					
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_CALLER_IS_CRI

inherit
	QL_FEATURE_HIERARCHY_CRI
		rename
			make as old_make
		redefine
			reset,
			intrinsic_domain,
			is_satisfied_by_internal
		end

create
	make

feature{NONE} -- Initialization

	make (a_feature: like criterion_domain; a_caller_type: like caller_type; only_current_version: BOOLEAN) is
			-- Initialize `criterion_domain' with `a_feature' and `caller_type' with `a_caller_type'.
			-- if `only_current_version' is True, only find callers of current version of features in `a_feature'.
		require
			a_feature_attached: a_feature /= Void
			a_caller_type_attached: a_caller_type /= Void
		do
			only_find_current_version := only_current_version
			caller_type := a_caller_type
			old_make (a_feature)
		end

feature -- Status report

	caller_type: QL_FEATURE_CALLEE_TYPE
			-- Feature caller type

	only_find_current_version: BOOLEAN
			-- Only caller of current versions (not descendant versions) of features in `criterion_domain'?

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_FEATURE_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		local
			l_user_data_list: like user_data_list
			l_feature_list: like feature_list
			l_feature: QL_FEATURE
			l_invariant_list: like invariant_list
			l_branch_id: INTEGER
			l_current_domain: like source_domain
			l_invariant_callee: like callee_list_for_invariant
			l_feature_callee: like callee_list_for_feature
		do
				-- For normal feature callers
			l_current_domain := source_domain
			l_feature_callee := callee_list_for_feature
			l_feature_list := feature_list
			create Result.make
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_feature := l_current_domain.feature_item_from_current_domain (l_feature_list.item)
				if l_feature /= Void then
					l_feature.set_data (l_current_domain.feature_item_from_current_domain (l_feature_callee.i_th (l_feature_list.index)))
					Result.extend (l_feature)
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
					l_feature := l_current_domain.invariant_item_from_current_domain (l_invariant_list.item)
					if l_feature /= Void then
						l_feature.set_data (l_current_domain.feature_item_from_current_domain (l_invariant_callee.item))
						Result.extend (l_feature)
					end
					l_invariant_list.forth
					l_invariant_callee.forth
				end
			end
		end

feature{NONE} -- Implementation

	find_result is
			-- Find callers to `criterion_domain'.
		do
			find_all_callees (caller_type.type)
		end

	find_current_callees (l_feat: E_FEATURE; a_flag: INTEGER_8) is
			-- Find callees of `l_feat'.
		require
			l_feat_not_void: l_feat /= Void
		local
			cfeat: STRING
			list: SORTED_LIST [STRING]
			invariant_name: STRING
			l_invariant_list: like invariant_list
			l_feature_list: like feature_list
			l_branch_id_list: like user_data_list
			l_invariant_callee: like callee_list_for_invariant
			l_feature_callee: like callee_list_for_feature
			l_callees: LIST [TUPLE [class_c: CLASS_C; feature_name: STRING]]
		do
			l_invariant_list := invariant_list
			l_feature_list := feature_list
			l_branch_id_list := user_data_list
			invariant_name := "_invariant"
			l_callees := l_feat.callees (a_flag)
			l_invariant_callee := callee_list_for_invariant
			l_feature_callee := callee_list_for_feature
			if l_callees /= Void then
				from
					l_callees.start
				until
					l_callees.after
				loop
					cfeat := l_callees.item.feature_name
					if cfeat.is_equal (invariant_name) then
						l_invariant_list.extend (l_callees.item.class_c)
						l_invariant_callee.extend (l_feat)
					else
						l_feature_list.extend (l_callees.item.class_c.feature_with_name (cfeat))
						l_feature_callee.extend (l_feat)
						l_branch_id_list.extend (1)
					end
					l_callees.forth
				end
			end
		end

	find_all_callees (a_flag: INTEGER_8) is
			-- Find all callees from every feature in `criterion_domain'.
		local
			descendants: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			a_feat: E_FEATURE
			a_class: CLASS_C
			a_list: ARRAYED_LIST [E_FEATURE]
			rid: INTEGER
			l_feature_domain: like features_from_domain
			l_feature: QL_FEATURE
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
						create descendants.make
						rid := l_feature.e_feature.rout_id_set.item (1)
						if not only_find_current_version then
							record_descendants (descendants, l_feature.e_feature.associated_class)
						else
							descendants.extend (l_feature.e_feature.associated_class)
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
									a_list.extend (a_feat)
								end
							end
							descendants.forth
						end

						from
							a_list.start
						until
							a_list.after
						loop
							find_current_callees (a_list.item, a_flag)
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
						a_item.set_data (
							l_current_domain.feature_item_from_current_domain (
								l_feature_callee.i_th (l_feature_list.index)))
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
					if a_item.class_c.class_id = l_invariant_list.item.class_id then
						a_item.set_data (
							l_current_domain.feature_item_from_current_domain (
								l_invariant_callee.i_th (l_invariant_list.index)))
						Result := True
					end
					l_invariant_list.forth
				end
			end
		end

invariant
	caller_type_attached: caller_type /= Void
	invariant_list_attached: invariant_list /= Void
	callee_list_for_invariant_attached: callee_list_for_invariant /= Void
	callee_list_for_invariant_invariant_list_valid: callee_list_for_invariant.count = invariant_list.count
	callee_list_for_feature_attached: callee_list_for_feature /= Void
	callee_list_for_feature_invariant_list_valid: callee_list_for_feature.count = feature_list.count

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
