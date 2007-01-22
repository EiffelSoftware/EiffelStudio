indexing
	description: "A basic editor for EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR

inherit
	EDITABLE_TEXT_PANEL
		rename
			cursors as editor_cursors,
			recycle as internal_recycle
		undefine
			font,
			line_height
		redefine
			handle_extended_ctrled_key,
			display_not_editable_warning_message,
			load_file,
			load_text,
			initialize_editor_context,
			reference_window,
			internal_recycle,
			show_warning_message
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_RECYCLABLE
		undefine
			default_create
		end

	SHARED_EDITOR_FONT
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	EB_STONABLE
		rename
			refresh as refresh_stone,
			set_position as set_stone_position,
			position as stone_position
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	 make is
			-- Initialize the editor.
		do
			default_create
			register_documents
		end

	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor pixmaps.
		do
			set_cursors (create {EB_EDITOR_CURSORS})
		end

	register_documents is
	 		-- Register known document types with this editor
	 	do
	 		register_document ("e", eiffel_class)
	 	end

	 eiffel_class: DOCUMENT_CLASS is
	         -- Eiffel class
	   	once
			create Result.make ("eiffel", "e", Void)
	   	    Result.set_scanner (create {EDITOR_EIFFEL_SCANNER}.make)
	   	end

feature -- Warning messages display

	display_not_editable_warning_message is
				-- display warning message : text is not editable...
		local
			wm: STRING_32
			w: EB_TEXT_LOADING_WARNING_DIALOG
		do
			if text_displayed /= Void then
				if is_read_only and then not allow_edition then
					if not_editable_warning_message = Void or else not_editable_warning_message.is_empty then
						wm := Warning_messages.w_Text_not_editable
					else
						wm := not_editable_warning_message
					end
					show_warning_message (wm)
				else
					create w.make
					w.show_modal_to_window (reference_window)
				end
			end
		end

	show_warning_message (a_message: STRING_GENERAL) is
			-- show `a_message' in a dialog window		
		local
			wd: EB_WARNING_DIALOG
		do
			create wd.make_with_text (a_message)
			wd.pointer_button_release_actions.force_extend (agent wd.destroy)
			wd.key_press_actions.force_extend (agent wd.destroy)
			wd.show_modal_to_window (reference_window)
		end

feature -- Access

	dev_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

	docking_content: SD_CONTENT
			-- Docking content.

feature -- Docking

	set_docking_content (a_content: SD_CONTENT) is
			-- Set `docking_content' with `a_content' and associate `widget' to `a_content'.
		require
			a_content_attached: a_content /= Void
		do
			docking_content := a_content
		end

feature -- Text Loading

	load_file (a_filename: STRING) is
	        -- Load contents of `a_filename'
		local
		    test_file, test_file_2: RAW_FILE
		    l_filename: FILE_NAME
  	   	do
  	   		reset
  	   		load_file_error := False

  	   		create l_filename.make_from_string (a_filename)
			create test_file.make (l_filename.string.twin)
			l_filename.add_extension ("swp")
			create test_file_2.make (l_filename)
			if test_file_2.exists and then test_file_2.is_readable and then ((not test_file.exists) or else test_file.date < test_file_2.date) then
				if test_file.exists then
					ask_if_opens_backup
					if not open_backup then
						test_file_2.delete
							-- Use original file
						create l_filename.make_from_string (a_filename)
					end
				end
					-- If `test_file' does not exist we force a loading of the backup file.
				Precursor (l_filename)
			else
				create l_filename.make_from_string (a_filename)
				Precursor (l_filename)
			end
  	  	end

	load_text (s: STRING) is
			-- Load text
		local
			l_d_class : DOCUMENT_CLASS
			l_scanner: EDITOR_EIFFEL_SCANNER
			l_stone: CLASSI_STONE
		do
			l_d_class := get_class_from_type (once "e")
			set_current_document_class (l_d_class)
			l_scanner ?= l_d_class.scanner
			if l_scanner /= Void then
				l_stone ?= stone
				if l_stone /= Void then
					l_scanner.set_current_class (l_stone.class_i.config_class)
				end
			end
			Precursor {EDITABLE_TEXT_PANEL} (s)
		end

feature -- Stonable

	stone : STONE
			-- Stone representing Current

	set_stone (a_stone: STONE) is
			-- Make `s' the new value of stone.
			-- Changes display as a consequence, to preserve the fact
			-- that the tool displays the content of the stone
			-- (when there is a stone).
		require else
			a_stone_attached: a_stone /= Void
		do
			stone := a_stone
		ensure then
			stone_attached: stone = a_stone
		end

	refresh_stone is
			-- Synchronize Current with `stone'.
		do

		end

feature {NONE} -- Memory Management

	internal_recycle is
			-- Destroy `Current'.
		do
			Precursor {EDITABLE_TEXT_PANEL}
			dev_window := Void
		end

feature {NONE} -- Handle keystokes

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		do
			inspect
				ev_key.code

			when Key_u then
					-- Ctrl-U
				run_if_editable (agent set_selection_case(shifted_key))

			when Key_k then
				if shifted_key then
						-- Ctrl+Shift+K uncomment selection
					run_if_editable (agent uncomment_selection)
				else
						-- Ctrl+K
					run_if_editable (agent comment_selection)
				end
			else
				Precursor (ev_key)
			end
		end

feature {EB_COMMAND, EB_SEARCH_PERFORMER, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Edition Operations on text

	comment_selection is
			-- Comment selected lines if possible.
		do
			if is_editable and then not is_empty then
				text_displayed.comment_selection
				refresh_now
			end
		end

	uncomment_selection is
			-- Uncomment selected lines if possible.
		do
			if is_editable and then not is_empty then
				text_displayed.uncomment_selection
				refresh_now
			end
		end

feature {NONE} -- Retrieving backup

	ask_if_opens_backup is
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			dial: EB_WARNING_DIALOG
		do
			create dial.make_with_text (Warning_messages.w_Found_backup)
			dial.set_buttons_and_actions (<<Interface_names.b_Open_backup, Interface_names.b_Open_original>>, <<agent open_backup_selected, agent open_normal_selected>>)
			dial.set_default_push_button (dial.button (Interface_names.b_Open_backup))
			dial.set_default_cancel_button (dial.button (Interface_names.b_Open_original))
			dial.set_title (Interface_names.t_Open_backup)
			dial.show_modal_to_window (reference_window)
		end

feature {NONE} -- Implementation

	reference_window: EV_WINDOW is
			-- Window which error dialogs will be shown relative to.
		do
			if internal_reference_window /= Void then
				Result := internal_reference_window
			else
				if dev_window /= Void and then dev_window.window /= Void then
					Result := dev_window.window
				else
					Result := Window_manager.last_focused_window.window
				end
				internal_reference_window := Result
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EDITOR
