note
	description: "Like types that have not been evaluated (has not gone past Degree 4)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	UNEVALUATED_LIKE_TYPE

inherit
	LIKE_TYPE_A
		redefine
			has_associated_class,
			associated_class, conform_to, internal_is_valid_for_class,
			evaluated_type_in_descendant, instantiated_in, instantiation_in
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: like dump)
			-- Initialize `anchor' to `a_string'
		require
			non_void_string: a_string /= Void
		do
			names_heap.put (a_string)
			anchor_name_id := names_heap.found_item
		ensure
			set: anchor.is_equal (a_string)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_unevaluated_like_type (Current)
		end

feature -- Access

	anchor_name_id: INTEGER
			-- Id of `anchor' in `names_heap'.

	anchor: STRING
			-- Anchor name
		do
			Result := names_heap.item (anchor_name_id)
		end

feature -- Status report

	has_associated_class: BOOLEAN = False
			-- Does Current have associated class?

feature -- Access

	associated_class: CLASS_C
			-- Class associated to the current type
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := anchor_name_id = other.anchor_name_id and then
				has_attached_mark = other.has_attached_mark and then
				has_detachable_mark = other.has_detachable_mark
		end

feature -- Output

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C)
			-- Append Current type to `st'.
		do
			if has_attached_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_attached_keyword, Void)
				st.add_space
			elseif has_detachable_mark then
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_detachable_keyword, Void)
				st.add_space
			end
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Like_keyword, Void)
			st.add_space
			st.add (anchor)
		end

	dump: STRING
		do
			create Result.make_empty
			if has_attached_mark then
				Result.append_character ('!')
			elseif has_detachable_mark then
				Result.append_character ('?')
			end
			Result.append ("like ")
			Result.append (anchor)
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- An unevaluated type is never valid.
		do
		end

feature {NONE} -- Implementation

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		local
			o: UNEVALUATED_LIKE_TYPE
		do
			o ?= other
			Result := o /= Void	and then
				anchor_name_id = o.anchor_name_id and then
				has_same_attachment_marks (o)
		end

	shared_create_info, create_info: CREATE_INFO
			-- Byte code information for entity type creation
		do
		end

	conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
			-- Does Current conform to `other' in `a_context_class'?
		do
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): like Current
		do
		end

	instantiated_in (class_type: TYPE_A): like Current
		do
		end

	evaluated_type_in_descendant (a_ancestor, a_descendant: CLASS_C; a_feature: FEATURE_I): like Current
		do
		end

invariant
	non_void_anchor: anchor /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class UNEVALUATED_LIKE_TYPE
