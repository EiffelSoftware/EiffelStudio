indexing
	description: "Objects that ..."
	author: ""
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
	
feature -- Creation

	make (input_cont: POINTER)is
		do
			input_context := input_cont
		ensure
			has_input_context: input_context /= Void
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

	set_comp_string (str: STRING) is
			-- Set the composition to 'str'
		local
				a: ANY
				bool: BOOLEAN
				l_string: WEL_STRING
		do
				a := str.to_c
				create l_string.make (str)
				bool := cwel_imm_set_composition_string (input_context, Scs_setstr, $a, 16, default_pointer, 0)
		end
		
feature -- Status Report

	candidate_list_count: INTEGER is
			-- The size of the candidate list
		local
			nb, count: INTEGER
		do
			nb := cwel_imm_get_candidate_list_count (input_context, count)
			Result := count
		end
		
	
	--get_candidate_list
		
		
feature -- Implementation

	input_context: POINTER
		

feature {NONE} -- Externals

	cwel_imm_get_composition_string (input_loc: POINTER; type: INTEGER; buffer: POINTER; bytes: INTEGER): INTEGER is
			-- Get Composition string information into 'buffer' according to 'type'
		external
			"C macro signature (HIMC, DWORD, LPVOID, DWORD): EIF_INTEGER use <imm.h>"
		alias
			"ImmGetCompositionString"
		end	
		
	cwel_imm_set_composition_string (input_cont: POINTER; type: INTEGER; compbuffer: POINTER; cb: INTEGER; readbuffer: POINTER; rb: INTEGER): BOOLEAN is
			-- Set Composition string information into '****buffer' according to 'type'
		external
			"C macro signature (HIMC, DWORD, LPVOID, DWORD, LPVOID, DWORD): EIF_BOOLEAN use <imm.h>"
		alias
			"ImmSetCompositionString"
		end	
		
	cwel_imm_get_candidate_list_count (input_cont: POINTER; count: INTEGER): INTEGER is
			-- Get the size of the candidate for 'string'
		external
			"C macro signature (HIMC, LPDWORD): EIF_INTEGER use <imm.h>"
		alias
			"ImmGetCandidateListCount"
		end	
		
end