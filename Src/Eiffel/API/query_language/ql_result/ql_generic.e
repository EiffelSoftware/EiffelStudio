note
	description: "Object that represents a class generic item in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GENERIC

inherit
	QL_CODE_STRUCTURE_ITEM
		undefine
			is_equal
		end

	QL_SHARED_SCOPES
		undefine
			is_equal
		end

create
	make_with_ast

feature{NONE} -- Initialization

	make_with_ast (a_ast: like ast; a_parent: like parent)
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
			name_set: name.same_string_general (a_ast.name.name.as_upper)
			parent_set: parent = a_parent
		end

feature -- Setting

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_is_not_empty: not a_name.is_empty
		do
			create {IMMUTABLE_STRING_32} name.make_from_string_general (a_name.as_upper)
		ensure
			name_attached: name /= Void
			name_set: name.same_string_general (a_name.as_upper)
		end

feature -- Access

	name: READABLE_STRING_32
			-- Name of current item

	hash_code: INTEGER
			-- Hash code value
		local
			l_str: STRING_32
			l_parent_name: STRING_32
			l_name: STRING_32
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

	description: STRING_32
			-- Description of current item
		do
			Result := {STRING_32} ""
		ensure then
			no_description_attached_to_a_line: Result.is_empty
		end

	wrapped_domain: QL_GENERIC_DOMAIN
			-- A domain which has current as the only item
		do
			create Result.make
			Result.extend (Current)
		end

	ast: FORMAL_DEC_AS
			-- AST node associated with current item
		local
			l_list: EIFFEL_LIST [FORMAL_DEC_AS]
			l_ast: like ast
			l_item_name: like {ID_AS}.name_32
			l_name: like name
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

	class_i: CLASS_I
			-- CLASS_I object associated with current item
		do
			if attached {QL_CLASS} parent as l_class then
				Result := l_class.class_i
			else
				check is_class: False end
			end
		end

	class_c: CLASS_C
			-- CLASS_C object associated with current_item
		do
			if attached {QL_CLASS} parent as l_class then
				Result := l_class.class_c
			else
				check is_class: False end
			end
		end

	written_class: like class_c
			-- CLASS_C in which current is written
		do
			Result := class_c
		ensure then
			good_result: Result = class_c
		end

	scope: QL_SCOPE
			-- Scope of current
		do
			Result := generic_scope
		ensure then
			good_result: Result = generic_scope
		end

	path_name_marker: QL_PATH_MARKER
			-- Marker for `path_name'
		do
			Result := generic_path_marker
		ensure then
			good_result: Result = generic_path_marker
		end

feature -- Status report

	is_compiled: BOOLEAN
			-- Is Current item compiled?
		do
			Result := True
		ensure then
			good_result: Result
		end

	has_constraint: BOOLEAN
			-- Does the formal generic parameter have a constraint?
		do
			Result := ast.has_constraint
		ensure
			good_result: Result implies ast.has_constraint
		end

	has_creation_constraint: BOOLEAN
			-- Does the construct have a creation constraint?
		do
			Result := ast.has_creation_constraint
		ensure
			good_result: Result implies ast.has_creation_constraint
		end

	is_reference: BOOLEAN
			-- Is Current formal to be always instantiated as a reference type?
		do
			Result := ast.is_reference
		ensure
			good_result: Result implies ast.is_reference
		end

	is_expanded: BOOLEAN
			-- Is Current formal to be always instantiated as an expanded type?
		do
			Result := ast.is_expanded
		ensure
			good_result: Result implies ast.is_expanded
		end

	is_visible: BOOLEAN
			-- Is current visible from source domain level?
		do
			if attached {QL_CLASS} parent as l_class then
				Result := l_class.is_visible
			else
				check is_class: False end
			end
		end

feature -- Visit

	process (a_visitor: QL_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_generic (Current)
		end

	is_equal (other: like Current): BOOLEAN
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

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
