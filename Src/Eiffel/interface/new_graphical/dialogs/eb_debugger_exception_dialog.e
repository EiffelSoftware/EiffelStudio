indexing
	description: "Objects that display an exception or an error in an EV_DIALOG."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_EXCEPTION_DIALOG

inherit
	ES_DIALOG

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX) is
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			hb: EV_HORIZONTAL_BOX
		do
			create label
			create wrapping_button
			create message_text
			create details_box
			create details_text
			details_box.extend (details_text)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			hb.extend (label); hb.disable_item_expand (label)
			hb.extend (create {EV_CELL})
			hb.extend (wrapping_button); hb.disable_item_expand (wrapping_button)

			a_container.extend (hb); a_container.disable_item_expand (hb)
			a_container.extend (message_text)
			a_container.extend (details_box); a_container.disable_item_expand (details_box)

			label.set_minimum_height (20)
			wrapping_button.enable_select
			wrapping_button.set_text (interface_names.l_wrap)
			message_text.enable_word_wrapping
			message_text.disable_edit
			message_text.set_minimum_width (300)
			message_text.set_minimum_height (80)
			message_text.set_background_color (colors.stock_colors.white)

			details_box.set_text (interface_names.l_additional_details)
			details_box.hide

			wrapping_button.select_actions.extend (agent set_wrapping_mode)

			set_title_and_label (
					interface_names.l_debugger_exception_message,
					interface_names.l_exception_message_from_debugger
					)

			set_button_text (dialog_buttons.ok_button, interface_names.b_save)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_close)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_save)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_close)

			save_button := dialog_window_buttons.item (dialog_buttons.ok_button)
			close_button := dialog_window_buttons.item (dialog_buttons.cancel_button)

			dialog.set_size (400, 400)
		end

feature -- Widgets

	message_text: EV_TEXT
			-- Message text field.

	wrapping_button: EV_CHECK_BUTTON
			-- Wrapping button

	label, details_text: EV_LABEL
			-- Details labels

	details_box: EV_FRAME
			-- Details's box

	save_button, close_button: EV_BUTTON
			-- Dialog's buttons

feature -- Details

	set_title_and_label (t,l: STRING_GENERAL) is
			-- Set the title and the label of the window
		require
			title_not_void: t /= Void
			label_not_void: l /= Void
		do
			dialog.set_title (t)
			label.set_text (l)
		end

	set_exception (e: EXCEPTION_DEBUG_VALUE) is
			-- Set Exception value
		do
			set_exception_meaning (e.meaning)
			set_exception_message (e.message)
			set_exception_text (e.text)
		end

	set_exception_meaning (t: STRING_GENERAL) is
			-- Set meaning and refresh display
		do
			if t /= Void and then not t.is_empty then
				exception_meaning := t.as_string_32
			else
				exception_meaning := Void
			end
			display_exception_info
		end

	set_exception_message (t: STRING_GENERAL) is
			-- Set message and refresh display
		do
			if t /= Void and then not t.is_empty then
				exception_message := t.as_string_32
			else
				exception_message := Void
			end

			display_exception_info
		end

	set_exception_text (t: STRING_GENERAL) is
			-- Set text and refresh display
		do
			if t /= Void and then not t.is_empty then
				exception_text := t.as_string_32
			else
				exception_text := Void
			end

			display_exception_info
		end

	display_exception_info is
			-- Display Exception's tag and message
		local
			s: STRING_32
		do
			create s.make_empty
			if exception_meaning /= Void then
				s.append_string (exception_meaning)
				s.append_string ("%N")
			end
			if exception_message /= Void then
				if exception_meaning = Void or else not exception_message.is_equal (exception_meaning) then
					s.append_string (exception_message)
					s.append_string ("%N")
				end
			end
			if exception_text /= Void then
				if not s.is_empty then
					s.append_string ("%N")
				end
				s.append_string (exception_text)
			end
			if s.occurrences ('%R') > 0 then
				s.prune_all ('%R')
			end
			message_text.set_text (s)
			message_text.disable_edit
			message_text.set_background_color ((create {EV_STOCK_COLORS}).white)
			if s.count > 0 then
				save_button.enable_sensitive
			else
				save_button.disable_sensitive
			end
		end

	set_details (d: STRING_GENERAL) is
			-- Add additional details
		require
			d_not_void: d /= Void
		local
			s32: STRING_32
		do
			s32 := d.twin.as_string_32
			if s32.occurrences ('%R') > 0 then
				s32.prune_all ('%R')
			end
			details_text.set_text (s32)
			details_box.show
		end

feature {NONE} -- Implementation

	exception_meaning,
	exception_message,
	exception_text: STRING_32
			-- Exception meaning, message, and text

	save_exception_message is
			-- Save exception trace into a file
		local
			l_save_tool: EB_SAVE_STRING_TOOL
		do
			create l_save_tool.make (dialog)
			l_save_tool.set_text (message_text.text)
			l_save_tool.set_title (Interface_names.e_Save_exception_into)
			l_save_tool.save
		end

	on_save is
			-- Action to do when "Save" button is activated
		do
			save_exception_message
			veto_close
		end

	on_close is
			-- Action to do when "Close" button is activated
		do
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

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.l_debugger_exception_message
		end

	buttons: DS_SET [INTEGER] is
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER is
			-- The dialog's default action button
		do
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER is
			-- The dialog's default cancel button
		do
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER is
			-- The dialog's default confirm button		
		do
			Result := dialog_buttons.cancel_button
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

end -- class EB_DEBUGGER_EXCEPTION_DIALOG

