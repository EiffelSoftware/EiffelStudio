indexing
	description: "Object that represents an assertion used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ASSERTION

inherit
	QL_FEATURE_COMPONENT
		redefine
			ast,
			wrapped_domain,
			written_class,
			path_name,
			is_equal
		end

	QL_SHARED_ASSERTION_TYPES
		undefine
			is_equal
		end

create
	make

feature{NONE} -- Implementation

	make (a_ast: like ast; a_written_in_ast: like written_in_ast; a_written_class: like written_class; a_assertion_type: like assertion_type; a_parent: like parent) is
			-- Initialize `ast' with `a_ast', `written_class' with `a_written_class' and
			-- `parent' with `a_parent'.
		require
			a_ast_attached: a_ast /= Void
			a_written_in_ast_attached: a_written_in_ast /= Void
			a_written_class_attached: a_written_class /= Void
			a_assertion_type_attached: a_assertion_type /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
			a_parent_is_feature: a_parent.is_feature
		do
			ast := a_ast
			written_in_ast := a_written_in_ast
			written_class := a_written_class
			assertion_type := a_assertion_type
			set_parent (a_parent)
		ensure
			ast_set: ast = ast
			a_written_in_ast_attached: a_written_in_ast /= Void
			written_class_set: written_class = a_written_class
			assertion_type_set: assertion_type = a_assertion_type
			parent_set: parent = a_parent
		end

feature -- Access

	name: STRING is
			-- Name of current item
			-- `name' can be empty for an assertion that has no tag attached to it.
		do
			if ast.tag = Void then
				Result := ""
			else
				Result := ast.tag.out
			end
		ensure then
			good_result: (ast.tag = Void implies Result.is_equal ("")) and
						 (ast.tag /= Void implies Result.is_equal (ast.tag))
		end

	path_name: STRING is
			-- Name used in `path'.
			-- For an assertion, `path_name' is "assertion "`name', e.g., is "assertion a_arg" for example.
			-- If an assertion doesn't has a tag attached to it, it's path name will be
			-- assertion "" (the word "assertion" followed by a quoted empty string)
		local
			l_path_marker: like path_name_marker
			l_name: STRING
			l_opener: STRING
			l_closer: STRING
		do
			l_path_marker := path_name_marker
			l_name := name
			if l_name.is_empty then
				l_name := empty_assertion_name
			end
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

	wrapped_domain: QL_ASSERTION_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.extend (Current)
		end

	ast: TAGGED_AS
			-- AST node associated with current item

	written_class: like class_c
			-- CLASS_C in which current invariant is written

	written_in_ast: AST_EIFFEL
			-- AST node in which `ast' is written

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := assertion_scope
		ensure then
			good_result: Result = assertion_scope
		end

	assertion_type: QL_ASSERTION_TYPE
			-- Type of current assertion
			-- For more information about assertion type, see {QL_SHARED_ASSERTION_TYPES}.

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := assertion_path_marker
		ensure then
			good_result: Result = assertion_path_marker
		end


feature -- Status report

	is_immediate: BOOLEAN is
			-- Is current invariant immediate?
		do
			Result := class_c.class_id = written_class.class_id
		ensure then
			good_result: Result implies (class_c.class_id = written_class.class_id)
		end

	is_precondition: BOOLEAN is
			-- Is current assertion a precondition?
		do
			Result := assertion_type = require_type or
					 assertion_type = require_else_type
		ensure
			good_result: Result implies (assertion_type = require_type or assertion_type = require_else_type)
		end

	is_postcondition: BOOLEAN is
			-- Is current assertion a postcondition?
		do
			Result := assertion_type = ensure_type or
					 assertion_type = require_else_type
		ensure
			good_result: Result implies (assertion_type = ensure_type or assertion_type = require_else_type)
		end

	is_invariant: BOOLEAN is
			-- Is current assertion an invariant?
		do
			Result := assertion_type = invariant_type
		ensure
			good_result: Result implies assertion_type = invariant_type
		end

	is_require: BOOLEAN is
			-- Is current a require assertion?
		do
			Result := assertion_type = require_type
		ensure
			good_result: Result implies assertion_type = require_type
		end

	is_require_else: BOOLEAN is
			-- Is current a require else assertion?
		do
			Result := assertion_type = require_else_type
		ensure
			good_result: Result implies assertion_type = require_else_type
		end

	is_ensure: BOOLEAN is
			-- Is current a ensure assertion?
		do
			Result := assertion_type = ensure_type
		ensure
			good_result: Result implies assertion_type = ensure_type
		end

	is_ensure_then: BOOLEAN is
			-- Is current a ensure then assertion?
		do
			Result := assertion_type = ensure_then_type
		ensure
			good_result: Result implies assertion_type = ensure_then_type
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_assertion (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := parent.is_equal (other.parent) and then ast = other.ast
		ensure then
			good_result: Result implies (parent.is_equal (other.parent) and then ast = other.ast)
		end

invariant
	name_attached: name /= Void
	parent_attached: parent /= Void
	parent_valid: parent.is_valid_domain_item
	parent_is_feature: parent.is_feature
	written_class_attached: written_class /= Void
	ast_attached: ast /= Void
	written_in_ast_attached: written_in_ast /= Void
	assertion_type_attached: assertion_type /= Void

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
