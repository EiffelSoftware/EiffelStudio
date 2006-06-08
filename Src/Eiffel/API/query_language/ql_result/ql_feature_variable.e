indexing
	description: "Object that represents a feature argument or a local variable used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_FEATURE_VARIABLE

inherit
	QL_FEATURE_COMPONENT
		redefine
			name,
			ast,
			is_equal
		end

feature{NONE} -- Initialization

	make (a_name: STRING; a_parent: like parent) is
			-- Initialize `name' with `a_name' and `parent' with `a_parent'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_compiled and then a_parent.is_valid_domain_item and then a_parent.is_real_feature
		do
			set_name (a_name)
			set_parent (a_parent)
		ensure
			name_set: name.is_equal (a_name.as_lower)
			parent_set: parent = a_parent
		end

	make_with_ast (a_name: STRING; a_ast: like ast; a_parent: like parent) is
			-- Initialize `ast' with `a_ast' and `parent' with `a_parent'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_ast_attached: a_ast /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_compiled and then a_parent.is_valid_domain_item and then a_parent.is_real_feature
		do
			internal_ast := a_ast
			make (a_name, a_parent)
		ensure
			name_set: name.is_equal (a_name.as_lower)
			parent_set: parent = a_parent
		end

feature -- Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_is_not_empty: not a_name.is_empty
		do
			create name.make_from_string (a_name.as_lower)
		ensure
			name_attached: name /= Void
			name_set: name.is_equal (a_name.as_lower)
		end

feature -- Access

	name: STRING
			-- Name of current item

	ast: TYPE_DEC_AS is
			-- AST node associated with current item
		do
			if internal_ast = Void then
				retrieve_ast
			end
			Result := internal_ast
		ensure then
			good_result: Result = internal_ast
		end

	written_class: like class_c is
			-- CLASS_C in which current is written
		do
			Result := class_c
		ensure then
			good_result: Result = class_c
		end

feature{NONE} -- Implementation

	retrieve_ast is
			-- Retrieve `ast'.
		deferred
		end

	type_dec_ast_with_name (a_name: STRING; a_type_dec_list: EIFFEL_LIST [TYPE_DEC_AS]): TYPE_DEC_AS is
			-- TYPE_DEC_AS object which has identifier named `a_name' in `a_type_dec_list'.
			-- Void if no item is named `a_name' in `a_type_dec_list'.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_type_dec: TYPE_DEC_AS
			l_cnt: INTEGER
			i: INTEGER
		do
			if a_type_dec_list /= Void and then not a_type_dec_list.is_empty then
				from
					a_type_dec_list.start
				until
					a_type_dec_list.after or Result /= Void
				loop
					l_type_dec := a_type_dec_list.item
					from
						i := 1
						l_cnt := l_type_dec.id_list.count
					until
						i > l_cnt or Result /= Void
					loop
						if l_type_dec.item_name (i).is_case_insensitive_equal (name) then
							Result := l_type_dec
						end
						i := i + 1
					end
					a_type_dec_list.forth
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := parent.is_equal (other.parent) and then name.is_equal (other.name)
		ensure then
			good_result: Result implies (parent.is_equal (other.parent) and then name.is_equal (other.name))
		end

invariant
	not_name_is_empty: not name.is_empty
	parent_attached: parent /= Void and then parent.is_valid_domain_item
	parent_is_real_feature: parent.is_real_feature

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
