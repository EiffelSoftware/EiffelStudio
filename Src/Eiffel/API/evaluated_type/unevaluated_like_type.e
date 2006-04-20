indexing
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
			is_like_current, has_associated_class,
			type_i, associated_class, conform_to, is_valid
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make,
	make_current

feature {NONE} -- Initialization

	make (a_string: like dump) is
			-- Initialize `anchor' to `a_string'
		require
			non_void_string: a_string /= Void
		do
			names_heap.put (a_string)
			anchor_name_id := names_heap.found_item
		ensure
			set: anchor.is_equal (a_string)
		end

	make_current is
			-- Initialize `anchor' to `Current'.
		do
			make (Like_current)
			is_like_current := True
		ensure
			is_like_current_set: is_like_current
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_unevaluated_like_type (Current)
		end

feature -- Properties

	anchor_name_id: INTEGER
			-- Id of `anchor' in `names_heap'.

	anchor: STRING is
			-- Anchor name
		do
			Result := names_heap.item (anchor_name_id)
		end

	is_like_current: BOOLEAN
			-- Is Current like Current?

	has_associated_class: BOOLEAN is False
			-- Does Current have associated class?

	is_valid: BOOLEAN is False
			-- An unevaluated type is never valid.

feature -- Access

	associated_class: CLASS_C is
			-- Class associated to the current type
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := anchor_name_id = other.anchor_name_id and then
				is_like_current = other.is_like_current
		end

feature -- Output

	ext_append_to (st: TEXT_FORMATTER; f: E_FEATURE) is
			-- Append Current type to `st'.
		do
			st.process_keyword_text (ti_Like_keyword, Void)
			st.add_space
			st.add (anchor)
		end

	dump: STRING is
		do
			create Result.make (0)
			Result.append ("like ")
			Result.append (anchor)
		end

feature {NONE} -- Implementation

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			l_other: like Current
		do
			l_other ?= other
			Result := l_other /= Void and then anchor_name_id = l_other.anchor_name_id
		end

	create_info: CREATE_INFO is
			-- Byte code information for entity type creation
		do
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other' in `a_context_class'?
		do
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): like Current is
		do
		end

	type_i: TYPE_I is
			-- C type
		do
		end

	Like_current: STRING is "Current"
			-- String constant for `Current'.

invariant

	non_void_anchor: anchor /= Void
	is_like_current_implies_current_anchor: is_like_current
				implies anchor.is_equal (Like_current)

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

end -- class UNEVALUATED_LIKE_TYPE
