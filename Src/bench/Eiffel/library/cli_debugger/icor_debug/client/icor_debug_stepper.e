indexing
	description: "[
		NOTA:
			typedef struct
			{
			   ULONG32 startOffset, endOffset;
			} COR_DEBUG_STEP_RANGE;
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_STEPPER

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	is_active: BOOLEAN is
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_active (item, $Result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	deactivate is
			-- Desactivate the stepper
		do
			last_call_success := cpp_deactivate (item)
		ensure
			success: last_call_success = 0
		end		

	step (a_b_step_in: BOOLEAN) is
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.Step ("+a_b_step_in.out+") %N")
			end
			last_call_success := cpp_step (item, a_b_step_in.to_integer)
		ensure
			success: last_call_success = 0
		end
		
	step_out is
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.StepOut %N")
			end
			
			last_call_success := cpp_step_out (item)
		ensure
			success: last_call_success = 0
		end		

	step_range (a_b_step_in: BOOLEAN; a_ranges: ARRAY [TUPLE[INTEGER, INTEGER]]) is
		require
			a_ranges /= Void
		local
			l_mp_ranges: MANAGED_POINTER
			l_struct_ptr: POINTER
			i: INTEGER
			l_item: TUPLE [INTEGER, INTEGER]
			l_size: INTEGER
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.StepRange ("+a_b_step_in.out+") %N")
			end
			
			--| create table of 'a_ranges.count' struct COR_DEBUG_STEP_RANGE |--
			l_size := sizeof_COR_DEBUG_STEP_RANGE
			create l_mp_ranges.make (a_ranges.count * l_size)
			from
				i := a_ranges.lower
			until
				i > a_ranges.upper
			loop
				l_item := a_ranges @ i
				
				--| Get address of the struct COR_DEBUG_STEP_RANGE |--
				l_struct_ptr := l_mp_ranges.item + ((i - a_ranges.lower) * l_size)
				
				--| Set value of Struct |--
				set_struct_start_offset (l_struct_ptr, l_item.integer_item (1))
				set_struct_end_offset   (l_struct_ptr, l_item.integer_item (2))
				
				i := i + 1
			end		
			last_call_success := cpp_step_range (item, a_b_step_in.to_integer, l_mp_ranges.item, a_ranges.count)
		ensure
			success: last_call_success = 0
		end

	set_range_il (a_b_il: BOOLEAN) is
		do
			last_call_success := cpp_set_range_il (item, a_b_il.to_integer)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_is_active (obj: POINTER; a_result: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsActive"
		end

	cpp_deactivate (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Deactivate"
		end		

	cpp_step (obj: POINTER; a_b_step_in: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Step"
		end

	cpp_step_out (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"StepOut"
		end		

	cpp_step_range (obj: POINTER; a_b_stepin: INTEGER; a_ranges: POINTER; a_count: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(BOOL, COR_DEBUG_STEP_RANGE*, ULONG32): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"StepRange"
		end		

	cpp_set_range_il (obj: POINTER; a_b_il: INTEGER): INTEGER is
		external
			"[
				C++ ICorDebugStepper signature(BOOL): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"SetRangeIL"
		end

feature {NONE} -- External Struct implementation

--	start_offset (p: POINTER): INTEGER_64 is
--			-- Access field StartOffset of struct pointed by `p'.
--		external
--			"C struct COR_DEBUG_STEP_RANGE access startOffset use %"cli_headers.h%" "
--		end
--
--	end_offset (p: POINTER): INTEGER_64 is
--			-- Access field EndOffset of struct pointed by `p'.
--		external
--			"C struct COR_DEBUG_STEP_RANGE access endOffset use %"cli_headers.h%" "
--		end

	set_struct_start_offset (p: POINTER; v: INTEGER_64) is
			-- Set field `StartOffset' of struct pointed by `p'.
		external
			"C struct COR_DEBUG_STEP_RANGE access startOffset type ULONG32 use %"cli_headers.h%" "
		end

	set_struct_end_offset (p: POINTER; v: INTEGER_64) is
			-- Set field `EndOffset' of struct pointed by `p'.
		external
			"C struct COR_DEBUG_STEP_RANGE access endOffset type ULONG32 use %"cli_headers.h%" "
		alias
			"endOffset"
		end

	sizeof_COR_DEBUG_STEP_RANGE: INTEGER is
			-- Number of bytes in a value of type `COR_DEBUG_STEP_RANGE'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(COR_DEBUG_STEP_RANGE)"
		end

end -- class ICOR_DEBUG_STEPPER

