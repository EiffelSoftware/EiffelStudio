indexing
	description: "Object to generate group domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GROUP_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			domain,
			item_type
		end

feature -- Access

	criterion: QL_GROUP_CRITERION
			-- Criterion used when generating new items

	domain: QL_GROUP_DOMAIN is
			-- Generated domain
		do
			if internal_domain = Void then
				create internal_domain.make
			end
			Result := internal_domain
		ensure then
			result_set: Result = internal_domain
		end

	scope: QL_SCOPE is
			-- Scope of current generator
		do
			Result := group_scope
		ensure then
			good_result: Result = group_scope
		end

feature -- Process

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		do
			process_groups_from_target (a_item.target, a_item, agent evaluate_item)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		local
			l_conf_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_assembly: CONF_ASSEMBLY
			l_group_set: LINKED_SET [CONF_GROUP]
		do
			l_conf_group := a_item.group
			if l_conf_group.is_cluster then
				l_cluster ?= l_conf_group
				l_group_set := l_cluster.dependencies
				if l_group_set /= Void then
					process_groups_from_list (l_group_set, a_item)
				end
			elseif l_conf_group.is_library then
				l_library ?= l_conf_group
				process_groups_from_target (l_library.library_target, a_item, agent evaluate_item)
			elseif l_conf_group.is_assembly then
				l_assembly ?= l_conf_group
				l_group_set := l_cluster.dependencies
				if l_group_set /= Void then
					process_groups_from_list (l_group_set, a_item)
				end
			end
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		do
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		do
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		do
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		do
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		do
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		do
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		do
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		do
		end

feature{NONE} -- Implementation

	tautology_criterion: like criterion is
			-- Tautology criterion
		do
			create {QL_GROUP_TRUE_CRI}Result
		end

	compiled_criterion: like criterion is
			-- A criterion that only compiled items can satisfy
		do
			create {QL_GROUP_IS_COMPILED_CRI}Result
		end

	process_groups_from_list (a_list: LIST [CONF_GROUP]; a_parent: QL_ITEM) is
			-- Iterate through groups in `a_list' is evaluate them using `actual_criterion'.
			-- If satisfied, create new items that represent satisfied groups and insert them
			-- in `domain', `a_parent' will be parent in newly created items.
		require
			a_list_attached: a_list /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
		local
			l_cursor: CURSOR
			l_group: QL_GROUP
		do
			if not a_list.is_empty then
				l_cursor := a_list.cursor
				from
					a_list.start
				until
					a_list.after
				loop
					create l_group.make_with_parent (a_list.item, a_parent)
					l_group.set_name (a_list.item.name)
					evaluate_item (l_group)
					a_list.forth
				end
				if l_cursor /= Void then
					a_list.go_to (l_cursor)
				end
			end
		end

feature{NONE} -- Observable

	item_type: QL_GROUP;
			-- Anchor type for items of generated domain

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
