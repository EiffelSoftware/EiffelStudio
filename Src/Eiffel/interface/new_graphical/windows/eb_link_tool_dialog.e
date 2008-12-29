note
	description: "Windows that allows the user to put handles on links"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LINK_TOOL_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end
create
	default_create

feature {NONE} -- Initialization

	initialize
			-- Build the dialog box.
		local
			ok_button, cancel_button: EV_BUTTON
			hb, hb2, hb3, hb5: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			frm: EV_FRAME
		do
			Precursor
			cancelled := False
			set_title (Interface_names.t_Diagram_link_tool)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)

			create ok_button.make_with_text_and_action (Interface_names.b_ok, agent ok_action)
			create cancel_button.make_with_text_and_action (Interface_names.b_cancel, agent cancel_action)
			create cb_nothing.make_with_text (interface_names.b_do_nothing)
			cb_nothing.hide
			create cb_left.make_with_text_and_action (interface_names.b_put_handle_left, agent apply_action)
			create cb_right.make_with_text_and_action (interface_names.b_put_handle_right, agent apply_action)
			create cb2_left.make_with_text_and_action (interface_names.b_put_two_handle_left, agent apply_action)
			create cb2_right.make_with_text_and_action (interface_names.b_put_two_handle_right, agent apply_action)
			create cb_reset.make_with_text_and_action (interface_names.b_Remove_handles, agent apply_action)
			create main_vb
			main_vb.set_padding (Layout_constants.Small_padding_size)
			main_vb.set_border_width (Layout_constants.Default_border_size)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			create hb2
			hb2.set_padding (Layout_constants.Small_padding_size)
			create hb3
			hb3.set_padding (Layout_constants.Small_padding_size)
			create hb5
			hb5.set_padding (Layout_constants.Small_padding_size)

			create frm
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			frm.extend (vb)

			vb.extend (cb_nothing)
			vb.extend (cb_left)
			vb.extend (cb_right)
			vb.extend (cb2_left)
			vb.extend (cb2_right)
			vb.extend (cb_reset)

			extend_button (hb5, ok_button)
			extend_button (hb5, cancel_button)

			extend (main_vb)
			main_vb.extend (frm)
			main_vb.disable_item_expand (frm)
			main_vb.extend (hb5)
			main_vb.disable_item_expand (hb5)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)

			set_minimum_size (width, height)
		end

feature -- Status report

	handle_left_selected: BOOLEAN
			-- Did the user choose "Put handle left on this link"?
		do
			Result := cb_left.is_selected
		end

	handle_right_selected: BOOLEAN
			-- Did the user choose "Put handle right on this link"?
		do
			Result := cb_right.is_selected
		end

	two_handles_left_selected: BOOLEAN
			-- Did the user choose "Put two handles left on this link"?
		do
			Result := cb2_left.is_selected
		end

	two_handles_right_selected: BOOLEAN
			-- Did the user choose "Put two handles right on this link"?
		do
			Result := cb2_right.is_selected
		end

	reset_selected: BOOLEAN
			-- Did the user choose "Remove handles on this link"?
		do
			Result := cb_reset.is_selected
		end

	cancelled: BOOLEAN
			-- Was the action cancelled?

feature {EB_LINK_TOOL_COMMAND} -- Status setting

	set_for_client_link
			-- Add list of features represented by `link_figure'.
		local
			frame_list: EV_FRAME
			vb: EV_VERTICAL_BOX
		do
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Default_border_size)
			create frame_list.make_with_text (interface_names.l_feature_list)
			frame_list.extend (vb)
			vb.extend (feature_list)
			main_vb.finish
			main_vb.put_left (frame_list)
			set_minimum_size (width, height + 120)
			set_maximum_width (width)
		end

feature {EB_LINK_TOOL_COMMAND} -- Element change

	set_strings (a_string_array: INDEXABLE [STRING, INTEGER])
			-- Wipe out `feature_list' and re-initialize with an item
			-- for each of `a_string_array'.
		do
			create feature_list
			feature_list.set_strings (a_string_array)
		end

	set_link_tool_command (ltc: EB_LINK_TOOL_COMMAND)
			-- Assign `ltc' to `link_tool_command'.
		require
			command_exists: ltc /= Void
		do
			link_tool_command := ltc
		ensure
			assigned: link_tool_command = ltc
		end

	set_link_figure (lf: EIFFEL_LINK_FIGURE)
			-- Assign `lf' to `link_figure'.
		require
			figure_exists: lf /= Void
		do
			link_figure := lf
		ensure
			assigned: lf = link_figure
		end

feature {EB_LINK_TOOL_COMMAND} -- Events

	cancel_action
			-- Close dialog.
		do
			cancelled := True
			hide
			link_tool_command.on_dialog_closed
		end

feature {EB_LINK_TOOL_COMMAND} -- Access

	link_figure: EIFFEL_LINK_FIGURE
			-- Figure on which `Current' has an effect.

feature {NONE} -- Implementation

	main_vb: EV_VERTICAL_BOX
			-- Main container inside `Current'.

	cb_nothing, cb_left, cb_right, cb2_left, cb2_right, cb_reset: EV_RADIO_BUTTON
			-- Buttons to tweak link handles.

	feature_list: EV_LIST
			-- Graphical list of links represented by `link_figure'.
			-- Void if `link_figure' is an inheritance link.

	link_tool_command: EB_LINK_TOOL_COMMAND
			-- Associated command.

	ok_action
			-- Close dialog.
		do
			cancelled := False
			hide
			link_tool_command.on_dialog_closed
		end

	apply_action
			-- Close dialog.
		do
				-- We need to check if `link_figure' is still on the diagram.
			if link_figure /= Void and then link_figure.world /= Void then
				if not link_figure.is_reflexive then
					link_figure.hide
					link_tool_command.project
					if handle_left_selected then
							link_figure.put_handle_left
					elseif handle_right_selected then
							link_figure.put_handle_right
					elseif two_handles_left_selected then
							link_figure.put_two_handles_left
					elseif two_handles_right_selected then
							link_figure.put_two_handles_right
					elseif reset_selected then
							link_figure.reset
					end
					link_figure.show
					link_tool_command.project
				end
			end
		end

note
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

end -- class EB_LINK_TOOL_DIALOG
