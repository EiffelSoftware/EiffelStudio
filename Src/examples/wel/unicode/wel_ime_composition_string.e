indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IME_COMPOSITION_STRING
	
inherit 
	WEL_INPUT_METHOD_EDITOR_CONSTANTS
		export
			{NONE} all
		end
	
create
	make
	
feature -- Initialization

	make (a_input_context: POINTER) is
			-- Create object with 'a_input_context' input context
		require
			input_context_not_void: a_input_context /= Void
		do
			input_context := a_input_context
		ensure
			input_context_set: input_context = a_input_context
		end


feature -- Access

	string: STRING is
			-- Composition string
		local
				buffer: POINTER
				nb: INTEGER
				l_string: WEL_STRING
		do
				nb := cwel_imm_get_composition_string (input_context, Gcs_compstr, $buffer, 0)
				create l_string.make_empty (nb)
				nb := cwel_imm_get_composition_string (input_context, Gcs_compstr, l_string.item, nb + 1)
				Result := l_string.string
		end
		
	
		
feature -- Status Setting

	set_comp_string (a_string: STRING) is
			-- Set the composition to 'a_string'
		require
			string_not_void: a_string /= Void
		local
			a: ANY
			bool: BOOLEAN
			l_string: WEL_STRING
		do
			a := a_string.to_c
			create l_string.make (a_string)
			bool := cwel_imm_set_composition_string (input_context, Scs_setstr, $a, 16, default_pointer, 0)
		ensure
			string_set: string = a_string
		end
		
feature -- Status Report

	candidate_list_count: INTEGER is
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

	cwel_imm_get_composition_string (a_input_locale: POINTER; type: INTEGER; buffer: POINTER; bytes: INTEGER): INTEGER is
			-- Get Composition string information into 'buffer' according to 'type'
		external
			"C macro signature (HIMC, DWORD, LPVOID, DWORD): EIF_INTEGER use <imm.h>"
		alias
			"ImmGetCompositionString"
		end	
		
	cwel_imm_set_composition_string (a_input_context: POINTER; type: INTEGER; compbuffer: POINTER; cb: INTEGER; readbuffer: POINTER; rb: INTEGER): BOOLEAN is
			-- Set Composition string information into '****buffer' according to 'type'
		external
			"C macro signature (HIMC, DWORD, LPVOID, DWORD, LPVOID, DWORD): EIF_BOOLEAN use <imm.h>"
		alias
			"ImmSetCompositionString"
		end	
		
	cwel_imm_get_candidate_list_count (a_input_context: POINTER; count: INTEGER): INTEGER is
			-- Get the size of the candidate for 'string'
		external
			"C macro signature (HIMC, LPDWORD): EIF_INTEGER use <imm.h>"
		alias
			"ImmGetCandidateListCount"
		end	
	
invariant
	has_input_context: input_context /= Void
		
indexing
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