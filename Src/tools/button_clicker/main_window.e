indexing
	description	: "Main window for this application"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date		: "$Date$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

			build_main_container
			extend (main_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window
			set_title (Window_title)

			set_icon_pixmap ((create {BUTTON_CLICKER_SMALL}.make).to_pixmap)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)
		end

feature {NONE} -- Implementation, Close event

	request_close_window is
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window is closed..
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_main_container is
			-- Create and populate `main_container'.
		require
			main_container_not_yet_created: main_container = Void
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			l_f: EV_FRAME
		do
			create main_container

			create l_f
			main_container.extend (l_f)
			create l_vbox
			l_vbox.set_border_width (4)
			l_vbox.set_padding (2)
			l_f.extend (l_vbox)

			create l_hbox
			create l_label.make_with_text ("Top Window Title: ")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create title_field.make_with_text (default_title)
			l_hbox.extend (title_field)
			l_vbox.extend (l_hbox)

			create l_hbox
			create l_label.make_with_text ("Button Text:      ")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create button_field.make_with_text (default_button)
			l_hbox.extend (button_field)
			l_vbox.extend (l_hbox)

			create l_hbox
			create l_label.make_with_text ("Scan Interval(s): ")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create interval_field.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 3600))
			interval_field.set_value (default_interval)
			l_hbox.extend (interval_field)
			l_vbox.extend (l_hbox)

			create start_button.make_with_text (start_string)
			start_button.select_actions.extend (agent start_stop)
			l_vbox.extend (start_button)
		ensure
			main_container_created: main_container /= Void
		end

feature {NONE} -- Events

	start_stop is
			-- Start or stop
		do
			if is_started then
				if timer /= Void then
					timer.destroy
				end
				is_started := False
				start_button.set_text (start_string)
				title_field.enable_sensitive
				button_field.enable_sensitive
				interval_field.enable_sensitive
			else
				last_interval := interval_field.value * 1000
				last_title := title_field.text
				last_button := button_field.text

				create timer
				timer.actions.extend (agent find_and_destroy_debug_dialog)
				timer.set_interval (last_interval)
				is_started := True
				start_button.set_text (stop_string)
				title_field.disable_sensitive
				button_field.disable_sensitive
				interval_field.disable_sensitive
			end
		end

	find_and_destroy_debug_dialog is
		do
			cwel_enum_windows_procedure (Current, $enum_windows_proc)
		end

	enum_windows_proc (hwnd: POINTER): BOOLEAN is
			-- Process `hwnd' when enumerating top windows.
			-- Return True to continue enumerating, otherwise to stop.
		require
			last_title_not_void: last_title /= Void
		local
			a_wel_string: WEL_STRING
			l_length: INTEGER
			nb: INTEGER
			l_string: STRING_32
			l_title_text: STRING_32
		do
			Result := True
			l_length := cwin_get_window_text_length (hwnd)
			if l_length > 0 then
				l_length := l_length + 1
				create a_wel_string.make_empty (l_length)
				nb := cwin_get_window_text (hwnd, a_wel_string.item, l_length)
				l_string := a_wel_string.string
				l_title_text := title_field.text
				if l_title_text.is_equal (l_string) then
						-- If the receiver return True, it means that the receiver handles the message.
						-- Window enumerating will stop.
					Result := False
					cwel_enum_child_windows_procedure (Current, $enum_children_windows_proc, hwnd)
				end
			end
		end

	enum_children_windows_proc (hwnd: POINTER): BOOLEAN is
		require
			last_button_not_void: last_button /= Void
		local
			a_wel_string: WEL_STRING
			l_length: INTEGER
			nb: INTEGER
			l_string: STRING_32
			l_button_text: STRING_32
		do
			Result := True
			l_length := cwin_get_window_text_length (hwnd)
			if l_length > 0 then
				l_length := l_length + 1
				create a_wel_string.make_empty (l_length)
				nb := cwin_get_window_text (hwnd, a_wel_string.item, l_length)
				l_string := a_wel_string.string
				l_button_text := last_button
				if l_button_text.is_equal (l_string) then
						-- If the receiver return True, it means that the receiver handles the message.
						-- Window enumerating will stop.
					Result := False
					{WEL_API}.post_message (hwnd, {WEL_WM_CONSTANTS}.WM_LBUTTONDOWN, cwin_mk_lbutton, cwin_make_long (1, 1))
					{WEL_API}.post_message (hwnd, {WEL_WM_CONSTANTS}.WM_LBUTTONUP, cwin_mk_lbutton, cwin_make_long (1, 1))
				end
			end
		end

feature {NONE} -- Externals

	cwel_enum_windows_procedure (cur_obj: like Current; callback: POINTER) is
			-- SDK EnumWindows
		external
			"C signature (EIF_OBJECT, EIF_POINTER) use %"wel_enum_child_windows.h%""
		end

	cwel_enum_child_windows_procedure (cur_obj: like Current; callback: POINTER; hwnd: POINTER) is
			-- SDK EnumChildWindows
			-- (from WEL_COMPOSITE_WINDOW)
			-- (export status {NONE})
		external
			"C signature (EIF_OBJECT, EIF_POINTER, HWND) use %"wel_enum_child_windows.h%""
		end

	cwin_get_window_text (hwnd, str: POINTER; len: INTEGER): INTEGER is
			-- SDK GetWindowText
		external
			"C [macro %"windows.h%"] (HWND, LPTSTR, int): EIF_INTEGER"
		alias
			"GetWindowText"
		end

	cwin_get_window_text_length (hwnd: POINTER): INTEGER is
			-- SDK GetWindowTextLength
		external
			"C [macro %"windows.h%"] (HWND): EIF_INTEGER"
		alias
			"GetWindowTextLength"
		end

	cwin_make_long (low, high: INTEGER_32): POINTER
			-- SDK MAKELONG
			-- (from WEL_WORD_OPERATIONS)
			-- (export status {NONE})
		external
			"C inline use <windows.h>"
		alias
			"(EIF_POINTER) MAKELONG($low, $high)"
		end

	cwin_mk_lbutton: POINTER
		external
			"C inline use <windows.h>"
		alias
			"MK_LBUTTON"
		end

feature {NONE} -- Implementation

	timer: EV_TIMEOUT

	start_button: EV_BUTTON

	title_field, button_field: EV_TEXT_FIELD

	interval_field: EV_SPIN_BUTTON

	is_started: BOOLEAN

	last_title: STRING_32
	last_button: STRING_32
	last_interval: INTEGER

feature {NONE} -- Constants

	Window_title: STRING = "Button Clicker"
			-- Title of the window.

	Label_confirm_close_window: STRING = "You are about to close this window.%NClick OK to proceed."
			-- String for the confirmation dialog box that appears
			-- when the user try to close the first window.

	start_string: STRING = "Click to Start"

	stop_string: STRING = "Click to Stop"

	Window_width: INTEGER is 300
			-- Initial width for this window.

	Window_height: INTEGER is 100
			-- Initial height for this window.

	default_interval: INTEGER = 5

	default_title: STRING_32 is
		once
			create Result.make_from_string ("test.exe")
		end

	default_button: STRING_32 is
		local
			l_str: STRING_32
		once
			create l_str.make_empty
			l_str.append_code (0x4E0D)
			l_str.append_code (0x53D1)
			l_str.append_code (0x9001)
			l_str.append ("(&D)")
			Result := l_str
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class MAIN_WINDOW
