note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_METHOD_MANAGER

inherit
	ANY

	WEL_IME_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature --Initialization

	make
			-- Create a new input method manager
		do
			initialise
		end

feature -- Access

	input_method_editor: ?WEL_INPUT_METHOD_EDITOR
		-- The input method editor (IME) associated with the current input locale

	input_locale: POINTER
		-- A handle to the currently active input locale

	input_context: POINTER
		-- Handle to the input context

	released: BOOLEAN
		-- Has the input context been released

	input_locale_identifier: STRING_32
			-- String describing the currently active input locale
		local
			a_bool: BOOLEAN
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make_empty ({WEL_KEYBOARD_LAYOUT_CONSTANTS}.Kl_namelength)
			a_bool := cwel_get_keyboard_layout_name (a_wel_string.item)
			Result := a_wel_string.string
		ensure
			result_not_void: Result /= Void
		end

	language_identifier: STRING_32
			-- The language identifier value associated with the input
			-- locale in hexadecimal form (i.e the low word value of the input locale)
		do
			Result := cwel_langid_from_locale (input_locale).to_hex_string
		ensure
			result_not_void: Result /= Void
		end

	get_language_identifier (a_locale: POINTER): INTEGER
			-- The language identifier value associated with the input
			-- locale 'a_locale' in hexadecimal form (i.e the low word value of the input locale)
		do
			Result := cwel_langid_from_locale (a_locale)
		ensure
			result_valid: Result >= 0
		end

	primary_language_identifier: STRING_32
			-- The primary language identifier value associated with the input locale
		do
			Result := cwel_primary_langid_from_langid (input_locale).to_hex_string
		ensure
			result_not_void: Result /= Void
		end

	sub_language_identifier: STRING_32
			-- The sub-language identifier value associated with the input locale
		do
			Result := cwel_sub_langid_from_langid (input_locale).to_hex_string
		ensure
			result_not_void: Result /= Void
		end

	input_locales: ARRAY [POINTER]
			-- Array of available input locale identifiers installed on system
		local
			cnt: INTEGER
			arr: ANY
		do
			cnt := cwel_get_keyboard_layout_list (0, default_pointer)
			create Result.make (1, cnt)
			arr := Result.to_c
			cnt := cwel_get_keyboard_layout_list (cnt, $arr)
		ensure
			result_not_void: Result /= Void
		end

	get_input_context (a_parent: POINTER)
			-- Retrieve the input context for the 'a_parent' window
		do
			input_context := cwel_get_imm_context (a_parent)
			update
		end


feature -- Status Report

	enabled: BOOLEAN
			-- Is IMM enabled on this system? Will return 'True' for
			-- Asian locales and Windows 2000 systems
		local
			sys_metrics: WEL_SYSTEM_METRICS
		do
			create sys_metrics
			Result := sys_metrics.imm_enabled or sys_metrics.dbcs_installed
		end

	conversion_status (a_parent: POINTER): INTEGER
			-- The IMM conversion status for the 'parent' window
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		local
			a_bool :BOOLEAN
			cnv, sent: INTEGER
		do
			a_bool := cwel_imm_get_conversion_status (input_context, $cnv, $sent)
			Result := cnv
		end

feature -- IME Access

	ime_description: STRING_32
			-- Retrieve the description of the current IME
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		local
			l_input_method_editor: like input_method_editor
		do
			l_input_method_editor := input_method_editor
				-- Per precondition
			check l_input_method_editor_attached: l_input_method_editor /= Void end
			Result := l_input_method_editor.description
		ensure
			result_not_void: Result /= Void
		end

	ime_filename: STRING_32
			-- The filename of the IME associated with the current input locale
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		local
			l_input_method_editor: like input_method_editor
		do
			l_input_method_editor := input_method_editor
				-- Per precondition
			check l_input_method_editor_attached: l_input_method_editor /= Void end
			Result := l_input_method_editor.filename
		ensure
			result_not_void: Result /= Void
		end

	ime_filename_by_locale (a_input_locale: POINTER): STRING_32
			-- The filename of the IME associated with the specified input locale
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		local
			l_input_method_editor: like input_method_editor
		do
			l_input_method_editor := input_method_editor
				-- Per precondition
			check l_input_method_editor_attached: l_input_method_editor /= Void end
			Result := l_input_method_editor.filename_by_locale (a_input_locale)
		ensure
			result_not_void: Result /= Void
		end

	ime_opened: BOOLEAN
			-- Is IME open or closed?
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				Result := l_input_method_editor.opened
			end
		end

	has_ime (a_input_locale: POINTER): BOOLEAN
			-- Has the input locale associated with 'a_input_locale' an IME?
		do
			Result := cwel_get_imm_is_ime(a_input_locale)
		end

	ime_property (a_prop_type: INTEGER): INTEGER
			-- The property and capabilities of 'a_prop_type' found in WEL_IME_CONSTANTS
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
			a_prop_type:
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				Result := l_input_method_editor.get_property (a_prop_type)
			end
		ensure
			result_valid: Result >= 0
		end

	ime_dialog_configure (a_parent: POINTER)
			-- Displays the configuration dialog box for the current IME
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.dialog_configure (a_parent)
			end
		end

	ime_regword_configure (a_parent: POINTER)
			-- Displays the register word dialog box for the current IME
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.regword_configure (a_parent)
			end
		end

	ime_dictionary_configure (parent: POINTER)
			-- Displays the dictionary dialog box for the current IME
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.dictionary_configure (parent)
			end
		end


