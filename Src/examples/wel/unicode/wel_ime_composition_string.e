note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IME_COMPOSITION_STRING

inherit
	ANY

	WEL_IME_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_input_context: POINTER)
			-- Create object with 'a_input_context' input context
		do
			input_context := a_input_context
		ensure
			input_context_set: input_context = a_input_context
		end


feature -- Access

	string: STRING_32
			-- Composition string
		local
			buffer: POINTER
			nb: INTEGER
			l_string: WEL_STRING
		do
			nb := cwel_imm_get_composition_string (input_context, {WEL_COMPOSITION_STRING_CONSTANTS}.Gcs_compstr, $buffer, 0)
			create l_string.make_empty (nb)
			nb := cwel_imm_get_composition_string (input_context, {WEL_COMPOSITION_STRING_CONSTANTS}.Gcs_compstr, l_string.item, nb + 1)
			Result := l_string.string
		end



feature -- Status Setting

	set_comp_string (a_string: STRING_GENERAL)
			-- Set the composition to 'a_string'
		require
			string_not_void: a_string /= Void
		local
			bool: BOOLEAN
			l_string: WEL_STRING
		do
			create l_string.make (a_string)
			bool := cwel_imm_set_composition_string (input_context, {WEL_COMPOSITION_STRING_CONSTANTS}.Scs_setstr, l_string.item, 16, default_pointer, 0)
		ensure
			string_set: string = a_string
		end

feature -- Status Report

	candidate_list_count: INTEGER
			-- The size of the candidate list
		local
			nb, count: INTEGER
		do
			nb := cwel_imm_get_candidate_list_count (input_context, count)
			Result := count
		ensure
			result_valid: Result >= 0
		end


feature -- Implementation

	input_context: POINTER


feature {NONE} -- Externals

	cwel_imm_get_composition_string (a_input_locale: POINTER; type: INTEGER; buffer: POINTER; bytes: INTEGER): INTEGER
			-- Get Composition string information into 'buffer' according to 'type'
		external
			"dllwin imm32.dll signature (HIMC, DWORD, LPVOID, DWORD): LONG use <windows.h>"
		alias
			"ImmGetCompositionStringW"
		end

	cwel_imm_set_composition_string (a_input_context: POINTER; type: INTEGER; compbuffer: POINTER; cb: INTEGER; readbuffer: POINTER; rb: INTEGER): BOOLEAN
			-- Set Composition string information into '****buffer' according to 'type'
		external
			"dllwin imm32.dll signature (HIMC, DWORD, LPVOID, DWORD, LPVOID, DWORD): BOOL use <windows.h>"
		alias
			"ImmSetCompositionStringW"
		end

	cwel_imm_get_candidate_list_count (a_input_context: POINTER; count: INTEGER): INTEGER
			-- Get the size of the candidate for 'string'
		external
			"dllwin imm32.dll signature (HIMC, LPDWORD): DWORD use <windows.h>"
		alias
			"ImmGetCandidateListCountW"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
