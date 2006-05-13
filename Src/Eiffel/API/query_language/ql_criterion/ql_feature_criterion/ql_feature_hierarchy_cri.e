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
			has_intrinsic_domain,
			require_compiled
		redefine
			intrinsic_domain
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_FEATURE): BOOLEAN is
			-- Evaluate `a_item'.
		do
			check
				a_item.is_compiled
			end
				-- Make sure we refresh delayed `criterion_domain' every time.
			if criterion_domain.is_delayed then
				initialize_delayed_domain
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
			l_source_domain: like source_domain
		do
			l_source_domain := source_domain
			l_user_data_list := user_data_list
			l_feature_list := feature_list
			create Result.make
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_feature := l_source_domain.feature_item_from_current_domain (l_feature_list.item)
				if l_feature /= Void then
					l_feature.set_data (l_user_data_list.i_th (l_feature_list.index))
					Result.extend (l_feature)
				end
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
		do
			descendants := e_class.descendants
			classes.extend (e_class)
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item
				if not classes.has (desc_c) then
					record_descendants (classes, desc_c)
				end
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
			create l_generator
			l_generator.enable_fill_domain
			Result ?= a_domain.new_domain (l_generator)
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
		local
			l_user_data_list: like user_data_list
			l_feature_list: like feature_list
			l_feature: E_FEATURE
		do
			if a_item.is_real_feature then
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
						a_item.set_data (l_user_data_list.i_th (l_feature_list.index))
						Result := True
					end
					l_feature_list.forth
				end
			end
		end

invariant
	feature_item_attached: criterion_domain /= Void
	user_data_list_attached: user_data_list /= Void
	feature_list_attached: feature_list /= Void
	feature_list_and_user_data_list_valid: feature_list.count = user_data_list.count

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
