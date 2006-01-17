indexing
	description: "Objects that display an exception or an error in an EV_DIALOG."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_EXCEPTION_DIALOG

inherit
	EB_DEBUGGER_EXCEPTION_DIALOG_IMP
		redefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
create
	make, default_create --, make_with_window

feature {NONE} -- Initialization

	make (a_exception_tag, a_exception_message: STRING) is
			-- Create Current with Exception message
		do
			default_create
			set_exception_tag (a_exception_tag)
			set_exception_message (a_exception_message)			
		end

	make_with_window (a_window: EV_DIALOG) is
			-- Create `Current' in `a_window'.
		require
			window_not_void: a_window /= Void
			window_empty: a_window.is_empty
			no_menu_bar: a_window.menu_bar = Void
		do
			window := a_window
			initialize
		ensure
			window_set: window = a_window
			window_not_void: window /= Void
		end

	default_create is
			 -- Create `Current'.
		do
			create window
			initialize
		ensure then
			window_not_void: window /= Void
		end

feature -- Show

	show_modal_to_window (w: EV_WINDOW) is
			-- Show modal to window
		do
			window.show_modal_to_window (w)
		end
		
feature -- Details

	set_title_and_label (t,l: STRING) is
			-- Set the title and the label of the window
		require
			t /= Void
			l /= Void
		do
			window.set_title (t)
			label.set_text (l)
		end

	set_exception_tag (t: STRING) is
			-- Set tag and refresh display
		do
			tag := t
			display_exception_tag_and_message
		end

	set_exception_message (t: STRING) is
			-- Set message and refresh display
		do
			message := t
			display_exception_tag_and_message
		end
		
	display_exception_tag_and_message is
			-- Display Exception's tag and message
		local
			s: STRING
		do
			s := ""
			if tag /= Void then
				s.append_string (tag)
				s.append_string ("%N%N")
			end
			if message /= Void then
				s.append_string (message)				
			end
			if s.occurrences ('%R') > 0 then
				s.prune_all ('%R')
			end
			message_text.set_text (s)
			message_text.disable_edit
			message_text.set_background_color ((create {EV_STOCK_COLORS}).white)			
		end		

	set_details (d: STRING) is
			-- Add additional details
		local
			s: STRING
		do
			s := d.twin
			if s.occurrences ('%R') > 0 then
				s.prune_all ('%R')
			end
			details_text.set_text (s)
			details_box.show
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			window.set_size (400, 400)
			set_title_and_label (
					"Debugger :: Exception message",
					"Exception message from debugger"
					)

			details_box.hide
			message_text.enable_word_wrapping
			message_text.disable_edit
			message_text.set_background_color ((create {EV_STOCK_COLORS}).white)
			window.set_default_cancel_button (close_button)
			window.set_icon_pixmap (pixmaps.icon_dialog_window)
		end

feature {NONE} -- Implementation

	tag, message: STRING
			-- Exception tag and message

	save_exception_message is
			-- Save exception trace into a file
		local
			sfd: EB_FILE_SAVE_DIALOG
			text_file: PLAIN_TEXT_FILE
			retried: BOOLEAN
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
			if not retried then
				create sfd.make_with_preference (preferences.dialog_data.last_saved_debugger_exception_directory_preference)
				set_dialog_filters_and_add_all (sfd, <<text_files_filter>>)
				create l_env
				l_dir := l_env.current_working_directory
				sfd.show_modal_to_window (window)
				l_env.change_working_directory (l_dir)
				if not sfd.file_name.is_empty then
					create text_file.make_open_write (sfd.file_name)
					text_file.put_string (message_text.text)
					text_file.close
				end
			end
		rescue
			retried := True
			retry
		end
	
	close_dialog is
			-- Close dialog
		do
			window.destroy
		end
		
	set_wrapping_mode is
			-- update wrapping mode for exception message
		do
			if wrapping_button.is_selected then
				message_text.enable_word_wrapping
			else
				message_text.disable_word_wrapping				
			end
			message_text.disable_edit
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_DEBUGGER_EXCEPTION_DIALOG

