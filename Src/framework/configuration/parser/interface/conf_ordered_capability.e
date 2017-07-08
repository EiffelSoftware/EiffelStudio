note
	description: "[
			A capability option that can be ordered by level.
			It includes 2 related settings:
			- a list of available values that are ordered from least capabable (less requirements, less rules to satisfy) to most capable (more requirements, more rules to satisfy)
			- a value used when the corresponding group is a root one
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ORDERED_CAPABILITY

inherit
	DEBUG_OUTPUT

create {CONF_TARGET_OPTION}
	make

feature {NONE} -- Creation

	make (option_value: CONF_VALUE_CHOICE)
			-- Associate capability with the specified choice option.
			-- The choice indicates maximum supported capability.
		do
			value :=option_value
			unset_root
		ensure
			value_set: value = option_value
			not_is_root_set: not is_root_set
		end

feature -- Status report

	is_valid_item (v: like {CONF_VALUE_CHOICE}.item): BOOLEAN
			-- Does `v' represent a valid (root) item for this option?
		do
			Result := value.is_valid_item (v)
		end

	is_valid_index (v: like {CONF_VALUE_CHOICE}.index): BOOLEAN
			-- Does value `v' represent a valid index for this option?
		do
			Result := value.is_valid_index (v)
		end

	is_capable (v: like {CONF_VALUE_CHOICE}.index): BOOLEAN
			-- Does value `v' correspond to a supported capability?
		require
			is_valid_index: is_valid_index (v)
		do
			Result := 0 < v and then v <= value.index
		ensure
			definition: Result = (0 < v and v <= value.index)
		end

	is_root_set: BOOLEAN
			-- Is there any explicitly selected value used when an entity is used as a root?
		do
			Result := custom_root_index /= 0
		ensure
			definition: Result = (0 < custom_root_index and custom_root_index <= value.count)
		end

	is_custom_root_valid: BOOLEAN
			-- Is expclicitly selected value compatible with supported capabilities?
		do
			Result := not is_root_set or else is_capable (custom_root_index)
		ensure
			true_if_unset: not is_root_set implies Result
			definition_if_set: is_root_set implies Result = is_capable (custom_root_index)
		end

feature -- Comparison

	same_kind (other: CONF_ORDERED_CAPABILITY): BOOLEAN
			-- Does `Current' represent the same capability as `other'?
		do
			Result := value.same_kind (other.value)
		end

feature -- Access

	value: CONF_VALUE_CHOICE
			-- An option value limited to the specified items.
			-- All items are considered as ordered with the first being least capable and the last - most capable.

	default_root_index: like root_index
			-- A default index of a value that is used when a group is used as a root of a system.
		do
			Result := value.index
		ensure
			is_valid_index: is_valid_index (Result)
			consistent: is_capable (Result)
		end

	root: like {CONF_VALUE_CHOICE}.item
			-- A value that is used when a group is used as a root of a system.
		do
			Result := value [root_index]
		ensure
			result_attached: attached Result
			is_valid_item: is_valid_item (Result)
		end

	root_index: like {CONF_VALUE_CHOICE}.index
			-- An index of a value that is used when a group is used as a root of a system.
		do
			Result :=
				if is_root_set and then is_capable (custom_root_index) then
					custom_root_index
				else
					default_root_index
				end
		ensure
			is_valid_index: is_valid_index (Result)
			consistent: is_capable (Result)
			definition: Result =
				if is_root_set and then is_capable (custom_root_index) then
					custom_root_index
				else
					default_root_index
				end
		end

	custom_root: like {CONF_VALUE_CHOICE}.item
			-- Requested value that would be used when a group is used as a root of a system.
		do
			if is_root_set then
				Result := value [custom_root_index]
			else
				Result := {STRING_32} ""
			end
		ensure
			result_attached: attached Result
			is_valid_item: is_root_set = is_valid_item (Result)
		end

	custom_root_index: like root_index
			-- Explicitly set `root_index'.

feature -- Modification

	put_root (v: like custom_root)
			-- Set `custom_root' to a custom value `v'.
		require
			value_attached: attached value
			is_valid_item: is_valid_item (v)
		do
			put_root_index (value.index_of (v))
		ensure
			custom_root_set: custom_root.same_string (v)
			is_root_set: is_root_set
		end

	put_root_index (v: like root_index)
			-- Set `root_index' to a custom value `v'.
		require
			is_valid_index: is_valid_index (v)
		do
			custom_root_index := v
		ensure
			is_root_set: is_root_set
			custom_root_index_set: custom_root_index = v
			root_index_set: is_capable (v) implies root_index = v
		end

	unset_root
			-- Unset custom root value.
		do
			custom_root_index := 0
		ensure
			not_is_root_set: not is_root_set
		end

	set_safely_root (other: like Current)
			-- Set root value from `other' if it is not set yet.
		require
			other_attached: attached other
		do
			if not is_root_set and then other.is_root_set and then root_index /= other.root_index then
				put_root_index (other.root_index)
			end
		ensure
			old_value:
				(old is_root_set or else not other.is_root_set or else old root_index = other.root_index) implies
					custom_root_index = old custom_root_index
			new_value:
				(not old is_root_set and then other.is_root_set and then old root_index /= other.root_index) implies
					(is_root_set and custom_root_index = other.root_index)
		end

	set_safely (other: like Current)
			-- Set value from `other' if it is not set yet.
		require
			other_attached: attached other
		do
			value.set_safely (other.value)
				-- Root should be set after capabilities.
			set_safely_root (other)
		ensure
			old_value: (old value.is_set or else old value.twin ~ other.value) implies value ~ old value.twin
			new_value: (not old value.is_set and then old value.twin /~ other.value) implies value.is_set
			old_root_value:
				(old is_root_set or else not other.is_root_set or else old root_index = other.root_index) implies
					custom_root_index = old custom_root_index
			new_root_value:
				(not old is_root_set and then other.is_root_set and then old root_index /= other.root_index) implies
					custom_root_index = other.root_index
		end

feature -- Output

	debug_output: STRING_32
			-- <Precursor>
		do
			Result := {STRING_32} "capability: "
			Result.append (value.debug_output)
			Result.append_string_general ("; root: ")
			if is_root_set then
				Result.append (root)
				if root_index /= custom_root_index then
					Result.append_string_general ("(custom: ")
					Result.append (custom_root)
					Result.append_character (')')
				end
			else
				Result.append_string_general ("default (")
				Result.append (value [default_root_index])
				Result.append_character (')')
			end
		end

invariant
	is_valid_custom_root_index: is_root_set implies is_valid_index (custom_root_index)

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
