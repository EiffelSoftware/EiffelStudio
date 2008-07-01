indexing
	description: "Name to be inserted by auto-completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAME_FOR_COMPLETION

inherit
	STRING_32
		rename
			make as make_string
		redefine
			is_equal, infix "<"
		end

create
	make

create {NAME_FOR_COMPLETION}
	make_string

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Initialization
		do
			make_from_string (a_name)
			name := a_name
			full_name := a_name
		end

feature -- Access

	name: STRING_32
			-- Completion item name
			-- i.e. Ambiguated name

	full_name: STRING_32
			-- Full completion item name

	insert_name: STRING_32 is
			-- Name to insert in editor
		do
			Result := out
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	full_insert_name: STRING_32 is
			-- Full name to insert in editor
		do
			Result := insert_name
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	sort_name: STRING_32 is
			-- Name for sorting
		do
			Result := string_32_to_lower (name)
		ensure
			result_not_void: Result /= Void
		end

	icon: EV_PIXMAP is
			-- Associated icon based on data
		do
			Result := icon_internal
		end

	tooltip_text: STRING_32 is
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make_from_string (Current)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	grid_item: EV_GRID_ITEM is
			-- Grid item
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			create l_item.make_with_text (out)
			if icon /= Void then
				l_item.set_pixmap (icon)
			end
			Result := l_item
		ensure
			Result_not_void: Result /= Void
		end

	child_grid_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- Grid items of children
		require
			has_child: has_child
		local
			i: INTEGER
		do
			create Result.make (children.count)
			from
				i := children.lower
			until
				i > children.upper
			loop
				Result.extend (children.item (i).grid_item)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	name_matcher: COMPLETION_NAME_MATCHER is
			-- Matcher
		do
			Result := name_matcher_internal
		end

feature -- Status report

	has_child: BOOLEAN is
			-- Does current have child?
		do
			Result := children /= Void and then not children.is_empty
		end

	has_parent: BOOLEAN is
			-- Does current have parent?
		do
			Result := parent /= Void
		end

	is_expanded: BOOLEAN
			-- Is expanded node?

feature -- Element change

	set_name_matcher (a_matcher: COMPLETION_NAME_MATCHER) is
			-- Set `name_matcher' with `a_matcher'.
		do
			name_matcher_internal := a_matcher
		ensure
			name_matcher_is_set: name_matcher_internal = a_matcher
		end

	set_icon (a_icon: EV_PIXMAP) is
			-- Set `icon_internal' with `a_icon'.
		require
			a_icon_not_void: a_icon /= Void
		do
			icon_internal := a_icon
		ensure
			icon_internal_not_void: icon_internal /= Void
		end

	add_child (a_child: like child_type) is
			-- Add `a_child' into `children'.
		require
			a_child_not_void: a_child /= Void
		do
			if children = Void then
				create children.make (1, 10)
			end
			children_index := children_index + 1
			if children_index > children.upper then
				children.grow (children.capacity + 10)
			end
			children.put (a_child, children_index)
			a_child.set_parent (Current)
		ensure
			a_child_added: children.has (a_child)
		end

	remove_child (a_child: like child_type) is
			-- Remove `a_child' from `children'.
		require
			a_child_not_void: a_child /= Void
		do
			if children /= Void then
				children.prune_all (a_child)
			end
		ensure
			a_child_removed: not children.has (a_child)
		end

	sort_children is
			-- Sort children
		do
			if children /= Void and children_index > 1 then
				children := children.subarray (1, children_index)
				children.sort
			else
				children := Void
			end
		end

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_is_expanded (a_b: BOOLEAN) is
			-- Set `is_expanded' with `a_b'.
		do
			is_expanded := a_b
		ensure
			is_expanded_set: is_expanded = a_b
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is name made of same character sequence as `other' (case has no importance)
		local
			l_name: STRING_32
		do
			l_name := sort_name
			Result := l_name.is_equal (other.sort_name)
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is name lexicographically lower than `other'?
		local
			l_name: STRING_32
		do
			l_name := sort_name
			if l_name.is_empty then
				Result := Precursor {STRING_32} (other)
			else
				Result := l_name < other.sort_name
			end
		end

	begins_with (s: STRING_32): BOOLEAN is
			-- Does this feature name begins with `s'?
		require
			s_not_void: s /= Void
		do
			if name_matcher = Void then
				create name_matcher_internal
			end
			Result := name_matcher.prefix_string (s, full_name)
		end

	is_binary_searchable: BOOLEAN is
			-- Is current binary searchable?
		do
			if name_matcher = Void then
				create name_matcher_internal
			end
			Result := name_matcher.binary_searchable (full_name)
		end

feature {CODE_COMPLETION_WINDOW} -- Children

	parent: like child_type
			-- Parent of current

	children: SORTABLE_ARRAY [like child_type]
			-- Possible children nodes.
			-- Normally void.

	children_index: INTEGER
			-- Children index

feature {NONE} -- Implementation

	string_32_to_lower (a_str: ?STRING_32): !STRING_32 is
			-- Make all possible char in `a_str' to lower.
			-- |FIXME: We need real Unicode as lower.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			create Result.make_from_string (a_str)
			from
				i := 1
				nb := a_str.count
			until
				i > nb
			loop
				if a_str.item (i).code <= {CHARACTER_8}.max_value then
					Result.put (a_str.item (i).to_character_8.as_lower, i)
				else
					Result.put (a_str.item (i), i)
				end
				i := i + 1
			end
		end

	icon_internal: EV_PIXMAP;
			-- Icon

	child_type: NAME_FOR_COMPLETION;
			-- Child type

	name_matcher_internal: like name_matcher;

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
