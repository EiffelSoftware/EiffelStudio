note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_ARRAY

inherit
	XRPC_INDEXABLE [NATURAL]

create
	make_empty,
	make_from_array

convert
	make_from_array ({ARRAY [XRPC_VALUE]}),
	to_array: {ARRAY [XRPC_VALUE]}

feature {NONE} -- Initialization

	make_empty
			-- Creates a new, empty XML-RPC array.
		do
			create internal_array.make (1, 0)
		end

	make_from_array (a_array: ARRAY [XRPC_VALUE])
			-- Creates a new XML-RPC array from an Eiffel array.
			--
			-- `a_array': The array to initialize from.
		require
			a_array_attached: attached a_array
			not_a_array_is_empty: not a_array.is_empty
		do
			copy_from_array (a_array)
		ensure
			same_count: a_array.count.as_natural_32 = count
		end

feature -- Access

	linear_representation: LINEAR [XRPC_VALUE]
			-- <Precursor>
		local
			l_list: ARRAYED_LIST [XRPC_VALUE]
			l_array: like internal_array
			i, i_count: INTEGER
		do
			if attached internal_linear_representation as l_result then
				Result := l_result
			else
				l_array := internal_array
				i_count := l_array.count
				create l_list.make (i_count)
				from i := 1 until i > i_count loop
					l_list.extend (l_array[i])
					i := i + 1
				end
				Result := l_list
			end
		ensure then
			result_attached: attached Result
		end

	type: XRPC_TYPE
			-- <Precursor>
		once
			Result := {XRPC_TYPE}.array
		end

feature -- Measurement

	count: NATURAL
			-- Number of items in Current
		do
			Result := internal_array.count.as_natural_32
		end

feature {NONE} -- Element change

	copy_from_array (a_array: ARRAY [XRPC_VALUE])
			-- Copies all the items from an array and reinitialized Current.
			--
			-- `a_array': The array to initialize from.
		require
			a_array_attached: attached a_array
			not_a_array_is_empty: not a_array.is_empty
		local
			l_array: like internal_array
			i, i_lower, i_upper: INTEGER
		do
			create l_array.make (1, a_array.count)
			from
				i := 0
				i_lower := a_array.lower
				i_upper := a_array.upper
			until
				i > i_upper
			loop
				l_array[i + 1] := a_array [i_lower + i]
				i := i + 1
			end
			internal_array := l_array

			internal_linear_representation := Void
		ensure
			internal_linear_representation_detached: internal_linear_representation = Void
			same_count: a_array.count.as_natural_32 = count
		end

feature -- Status report

	is_valid_index (a_index: NATURAL): BOOLEAN
			-- <Precursor>
		do
			Result := a_index >= 1 and then a_index <= count
		ensure then
			index_big_enough: Result implies a_index >= 1
			index_small_enough: Result implies a_index <= count
		end

feature -- Query

	item alias "[]" (a_index: NATURAL): XRPC_VALUE
			-- <Precursor>
		do
			Result := internal_array[a_index.as_integer_32]
		end

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_VISITOR)
			-- <Precursor>
		do

		end

feature -- Conversion

	to_array: ARRAY [XRPC_VALUE]
			-- Converts the array into an Eiffel {ARRAY}.
		local
			l_array: like internal_array
		do
			l_array := internal_array
			create Result.make (1, l_array.count)
			Result.copy (l_array)
		ensure
			result_attached: attached Result
			result_lower_is_default: Result.lower = 1
			result_same_count: Result.count.as_natural_32 = count
		end

feature {NONE} -- Implementation

	internal_array: ARRAY [XRPC_VALUE]
			-- Array of values.

	internal_linear_representation: detachable like linear_representation
			-- Cached version of `linear_representation'.
			-- Note: Do not use directly!

invariant
	internal_array_attached: attached internal_array
	internal_array_lower_is_default: internal_array.lower = 1

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
