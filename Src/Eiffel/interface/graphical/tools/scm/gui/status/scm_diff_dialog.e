note
	description: "Summary description for {SCM_DIFF_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_DIFF_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		redefine
			is_size_and_position_remembered
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_SCM_NAMES

	EV_LAYOUT_CONSTANTS

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S; a_diff: SCM_DIFF)
		do
			scm_service := a_service
			diff := a_diff
			create progress_log_text

			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	diff: SCM_DIFF

feature -- Widgets

	progress_log_text: EV_TEXT


feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			txt: EV_TEXT
		do
			txt := progress_log_text
			txt.set_text (diff.full_text)
			txt.disable_edit
			a_container.extend (txt)

			set_button_text (dialog_buttons.close_button, interface_names.b_close)

			set_button_action_before_close (dialog_buttons.close_button, agent on_close)
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "FIXME..." -- FIXME
		end

feature {NONE} -- Helpers

	register_input_widget (aw: EV_WIDGET)
			-- Register `aw' as an input widget
		do
			suppress_confirmation_key_close  (aw)
		end

	extend_non_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, False)
		end

	extend_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, True)
		end

	extend_to (b: EV_BOX; w: EV_WIDGET; is_expandable: BOOLEAN)
			-- Extend `w' to `b', and keep expand enabled (default)
		do
			b.extend (w)
			if not is_expandable then
				b.disable_item_expand (w)
			end
		end

feature -- Action

	set_size (w,h: INTEGER)
		do
			dialog.set_size (w, h)
		end

	on_close
		do
			-- Bye
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.source_version_control_icon_buffer
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := scm_names.title_scm_diff
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.close_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.close_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.close_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.close_button
		end

	is_size_and_position_remembered: BOOLEAN = False
			-- Indicates if the size and position information is remembered for the dialog	

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end
