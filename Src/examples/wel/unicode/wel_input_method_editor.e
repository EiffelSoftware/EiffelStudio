indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_METHOD_EDITOR
	
inherit
	WEL_INPUT_METHOD_EDITOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature --Initialization
		
	make (input_cont: POINTER; input_loc: POINTER)is
		do
			input_context := input_cont
			input_locale := input_loc
			create composition_string.make (input_cont)
		ensure
			has_input_context: input_context /= Void
			has_input_locale: input_locale /= Void
		end

feature --Access
		
	input_locale: POINTER
			-- Handle to the input locale associated with this IME		
		
	input_context: POINTER 
		-- Handle to the input context maintained by the IME
		
	description: STRING is
			-- Retrieve the description of the current IME
		local
			buffer: POINTER
			nb: INTEGER
			l_string: WEL_STRING
		do
			nb := cwel_get_imm_description(input_locale, $buffer, 0)
			create l_string.make_empty (nb)
			nb := cwel_get_imm_description(input_locale, l_string.item, nb + 1)
			Result := l_string.string
		end
		
	filename: STRING is
			-- The filename of the IME 
		local
			buffer: POINTER
			nb: INTEGER
			l_string: WEL_STRING
		do
			nb := cwel_get_imm_ime_filename (input_locale, $buffer, 0)
			create l_string.make_empty (nb)
			nb := cwel_get_imm_ime_filename (input_locale, l_string.item, nb + 1)
			Result := l_string.string
		end
	
	filename_by_locale (input_loc: POINTER): STRING is
			-- The filename of the IME associated with the 'input_loc' input locale
		local
			buffer: POINTER
			nb: INTEGER
		do
			nb := cwel_get_imm_ime_filename(input_loc, $buffer, 0)
			create Result.make_from_c (buffer)
		end
		
	conversion_mode: INTEGER 
			-- Value representing combination of conversion mode values from WEL_IME_CONSTANTS
			
	sentence_mode: INTEGER
			-- Value representing combination of sentence mode values from WEL_IME_CONSTANTS

feature --Status Setting

	open is
			-- Open the IME 
		do
			opened := cwel_set_open_status (input_context, True)		
		end
		
	close is
			-- Close the IME
		do
			opened := cwel_set_open_status (input_context, False)
		end
		
	dialog_configure (parent: POINTER) is
			-- Open the configuration dialog for the IME
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_imm_configure_ime (input_locale, parent, Ime_config_general, 0)
		end
		
	regword_configure (parent: POINTER) is
			-- Displays the register word dialog box for the current IME 
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_imm_configure_ime (input_locale, parent, Ime_config_register_word, 0)
		end
		
	dictionary_configure (parent: POINTER) is
			-- Displays the dictionary dialog box for the current IME 
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_imm_configure_ime (input_locale, parent, Ime_config_selectdictionary, 0)
		end
		
	set_conversion_status (conv_mode: INTEGER) is
			-- Set the conversion status with 'conv_mode'
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_set_conversion_status (input_context, conv_mode, 0)
			if tmp_bool then
				conversion_mode := conv_mode
			end
		end
		
	set_sentence_status (sent_mode: INTEGER) is
			-- Set the sentence status with 'sent_mode'
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_set_conversion_status (input_context, 0, sent_mode)
			if tmp_bool then
				sentence_mode := sent_mode
			end
		end
	
	move_composition_window (x, y: INTEGER) is
			-- Move the composition window to x,y position
		local
			moved: BOOLEAN
		do
			moved := cwel_ime_move_composition_window (input_context, Cfs_point, x, y)			
		end
		
	move_status_window (x, y: INTEGER) is
			-- Move the status window to x,y position
		local
			moved: BOOLEAN
		do
			moved := cwel_ime_move_status_window (input_context, x, y)			
		end
		

feature --Status Report

	opened: BOOLEAN		
			-- Is IME open or closed?
			
	composition_string: WEL_IME_COMPOSITION_STRING 
			-- The composition string 
			
	get_conversion_status is
			-- Retrieve the conversion status
		local
			tmp_bool: BOOLEAN
		do
			tmp_bool := cwel_get_conversion_status (input_context, $conversion_mode, $sentence_mode)
		end
		
	get_property (prop_type: INTEGER): INTEGER is
			-- The property and capabilities of the 'prop_type' as found in WEL_IME_CONSTANTS
		do
			Result := cwel_get_imm_property(input_locale, prop_type)
		end


feature --Externals

	cwel_get_imm_description (key_layout: POINTER; dest: POINTER; buff_len: INTEGER): INTEGER
		is
			-- Given a keyboard layout `hKl' return associated IME description string in `dest'
		external
			"C macro signature (HKL, LPTSTR, UINT): EIF_INTEGER use <windows.h>"
		alias
			"ImmGetDescription"
		end
		
	cwel_get_imm_ime_filename (key_layout, dest: POINTER; buff_len: INTEGER): INTEGER
		is
			-- Given a keyboard layout `hKl' return associated IME description string in `dest'
		external
			"C macro signature (HKL, LPTSTR, UINT): EIF_INTEGER use <imm.h>"
		alias
			"ImmGetIMEFileName"
		end
		
	cwel_get_imm_property (key_layout: POINTER; propty: INTEGER): INTEGER is
			-- Get the property and capabilities of the IME associated with the specified keyboard layout
		external
			"C macro signature (HKL, DWORD): EIF_INTEGER use <windows.h>"
		alias
			"ImmGetProperty"
		end
		
	cwel_set_open_status (input_loc: POINTER; open_flag: BOOLEAN): BOOLEAN is
			-- Open or close the IME associated with the input context
		external
			"C macro signature (HIMC, BOOL): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmSetOpenStatus"
		end
		
	cwel_imm_configure_ime (input_loc, window: POINTER; flag, mode: INTEGER): BOOLEAN is
			-- 
		external
			"C macro signature (HKL, HWND, DWORD, LPVOID): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmConfigureIME"
		end	
		
	cwel_get_conversion_status (input_cont, conv_mode, sent_mode: POINTER): BOOLEAN is
			-- Get the conversion and/or sentence mode status into 'conv_mode' and 'sent_mode'
		external
			"C macro signature (HIMC, LPDWORD, LPDWORD): EIF_BOOLEAN use <imm.h>"
		alias
			"ImmGetConversionStatus"
		end	
		
	cwel_set_conversion_status (input_cont: POINTER; conv_mode, sent_mode: INTEGER): BOOLEAN is
			-- Set the conversion and/or sentence mode status from values of 'conv_mode' and 'sent_mode'
		external
			"C macro signature (HIMC, DWORD, DWORD): EIF_BOOLEAN use <imm.h>"
		alias
			"ImmSetConversionStatus"
		end	
		
	cwel_ime_move_composition_window (input_cont: POINTER; style, xpos, ypos: INTEGER): BOOLEAN is
			-- 
		external
			"C macro signature (EIF_POINTER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER): EIF_BOOLEAN use <wel_imm.h>"
		end
		
	cwel_ime_move_status_window (input_cont: POINTER; xpos, ypos: INTEGER): BOOLEAN is
			-- 
		external
			"C macro signature (EIF_POINTER, EIF_INTEGER, EIF_INTEGER): EIF_BOOLEAN use <wel_imm.h>"
		end
		
		

end -- class WEL_INPUT_METHOD_EDITOR
