indexing
	description	: "Dialog to display an exception trace"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXCEPTION_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
			{ANY} show_modal_to_window
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_trace: STRING) is
			-- Perform clean quit of $EiffelGraphicalCompiler$
		local
			error_label: EV_LABEL
			error_pixmap: EV_PIXMAP
			buttons_box: EV_HORIZONTAL_BOX
			error_box: EV_HORIZONTAL_BOX
			main_box: EV_VERTICAL_BOX
			quit_button: EV_BUTTON
			restart_button: EV_BUTTON
			exception_frame: EV_FRAME
			pixmap_box: EV_VERTICAL_BOX
			exception_text: TEXT_PANEL
			save_button: EV_BUTTON
		do
			trace := a_trace
			
			default_create
			set_title ("Internal Error")
			set_size (600, 440)

			create error_label.make_with_text (Warning_messages.w_Internal_error)
			error_label.align_text_left
			error_pixmap := clone (Pixmaps.error_pixmap)
			error_pixmap.set_minimum_size (error_pixmap.width, error_pixmap.height)
			
			create quit_button.make_with_text_and_action ("Quit now!", agent execute_die)
			create restart_button.make_with_text_and_action ("Restart now!", agent restart)
			create save_button.make_with_text_and_action ("Save", agent save_exeption_trace)
			Layout_constants.set_default_size_for_button (quit_button)
			Layout_constants.set_default_size_for_button (restart_button)
			Layout_constants.set_default_size_for_button (save_button)

			create exception_text.make
			exception_text.widget.set_minimum_height (Layout_constants.dialog_unit_to_pixels (60))
			exception_text.load_basic_text (trace)
			
			create pixmap_box
			pixmap_box.extend (error_pixmap)
			pixmap_box.disable_item_expand (error_pixmap)
			pixmap_box.extend (create {EV_CELL})
			
			create error_box
			error_box.set_padding (Layout_constants.Default_padding_size)
			error_box.extend (pixmap_box)
			error_box.disable_item_expand (pixmap_box)
			error_box.extend (error_label)
			error_box.disable_item_expand (error_label)
			error_box.extend (create {EV_CELL})
			
			create exception_frame
			exception_frame.extend (exception_text.widget)

			create buttons_box
			buttons_box.set_padding (Layout_constants.Default_padding_size)
			buttons_box.extend (create {EV_CELL})
			buttons_box.extend (quit_button)
			buttons_box.disable_item_expand (quit_button)
			buttons_box.extend (restart_button)
			buttons_box.disable_item_expand (restart_button)
			buttons_box.extend (save_button)
			buttons_box.disable_item_expand (save_button)
			buttons_box.extend (create {EV_CELL})
			
			create main_box
			main_box.set_padding (Layout_constants.Default_padding_size)
			main_box.set_border_width (Layout_constants.Default_border_size)
			main_box.extend (error_box)
			main_box.disable_item_expand (error_box)
			main_box.extend (exception_frame) -- Expadable item
			main_box.extend (buttons_box)
			main_box.disable_item_expand (buttons_box)
			
			extend (main_box)
			set_default_push_button (restart_button)
			set_default_cancel_button (quit_button)
		end
		
feature {NONE} -- Implementation

	execute_die is
			-- Command call when a crash occurs to clean up disk
		do
				-- Ensure clean exit in case of exception
			(create {EXCEPTIONS}).die (-1)
		end

	restart is
		local
			launcher: COMMAND_EXECUTOR
		do
			create launcher
			launcher.execute ((create {EIFFEL_ENV}).Estudio_command_name)
			execute_die
		end

	save_exeption_trace is
			-- Save exception trace into a file
		local
			sfd: EV_FILE_SAVE_DIALOG
			text_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create sfd
				sfd.set_filter("*.txt")
				sfd.show_modal_to_window (Current)
				if not sfd.file_name.is_empty then
					create text_file.make_open_write (sfd.file_name)
					text_file.put_string (trace)
					text_file.close
				end
			end
		rescue
			retried := True
			retry
		end

	trace: STRING
			-- displayed Trace
			
end -- class EB_EXCEPTION_DIALOG
