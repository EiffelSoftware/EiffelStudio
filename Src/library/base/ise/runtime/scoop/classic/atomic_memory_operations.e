note
	description: "Class for performing Atomic Memory Operations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ATOMIC_MEMORY_OPERATIONS

feature

	destination_type: POINTER do end
		-- Type used for accession INTEGER_32 address
		-- Change to TYPED_POINTER [INTEGER_32] when feature in SPECIAL is available.

	frozen compare_and_swap_integer_32 (a_destination: like destination_type; a_setter_value, a_comparison_value: INTEGER_32): INTEGER_32
			-- Atomic Compare and Swap Operation value `a_destination' value with `a_setter_value' if value at `a_destination' = `a_comparison_value'.
			-- Return initial value at `a_destination', this value is used to determine if swap occurred.
		external
			"C macro use <eif_atomops.h>"
		alias
			"RTS_ACAS_I32"
		end

	frozen swap_integer_32 (a_destination: like destination_type; a_setter_value: INTEGER): INTEGER_32
			-- Atomic Swap Operation value `a_destination' value with `a_setter_value'.
			-- Return initial value at `a_destination', this value is used to determine if swap occurred.
		external
			"C macro use <eif_atomops.h>"
		alias
			"RTS_AS_I32"
		end

	frozen increment_integer_32 (a_destination: like destination_type): INTEGER_32
			-- Atomic INTEGER_32 Increment of `a_destination' value.
		external
			"C macro use <eif_atomops.h>"
		alias
			"RTS_AI_I32"
		end

	frozen decrement_integer_32 (a_destination: like destination_type): INTEGER_32
			-- Atomic INTEGER_32 Decrement of `a_destination' value.
		external
			"C macro use <eif_atomops.h>"
		alias
			"RTS_AD_I32"
		end

	frozen add_integer_32 (a_destination: like destination_type; a_value: INTEGER_32): INTEGER_32
			-- Atomic INTEGER_32 Add of `a_destination' value with `a_value'.
			-- Returns initial value of `a_destination'.
		external
			"C macro use <eif_atomops.h>"
		alias
			"RTS_AA_I32"
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
