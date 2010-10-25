note
	description: "Class for performing Atomic Memory Operations"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ATOMIC_MEMORY_OPERATIONS


feature

	frozen compare_and_swap_integer_32 (a_destination: TYPED_POINTER [INTEGER_32]; a_setter_value, a_comparison_value: INTEGER_32): INTEGER_32
			-- Atomic Compare and Swap Operation value `a_destination' value with `a_setter_value' if value at `a_destination' = `a_comparison_value'.
			-- Return initial value at `a_destination', this value is used to determine if swap occurred.
		external
			"C inline use <eif_threads.h>"
		alias
			"return InterlockedCompareExchange ((LONG volatile *) $a_destination, (LONG) $a_setter_value, (LONG) $a_comparison_value);"
		end

	frozen swap_integer_32 (a_destination: TYPED_POINTER [INTEGER_32]; a_setter_value: INTEGER): INTEGER_32
			-- Atomic Swap Operation value `a_destination' value with `a_setter_value'.
			-- Return initial value at `a_destination', this value is used to determine if swap occurred.
		external
			"C inline use <eif_threads.h>"
		alias
			"return InterlockedExchange ((LONG volatile *) $a_destination, (LONG) $a_setter_value);"
		end

	frozen increment_integer_32 (a_destination: TYPED_POINTER [INTEGER_32]): INTEGER_32
			-- Atomic INTEGER_32 Increment of `a_destination' value.
		external
			"C inline use <eif_threads.h>"
		alias
			"return InterlockedIncrement ((LONG volatile *) $a_destination);"
		end

	frozen decrement_integer_32 (a_destination: TYPED_POINTER [INTEGER_32]): INTEGER_32
			-- Atomic INTEGER_32 Decrement of `a_destination' value.
		external
			"C inline use <eif_threads.h>"
		alias
			"return InterlockedDecrement ((LONG volatile *) $a_destination);"
		end

	frozen add_integer_32 (a_destination: TYPED_POINTER [INTEGER_32]; a_value: INTEGER_32): INTEGER_32
			-- Atomic INTEGER_32 Add of `a_destination' value with `a_value'.
			-- Returns initial value of `a_destination'.
		external
			"C inline use <eif_threads.h>"
		alias
			"return InterlockedExchangeAdd ((LONG volatile *) $a_destination, (LONG) $a_value);"
		end

end
