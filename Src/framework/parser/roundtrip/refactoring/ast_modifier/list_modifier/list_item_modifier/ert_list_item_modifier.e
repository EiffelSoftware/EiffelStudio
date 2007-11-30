indexing
	description: "Object that represents a modification to an EIFFEL_LIST item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_LIST_ITEM_MODIFIER

inherit
	COMPARABLE

	ERT_AST_MODIFIER
		undefine
			is_equal
		end

	ERT_EIFFEL_LIST_ITEM_ARGUMENTS
		undefine
			is_equal
		end

feature -- Initialization

	initialize (a_text: STRING; a_owner: INTEGER; a_index: INTEGER; a_marker: INTEGER; a_list: like match_list) is
			-- Initialize
		require
			a_list_not_void: a_list /= Void
		do
			if a_text = Void then
				text := Void
			else
				text := a_text.twin
			end
			text := a_text
			owner := a_owner
			index := a_index
			addition_marker := a_marker
			match_list := a_list
		ensure
			text_set: (a_text = Void implies text = Void) and (a_text /= Void implies text.is_equal (a_text))
			owner_set: owner = a_owner
			index_set: index = a_index
			addition_marker_set: addition_marker = a_marker
			match_list_set: match_list = a_list
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			if owner /= other.owner then
				Result := owner < other.owner
			elseif addition_marker /= other.addition_marker then
				Result := addition_marker < other.addition_marker
			else
				check addition_marker /= 0 end
				Result := index < other.index
			end
		end

feature -- Setting

	set_is_separator_needed (b: BOOLEAN) is
			-- Set `is_separator_needed' with `b'.
		do
			is_separator_needed := b
		ensure
			is_separator_needed_set: is_separator_needed = b
		end

feature -- Access

	owner: INTEGER
			-- Owner item

	addition_marker: INTEGER
			-- For prepended, is -1, for appended, is 1,
			-- for original item, is 0

	index: INTEGER
			-- Index of inserted order	

	is_original_item: BOOLEAN is
			-- Is current an original item?
		do
			Result := addition_marker = 0
		end

feature -- Status reporting

	is_removed: BOOLEAN is
			-- Is current item removed?
		deferred
		end

	is_separator_needed: BOOLEAN
			-- Is separator needed?

	has_text_changed: BOOLEAN is
			-- Has text changed?
		deferred
		end

	text: STRING
			-- Text of current item

feature{NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- Match list used by roundtrip

invariant
	match_list_not_void: match_list /= Void

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
