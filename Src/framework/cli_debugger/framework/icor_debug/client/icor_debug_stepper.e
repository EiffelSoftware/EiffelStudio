note
	description: "[
			NOTA:
				typedef struct
				{
				   ULONG32 startOffset, endOffset;
				} COR_DEBUG_STEP_RANGE;
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_STEPPER

inherit
	ICOR_OBJECT

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	is_active: BOOLEAN
		local
			r: INTEGER
		do
			last_call_success := cpp_is_active (item, $r)
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	deactivate
			-- Desactivate the stepper
		do
			last_call_success := cpp_deactivate (item)
		end

	set_intercept_mask (a_mask: INTEGER)
			--|     SetInterceptMask controls which intercept code will be stepped
			--|     into by the stepper. If the bit for an interceptor is set, the
			--|     stepper will complete with reason STEPPER_INTERCEPT when the
			--|     given type of intercept occurs.  If the bit is cleared, the
			--|     intercepting code will be skipped.
			--|
			--|     Note that SetInterceptMask may have unforeseen interactions
			--|     with SetUnmappedStopMask (from the user's point of view).  For
			--|     example, if the only visible (ie, non internal) portion of class
			--|     init code lacks mapping info (STOP_NO_MAPPING_INFO) and
			--|     STOP_NO_MAPPING_INFO isn't set, then we'll step over the class init.
			--|
			--|     By default, only INTERCEPT_NONE will be used.

			--|    typedef enum CorDebugIntercept
			--|    {
			--|          INTERCEPT_NONE                = 0x0 ,
			--|          INTERCEPT_CLASS_INIT          = 0x01,
			--|          INTERCEPT_EXCEPTION_FILTER    = 0x02,
			--|          INTERCEPT_SECURITY            = 0x04,
			--|          INTERCEPT_CONTEXT_POLICY      = 0x08,
			--|          INTERCEPT_INTERCEPTION        = 0x10,
			--|          INTERCEPT_ALL                 = 0xffff
			--|    } CorDebugIntercept;
		do
			last_call_success := cpp_set_intercept_mask (item, a_mask)
		end

	set_unmapped_stop_mask (a_mask: INTEGER)
			--|
			--| SetUnmappedStopMask controls whether the stepper
			--| will stop in jitted code which is not mapped to IL.
			--|
			--| If the given flag is set, then that type of unmapped code
			--| will be stopped in.  Otherwise stepping transparently continues.
			--|
			--| It should be noted that if one doesn't use a stepper to enter a
			--| method (for example, the main() method of C++), then one
			--| won't neccessarily step over prologs,etc.
			--|
			--| By default, STOP_OTHER_UNMAPPED will be used.
			--|
			--| STOP_UNMANAGED is only valid w/ interop debugging.
			--|
		do
			last_call_success := cpp_set_unmapped_stop_mask (item, a_mask)
		end

	step (a_b_step_in: BOOLEAN)
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.Step (" + a_b_step_in.out + ") %N")
			end
			last_call_success := cpp_step (item, a_b_step_in.to_integer)
		ensure
			success: last_call_success = 0
		end

	step_out
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.StepOut %N")
			end

			last_call_success := cpp_step_out (item)
		ensure
			success: last_call_success = 0
		end

	step_range (a_b_step_in: BOOLEAN; a_ranges: ARRAY [TUPLE [left: INTEGER; right: INTEGER]])
			-- Step ranges.
			-- FIXME jfiat [2008/11/07] : a_ranges should be made of NATURAL_32
		require
			a_ranges /= Void
		local
			l_mp_ranges: MANAGED_POINTER
			l_struct_ptr: POINTER
			i: INTEGER
			l_item: TUPLE [left: INTEGER; right: INTEGER]
			l_size: INTEGER
		do
			debug ("debugger_eifnet_data")
				io.error.put_string ("[enter] ICOR_DEBUG_STEPPER.StepRange (" + a_b_step_in.out + ") %N")
			end

				--| create table of 'a_ranges.count' struct COR_DEBUG_STEP_RANGE |--
			l_size := sizeof_COR_DEBUG_STEP_RANGE
			create l_mp_ranges.make (a_ranges.count * l_size)
			from
				i := a_ranges.lower
			until
				i > a_ranges.upper
			loop
				l_item := a_ranges [i]

					--| Get address of the struct COR_DEBUG_STEP_RANGE |--
				l_struct_ptr := l_mp_ranges.item + ((i - a_ranges.lower) * l_size)

					--| Set value of Struct |--
				set_struct_start_offset (l_struct_ptr, l_item.left.as_natural_32)
				set_struct_end_offset (l_struct_ptr, l_item.right.as_natural_32)

				i := i + 1
			end
			last_call_success := cpp_step_range (item, a_b_step_in.to_integer, l_mp_ranges.item, a_ranges.count.to_natural_32)
		ensure
			success: last_call_success = 0
		end

	set_range_il (a_b_il: BOOLEAN)
		do
			last_call_success := cpp_set_range_il (item, a_b_il.to_integer)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_is_active (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsActive"
		end

	cpp_deactivate (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Deactivate"
		end

	cpp_set_intercept_mask (obj: POINTER; a_mask: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(CorDebugIntercept): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetInterceptMask"
		end

	cpp_set_unmapped_stop_mask (obj: POINTER; a_mask: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(CorDebugUnmappedStop): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetUnmappedStopMask"
		end

	cpp_step (obj: POINTER; a_b_step_in: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(BOOL): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Step"
		end

	cpp_step_out (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"StepOut"
		end

	cpp_step_range (obj: POINTER; a_b_stepin: INTEGER; a_ranges: POINTER; a_count: NATURAL_32): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(BOOL, COR_DEBUG_STEP_RANGE*, ULONG32): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"StepRange"
		end

	cpp_set_range_il (obj: POINTER; a_b_il: INTEGER): INTEGER
		external
			"[
				C++ ICorDebugStepper signature(BOOL): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetRangeIL"
		end

feature -- enum CorDebugIntercept

	frozen enum_cor_debug_intercept__INTERCEPT_NONE: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_NONE"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_CLASS_INIT: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_CLASS_INIT"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_EXCEPTION_FILTER: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_EXCEPTION_FILTER"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_SECURITY: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_SECURITY"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_CONTEXT_POLICY: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_CONTEXT_POLICY"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_INTERCEPTION: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_INTERCEPTION"
		end

	frozen enum_cor_debug_intercept__INTERCEPT_ALL: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"INTERCEPT_ALL"
		end

feature -- enum CorDebugUnmappedStop

		--|    typedef enum CorDebugUnmappedStop
		--|    {
		--|        STOP_NONE               = 0x0,
		--|        STOP_PROLOG             = 0x01,
		--|        STOP_EPILOG             = 0x02,
		--|        STOP_NO_MAPPING_INFO    = 0x04,
		--|        STOP_OTHER_UNMAPPED     = 0x08,
		--|        STOP_UNMANAGED          = 0x10,
		--|
		--|        STOP_ALL                = 0xffff,
		--|
		--|    } CorDebugUnmappedStop;

	frozen enum_cor_debug_unmapped_stop__stop_none: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_NONE"
		end

	frozen enum_cor_debug_unmapped_stop__stop_prolog: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_PROLOG"
		end

	frozen enum_cor_debug_unmapped_stop__stop_epilog: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_EPILOG"
		end

	frozen enum_cor_debug_unmapped_stop__stop_no_mapping_info: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_NO_MAPPING_INFO"
		end

	frozen enum_cor_debug_unmapped_stop__stop_other_unmapped: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_OTHER_UNMAPPED"
		end

	frozen enum_cor_debug_unmapped_stop__stop_unmanaged: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_UNMANAGED"
		end

	frozen enum_cor_debug_unmapped_stop__stop_all: INTEGER
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STOP_ALL"
		end

feature {NONE} -- External Struct implementation

--	start_offset (p: POINTER): NATURAL_32 is
--			-- Access field StartOffset of struct pointed by `p'.
--		external
--			"C struct COR_DEBUG_STEP_RANGE access startOffset use %"cli_debugger_headers.h%" "
--		end
--
--	end_offset (p: POINTER):NATURAL_32 is
--			-- Access field EndOffset of struct pointed by `p'.
--		external
--			"C struct COR_DEBUG_STEP_RANGE access endOffset use %"cli_debugger_headers.h%" "
--		end

	set_struct_start_offset (p: POINTER; v: NATURAL_32)
			-- Set field `StartOffset' of struct pointed by `p'.
		external
			"C struct COR_DEBUG_STEP_RANGE access startOffset type ULONG32 use %"cli_debugger_headers.h%" "
		end

	set_struct_end_offset (p: POINTER; v: NATURAL_32)
			-- Set field `EndOffset' of struct pointed by `p'.
		external
			"C struct COR_DEBUG_STEP_RANGE access endOffset type ULONG32 use %"cli_debugger_headers.h%" "
		alias
			"endOffset"
		end

	sizeof_COR_DEBUG_STEP_RANGE: INTEGER
			-- Number of bytes in a value of type `COR_DEBUG_STEP_RANGE'
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"sizeof(COR_DEBUG_STEP_RANGE)"
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
