indexing
	description: "Abstract representation of an inspect value of a particular type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TYPED_INTERVAL_VAL_B [H]

inherit
	INTERVAL_VAL_B
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (v: H) is
			-- Initialize `value' with `v'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current?
		do
			Result := value = other.value
		end

	is_next (other: like Current): BOOLEAN is
			-- Is `other' next to Current?
		do
			Result := other.value = next_value (value)
		end

feature {TYPED_INTERVAL_B, TYPED_INTERVAL_VAL_B, BYTE_NODE_VISITOR} -- Data

	value: H
			-- Constant value

feature {TYPED_INTERVAL_B} -- C code generation

	generate_interval (other: like Current) is
			-- Generate interval Current..`other'.
		local
			lo, up: H
			buf: GENERATION_BUFFER
		do
				-- Do not use `lo > up' as exit test since `lo'
				-- will be out of bounds when `up' is the greatest
				-- allowed value.
			from
				buf := buffer
				lo := value
				up := other.value
				buf.put_string ("case ")
				generate_value (lo)
				buf.put_character (':')
				buf.put_new_line
			until
				lo = up
			loop
				lo := next_value (lo)
				buf.put_string ("case ")
				generate_value (lo)
				buf.put_character (':')
				buf.put_new_line
			end
		end

feature {NONE} -- Implementation: C code generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		require
			value_not_void: value /= Void
		deferred
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		require
			value_not_void: value /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
