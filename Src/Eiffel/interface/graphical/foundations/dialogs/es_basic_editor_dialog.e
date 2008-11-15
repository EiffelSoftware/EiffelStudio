indexing
	description: "[
		A basic dialog for displaying text in a basic Eiffel studio editor.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ES_BASIC_EDITOR_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog,
			make_with_window as make_dialog_with_window
		redefine
			on_before_initialize
		end

	EB_SHARED_PREFERENCES
		rename
			preferences as shared_preferences
		export
			{NONE} all
		end

create
	make,
	make_with_window

feature {NONE} -- Initialization

	make (a_icon: !like icon; a_title: !READABLE_STRING_GENERAL)
			-- Initialize the editor dialog.
			--
			-- `a_icon': The icon to set on the dialog.
			-- `a_title': The title to set on the dialog.
		require
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			not_a_title_is_empty: not a_title.is_empty
		do
			icon := a_icon
			internal_title := a_title.as_string_32
			make_dialog
		ensure
			icon_set: icon ~ a_icon
			title_set: a_title.as_string_32.is_equal (title)
		end

	make_with_window (a_icon: !like icon; a_title: !READABLE_STRING_GENERAL; a_window: !like development_window)
			-- Initialize the editor dialog using a specific development window.
			--
			-- `a_icon': The icon to set on the dialog.
			-- `a_title': The title to set on the dialog.
			-- `a_window': The parent host window to center the dialog to.
		require
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			not_a_title_is_empty: not a_title.is_empty
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			icon := a_icon
			internal_title := a_title.as_string_32
			make_dialog_with_window (a_window)
		ensure
			icon_set: icon ~ a_icon
			title_set: a_title.as_string_32.is_equal (title)
			development_window_set: development_window ~ a_window
		end

feature {NONE} -- Initialize

	on_before_initialize
			-- <Precursor>
		do
			is_auto_resized := True
			Precursor
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_border: ES_BORDERED_WIDGET [EV_WIDGET]
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.dialog_button_vertical_padding)

				--
				-- `text_panel'
				--
			create text_panel
			text_panel.disable_line_numbers
			text_panel.widget.set_minimum_size (400, 165)
			create l_border.make (text_panel.widget)
			a_container.extend (l_border)
		end

feature -- Access

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_buttons
		end

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	icon: !EV_PIXEL_BUFFER assign set_icon
			-- <Precursor>

	title: !STRING_32
			-- <Precursor>
		do
			if {l_result: STRING_32} dialog.title and then not l_result.is_empty then
				Result := l_result
			elseif {l_internal_result: STRING_32} internal_title then
				Result := l_internal_result
			else
				check False end
				create Result.make_empty
			end
		end

	text: !STRING_32
			-- Editor text
		require
			is_interface_usable: is_interface_usable
		do
			if {l_result: STRING_32} internal_text then
				Result := l_result
			else
				create Result.make_empty
				internal_text := Result
			end
		end

feature -- Element change

	set_title (a_title: !READABLE_STRING_GENERAL)
			-- Sets the dialog title.
			--
			-- `a_title': The title to display on the dialog
		require
			is_initialized: is_initialized
			is_interface_usable: is_interface_usable
			not_a_title_is_empty: not a_title.is_empty
		do
			internal_title := a_title.as_string_32
			dialog.set_title (internal_title)
		ensure
			title_set: a_title.as_string_32.is_equal (title)
		end

	set_icon (a_icon: !like icon)
			-- Sets the dialog's icon.
			--
			-- `a_icon': The icon to display on the dialog.
		require
			is_initialized: is_initialized
			is_interface_usable: is_interface_usable
			not_a_icon_is_destroyed: not a_icon.is_destroyed
		do
			dialog.set_icon_pixmap (icon.to_pixmap)
		ensure
			icon_set: icon ~ a_icon
		end

	set_text (a_text: !like text)
			-- Sets the display text.
			--
			-- `a_text': The text to display in the editor
		require
			is_initialized: is_initialized
			is_interface_usable: is_interface_usable
			not_a_text_is_empty: not a_text.is_empty
		do
			internal_text := a_text.as_string_32
			if is_auto_resized then
				resize_text_panel
			end
			text_panel.load_text (internal_text)
		ensure
			text_set: a_text.as_string_32.is_equal (text)
		end

feature -- Status report

	is_auto_resized: BOOLEAN assign set_is_auto_resized
			-- Indicates if the dialog should be automatically resized to best fit the set text.

feature -- Status setting

	set_is_auto_resized (a_auto_resize: BOOLEAN)
			-- Sets automatic resizing ability of the dialog.
			--
			-- `a_auto_resize': True to perform automatic resizing; False otherwise.
		require
			is_initialized: is_initialized
			is_interface_usable: is_interface_usable
		do
			is_auto_resized := a_auto_resize
			if is_shown and then a_auto_resize then
				resize_text_panel
			end
		ensure
			is_auto_resized_set: is_auto_resized = a_auto_resize
		end

feature {NONE} -- Basic operations

	resize_text_panel
			-- Resizes the text panel to match that of the the trace text
		require
			is_initialized: is_initialized or is_initializing
			is_interface_usable: is_interface_usable
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := (text_panel.left_margin_width * 2) + text_panel.font.string_width (text) + text_panel.vertical_scrollbar.width
			l_width := l_width.min ({ES_UI_CONSTANTS}.dialog_maximum_width)
			l_height := 2 + (text_panel.line_height * text.occurrences ('%N'))
			l_height := l_height.min ({ES_UI_CONSTANTS}.dialog_maximum_height)
			text_panel.widget.set_minimum_size (l_width, l_height)
		end

feature {NONE} -- User interface elements

	text_panel: !SELECTABLE_TEXT_PANEL
			-- Widget diaplying exception log

feature {NONE} -- Action handlers

	on_ok
			-- Called when the user selects the Ok button
		do
			--| Do nothing
		end

feature {NONE} -- Implementation: Internal cache

	internal_title: ?like title
			-- Temporary version of `title', used during initialization only.
			-- Note: Do not use!

	internal_text: ?like text
			-- Cached version of `text'.
			-- Note: Do not use!

;indexing
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

end
