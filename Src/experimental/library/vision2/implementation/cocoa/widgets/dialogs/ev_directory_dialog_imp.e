note
	description: "Eiffel Vision directory dialog."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I
		rename
			set_start_path as set_start_directory,
			start_path as start_directory
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
			directory as cocoa_directory,
			directory_path as cocoa_directory_path
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
			initialize_class
			set_can_choose_directories (True)
			set_can_create_directories (True)
			set_can_choose_files (False)
			set_prompt (create {NS_STRING}.make_with_string ("Choose"))
		end

feature -- Access

	directory: PATH
			-- Path of the current selected directory
		do
			if attached selected_button as l_selected and then l_selected.is_equal (internal_accept) then
				Result := path
			else
				create Result.make_empty
			end
		end

	start_directory: PATH
			-- Base directory where browsing will start.
		do
			if attached internal_start_directory as l_path then
				Result := l_path
			else
				create Result.make_empty
			end
		end

feature -- Element change

	set_start_directory (a_path: PATH)
			-- Make `a_path' the base directory.
		do
			internal_start_directory := a_path
			set_directory_path (a_path)
		end

feature {NONE} -- Implementation

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show the
		local
			button: INTEGER
		do
			check attached {EV_WINDOW_IMP} a_window.implementation as l_window then
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

	internal_start_directory: detachable like start_directory

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIRECTORY_DIALOG note option: stable attribute end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_DIRECTORY_DIALOG_IMP
