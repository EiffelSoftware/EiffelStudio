indexing
	description: "Object that represents a class item used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS

inherit
	QL_CODE_STRUCTURE_ITEM
		undefine
			is_equal
		redefine
			name,
			wrapped_domain,
			ast
		end

create
	make_with_parent,
	make

feature{NONE} -- Initialization

	make_with_parent (a_class: like conf_class; a_parent: like parent) is
			-- Initialize `conf_class' with `a_class' and `parent' with `a_parent'.
		require
			a_class_attached: a_class /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_group and a_parent.is_valid_domain_item
		do
			set_parent (a_parent)
			conf_class := a_class
		ensure
			class_item_set: conf_class = a_class
		end

	make (a_class: like conf_class) is
			-- Initialize `conf_class' with `a_class'.
		require
			a_class_attached: a_class /= Void
		do
			conf_class := a_class
		ensure
			class_item_set: conf_class = a_class
		end

feature -- Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_is_not_empty: not a_name.is_empty
		do
			create name_internal.make_from_string (a_name.as_upper)
		ensure
			name_internal_set: name_internal /= Void and then name.is_equal (a_name.as_upper)
			name_set: name.is_equal (a_name.as_upper)
		end

feature -- Access

	name: STRING is
			-- Name of current item
		do
			if name_internal = Void then
				Result := conf_class.name
			else
				Result := name_internal
			end
		end

	hash_code: INTEGER is
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := conf_class.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = conf_class.hash_code
		end

	description: STRING is
			-- Description of current item
		local
			l_indexing: INDEXING_CLAUSE_AS
			l_string: STRING
			l_index_item: INDEX_AS
			done: BOOLEAN
		do
			if is_compiled then
				l_indexing := ast.top_indexes
				if l_indexing /= Void then
					from
						l_indexing.start
					until
						l_indexing.after or done
					loop
						l_index_item := l_indexing.item
						l_string := l_index_item.tag
						if l_string.is_case_insensitive_equal (description_string) then
							if not l_index_item.index_list.is_empty then
								l_string := l_index_item.index_list.first.string_value
								if l_string /= Void then
									create Result.make_from_string (l_string)
								end
							end
							done := True
						end
						l_indexing.forth
					end
				end
				if Result = Void then
					Result := ""
				end
			else
				Result := ""
			end
		end

	description_string: STRING is "description"
			-- String of description item in top indexing of `class_i'

	wrapped_domain: QL_CLASS_DOMAIN is
			-- A domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	class_c: CLASS_C is
			-- Compiled class of `conf_class'
		do
			Result := class_i.compiled_class
		ensure then
			good_result: Result = class_i.compiled_class
		end

	written_class: like class_c is
			-- CLASS_C in which current is written
		do
			Result := class_c
		ensure then
			good_result: Result = class_c
		end

	class_i: CLASS_I is
			-- Un-compiled class information of `conf_class'
		local
			l_conf_class: CONF_CLASS
			l_eiffel_class_i: EIFFEL_CLASS_I
			l_external_class_i: EXTERNAL_CLASS_I
			l_partial_class_i: PARTIAL_EIFFEL_CLASS_I
		do
			l_conf_class := conf_class
			if l_conf_class.is_class_assembly then
				l_eiffel_class_i ?= l_conf_class
				Result ?= l_eiffel_class_i
			elseif l_conf_class.is_partial then
				l_partial_class_i ?= l_conf_class
				Result ?= l_partial_class_i
			else
				l_eiffel_class_i ?= l_conf_class
				Result ?= l_eiffel_class_i
			end
		ensure
			result_attached: Result /= Void
		end

	ast: CLASS_AS is
			-- AST node associated with current class
		do
			Result := class_c.ast
		ensure then
			good_result: Result = class_c.ast
		end

	path_name_marker: QL_PATH_MARKER is
			-- Marker for `path_name'
		do
			Result := class_path_marker
		ensure then
			good_result: Result = class_path_marker
		end

feature -- Status report

	conf_class: CONF_CLASS
			-- Class associated with current

	is_compiled: BOOLEAN is
			-- Is Current item compiled?
		do
			Result := conf_class.is_compiled
		ensure then
			good_result: Result = conf_class.is_compiled
		end

	scope: QL_SCOPE is
			-- Scope of current
		do
			Result := class_scope
		ensure then
			good_result: Result = class_scope
		end

feature -- Visit

	process (a_visitor: QL_VISITOR) is
			-- Process `a_visitor'.
		do
			a_visitor.process_class (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := conf_class = other.conf_class
		ensure then
			good_result: Result implies (conf_class = other.conf_class)
		end

feature{NONE} -- Implementation

	name_internal: like name
			-- Implementation of `name'

invariant
	class_item_attached: conf_class /= Void
	parent_valid: parent /= Void implies parent.is_group and parent.is_valid_domain_item

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
