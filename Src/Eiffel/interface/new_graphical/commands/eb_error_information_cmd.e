note
	description: "Dialog used to display extended help concerning a compilation error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ERROR_INFORMATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_STONABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Status report

	is_valid_stone (a_stone: STONE): BOOLEAN
			-- <Precursor>
		do
			Result := attached {ERROR_STONE} a_stone as l_error
		end

feature -- Basic operations

	execute
			-- <Precursor>
		do
			execute_with_text (Interface_names.e_Drop_an_error_stone)
		end

	execute_with_stone (a_stone: STONE)
			-- <Precursor>
		do
			if attached {ERROR_STONE} a_stone as l_error then
				execute_with_text (l_error.help_text)
			end
		end

feature -- Status report

	description: STRING_GENERAL
			-- Explanatory text for this command.
		do
			Result := Interface_names.e_Display_error_help
		end

	tooltip: STRING_GENERAL
			-- Tooltip for `Current's toolbar button.
		do
			Result := Interface_names.e_Display_error_help
		end

	tooltext: STRING_GENERAL
			-- Text for `Current's toolbar button.
		do
			Result := Interface_names.b_Display_error_help
		end

	name: STRING = "Open_help_tool"
			-- Internal textual representation.

	pixmap: EV_PIXMAP
			-- Image used for `Current's toolbar buttons.
		do
			Result := pixmaps.icon_pixmaps.command_error_info_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_error_info_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Text used for menu items for `Current'.
		do
			Result := Interface_names.m_Display_error_help
		end

feature {NONE} -- Implementation

	current_dialog: EV_DIALOG
			-- Dialog used to display the error explanations.

	current_editor: SELECTABLE_TEXT_PANEL
			-- Text in which the explanation texts are put.

	execute_with_text (a_text: STRING)
			-- Pop up a new dialog and display `a_text' inside it.
		do
			create_new_dialog
			current_editor.load_text (a_text)
			current_editor.disable_line_numbers
			current_dialog.show_relative_to_window (Window_manager.last_focused_development_window.window)
			current_dialog := Void
		end

	create_new_dialog
			-- Fill `current_dialog' with a newly created dialog.
		local
			but: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			fs: INTEGER
			ft: EV_FONT
			f: EV_FRAME
		do
				-- Build the layout.
			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.small_border_size)
			create hb
			create current_dialog
			current_dialog.set_title (Interface_names.t_Extended_explanation)
			current_dialog.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)

			create but.make_with_text (Interface_names.b_Close)
			Layout_constants.set_default_width_for_button (but)
			create current_editor
			current_editor.set_cursors (create {EB_EDITOR_CURSORS})
			current_editor.set_reference_window (current_dialog)
			current_editor.widget.set_minimum_size (150, 100)

			create f
			f.extend (current_editor.widget)
			hb.extend (create {EV_CELL})
			hb.extend (but)
			hb.disable_item_expand (but)
			hb.extend (create {EV_CELL})
			vb.extend (f)
			vb.extend (hb)
			vb.disable_item_expand (hb)

			current_dialog.extend (vb)

				-- Set up the event handlers.
			current_dialog.set_default_cancel_button (but)
			but.select_actions.extend (agent current_dialog.destroy)
			current_editor.drop_actions.extend (agent set_stone (current_editor, ?))
				--| + 1 to make sure there is enough room.
			ft := (create {SHARED_EDITOR_FONT}).font
			fs := (ft.maximum_width + ft.width) // 2
				--| 60 is the number of characters in the error texts,
				--| 56 is the overhead brought by the editor (margins),
				--| 20 is an approximation of the overhead due to the window border.
			current_dialog.set_size (Layout_constants.dialog_unit_to_pixels (60 * fs + 56 + 20),
									 Layout_constants.dialog_unit_to_pixels (300))
		ensure
			valid_dialog: current_dialog /= Void and then not current_dialog.is_destroyed
			valid_editor: current_editor /= Void
		end

	set_stone (editor: SELECTABLE_TEXT_PANEL; st: ERROR_STONE)
			-- Display the help text associated with `st' in `editor'.
		require
			valid_stone: st /= Void
			valid_editor: editor /= Void
		do
			editor.load_text (st.help_text)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_ERROR_INFORMATION_DIALOG
