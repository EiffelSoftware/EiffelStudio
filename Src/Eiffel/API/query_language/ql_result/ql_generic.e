indexing
	description: "Object that represents a class generic item in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GENERIC

inherit
	QL_CODE_STRUCTURE_ITEM
		undefine
			is_equal
		redefine
			wrapped_domain,
			name,
			ast
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

create
	make,
	make_with_ast

feature{NONE} -- Initialization

	make (a_name: STRING; a_parent: like parent) is
			-- Initialize `name' with `a_name' and `parent' with `a_parent'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_class and then a_parent.is_compiled a_parent.is_valid_domain_item
		do
			set_name (a_name)
			set_parent (a_parent)
		ensure
			name_set: name.is_equal (a_name)
			parent_set: parent = a_parent
		end

	make_with_ast (a_ast: like ast; a_parent: like parent) is
			-- Initialize `ast' with `a_ast' and `parent' with `a_parent'.
		require
			a_ast_attached: a_ast /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_class and then a_parent.is_compiled a_parent.is_valid_domain_item
		do
			internal_ast := a_ast
			set_name (a_ast.name.name)
			set_parent (a_parent)
		ensure
			name_set: name.is_case_insensitive_equal (a_ast.name.name)
			parent_set: parent = a_parent
		end

feature -- Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_is_not_empty: not a_name.is_empty
		do
			create name.make_from_string (a_name.as_upper)
		ensure
			name_attached: name /= Void
			name_set: name.is_equal (a_name.as_upper)
		end

feature -- Access

	name: STRING
			-- Name of current item

	hash_code: INTEGER is
			-- Hash code value
		local
			l_str: STRING
			l_parent_name: STRING
			l_name: STRING
		do
			if internal_hash_code = 0 then
				check parent /= Void end
				l_parent_name := parent.name
				l_name := name
				create l_str.make (l_parent_name.count + l_name.count + 1)
				l_str.append (l_parent_name)
				l_str.append_character (path_separator)
				l_str.append (l_name)
				internal_hash_code := l_str.hash_code
			end
			Result := internal_hash_code
		end

	description: STRING is
			-- Description of current item
		do
			Result := ""
		ensure then
			no_description_attached_to_a_line: Result.is_equal ("")
		end

	wrapped_domain: QL_GENERIC_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.extend (Current)
		end

	ast: FORMAL_DEC_AS is
			-- AST node associated with current item
		local
			l_list: EIFFEL_LIST [FORMAL_DEC_AS]
			l_ast: like ast
			l_item_name: STRING
			l_name: STRING
		do
			if internal_ast = Void then
				l_list := class_c.generics
				check l_list /= Void and then not l_list.is_empty end
				from
					l_ast := Void
					l_name := name
					l_list.start
				until
					l_list.after or l_ast /= Void
				loop
					l_item_name := l_list.item.name.name
					if l_item_name.is_case_insensitive_equal (l_name) then
						l_ast := l_list.item
					end
					l_list.forth
				end
				internal_ast := l_ast
			end
			Result := internal_ast
		ensure then
			good_result: Result = internal_ast
		end

	class_i: CLASS_I is
			-- CLASS_I object associated with current item
		local
			l_class: QL_CLASS
		do
			l_class ?= parent
			check l_class /= Void end
			Result := l_class.class_i
		end

	class_c: CLASS_C is
			-- CLASS_C object associated with current_item
		local
			l_class: QL_CLASS
		do
			l_class ?= parent
			check l_class /= Void end
			Result := l_class.class_c
		end

	written_class: like class_c is
			-- CLASS_C in which current is written
		do
			Result := class_c
		ensure then
			good_result: Result = class_c
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := generic_scope
		ensure then
			good_result: Result = generic_scope
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := generic_path_marker
		ensure then
			good_result: Result = generic_path_marker
		end

feature -- Status report

	is_compiled: BOOLEAN is
			-- Is Current item compiled?
		do
			Result := True
		ensure then
			good_result: Result
		end

	has_constraint: BOOLEAN is
			-- Does the formal generic parameter have a constraint?
		do
			Result := ast.has_constraint
		ensure
			good_result: Result implies ast.has_constraint
		end

	has_creation_constraint: BOOLEAN is
			-- Does the construct have a creation constraint?
		do
			Result := ast.has_creation_constraint
		ensure
			good_result: Result implies ast.has_creation_constraint
		end

	is_self_initializing: BOOLEAN
			-- Is Current formal self-initializing?
		do
			Result := ast.is_self_initializing
		ensure
			good_result: Result implies ast.is_self_initializing
		end

	is_reference: BOOLEAN is
			-- Is Current formal to be always instantiated as a reference type?
		do
			Result := ast.is_reference
		ensure
			good_result: Result implies ast.is_reference
		end

	is_expanded: BOOLEAN is
			-- Is Current formal to be always instantiated as an expanded type?
		do
			Result := ast.is_expanded
		ensure
			good_result: Result implies ast.is_expanded
		end

	is_visible: BOOLEAN is
			-- Is current visible from source domain level?
		local
			l_class: QL_CLASS
		do
			l_class ?= parent
			check l_class /= Void end
			Result := l_class.is_visible
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_generic (Current)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := parent.is_equal (other.parent) and then name.is_equal (other.name)
		ensure then
			good_result: Result implies (parent.is_equal (other.parent) and then name.is_equal (other.name))
		end

feature{NONE} -- Implementation

	internal_ast: like ast
			-- Implementation of `ast'

invariant
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty
	parent_attached: parent /= Void
	parent_valid: parent.is_class and then parent.is_valid_domain_item and then parent.is_compiled

indexing
        copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
