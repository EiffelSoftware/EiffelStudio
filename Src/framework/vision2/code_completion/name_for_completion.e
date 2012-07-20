note
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
			is_equal, is_less,
			new_string
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
			-- Initialization
		do
			name := a_name
			full_name := a_name
			make_from_string (a_name)
		end

feature -- Access

	name: STRING_32
			-- Completion item name
			-- i.e. Ambiguated name

	full_name: STRING_32
			-- Full completion item name

	insert_name: STRING_32
			-- Name to insert in editor
		do
			Result := out
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	full_insert_name: STRING_32
			-- Full name to insert in editor
		do
			Result := insert_name
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	sort_name: STRING_32
			-- Name for sorting
		do
			Result := string_32_to_lower (name)
		ensure
			result_not_void: Result /= Void
		end

	icon: detachable EV_PIXMAP
			-- Associated icon based on data
		do
			Result := icon_internal
		end

	tooltip_text: STRING_32
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make_from_string (Current)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	grid_item: EV_GRID_ITEM
			-- Grid item
		local
			l_item: EV_GRID_LABEL_ITEM
		do
			create l_item.make_with_text (out)
			if attached icon as l_icon then
				l_item.set_pixmap (l_icon)
			end
			Result := l_item
		ensure
			Result_not_void: Result /= Void
		end

	child_grid_items: ARRAYED_LIST [EV_GRID_ITEM]
			-- Grid items of children
		require
			has_child: has_child
		local
			i: INTEGER
		do
			if attached children as l_children then
				create Result.make (l_children.count)
				from
					i := l_children.lower
				until
					i > l_children.upper
				loop
					Result.extend (l_children.item (i).grid_item)
					i := i + 1
				end
			else
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	name_matcher: COMPLETION_NAME_MATCHER
			-- Matcher
		do
			if attached name_matcher_internal as l_matcher then
				Result := l_matcher
			else
				create Result
			end
		end

feature -- Status report

	has_child: BOOLEAN
			-- Does current have child?
		do
			Result := attached children as l_children and then not l_children.is_empty
		end

	has_parent: BOOLEAN
			-- Does current have parent?
		do
			Result := parent /= Void
		end

	is_expanded: BOOLEAN
			-- Is expanded node?

feature -- Element change

	set_name_matcher (a_matcher: COMPLETION_NAME_MATCHER)
			-- Set `name_matcher' with `a_matcher'.
		do
			name_matcher_internal := a_matcher
		ensure
			name_matcher_is_set: name_matcher_internal = a_matcher
		end

	set_icon (a_icon: EV_PIXMAP)
			-- Set `icon_internal' with `a_icon'.
		require
			a_icon_not_void: a_icon /= Void
		do
			icon_internal := a_icon
		ensure
			icon_set: icon = a_icon
		end

	add_child (a_child: like child_type)
			-- Add `a_child' into `children'.
		require
			a_child_not_void: a_child /= Void
		local
			l_children: like children
		do
			l_children := children
			if l_children = Void then
				create l_children.make (1, 10)
				children := l_children
			end
			children_index := children_index + 1
			if children_index > l_children.upper then
				l_children.grow (l_children.capacity + 10)
			end
			l_children.put (a_child, children_index)
			a_child.set_parent (Current)
		ensure
			a_child_added: attached children as l_children2 and then l_children2.has (a_child)
		end

	remove_child (a_child: like child_type)
			-- Remove `a_child' from `children'.
		require
			a_child_not_void: a_child /= Void
		do
			if attached children as l_children then
				l_children.prune_all (a_child)
			end
		ensure
			a_child_removed: attached children as l_children implies not l_children.has (a_child)
		end

	sort_children
			-- Sort children
		local
			l_children: like children
		do
			l_children := children
			if l_children /= Void and then children_index > 1 then
				l_children := l_children.subarray (1, children_index)
				l_children.sort
				children := l_children
			else
				children := Void
			end
		end

	set_parent (a_parent: like parent)
			-- Set `parent' with `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_is_expanded (a_b: BOOLEAN)
			-- Set `is_expanded' with `a_b'.
		do
			is_expanded := a_b
		ensure
			is_expanded_set: is_expanded = a_b
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is name made of same character sequence as `other' (case has no importance)
		local
			l_name: STRING_32
		do
			l_name := sort_name
			Result := l_name.is_equal (other.sort_name)
		end

	is_less alias "<" (other: like Current): BOOLEAN
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

	begins_with (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Does this feature name begins with `s'?
		do
			if s /= Void then
				Result := name_matcher.prefix_string (s.to_string_32, full_name)
			end
		end

	is_binary_searchable: BOOLEAN
			-- Is current binary searchable?
		do
			Result := name_matcher.binary_searchable (full_name)
		end

feature {CODE_COMPLETION_WINDOW} -- Children

	parent: detachable like child_type
			-- Parent of current

	children: detachable SORTABLE_ARRAY [like child_type]
			-- Possible children nodes.
			-- Normally void.

	children_index: INTEGER
			-- Children index

feature {NONE} -- Implementation

	new_string (n: INTEGER): like Current
			-- New instance of current with space for at least `n' characters.
		do
			create Result.make (name)
		end

	icon_internal: detachable EV_PIXMAP
			-- Storage for `icon'.

	string_32_to_lower (a_str: detachable STRING_32): attached STRING_32
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

	child_type: NAME_FOR_COMPLETION
			-- Child type
		require
			callable: False
		do
			check False then end
		end

	name_matcher_internal: detachable like name_matcher;

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
