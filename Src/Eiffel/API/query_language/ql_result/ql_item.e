indexing
	description: "Object that represents a basic item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_ITEM

inherit
	SHARED_WORKBENCH
		undefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
		end

	REFACTORING_HELPER
		undefine
			is_equal
		end

	QL_VISITABLE
		undefine
			is_equal
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

	QL_SHARED_PATH_MARKER
		undefine
			is_equal
		end

	QL_SHARED
		undefine
			is_equal
		end

feature -- Setting

	set_data (some_data: like data) is
			-- Assign `some_data' to `data'.
		do
			data := some_data
		ensure
			data_assigned: data = some_data
		end

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		require
			a_parent_attached: a_parent /= Void
			a_parent_is_valid: a_parent.is_valid_domain_item
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	name: STRING is
			-- Name of current item
		deferred
		ensure
			result_attached: Result /= Void
		end

	path_name: STRING is
			-- Name used in `path'.
		local
			l_path_marker: like path_name_marker
			l_name: STRING
			l_opener: STRING
			l_closer: STRING
		do
			l_path_marker := path_name_marker
			l_name := name
			l_opener := l_path_marker.opener
			l_closer := l_path_marker.closer
			create Result.make (l_opener.count + l_name.count + l_closer.count)
			if not l_opener.is_empty then
				Result.append (l_opener)
			end
			Result.append (l_name)
			if not l_closer.is_empty then
				Result.append (l_closer)
			end
		end

	path: STRING is
			-- Full path of current item
		require
			valid_item: is_valid_domain_item
		local
			l_name: STRING
			l_parent_path: STRING
			l_separator: like path_separator
		do
			if parent = Void then
				Result := ""
			else
				l_parent_path := parent.path
				l_name := path_name
				if l_parent_path.is_empty then
					create Result.make_from_string (l_name)
				else
					create Result.make (l_parent_path.count + l_name.count + 1)
					Result.append (l_parent_path)
					Result.append_character (path_separator)
					Result.append (l_name)
				end
			end
		ensure
			result_attached: Result /= Void
		end

	description: STRING is
			-- Description of current item
		require
			valid_item: is_valid_domain_item
		deferred
		end

	wrapped_domain: QL_DOMAIN is
			-- A domain which has current as the only item
		require
			current_is_valid: Current.is_valid_domain_item
		deferred
		ensure
			result_attached: Result /= Void
			current_in_domain: Result.content.has (Current)
		end

	string_representation: STRING is
			-- String representation of current
		do
			Result := name
		ensure then
			good_result: Result.is_equal (name)
		end

	parent: QL_ITEM
			-- Parent of current item

	data: ANY
			-- Arbitrary user data may be stored here.

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		deferred
		ensure
			result_attached: Result /= Void
		end

	nearest_parent_with_scope (a_scope: QL_SCOPE): QL_ITEM is
			-- Nearest parent or indirect parent (including current item itself) whose `scope' is `a_scope'.
			-- For example, for a QL_FEATURE item, its nearest parent with CLASS_SCOPE
			-- is its direct parent, which is a QL_CLASS item.
		require
			current_valid: is_valid_domain_item
			a_scope_attached: a_scope /= Void
		local
			l_parent: QL_ITEM
		do
			from
				l_parent := Current
			until
				parent = Void or Result /= Void
			loop
				if l_parent.scope = a_scope then
					Result := l_parent
				else
					l_parent := l_parent.parent
				end
			end
		ensure
			good_result: Result /= Void implies Result.scope = a_scope
		end

	nearest_domain_with_scope (a_scope: QL_SCOPE): QL_DOMAIN is
			-- Nearest domain with scope `a_scope'
			-- If Result is not empty, the only item in returned domain is `nearest_parent_with_scope' of `a_scope'.
		require
			current_valid: is_valid_domain_item
			a_scope_attached: a_scope /= Void
		local
			l_item: QL_ITEM
		do
			l_item := nearest_parent_with_scope (a_scope)
			if l_item /= Void then
				Result := l_item.wrapped_domain
			else
				Result := a_scope.empty_domain
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Item type

	is_target: BOOLEAN is
			-- Is current a target item?
		do
			Result := scope.is_equal (target_scope)
		ensure
			good_result: Result implies scope.is_equal (target_scope)
		end

	is_group: BOOLEAN is
			-- Is current a group item?
		do
			Result := scope.is_equal (group_scope)
		ensure
			good_result: Result implies scope.is_equal (group_scope)
		end

	is_class: BOOLEAN is
			-- Is current a class item?
		do
			Result := scope.is_equal (class_scope)
		ensure
			good_result: Result implies scope.is_equal (class_scope)
		end

	is_feature: BOOLEAN is
			-- Is current a feature item?
		do
			Result := scope.is_equal (feature_scope)
		ensure
			good_result: Result implies scope.is_equal (feature_scope)
		end

	is_real_feature: BOOLEAN is
			-- Is current a real feature (not a class invariant?)?
		do
		ensure
			good_result: Result implies (is_feature and then not is_invariant_feature)
		end

	is_invariant_feature: BOOLEAN is
			-- Is current a class invariant (not a feature)?
			-- Note that class invariant is treated as a special kind of feature
			-- and it can has contract assertions in it.
		do
		ensure
			good_result: Result implies (is_feature and then not is_real_feature)
		end

	is_assertion: BOOLEAN is
			-- Is current an assertion item?
		do
			Result := scope.is_equal (assertion_scope)
		ensure
			good_result: Result implies scope.is_equal (assertion_scope)
		end

	is_local: BOOLEAN is
			-- Is current a local variable item?
		do
			Result := scope.is_equal (local_scope)
		ensure
			good_result: Result implies scope.is_equal (local_scope)
		end

	is_argument: BOOLEAN is
			-- Is current an argument item?
		do
			Result := scope.is_equal (argument_scope)
		ensure
			good_result: Result implies scope.is_equal (argument_scope)
		end

	is_generic: BOOLEAN is
			-- Is current a generic item?
		do
			Result := scope.is_equal (generic_scope)
		ensure
			good_result: Result implies scope.is_equal (generic_scope)
		end

	is_line: BOOLEAN is
			-- Is current a line item?
		do
			Result := scope.is_equal (line_scope)
		ensure
			good_result: Result implies scope.is_equal (line_scope)
		end

	is_quantity: BOOLEAN is
			-- Is current a quantity item?
		do
			Result := scope.is_equal (quantity_scope)
		ensure
			good_result: Result implies scope.is_equal (quantity_scope)
		end

	is_code_structure: BOOLEAN is
			-- Is current item a code-direct-related item?
		do
			Result := is_class or is_feature or is_assertion or is_local or is_argument or is_generic
		ensure
			good_result: Result implies (is_class or is_feature or is_assertion or is_local or is_argument or is_generic)
		end

feature -- Status report

	scope: QL_SCOPE is
			-- Scope of current
		deferred
		ensure
			result_attached: Result /= Void
		end

	is_compiled: BOOLEAN is
			-- Is Current item compiled?
		deferred
		end

	is_valid_domain_item: BOOLEAN is
			-- Is current a valid item that is fully attached in a domain?
		local
			l_parent: QL_ITEM
			l_cur_item: QL_ITEM
			done: BOOLEAN
			l_system_target: CONF_TARGET
			l_target: QL_TARGET
		do
			l_system_target := universe.target
			from
				l_parent := parent
				l_cur_item := Current
			until
				done
			loop
				if l_parent = Void then
						-- If an item's parent is Void, and then if it's a target item that represents
						-- the root target of current system, it's valid, otherwise, not valid.
					if l_cur_item.is_target then
						l_target ?= l_cur_item
						Result := l_target.target = l_system_target
					end
					done := True
				else
					l_cur_item := l_cur_item.parent
					l_parent := l_cur_item.parent
				end
			end
		end

feature{NONE} -- Implementation

	internal_hash_code: INTEGER
			-- Internal `hash_code'

invariant
	name_valid: name /= Void and then not name.is_empty
	full_name_valid: path /= Void and then not path.is_empty

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
