note
	description: "Object that represents a group item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GROUP

inherit
	QL_ITEM
		redefine
			name,
			is_compiled,
			wrapped_domain
		end

create
	make,
	make_with_parent

feature{NONE} -- Initialization

	make (a_group: like group)
			-- Initialize `group' with `a_group'.
		require
			a_group_attached: a_group /= Void
		do
			group := a_group
		ensure
			group_set: group = a_group
		end

	make_with_parent (a_group: like group; a_parent: like parent)
			-- Initialize `group' with `a_group' and `parent' with `a_parent'.
		require
			a_group_attached: a_group /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_group or a_parent.is_target
			a_parent_valid: a_parent.is_valid_domain_item
		do
			make (a_group)
			set_parent (a_parent)
		ensure
			group_set: group = a_group
		end

feature -- Setting

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_is_not_empty: not a_name.is_empty
		do
			create name_internal.make_from_string (a_name.as_lower)
		ensure
			name_internal_set: name_internal /= Void and then name.is_equal (a_name.as_lower)
			name_set: name.is_equal (a_name.as_lower)
		end

feature -- Access

	name: STRING
			-- Name of current item
		do
			if name_internal = Void then
				Result := group.name
			else
				Result := name_internal
			end
		end

	group: CONF_GROUP
			-- Group

	description: STRING_32
			-- Description of current item
		do
			Result := group.description
			if Result = Void then
				Result := ""
			end
		ensure then
			good_result: (group.description = Void implies Result.is_empty) and
						 (attached group.description as d implies Result ~ d)
		end

	hash_code: INTEGER
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := group.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = group.hash_code
		end

	title: STRING
			-- Title of current information
		once
			Result := query_language_names.ql_group
		ensure then
			good_result: Result.is_equal (query_language_names.ql_group)
		end

	wrapped_domain: QL_GROUP_DOMAIN
			-- A group domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	path_name_marker: QL_PATH_MARKER
			-- Marker for `path_name'
		do
			Result := group_path_marker
		ensure then
			good_result: Result = group_path_marker
		end

	library_target: QL_TARGET
			-- Library target object if current group is a library
		require
			group_is_library: group.is_library
		local
			l_domain_generator: QL_TARGET_DOMAIN_GENERATOR
			l_target_domain: QL_TARGET_DOMAIN
		do
			create l_domain_generator
			l_domain_generator.enable_fill_domain
			l_target_domain ?= wrapped_domain.new_domain (l_domain_generator)
			check
				l_target_domain /= Void and then l_target_domain.count = 1
			end
			Result := l_target_domain.first
		ensure
			result_attached: Result /= Void
		end

	groups_in_target: QL_GROUP_DOMAIN
			-- Groups in `library_target'
		require
			group_is_library: group.is_library
		local
			l_group_domain_generator: QL_GROUP_DOMAIN_GENERATOR
		do
			create l_group_domain_generator
			l_group_domain_generator.enable_fill_domain
			Result ?= library_target.wrapped_domain.new_domain (l_group_domain_generator)
		ensure
			result_attached: Result /= Void
		end

	parent_with_real_path: QL_ITEM
			-- Parent item of Current with real path.
			-- Real path means that every parent is physically determined.
		do
			Result := query_target_item_from_conf_target (group.target)
		end

feature -- Status report

	is_compiled: BOOLEAN = True
			-- Is current item compiled?

	scope: QL_SCOPE
			-- Scope of current
		do
			Result := group_scope
		ensure then
			good_result: Result = group_scope
		end

	is_library: BOOLEAN
			-- Is `group' a library?
		do
			Result := group.is_library
		end

	is_assembly: BOOLEAN
			-- Is `group' an assembly?
		do
			Result := group.is_assembly
		end

	is_cluster: BOOLEAN
			-- Is `group' a cluster?
		do
			Result := group.is_cluster
		end

	is_physical_assembly: BOOLEAN
			-- Is `group' a physical assembly?
		do
			Result := group.is_physical_assembly
		end

feature -- Visit

	process (a_visitor: QL_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := group = other.group
		ensure then
			good_result: Result implies (group = other.group)
		end

feature{NONE} -- Implementation

	name_internal: like name
			-- Implementation of `name'

invariant
	group_attached: group /= Void
	parent_valid: parent /= Void implies ((parent.is_group or parent.is_target) and (parent.is_valid_domain_item))

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
