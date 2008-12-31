note
	description: "Input Method Editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_METHOD_EDITOR

inherit
	ANY

	WEL_IME_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature --Initialization

	make (a_input_context: POINTER; a_input_locale: POINTER)
		do
			input_context := a_input_context
			input_locale := a_input_locale
			create composition_string.make (a_input_context)
		end

feature --Access

	input_locale: POINTER
			-- Handle to the input locale associated with this IME		

	input_context: POINTER
		-- Handle to the input context maintained by the IME

	description: STRING_32
			-- Retrieve the description of the current IME
		local
			buffer: POINTER
			nb: INTEGER
			l_string: WEL_STRING
		do
			nb := cwel_get_imm_description(input_locale, $buffer, 0)
			create l_string.make_empty (nb + 1)
			nb := cwel_get_imm_description(input_locale, l_string.item, nb)
			Result := l_string.string
		ensure
			result_not_void: Result /= Void
		end

	filename: STRING_32
			-- The filename of the IME
		local
			buffer: POINTER
			nb: INTEGER
			l_string: WEL_STRING
		do
			nb := cwel_get_imm_ime_filename (input_locale, $buffer, 0)
			create l_string.make_empty (nb + 1)
			nb := cwel_get_imm_ime_filename (input_locale, l_string.item, nb)
			Result := l_string.string
		ensure
			result_not_void: Result /= Void
		end

	filename_by_locale (a_input_locale: POINTER): STRING_32
			-- The filename of the IME associated with the 'input_loc' input locale
		local
			buffer: POINTER
			l_string: WEL_STRING
			nb: INTEGER
		do
			nb := cwel_get_imm_ime_filename(a_input_locale, $buffer, 0)
			create l_string.make_empty (nb + 1)
			nb := cwel_get_imm_ime_filename(a_input_locale, l_string.item, nb)
			Result := l_string.string
		ensure
			result_not_void: Result /= Void
		end

	conversion_mode: INTEGER
			-- Value representing combination of conversion mode values from WEL_IME_CONSTANTS

	sentence_mode: INTEGER
			-- Value representing combination of sentence mode values from WEL_IME_CONSTANTS

feature --Status Setting

	open
			-- Open the IME
		do
			opened := cwel_set_open_status (input_context, True)
		ensure
			not_closed: opened = True
		end

	close
			-- Close the IME
		do
			opened := cwel_set_open_status (input_context, False)
		ensure
			not_open: opened = False
		end

	dialog_configure (a_parent: POINTER)
			-- Open the configuration dialog for the IME associated with 'a_parent'
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_imm_configure_ime (input_locale, a_parent, Ime_config_general, 0)
		end

	regword_configure (a_parent: POINTER)
			-- Displays the register word dialog box for the current IME associated with
			-- 'a_parent'
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_imm_configure_ime (input_locale, a_parent, Ime_config_register_word, 0)
		end

	dictionary_configure (a_parent: POINTER)
			-- Displays the dictionary dialog box for the current IME associated with
			-- 'a_parent'
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_imm_configure_ime (input_locale, a_parent, Ime_config_selectdictionary, 0)
		end

	set_conversion_status (a_conv_mode: INTEGER)
			-- Set the conversion status with 'a_conv_mode'
		require
			valid_conv_mode:
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_set_conversion_status (input_context, a_conv_mode, 0)
			if a_bool then
				conversion_mode := a_conv_mode
			end
		end

	set_sentence_status (a_sent_mode: INTEGER)
			-- Set the sentence status with 'a_sent_mode'
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_set_conversion_status (input_context, 0, a_sent_mode)
			if a_bool then
				sentence_mode := a_sent_mode
			end
		end

	move_composition_window (a_x, a_y: INTEGER)
			-- Move the composition window to x,y position
		require
			x_valid: a_x >= 0
			y_valid: a_y >= 0
		local
			moved: BOOLEAN
			pt: WEL_POINT
			cf: WEL_COMPOSITION_FORM
		do
			create pt.make (a_x, a_y)
			create cf.make
			cf.set_point (pt)
			moved := cwel_ime_move_composition_window (input_context, cf.item)
		end

	move_status_window (a_x, a_y: INTEGER)
			-- Move the status window to x,y position
		require
			x_valid: a_x >= 0
			y_valid: a_y >= 0
		local
			moved: BOOLEAN
			pt: WEL_POINT
		do
			create pt.make (a_x, a_y)
			moved := cwel_ime_move_status_window (input_context, pt.item)
		end


