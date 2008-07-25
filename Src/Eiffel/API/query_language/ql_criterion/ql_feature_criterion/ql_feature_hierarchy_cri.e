indexing
	description: "Object that represents a criterion for feature hierarchy relationship"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_FEATURE_HIERARCHY_CRI

inherit
	QL_INTRINSIC_DOMAIN_CRITERION
		redefine
			is_satisfied_by
		end

	QL_FEATURE_CRITERION
		undefine
			has_inclusive_intrinsic_domain,
			require_compiled,
			process
		redefine
			intrinsic_domain
		end

	QL_UTILITY

feature -- Evaluate

	is_satisfied_by (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		do
			check
				a_item.is_compiled
			end
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			if
				has_intrinsic_domain and then
				used_in_domain_generator.is_temp_domain_used and then
				not is_intrinsic_domain_cached_in_domain_generator
			then
				cache_intrinsic_domain
			end
			Result := is_satisfied_by_internal (a_item)
		end

feature{QL_DOMAIN} -- Intrinsic domain

	intrinsic_domain: QL_FEATURE_DOMAIN is
			-- Intrinsic_domain which can be inferred from current criterion
		local
			l_user_data_list: like user_data_list
			l_feature_list: like feature_list
			l_feature: QL_FEATURE
			l_generator: like used_in_domain_generator
		do
			if not is_criterion_domain_evaluated then
				initialize_domain
			end
			source_domain.clear_cache
			l_user_data_list := user_data_list
			l_feature_list := feature_list
			l_generator := used_in_domain_generator
			create Result.make
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_feature := query_feature_item (l_feature_list.item)
				l_feature.set_data (l_user_data_list.i_th (l_feature_list.index))
				Result.extend (l_feature)
				l_generator.increase_internal_counter (l_feature)
				l_feature_list.forth
			end
		end

feature{NONE} -- Implementation

	feature_list: LIST [E_FEATURE]
			-- List of candidate features from `criterion_domain'

	user_data_list: LIST [ANY]
			-- User data for every item in `feature_list'.

	record_descendants (classes: LIST [CLASS_C]; e_class: CLASS_C) is
			-- Record the descendants of `class_c' to `classes'.
		require
			valid_classes: classes /= Void
			valid_e_class: e_class /= Void
		local
			descendants: ARRAYED_LIST [CLASS_C]
			desc_c: CLASS_C
			l_used_in_domain_generator: like used_in_domain_generator
		do
			descendants := e_class.direct_descendants
			classes.extend (e_class)
			l_used_in_domain_generator := used_in_domain_generator
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item
				if not classes.has (desc_c) then
					record_descendants (classes, desc_c)
				end
				l_used_in_domain_generator.increase_internal_counter (Void)
				descendants.forth
			end
		end

	record_ancestors (classes: LIST [CLASS_C]; e_class: CLASS_C) is
			-- Record parents of `class_c' to `classes'.	
		local
			parents: FIXED_LIST [CL_TYPE_A]
			e_parent: CLASS_C
		do
			parents := e_class.parents
			classes.extend (e_class)
			from
				parents.start
			until
				parents.after
			loop
				e_parent := parents.item.associated_class
				if not classes.has (e_parent) then
					record_ancestors (classes, e_parent)
				end
				parents.forth
			end
		end

	reset is
			-- Reset internal data structure.
		do
			if user_data_list = Void then
				create {ARRAYED_LIST [ANY]}user_data_list.make (30)
			else
				user_data_list.wipe_out
			end
			if feature_list = Void then
				create {ARRAYED_LIST [E_FEATURE]}feature_list.make (30)
			else
				feature_list.wipe_out
			end
		ensure then
			user_data_list_attached: user_data_list /= Void
			user_data_list_valid: user_data_list.is_empty
			implementor_list_attached: feature_list /= Void
			implementor_list_valid: feature_list.is_empty
		end

	features_from_domain (a_domain: QL_DOMAIN): QL_FEATURE_DOMAIN is
			-- A domain in where all features that are included in `a_domain' are included
		require
			a_domain_attached: a_domain /= Void
		local
			l_generator: QL_FEATURE_DOMAIN_GENERATOR
		do
			create l_generator.make (Void, True)
			Result ?= a_domain.new_domain (l_generator)
		ensure
			result_attached: Result /= Void
		end

	query_feature_item (a_feature: E_FEATURE): QL_FEATURE is
			-- Query feature representation of `a_feature'
			-- Take case of both visible and invisible features.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_class: QL_CLASS
		do
			Result := source_domain.feature_item_from_current_domain (a_feature)
			if Result = Void then
				l_class := query_class_item_from_class_c (a_feature.associated_class)
				l_class.set_visible (False)
				create {QL_REAL_FEATURE} Result.make_with_parent (a_feature, l_class)
			end
		ensure
			result_attached: Result /= Void
		end

	query_invariant_item (a_class: CLASS_C): QL_FEATURE is
			-- Query invariant representation of invariant part in `a_class'
			-- Take case of both visible and invisible features.
		require
			a_class_attached: a_class /= Void
			a_class_has_invariant: a_class.has_invariant
		local
			l_class: QL_CLASS
		do
			Result := source_domain.invariant_item_from_current_domain (a_class)
			if Result = Void then
				l_class := query_class_item_from_class_c (a_class)
				l_class.set_visible (False)
				create {QL_INVARIANT} Result.make_with_parent (a_class, a_class, l_class)
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Evaluate

	is_satisfied_by_internal (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
			source_domain_attached: source_domain /= Void
		deferred
		end

invariant
	feature_item_attached: criterion_domain /= Void
	list_count_valid:
		(feature_list /= Void and then user_data_list /= Void) implies (feature_list.count = user_data_list.count)

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
