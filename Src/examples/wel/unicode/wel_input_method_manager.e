indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_METHOD_MANAGER
	
inherit		
	WEL_INPUT_METHOD_EDITOR_CONSTANTS
		export
			{NONE} all
		end
	
creation
	make
	
feature --Initialization


	make is
			-- create a new input method manager
		once
			initialise
		end
	
	
feature -- Access

	input_method_editor: WEL_INPUT_METHOD_EDITOR
		-- The input method editor (IME) associated with the current input locale, if there is one

	input_locale: POINTER
		-- A handle to the currently active input locale
		
	input_context: POINTER 
		-- Handle to the input context
		
	released: BOOLEAN
		-- Has the input context been released 

	input_locale_identifier: STRING is
			-- String describing the currently active input locale
		local
			tmp_bool: BOOLEAN
			awel_string: WEL_STRING
		do
			create awel_string.make_empty (Kl_namelength)
			tmp_bool := cwel_get_keyboard_layout_name (awel_string.item)
			Result := awel_string.string
		end		

	language_identifier: STRING is
			-- The language identifier value associated with the input
			-- locale in hexadecimal form (i.e the low word value of the input locale)
		do
			Result := cwel_langid_from_locale (input_locale).to_hex_string
		end	
		
	get_language_identifier (loc: POINTER): INTEGER is
			-- The language identifier value associated with the input
			-- locale 'loc' in hexadecimal form (i.e the low word value of the input locale)
		do
			Result := cwel_langid_from_locale (loc)
		end	
		
	primary_language_identifier: STRING is
			-- The primary language identifier value associated with the input locale
		do
			Result := cwel_primary_langid_from_langid (input_locale).to_hex_string
		end	
		
	sub_language_identifier: STRING is
			-- The sub-language identifier value associated with the input locale
		do
			Result := cwel_sub_langid_from_langid (input_locale).to_hex_string
		end	
		
	input_locales: ARRAY [POINTER] is
			-- Array of available input locale identifiers installed on system
		local
			cnt: INTEGER
			arr: ANY
		do
			cnt := cwel_get_keyboard_layout_list (0, default_pointer)
			create Result.make (1, cnt)
			arr := Result.to_c
			cnt := cwel_get_keyboard_layout_list (cnt, $arr)
		end
		
	get_input_context (parent: POINTER) is
			-- Retrieve the input context for the 'parent' window
		do
			input_context := cwel_get_imm_context (parent)
			update
		end
	

feature -- Status Report

	enabled: BOOLEAN is
			-- Is IMM enabled on this system? Will return 'True' for
			-- Asian locales and Windows 2000 systems
		local
			sys_met: WEL_SYSTEM_METRICS
		do
			create sys_met
			Result := sys_met.imm_enabled or sys_met.dbcs_installed
		end

	conversion_status (parent: POINTER): INTEGER is
			-- The IMM conversion status for the 'parent' window
		local
			temp_bool :BOOLEAN
			cnv, sent: INTEGER
		do
			temp_bool := cwel_imm_get_conversion_status (input_context, $cnv, $sent)
			Result := cnv
		end
	

feature -- IME Access

	ime_description: STRING is
			-- Retrieve the description of the current IME
		do
			Result := input_method_editor.description
		end

	ime_filename: STRING is
			-- The filename of the IME associated with the current input locale
		do
			Result := input_method_editor.filename
		end
		
	ime_filename_by_locale (input_loc: POINTER): STRING is
			-- The filename of the IME associated with the specified input locale
		do
			Result := input_method_editor.filename_by_locale (input_loc)
		end

	ime_opened: BOOLEAN is		
			-- Is IME open or closed?
		do
			Result := input_method_editor.opened
		end
		
		
	has_ime (input_loc: POINTER): BOOLEAN is
			-- Has the input locale associated with 'input_loc' an IME?
		do
			Result := cwel_get_imm_is_ime(input_loc)
		end

	ime_property (prop_type: INTEGER): INTEGER is
			-- The property and capabilities of 'prop_type' found in WEL_IME_CONSTANTS
		do
			Result := input_method_editor.get_property (prop_type)
		end
	
	ime_dialog_configure (parent: POINTER) is
			-- Displays the configuration dialog box for the current IME
		do
			input_method_editor.dialog_configure (parent)
		end
		
	ime_regword_configure (parent: POINTER) is
			-- Displays the register word dialog box for the current IME 
		do
			input_method_editor.regword_configure (parent)
		end
		
	ime_dictionary_configure (parent: POINTER) is
			-- Displays the dictionary dialog box for the current IME
		do
			input_method_editor.dictionary_configure (parent)
		end
		
	
