note
	description: "Eiffel Vision directory dialog."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I
		redefine
			interface
		select
			copy
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			make,
			dispose,
			show_modal_to_window
		end

	NS_OPEN_PANEL
		rename
			make as make_panel,
			make_window as make_panel_window,
			item as cocoa_panel_ptr,
			copy as cocoa_copy_panel,
			title as cocoa_title,
			set_background_color as cocoa_set_background_color,
			background_color as cocoa_background_color,
			screen as cocoa_screen,
			set_title as cocoa_set_title,
			directory as cocoa_directory
		undefine
			is_equal
		redefine
			dispose
		select
			cocoa_panel_ptr,
			cocoa_screen,
			make_panel_window
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Setup action sequences.
		do
			make_panel
			set_can_choose_directories (True)
			set_can_create_directories (True)
			set_can_choose_files (False)
			set_prompt (create {NS_STRING}.make_with_string ("Choose"))
		end

feature -- Access

	directory: STRING_32
			-- Path of the current selected directory
		do
			if selected_button.is_equal (internal_accept) then
				Result := filename
			else
				create Result.make_empty
			end
		end

	start_directory: STRING_32
			-- Base directory where browsing will start.

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		do
			start_directory := a_path
			set_directory (create {NS_STRING}.make_with_string (a_path))
		end

feature {NONE} -- Implementation

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show the
		local
			button: INTEGER
			l_window: NS_WINDOW
		do
			l_window ?= a_window.implementation
			begin_sheet (void, void, void, l_window, delegate_class.create_instance, default_pointer, default_pointer)
			button := run_modal
			if button =  {NS_PANEL}.ok_button then
				selected_button := internal_accept
				ok_actions.call ([])
			elseif button = {NS_PANEL}.cancel_button then
				selected_button := ev_cancel
				cancel_actions.call ([])
			end
		end

	delegate_class: OBJC_CLASS
		once
			create Result.make_with_name ("NSOpenPanelSheetDelegate")
			Result.add_method ("openPanelDidEnd:", agent (panel: POINTER; return_code: INTEGER; context_info: POINTER) do  end)
			Result.register
		end

	dispose
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			Precursor {NS_OPEN_PANEL}
		end

	interface: EV_DIRECTORY_DIALOG;

end -- class EV_DIRECTORY_DIALOG_IMP
