indexing
	description: "Node for normal class type. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit
	TYPE_AS
		redefine
			is_equivalent, start_location, end_location,
			first_token, last_token
		end

	CLICKABLE_AST
		redefine
			is_class, class_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; m: SYMBOL_AS; a: like has_attached_mark; d: like has_detachable_mark) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
			n_upper: n.name.is_equal (n.name.as_upper)
			correct_attachment_status: not (a and d)
		do
			class_name := n
			if m /= Void then
				attachment_mark_index := m.index
			end
			has_attached_mark := a
			has_detachable_mark := d
		ensure
			class_name_set: class_name.name.is_equal (n.name)
			attachment_mark_set: m /= Void implies attachment_mark_index = m.index
			has_attached_mark_set: has_attached_mark = a
			has_detachable_mark_set: has_detachable_mark = d
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_type_as (Current)
		end

feature -- Attributes

	class_name: ID_AS
			-- Class type name

	generics: TYPE_LIST_AS is
			-- Possible generical parameters
		do
		end

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

	is_expanded: BOOLEAN
			-- Is current type used with `expanded' keyword?

	is_separate: BOOLEAN
			-- Is current type used with `separate' keyword?

	has_attached_mark: BOOLEAN
			-- Is attached mark specified?

	has_detachable_mark: BOOLEAN
			-- Is detachable mark specified?

feature -- Roundtrip

	attachment_mark_index: INTEGER
			-- Index of attachment symbol (if any)

	expanded_keyword_index: INTEGER
			-- Index of keyword "expanded" associated with this structure.

	separate_keyword_index: INTEGER
			-- Index of keyword "separate" associated with this structure.	

	attachment_mark (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Attachment symbol (if any)
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := attachment_mark_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	expanded_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "expanded" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := expanded_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	separate_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "separate" associated with this structure.	
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := separate_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void then
					Result := attachment_mark (a_list)
					if Result = Void then
						Result := expanded_keyword (a_list)
						if Result = Void then
							Result := separate_keyword (a_list)
						end
					end
				end
				if Result = Void then
					Result := class_name.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := class_name.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (generics, other.generics) and then
				is_expanded = other.is_expanded and then
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark
		end

feature {AST_FACTORY, COMPILER_EXPORTER} -- Conveniences

	set_is_expanded (i: like is_expanded; s_as: like expanded_keyword) is
			-- Set `is_separate' to `i'.
		do
			is_expanded := i
			if s_as /= Void then
				expanded_keyword_index := s_as.index
			end
		ensure
			is_expanded_set: is_expanded = i
			expanded_keyword_set: s_as /= Void implies expanded_keyword_index = s_as.index
		end

	set_is_separate (i: like is_separate; s_as: like separate_keyword) is
			-- Set `is_separate' to `i'.
		do
			is_separate := i
			if s_as /= Void then
				separate_keyword_index := s_as.index
			end
		ensure
			is_separate_set: is_separate = i
			separate_keyword_set: s_as /= Void implies separate_keyword_index = s_as.index
		end

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end

	dump: STRING is
			-- Dumped string
		do
			create Result.make (class_name.name.count)
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
			Result.append (class_name.name)
		end

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

end -- class CLASS_TYPE_AS
