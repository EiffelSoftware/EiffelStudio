note
	description: "Choice option value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONF_VALUE_CHOICE

inherit
	CONF_VALUE
		redefine
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

create {CONF_OPTION}

	make

feature {NONE} -- Creation

	make (items: ARRAY [READABLE_STRING_32]; default_index: like index)
			-- Create a new object with `items' as allowed option values and `index' set to `default_index'.
			-- Use `put' or `put_index' to select the index explicitly.
		require
			items_attached: items /= Void
			is_normalized: items.lower = 1
			is_default_item_present: items.lower <= default_index and default_index <= items.upper
		do
			index := default_index
			content := items
		ensure
			index_set: index = default_index
			content_set: content = items
			count_set: count = items.count
			not_is_set: not is_set
		end

feature -- Status report

	is_valid_item (value: like item): BOOLEAN
			-- Does `value' represent a valid item for this option?
		require
			value_attached: value /= Void
		do
			Result := content.has (value)
		end

feature -- Access

	index: NATURAL_8 assign put_index
			-- Currently selected index (if any)

	item: READABLE_STRING_32 assign put
			-- Current value (if any)
		do
			if is_set then
				Result := content [index]
			else
				Result := ""
			end
		end

	count: NATURAL_8
			-- Total number of available indexes
		do
			Result := content.count.to_natural_8
		ensure
			expected_result: Result = content.count
		end

feature -- Modification

	put_index (value: like index)
			-- Set `index' to `value'.
		require
			value_small_enough: value < count
		do
			index := value
			is_set := True
		ensure
			index_set: index = value
			is_set: is_set
		end

	put (value: like item)
			-- Set `item' to `value'.
		require
			value_attached: value /= Void
			is_valid_item: is_valid_item (value)
		do
			from
				index := content.lower.to_natural_8
			until
				item.is_equal (value)
			loop
				index := index + 1
			variant
				content.upper - index + 1
			end
			is_set := True
		ensure
			item_set: item.is_equal (value)
			is_set: is_set
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := item.out
		end

	debug_output: STRING
			-- <Precursor>
		do
			if is_set then
				Result := item
			else
				Result := "default ("
				Result.append_string_general (content [index])
				Result.append_character (')')
			end
		end

feature {CONF_VALUE_CHOICE} -- Content

	content: ARRAY [READABLE_STRING_32]
			-- All possible `item' values

invariant
	positive_count: count > 0
	attached_content: content /= Void
	index_in_range: index < count

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
end
