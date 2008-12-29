note
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
			ast,
			is_compiled,
			text,
			is_visible,
			parent_with_real_path
		end

	QL_UTILITY
		undefine
			is_equal
		end

	SHARED_EIFFEL_PARSER
		export{NONE}all
		undefine
			is_equal
		end

create
	make_with_compiled_flag,
	make_with_parent,
	make

feature{NONE} -- Initialization

	make_with_compiled_flag (a_class: like conf_class; a_parent: like parent)
			-- Initialize `conf_class' with `a_class' and `parent' with `a_parent'.
			-- And set `is_compiled' to True. (For optimization concern)
		require
			a_class_attached: a_class /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_group and a_parent.is_valid_domain_item
		do
			make_with_parent (a_class, a_parent)
			is_compiled_internal := True
		ensure
			class_item_set: conf_class = a_class
			parent_set: parent = a_parent
			is_compiled: is_compiled
		end

	make_with_parent (a_class: like conf_class; a_parent: like parent)
			-- Initialize `conf_class' with `a_class' and `parent' with `a_parent'.
		require
			a_class_attached: a_class /= Void
			a_parent_attached: a_parent /= Void
--			a_parent_valid: a_parent.is_group and a_parent.is_valid_domain_item
		do
			make (a_class)
			set_parent (a_parent)
		ensure
			class_item_set: conf_class = a_class
			parent_set: parent = a_parent
		end

	make (a_class: like conf_class)
			-- Initialize `conf_class' with `a_class'.
		require
			a_class_attached: a_class /= Void
		do
			conf_class := a_class
			class_i ?= a_class
			class_c := class_i.compiled_representation
			is_visible := True
		ensure
			class_item_set: conf_class = a_class
			is_visible: is_visible
		end

feature -- Setting

	set_name (a_name: like name)
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

	set_visible (b: BOOLEAN)
			-- Set `is_visible' with `b'.
		do
			is_visible := b
		ensure
			is_visible_set: is_visible = b
		end

feature -- Access

	name: STRING
			-- Name of current item
		do
			if name_internal = Void then
				Result := conf_class.name
			else
				Result := name_internal
			end
		end

	hash_code: INTEGER
			-- Hash code of current
		do
			if internal_hash_code = 0 then
				internal_hash_code := conf_class.hash_code
			end
			Result := internal_hash_code
		ensure then
			good_result: Result = internal_hash_code and internal_hash_code = conf_class.hash_code
		end

	description: STRING
			-- Description of current item
			--| Note: This is slow.
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
						l_string := l_index_item.tag.name
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

	description_string: STRING = "description"
			-- String of description item in top indexing of `class_i'

	wrapped_domain: QL_CLASS_DOMAIN
			-- A domain which has current as the only item
		do
			create Result.make
			Result.content.extend (Current)
		end

	class_c: CLASS_C
			-- Compiled class of `conf_class'
			-- Void if `conf_class' is not compiled

	written_class: like class_c
			-- CLASS_C in which current is written
		do
			Result := class_c
		ensure then
			good_result: Result = class_c
		end

	class_i: CLASS_I
			-- Un-compiled class information of `conf_class'

	ast: CLASS_AS
			-- AST node associated with current class
		do
			Result := class_c.ast
		ensure then
			good_result: Result = class_c.ast
		end

	path_name_marker: QL_PATH_MARKER
			-- Marker for `path_name'
		do
			Result := class_path_marker
		ensure then
			good_result: Result = class_path_marker
		end

	scope: QL_SCOPE
			-- Scope of current
		do
			Result := class_scope
		ensure then
			good_result: Result = class_scope
		end

	text: STRING
			-- Text of `ast'
		do
			if is_compiled then
				Result := Precursor
			else
				if text_internal = Void then
					text_internal := class_text
				end
				Result := text_internal
			end
		end

	parent_with_real_path: QL_ITEM
			-- Parent item of Current with real path.
			-- Real path means that every parent is physically determined.
		do
			Result := query_group_item_from_conf_group (class_i.group)
		end

feature -- Status report

	conf_class: CONF_CLASS
			-- Class associated with current

	is_compiled: BOOLEAN
			-- Is Current item compiled?
		do
			if is_compiled_internal = Void then
				is_compiled_internal := is_class_compiled (conf_class)
			end
			Result := is_compiled_internal
		end

	is_visible: BOOLEAN
			-- Is current item visible in the level where current is generated?
			-- For example,
			--		System
			--		 |
			--       +-- Lib1
			--			  |
			--			  +-- Lib2
			--
			-- and there is a class C in System inherit class B in Lib1 which inherit class A in Lib2: C->B->A
			-- So from System level, we cannot see class A.
			--
			-- From application target level, we want to generate ancestor classes of
			-- a centain class. But some of the ancestor classes are not visible from the application target level,
			-- in this case, those invisible classes will also be in the result domain, with `is_visible' set to false.
			-- To filter out invisible classes, use class criterion: is_visible (You can get it from {QL_CLASS_CRITERION_FACTORY}).

feature -- Visit

	process (a_visitor: QL_VISITOR)
			-- Process `a_visitor'.
		do
			a_visitor.process_class (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
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

	is_compiled_internal: BOOLEAN_REF
			-- Implementation of `is_compiled'

	text_internal: like text
			-- Internal stored text.
			-- Used for non-compiled class

	roundtrip_eiffel_parser: EIFFEL_PARSER
			-- Roundtrip parser used to retrieve indexing clause
		do
			if il_parsing then
				Result := roundtrip_il_eiffel_parser
			else
				Result := roundtrip_pure_eiffel_parser
			end
		ensure
			result_attached: Result /= Void
		end

	roundtrip_pure_eiffel_parser: EIFFEL_PARSER
			-- Pure Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
		end

	roundtrip_il_eiffel_parser: EIFFEL_PARSER
			-- IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			Result.set_il_parser
		end

	class_text: STRING
			-- Text of current class if it's a non-compiled class
		require
			not_compiled: not is_compiled
		local
			l_retried: BOOLEAN
			l_text: STRING
		do
			if not l_retried then
				l_text := class_i.text
				if l_text /= Void then
					roundtrip_eiffel_parser.parse_from_string (l_text)
					Result := roundtrip_eiffel_parser.root_node.original_text (roundtrip_eiffel_parser.match_list)
				else
					Result := ""
				end
			end
		ensure
			result_attached: Result /= Void
		rescue
			Result := ""
			l_retried := True
			retry
		end

invariant
	class_item_attached: conf_class /= Void
	class_i_attached: class_i /= Void
	parent_valid: parent /= Void implies parent.is_group and parent.is_valid_domain_item

note
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