feature --Status Report

	opened: BOOLEAN
			-- Is IME open or closed?

	composition_string: WEL_IME_COMPOSITION_STRING
			-- The composition string

	get_conversion_status
			-- Retrieve the conversion status into 'conversion_mode' and 'sentence_mode'
		local
			a_bool: BOOLEAN
		do
			a_bool := cwel_get_conversion_status (input_context, $conversion_mode, $sentence_mode)
		end

	get_property (a_prop_type: INTEGER): INTEGER
			-- The property and capabilities of the 'prop_type' as found in WEL_IME_CONSTANTS
		do
			Result := cwel_get_imm_property(input_locale, a_prop_type)
		end

feature {NONE} -- Externals

	cwel_get_imm_description (key_layout: POINTER; dest: POINTER; buff_len: INTEGER): INTEGER
			-- Given a keyboard layout `hKl' return associated IME description string in `dest'
		external
			"dllwin imm32.dll signature (HKL, LPTSTR, UINT): UINT use <windows.h>"
		alias
			"ImmGetDescription"
		end

	cwel_get_imm_ime_filename (key_layout, dest: POINTER; buff_len: INTEGER): INTEGER
		
			-- Given a keyboard layout `hKl' return associated IME description string in `dest'
		external
			"dllwin imm32.dll signature (HKL, LPTSTR, UINT): UINT use <windows.h>"
		alias
			"ImmGetIMEFileName"
		end

	cwel_get_imm_property (key_layout: POINTER; a_property: INTEGER): INTEGER
			-- Get the property and capabilities of the IME associated with the specified keyboard layout
		external
			"dllwin imm32.dll signature (HKL, DWORD): DWORD use <windows.h>"
		alias
			"ImmGetProperty"
		end

	cwel_set_open_status (a_input_locale: POINTER; open_flag: BOOLEAN): BOOLEAN
			-- Open or close the IME associated with the input context
		external
			"dllwin imm32.dll signature (HIMC, BOOL): BOOL use <windows.h>"
		alias
			"ImmSetOpenStatus"
		end

	cwel_imm_configure_ime (a_input_loc, a_window: POINTER; flag, mode: INTEGER): BOOLEAN
			--
		external
			"dllwin imm32.dll signature (HKL, HWND, DWORD, LPVOID): BOOL use <windows.h>"
		alias
			"ImmConfigureIME"
		end

	cwel_get_conversion_status (a_input_context, a_conv_mode, a_sent_mode: POINTER): BOOLEAN
			-- Get the conversion and/or sentence mode status into 'conv_mode' and 'sent_mode'
		external
			"dllwin imm32.dll signature (HIMC, LPDWORD, LPDWORD): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmGetConversionStatus"
		end

	cwel_set_conversion_status (a_input_cont: POINTER; a_conv_mode, a_sent_mode: INTEGER): BOOLEAN
			-- Set the conversion and/or sentence mode status from values of 'conv_mode' and 'sent_mode'
		external
			"dllwin imm32.dll signature (HIMC, DWORD, DWORD): BOOL use <windows.h>"
		alias
			"ImmSetConversionStatus"
		end

	cwel_ime_move_composition_window (a_input_context, a_comp_form: POINTER): BOOLEAN
			--
		external
			"dllwin imm32.dll signature (HIMC, LPCOMPOSITIONFORM): BOOL use <windows.h>"
		alias
			"ImmSetCompositionWindow"
		end

	cwel_ime_move_status_window (a_input_context, a_point: POINTER): BOOLEAN
			--
		external
			"dllwin imm32.dll signature (HIMC, LPPOINT): BOOL use <windows.h>"
		alias
			"ImmSetStatusWindowPos"
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


end -- class WEL_INPUT_METHOD_EDITOR
