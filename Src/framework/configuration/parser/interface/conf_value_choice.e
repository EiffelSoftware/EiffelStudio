note
	description: "[
			Choice option value.
			The value is one of known values indexed by successive indexes starting from 1.
			Initially an option is unset and its index corresponds to the default one.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONF_VALUE_CHOICE

inherit
	CONF_VALUE
		redefine
			is_equal,
			out,
			set_safely,
			unset
		end

	DEBUG_OUTPUT
		redefine
			is_equal,
			out
		end

create {CONF_OPTION, CONF_TARGET_SETTINGS}

	make

feature {NONE} -- Creation

	make (items: ARRAY [READABLE_STRING_32]; default_index_value: like index)
			-- Create a new object with `items' as allowed option values and `index' set to `default_index_value'.
			-- Use `put' or `put_index' to select the index explicitly.
		require
			items_attached: items /= Void
			is_normalized: items.lower = 1
			is_default_item_present: items.lower <= default_index_value and default_index_value <= items.upper
		do
			default_index := default_index_value
			index := default_index_value
			content := items
			content.compare_objects
		ensure
			default_index_set: default_index = default_index_value
			index_set: index = default_index_value
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

	is_valid_index (value: like index): BOOLEAN
			-- Does `value' represent a valid index for this option?
		do
			Result := 0 < value and value <= count
		ensure
			definition: Result =(0 < value and value <= count)
		end

feature -- Comparison

	is_equal (other: CONF_VALUE_CHOICE): BOOLEAN
			-- <Precursor>
		do
			Result :=
				index = other.index and then
				default_index = other.default_index and then
				is_set = other.is_set and then
				content ~ other.content
		end

	same_kind (other: CONF_VALUE_CHOICE): BOOLEAN
			-- Does `Current' represent the same option value as `other'?
		do
			Result :=
				count = other.count and
				default_index = other.default_index and then
				content ~ other.content
		end

feature -- Access

	default_index: like index
			-- Default index.

	index: NATURAL_8 assign put_index
			-- Currently selected index if `is_set' or `default_index` otherwise.

	item: READABLE_STRING_32 assign put
			-- Current value (if any).
		do
			if is_set then
				Result := content [index]
			else
				Result := {STRING_32} ""
			end
		end

	count: NATURAL_8
			-- Total number of available indexes.
		do
			Result := content.count.to_natural_8
		ensure
			expected_result: Result = content.count
		end

	i_th alias "[]" (i: like index): like item
			-- Value at index `i'.
		require
			is_valid_index: is_valid_index (i)
		do
			Result := content [i]
		end

	index_of (value: like item): like index
			-- Index of an item `value'.
		require
			is_valid_item: is_valid_item (value)
		do
			from
				Result := 1
			invariant
				has_value: across Result.as_integer_32 |..| count as i some content [i].same_string (value) end
			until
				content [Result].same_string (value)
			loop
				Result := Result + 1
			variant
				count.as_integer_32 - Result + 1
			end
		ensure
			is_valid_index: is_valid_index (Result)
			index_of_value: i_th (Result).same_string (value)
		end

feature -- Modification

	set_safely (other: CONF_VALUE_CHOICE)
			-- <Precursor>
		local
			d: like default_index
		do
			d := default_index
			Precursor (other)
				-- Restore default index (maybe required if default indexes are different due to different versions).
			default_index := d
		end

	put_default_index (value: like index)
			-- Set `default_index' to `value'.
		require
			is_valid_value: is_valid_index (value)
		do
			default_index := value
			if not is_set then
					-- Preserve class invariant.
				index := value
			end
		ensure
			default_index_set: default_index = value
		end

	put_index (value: like index)
			-- Set `index' to `value'.
		require
			is_valid_value: is_valid_index (value)
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
				-- Option should be marked as set to get non-empty strings from `item'.
			is_set := True
			index := index_of (value)
		ensure
			item_set: item.same_string (value)
			is_set: is_set
		end

	unset
			-- Unset option value and set its `index' to the default one.
		do
			Precursor
			index := default_index
		ensure then
			index_set: index = default_index
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := item.out
		end

	debug_output: STRING_32
			-- <Precursor>
		do
			if is_set then
				Result := item
			else
				Result := {STRING_32} "default ("
				Result.append (content [default_index])
				Result.append_character ({CHARACTER_32} ')')
			end
		end

feature {CONF_VALUE_CHOICE} -- Content

	content: ARRAY [READABLE_STRING_32]
			-- All possible `item' values.

invariant
	positive_count: count > 0
	attached_content: content /= Void
	valid_content_lower: content.lower = 1
	is_value_comparison: content.object_comparison
	index_in_range: 0 < index and index <= count
	default_index_in_range: 0 < default_index and default_index <= count
	unset_index: not is_set implies index = default_index

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