feature -- Status Setting

	create_input_context (hwnd: POINTER) is
			-- Create a new input context into 'input_context' and associate a with 'hwnd' window
		do
			input_context := cwel_imm_create_context
			prev_input_context := cwel_imm_associate_context (hwnd, input_context)
		end	

	release_input_context (parent: POINTER) is
			-- Release the input context associated with 'parent'
		do
			released := cwel_set_imm_release_context (parent, input_context)
		end
		
	destroy_input_context is
			-- Destroy the input_context
		local
			destroyed: BOOLEAN
		do
			destroyed := cwel_imm_destroy_context (input_context)
		end
	
	ime_open (in_context: POINTER) is
			-- Open the IME
		do
			input_method_editor.open
		end
		
	ime_close (in_context: POINTER) is
			-- Open the IME
		do
			input_method_editor.close
		end	
		
	load_input_locale (input_loc: POINTER) is
			-- Load the input locale specified by 'input_loc' into the system
			-- and activate it for the current thread
		local
			temp_locale: POINTER
		do
			temp_locale := cwel_load_keyboard_layout (input_loc, Klf_activate)
		end
	
	switch_input_locale (input_loc: POINTER) is
			-- Switch to the input locale pointed to by 'input_loc' (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (input_loc, Klf_set_for_process)
			update
		end
	
	switch_next_input_locale is
			-- Switch to the next installed input locale (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (default_pointer + Hkl_next, 0)
			update
		end
		
	switch_prev_input_locale is
			-- Switch to the previous installed input locale (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (default_pointer + Hkl_prev, 0)
			update
		end

	set_conversion_status (parent:POINTER; conv_mode, sent_mode: INTEGER): BOOLEAN is
			-- Set the conversion mode status with the values of 'conv_mode' and 'sent_mode'.
			-- The can be any combination of values of those inherited from WEL_IME_CONSTANTS
		do
			Result := cwel_imm_set_conversion_status (input_context, conv_mode, sent_mode)
		end

	move_composition_window (x, y: INTEGER) is
			-- Move composition window upper-left corner to 'pos'
		do
			input_method_editor.move_composition_window (x, y)
		end
		
	move_status_window (x, y: INTEGER) is
			-- Move status window upper-left corner to 'pos'
		do
			input_method_editor.move_status_window (x, y)
		end

feature {NONE} -- Implementation 	

	prev_input_locale_identifier: POINTER
		-- A handle to the previously active input locale
		
	prev_input_context: POINTER 
			-- A handle to the previously associated input context before
			-- call to 'create_input_context'.  Required in case needs to
			-- be restored at any time

	initialise, update is
			-- Initialise the IMM / Update after changes
		do
			set_input_locale
			if has_ime (input_locale) then
				create input_method_editor.make (input_context, input_locale)
			end
		end
		
	set_input_locale is
			-- Set the input locale to reflect the newly changed locale
			-- (workaround since GetKeyboardLayout always returns same value)
		local
			tmp_ptr1, tmp_ptr2: POINTER
		do
			tmp_ptr1 := cwel_activate_keyboard_layout (default_pointer + Hkl_prev, 0)
			tmp_ptr2 := cwel_activate_keyboard_layout (default_pointer + Hkl_next, 0)
			input_locale := tmp_ptr1
		end

feature {NONE} -- Externals

	cwel_get_keyboard_layout: POINTER is
			-- Retrieve the active input locale identifier for the current thread
		external
			"C macro signature: EIF_INTEGER use <windows.h>"
		alias
			"GetKeyboardLayout"
		end
		
	cwel_activate_keyboard_layout (input_loc: POINTER; flag: INTEGER): POINTER is
			-- Set the input locale identifier for the current thread
		external
			"C macro signature (HKL, UINT): EIF_INTEGER use <windows.h>"
		alias
			"ActivateKeyboardLayout"
		end
		
	cwel_get_keyboard_layout_list (arr_sz: INTEGER; arr: POINTER): INTEGER is
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (int, HKL): EIF_INTEGER use <windows.h>"
		alias
			"GetKeyboardLayoutList"
		end
		
	cwel_load_keyboard_layout (input_loc: POINTER; flags: INTEGER): POINTER is
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (LPCTSTR , UINT): EIF_INTEGER use <windows.h>"
		alias
			"LoadKeyboardLayout"
		end
		
	cwel_get_keyboard_layout_name (buffer: POINTER): BOOLEAN is
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (LPTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"GetKeyboardLayoutName"
		end

	cwel_imm_create_context: POINTER is
			-- Create new input context
		external
			"C macro signature (): EIF_POINTER use <imm.h>"
		alias
			"ImmCreateContext"
		end
	
	cwel_imm_associate_context (hwnd, input_cont: POINTER): POINTER is
			-- Associate new 'input_cont' with 'hwnd'
		external
			"C macro signature (HWND, HIMC): EIF_POINTER use <imm.h>"
		alias
			"ImmAssociateContext"
		end	

	cwel_get_imm_context (window: POINTER): POINTER is
			-- Retrieve the input context associated with the window
		external
			"C macro signature (HWND): EIF_POINTER use <windows.h>"
		alias
			"ImmGetContext"
		end
		
	cwel_imm_destroy_context (input_cont: POINTER): BOOLEAN is
			-- Destroy input context
		external
			"C macro signature (HIMC): EIF_BOOLEAN use <imm.h>"
		alias
			"ImmDestroyContext"
		end
	
	cwel_get_imm_is_ime(input_loc: POINTER): BOOLEAN is
			-- Determine whether the input locale has an IME
		external
			"C macro signature (HKL): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmIsIME"
		end

	cwel_set_imm_release_context(window, input_loc:POINTER): BOOLEAN is
			-- Close the input context 
		external
			"C macro signature (HWND, HIMC): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmReleaseContext"
		end
	
	cwel_imm_simulate_hotkey (window: POINTER; hot_key: INTEGER): BOOLEAN is
			-- Simulate the specified IME hotkey
		external
			"C macro signature (HWND, DWORD): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmSimulateHotKey"
		end	
		
	cwel_langid_from_locale (input_loc: POINTER): INTEGER is
			-- 
		external
			"C macro signature (LCID): EIF_INTEGER use <windows.h>"
		alias
			"LANGIDFROMLCID"
		end	
		
	cwel_primary_langid_from_langid (input_loc: POINTER): INTEGER is
			-- 
		external
			"C macro signature (WORD): EIF_INTEGER use <windows.h>"
		alias
			"PRIMARYLANGID"
		end	
		
	cwel_sub_langid_from_langid (input_loc: POINTER): INTEGER is
			-- 
		external
			"C macro signature (WORD): EIF_INTEGER use <windows.h>"
		alias
			"SUBLANGID"
		end	
		
	cwel_localeid_from_langid (lang_id: INTEGER; sort_id: INTEGER): INTEGER is
			-- 
		external
			"C macro signature (WORD, WORD): EIF_INTEGER use <windows.h>"
		alias
			"MAKELCID"
		end	
		
	cwel_imm_get_conversion_status (input_cont, conv_mode, sent_mode: POINTER): BOOLEAN is
			-- Retrieve the current conversion status
		external
			"C macro signature (HIMC, LPDWORD, LPDWORD): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmGetConversionStatus"
		end
		
	cwel_imm_set_conversion_status (input_cont: POINTER; conv_mode, sent_mode: INTEGER): BOOLEAN is
			-- Retrieve the current conversion status
		external
			"C macro signature (HIMC, DWORD, DWORD): EIF_BOOLEAN use <windows.h>"
		alias
			"ImmSetConversionStatus"
		end		


end -- class WEL_INPUT_METHOD_MANAGER
