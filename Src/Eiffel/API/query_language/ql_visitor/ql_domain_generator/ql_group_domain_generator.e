note
	description: "Object to generate group domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GROUP_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			item_type
		end

create
	default_create,
	make

feature -- Access

	criterion: QL_GROUP_CRITERION
			-- Criterion used when generating new items

	domain: QL_GROUP_DOMAIN
			-- Generated domain
		do
			if internal_domain = Void then
				create internal_domain.make
			end
			Result := internal_domain
		ensure then
			result_set: Result = internal_domain
		end

	scope: QL_SCOPE
			-- Scope of current generator
		do
			Result := group_scope
		ensure then
			good_result: Result = group_scope
		end

feature -- Process

	process_target (a_item: QL_TARGET)
			-- Process `a_item'.
		do
			process_groups_from_target (a_item.target, a_item, agent evaluate_item)
		end

	process_group (a_item: QL_GROUP)
			-- Process `a_item'.
		local
			l_conf_group: CONF_GROUP
			l_list: ARRAYED_LIST [CONF_GROUP]
		do
			l_conf_group := a_item.group
			if l_conf_group.is_cluster then
				if attached {CONF_CLUSTER} l_conf_group as l_cluster then
					if attached l_cluster.dependencies as l_group_set then
						create l_list.make (l_group_set.count)
						from
							l_group_set.start
						until
							l_group_set.after
						loop
							l_list.extend (l_group_set.item_for_iteration)
							l_group_set.forth
						end
						process_groups_from_list (l_list, a_item)
					end
				else
					check is_cluster: False end
				end
			elseif l_conf_group.is_library then
				if attached {CONF_LIBRARY} l_conf_group as l_library then
					if attached l_library.library_target as l_library_target then
						process_groups_from_target (l_library_target, a_item, agent evaluate_item)
					end
				else
					check is_library: False end
				end
			elseif l_conf_group.is_assembly then
				if attached {CONF_ASSEMBLY} l_conf_group as l_assembly then
					if
						attached {CONF_PHYSICAL_ASSEMBLY} l_assembly.physical_assembly as l_phys_as and then
						attached l_phys_as.dependencies as l_deps
					then
						process_groups_from_list (l_deps.linear_representation, a_item)
					end
				else
					check is_assembly: False end
				end
			elseif l_conf_group.is_physical_assembly then
				if attached {CONF_PHYSICAL_ASSEMBLY} l_conf_group as l_phys_as then
					if attached l_phys_as.dependencies as l_deps then
						process_groups_from_list (l_deps.linear_representation, a_item)
					end
				else
					check is_physical_assembly: False end
				end
			end
		end

	process_class (a_item: QL_CLASS)
			-- Process `a_item'.
		do
		end

	process_feature (a_item: QL_FEATURE)
			-- Process `a_item'.
		do
		end

	process_real_feature (a_item: QL_REAL_FEATURE)
			-- Process `a_item'.
		do
		end

	process_invariant (a_item: QL_INVARIANT)
			-- Process `a_item'.
		do
		end

	process_quantity (a_item: QL_QUANTITY)
			-- Process `a_item'.
		do
		end

	process_line (a_item: QL_LINE)
			-- Process `a_item'.
		do
		end

	process_generic (a_item: QL_GENERIC)
			-- Process `a_item'.
		do
		end

	process_local (a_item: QL_LOCAL)
			-- Process `a_item'.
		do
		end

	process_argument (a_item: QL_ARGUMENT)
			-- Process `a_item'.
		do
		end

	process_assertion (a_item: QL_ASSERTION)
			-- Process `a_item'.
		do
		end

feature{NONE} -- Implementation

	tautology_criterion: like criterion
			-- Tautology criterion
		do
			Result := group_criterion_factory.simple_criterion_with_index (group_criterion_factory.c_true)
		end

	compiled_criterion: like criterion
			-- A criterion that only compiled items can satisfy
		do
			Result := group_criterion_factory.simple_criterion_with_index (group_criterion_factory.c_is_compiled)
		end

	process_groups_from_list (a_list: LIST [CONF_GROUP]; a_parent: QL_ITEM)
			-- Iterate through groups in `a_list' is evaluate them using `actual_criterion'.
			-- If satisfied, create new items that represent satisfied groups and insert them
			-- in `domain', `a_parent' will be parent in newly created items.
		require
			a_list_attached: a_list /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
		do
			if not a_list.is_empty then
				a_list.do_all (agent (a_item: CONF_GROUP; a_a_parent: QL_ITEM)
					local
						l_group: QL_GROUP
					do
						create l_group.make_with_parent (a_item, a_a_parent)
						l_group.set_name (a_item.name)
						evaluate_item (l_group)
					end (?, a_parent))
			end
		end

feature{NONE} -- Observable

	item_type: QL_GROUP
			-- Anchor type for items of generated domain

feature{NONE} -- Implementation/Criterion interaction

	temp_domain: like domain
			-- Temporary domain used to store candidate items from relation criterion such as "ancestor_is", "descendant_is"
		do
			if temp_domain_internal = Void then
				create temp_domain_internal.make
			end
			Result := temp_domain_internal
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
