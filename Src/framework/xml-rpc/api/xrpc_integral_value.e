﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_INTEGRAL_VALUE [G -> ANY]

inherit
	XRPC_VALUE

convert
	value: {G}

feature {NONE} -- Initialization

	make (a_value: G)
			-- Initializes the value with a raw string value.
			--
			-- `a_value': A value to initialize the XML RPC value with
		do
			set_value (a_value)
		ensure
			value_set: value ~ a_value
		end

	make_from_string (a_value: READABLE_STRING_32)
			-- Initializes the value with a raw string value.
			--
			-- `a_value': The raw string value.
		require
			a_value_attached: attached a_value
		do
			set_value_from_string (a_value)
		end

feature -- Access

	value: G assign set_value
			-- Actual value.

	frozen item: G assign set_value
			-- Actual value.
		do
			Result := value
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Element change

	set_value (a_value: G)
			-- Sets the value.
			--
			-- `a_value': The new value to set.
		do
			is_valid := True
			value := a_value.twin
		ensure
			is_valid: is_valid
			value_set: value ~ a_value
		end

	set_value_from_string (a_string: READABLE_STRING_32)
			-- Sets the value from a string.
			--
			-- `a_string': The string value to attempt to set `value' from.
		require
			a_string_attached: attached a_string
		deferred
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>

invariant
	is_scalar: is_integral

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