feature --Status Setting

	create_input_context (a_window: POINTER)
			-- Create a new input context into 'input_context' and associate a with 'hwnd' window
		do
			input_context := cwel_imm_create_context
			prev_input_context := cwel_imm_associate_context (a_window, input_context)
		ensure
			context_changed: prev_input_context = old input_context
		end

	release_input_context (a_parent: POINTER)
			-- Release the input context associated with 'parent'
		do
			released := cwel_set_imm_release_context (a_parent, input_context)
		ensure
			is_released: released
		end

	destroy_input_context
			-- Destroy the input_context
		local
			destroyed: BOOLEAN
		do
			destroyed := cwel_imm_destroy_context (input_context)
		end

	ime_open (a_input_context: POINTER)
			-- Open the IME associated with 'a_input_context'
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.open
			end
		end

	ime_close (a_input_context: POINTER)
			-- Open the IME associated with 'a_input_context'
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.close
			end
		end

	load_input_locale (a_input_locale: POINTER)
			-- Load the input locale specified by 'a_input_locale' into the system
			-- and activate it for the current thread
		local
			a_locale: POINTER
		do
			a_locale := cwel_load_keyboard_layout (a_input_locale, {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Klf_activate)
		end

	switch_input_locale (a_input_locale: POINTER)
			-- Switch to the input locale pointed to by 'a_input_locale' (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (a_input_locale, {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Klf_set_for_process)
			update
		end

	switch_next_input_locale
			-- Switch to the next installed input locale (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (default_pointer + {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Hkl_next, 0)
			update
		end

	switch_prev_input_locale
			-- Switch to the previous installed input locale (user must have
			-- installed additional input locales through the control panel for
			-- this to work).
		do
			prev_input_locale_identifier := cwel_activate_keyboard_layout (default_pointer + {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Hkl_prev, 0)
			update
		end

	set_conversion_status (a_parent:POINTER; a_conv_mode, a_sent_mode: INTEGER): BOOLEAN
			-- Set the conversion mode status with the values of 'a_conv_mode' and 'a_sent_mode'.
			-- The can be any combination of values of those inherited from WEL_IME_CONSTANTS
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			Result := cwel_imm_set_conversion_status (input_context, a_conv_mode, a_sent_mode)
		end

	move_composition_window (a_x, a_y: INTEGER)
			-- Move composition window upper-left corner to 'a_x' and 'a_y'
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.move_composition_window (a_x, a_y)
			end
		end

	move_status_window (a_x, a_y: INTEGER)
			-- Move status window upper-left corner to 'a_x' and 'a_y'
		require
			imm_enabled: enabled
			imm_has_ime: has_ime (input_locale)
		do
			if {l_input_method_editor: like input_method_editor} input_method_editor then
				l_input_method_editor.move_status_window (a_x, a_y)
			end
		end


feature {NONE} -- Implementation 	

	prev_input_locale_identifier: POINTER
		-- A handle to the previously active input locale

	prev_input_context: POINTER
			-- A handle to the previously associated input context before
			-- call to 'create_input_context'.  Required in case needs to
			-- be restored at any time

	initialise, update
			-- Initialise the IMM / Update after changes
		do
			set_input_locale
			if has_ime (input_locale) then
				create input_method_editor.make (input_context, input_locale)
			end
		ensure
			valid_ime: has_ime (input_locale) implies input_method_editor /= Void
		end

	set_input_locale
			-- Set the input locale to reflect the newly changed locale
			-- (workaround since GetKeyboardLayout always returns same value)
		local
			a_ptr_1, a_ptr_2: POINTER
		do
			a_ptr_1 := cwel_activate_keyboard_layout (default_pointer + {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Hkl_prev, 0)
			a_ptr_2 := cwel_activate_keyboard_layout (default_pointer + {WEL_KEYBOARD_LAYOUT_CONSTANTS}.Hkl_next, 0)
			input_locale := a_ptr_1
		end

feature {NONE} -- Externals

	cwel_get_keyboard_layout: POINTER
			-- Retrieve the active input locale identifier for the current thread
		external
			"C macro signature: EIF_INTEGER use <windows.h>"
		alias
			"GetKeyboardLayout"
		end

	cwel_activate_keyboard_layout (a_input_locale: POINTER; flag: INTEGER): POINTER
			-- Set the input locale identifier for the current thread
		external
			"C macro signature (HKL, UINT): EIF_INTEGER use <windows.h>"
		alias
			"ActivateKeyboardLayout"
		end

	cwel_get_keyboard_layout_list (arr_sz: INTEGER; arr: POINTER): INTEGER
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (int, HKL *): EIF_INTEGER use <windows.h>"
		alias
			"GetKeyboardLayoutList"
		end

	cwel_load_keyboard_layout (a_input_locale: POINTER; flags: INTEGER): POINTER
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (LPCTSTR , UINT): EIF_INTEGER use <windows.h>"
		alias
			"LoadKeyboardLayout"
		end

	cwel_get_keyboard_layout_name (buffer: POINTER): BOOLEAN
			-- Retrieve the input locale identifiers installed on the system
		external
			"C macro signature (LPTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"GetKeyboardLayoutName"
		end

	cwel_imm_create_context: POINTER
			-- Create new input context
		external
			"dllwin imm32.dll signature (): HIMC use <windows.h>"
		alias
			"ImmCreateContext"
		end

	cwel_imm_associate_context (a_window, a_input_context: POINTER): POINTER
			-- Associate new 'a_input_context' with 'a_window'
		external
			"dllwin imm32.dll signature (HWND, HIMC): HIMC use <windows.h>"
		alias
			"ImmAssociateContext"
		end

	cwel_get_imm_context (a_window: POINTER): POINTER
			-- Retrieve the input context associated with 'a_window'
		external
			"dllwin imm32.dll signature (HWND): HIMC use <windows.h>"
		alias
			"ImmGetContext"
		end

	cwel_imm_destroy_context (a_input_cont: POINTER): BOOLEAN
			-- Destroy input context 'a_input_context'
		external
			"dllwin imm32.dll signature (HIMC): BOOL use <windows.h>"
		alias
			"ImmDestroyContext"
		end

	cwel_get_imm_is_ime(a_input_locale: POINTER): BOOLEAN
			-- Determine whether the input locale has an IME
		external
			"dllwin imm32.dll signature (HKL): BOOL use <windows.h>"
		alias
			"ImmIsIME"
		end

	cwel_set_imm_release_context(a_window, a_input_locale:POINTER): BOOLEAN
			-- Close the input context
		external
			"dllwin imm32.dll signature (HWND, HIMC): BOOL use <windows.h>"
		alias
			"ImmReleaseContext"
		end

	cwel_imm_simulate_hotkey (a_window: POINTER; a_hot_key: INTEGER): BOOLEAN
			-- Simulate the specified IME hotkey
		external
			"dllwin imm32.dll signature (HWND, DWORD): BOOL use <windows.h>"
		alias
			"ImmSimulateHotKey"
		end

	cwel_langid_from_locale (a_input_locale: POINTER): INTEGER
			--
		external
			"C macro signature (LCID): EIF_INTEGER use <windows.h>"
		alias
			"LANGIDFROMLCID"
		end

	cwel_primary_langid_from_langid (a_input_locale: POINTER): INTEGER
			--
		external
			"C macro signature (WORD): EIF_INTEGER use <windows.h>"
		alias
			"PRIMARYLANGID"
		end

	cwel_sub_langid_from_langid (a_input_locale: POINTER): INTEGER
			--
		external
			"C macro signature (WORD): EIF_INTEGER use <windows.h>"
		alias
			"SUBLANGID"
		end

	cwel_localeid_from_langid (lang_id: INTEGER; sort_id: INTEGER): INTEGER
			--
		external
			"C macro signature (WORD, WORD): EIF_INTEGER use <windows.h>"
		alias
			"MAKELCID"
		end

	cwel_imm_get_conversion_status (a_input_context, a_conv_mode, a_sent_mode: POINTER): BOOLEAN
			-- Retrieve the current conversion status
		external
			"dllwin imm32.dll signature (HIMC, LPDWORD, LPDWORD): BOOL use <windows.h>"
		alias
			"ImmGetConversionStatus"
		end

	cwel_imm_set_conversion_status (a_input_context: POINTER; a_conv_mode, a_sent_mode: INTEGER): BOOLEAN
			-- Retrieve the current conversion status
		external
			"dllwin imm32.dll signature (HIMC, DWORD, DWORD): BOOL use <windows.h>"
		alias
			"ImmSetConversionStatus"
		end

invariant
	input_method_editor_attached: has_ime (input_locale) implies input_method_editor /= Void

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


end -- class WEL_INPUT_METHOD_MANAGER
