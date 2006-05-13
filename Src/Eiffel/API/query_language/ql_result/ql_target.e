indexing
	description: "Object that represents a target item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TARGET

inherit
	QL_ITEM
		redefine
			is_valid_domain_item,
			is_compiled,
			wrapped_domain,
			nearest_parent_with_scope
		end

create
	make,
	make_with_parent

feature{NONE} -- Initialization

	make (a_target: like target) is
			-- Initialize `target' with `a_target'.
		require
			a_target_attached: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

	make_with_parent (a_target: like target; a_parent: like parent) is
			-- Initialize `target' with `a_target' and `parent' with `a_parent'.
		require
			a_target_attached: a_target /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_group and a_parent.is_valid_domain_item
		do
			make (a_target)
			parent := a_parent
		ensure
			target_set: target = a_target
			parent_set: parent = a_parent
		end

feature -- Access

	name: STRING is
			-- Name of current item
		do
			Result := target.name.as_lower
		ensure then
			good_result: Result.is_equal (target.name.as_lower)
		end

	description: STRING is
			-- Description of current item
		do
			Result := target.description
			if Result = Void then
				Result := ""
			end
		ensure then
			good_result: (target.description = Void implies Result.is_equal ("")) and
						 (target.description /= Void implies Result.is_equal (target.description))
		end

	target: CONF_TARGET
			-- Target associated with current

	wrapped_domain: QL_TARGET_DOMAIN is
			-- A target domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := target_path_marker
		ensure then
			good_result: Result = target_path_marker
		end

	nearest_parent_with_scope (a_scope: QL_SCOPE): QL_ITEM is
			-- Nearest parent or indirect parent whose `scope' is `a_scope'.
			-- For example, for a QL_FEATURE item, its nearest parent with CLASS_SCOPE
			-- is its direct parent, which is a QL_CLASS item.
		do
			if parent = Void then
				if a_scope = target_scope then
					Result := Current
				end
			else
				Result := Precursor (a_scope)
			end
		end

	groups_in_target: QL_GROUP_DOMAIN is
			-- Groups in `target'
		local
			l_group_domain_generator: QL_GROUP_DOMAIN_GENERATOR
		do
			create l_group_domain_generator
			l_group_domain_generator.enable_fill_domain
			Result ?= Current.wrapped_domain.new_domain (l_group_domain_generator)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	hash_code: INTEGER is
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := target.name.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = target.name.hash_code
		end

	is_compiled: BOOLEAN is True
			-- Is Current item compiled?

	is_valid_domain_item: BOOLEAN is
			-- Is current a valid item that is fully attached in a domain?
			-- True as return value means every ancestors of current item is a valid domain item.
		once
			if parent = Void then
				Result := target = universe.target
			else
				Result := parent.is_valid_domain_item
			end
		ensure then
			good_result: (parent = Void implies (Result = (target = universe.target))) and
						 (parent /= Void implies (Result = parent.is_valid_domain_item))
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := target_scope
		ensure then
			good_result: Result = target_scope
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_target (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := target = other.target
		ensure then
			good_result: Result implies (target = other.target)
		end

invariant
	target_attached: target /= Void

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
