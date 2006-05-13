indexing
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

	make (a_group: like group) is
			-- Initialize `group' with `a_group'.
		require
			a_group_attached: a_group /= Void
		do
			group := a_group
		ensure
			group_set: group = a_group
		end

	make_with_parent (a_group: like group; a_parent: like parent) is
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

	set_name (a_name: like name) is
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

	name: STRING is
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

	description: STRING is
			-- Description of current item
		do
			Result := group.description
			if Result = Void then
				Result := ""
			end
		ensure then
			good_result: (group.description = Void implies Result.is_equal ("")) and
						 (group.description /= Void implies Result.is_equal (group.description))
		end

	hash_code: INTEGER is
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := group.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = group.hash_code
		end

	title: STRING is
			-- Title of current information
		once
			Result := query_language_names.ql_group
		ensure then
			good_result: Result.is_equal (query_language_names.ql_group)
		end

	wrapped_domain: QL_GROUP_DOMAIN is
			-- A group domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := group_path_marker
		ensure then
			good_result: Result = group_path_marker
		end

	library_target: QL_TARGET is
			-- Library target object if current group is a library
		require
			group_is_library: group.is_library
		local
			l_domain_generator: QL_TARGET_DOMAIN_GENERATOR
			l_target_domain: QL_TARGET_DOMAIN
		do
			create l_domain_generator
			l_domain_generator.enable_fill_domain
			l_target_domain ?= Current.wrapped_domain.new_domain (l_domain_generator)
			check
				l_target_domain /= Void and then l_target_domain.count = 1
			end
			Result := l_target_domain.first
		ensure
			result_attached: Result /= Void
		end

	groups_in_target: QL_GROUP_DOMAIN is
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

feature -- Status report

	is_compiled: BOOLEAN is True
			-- Is current item compiled?

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := group_scope
		ensure then
			good_result: Result = group_scope
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
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
