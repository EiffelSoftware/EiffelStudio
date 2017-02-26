note
	description: "Main window for this application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			setup_widgets

			default_create

			extend (main_container)
				-- Set the title of the window
			set_title (Window_title)
				-- Set the initial size of the window
			set_size (Window_width, Window_height)



				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

			show_content_control_panel
		end

	setup_widgets
			-- Build the interface for this window.
		do
			build_containers

			main_container.extend (docking_container)
		end

feature -- Query

	is_main_container_set: BOOLEAN
			-- If main container has been set?

feature {NONE} -- Implemetation, Docking management

	show_content_control_panel
			-- Show center control panel
		local
			l_dialog: EV_DIALOG
			l_docking_manager: SD_DOCKING_MANAGER
			l_content_control_panel: CONTENT_CONTROL_PANEL
		do
			create l_dialog.make_with_title ("Control Panel")
			create l_docking_manager.make (docking_container, Current)
			create l_content_control_panel.make (l_docking_manager, Current)
			l_dialog.extend (l_content_control_panel)
			l_dialog.set_width (400)
			l_dialog.set_height (400)
			l_dialog.show_relative_to_window (Current)
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button ~ ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window is closed..
				if attached (create {EV_ENVIRONMENT}).application as l_app then
					l_app.destroy
				else
					check False end -- Implied by application is running
				end
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	docking_container: EV_VERTICAL_BOX
			-- Container managed by docking manager.

	build_containers
			-- Create `main_container' and `docking_container'.
		require
			main_container_not_yet_created: not is_main_container_set
		do
			create main_container
			is_main_container_set := True
			create docking_container
		ensure
			main_container_created: is_main_container_set
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "Docking Control"
			-- Title of the window.

	Window_width: INTEGER = 800
			-- Initial width for this window.

	Window_height: INTEGER = 600
			-- Initial height for this window.

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
	]"

end
