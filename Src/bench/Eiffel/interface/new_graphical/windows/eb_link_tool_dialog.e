indexing
	description: "Windows that allows the user to put handles on links"
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

	initialize is
			-- Build the dialog box.
		local
			ok_button, apply_button, cancel_button: EV_BUTTON
			hb, hb2, hb3, hb5: EV_HORIZONTAL_BOX
			frm, frm2, frm3: EV_FRAME
		do
			Precursor
			handle_left_selected := False
			handle_right_selected := False
			two_handles_left_selected := False
			two_handles_right_selected := False
			reset_selected := False
			cancelled := False
			set_title (Interface_names.t_Diagram_link_tool)

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, ~ok_action)
			create apply_button.make_with_text_and_action (Interface_names.b_Apply, ~apply_action)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel_text, ~cancel_action)
			create cb_left.make_with_text (" left")
			cb_left.select_actions.extend (~on_handle_left_selected)
			create cb_right.make_with_text (" right")
			cb_right.select_actions.extend (~on_handle_right_selected)
			create cb2_left.make_with_text (" left")
			cb2_left.select_actions.extend (~on_two_handles_left_selected)
			create cb2_right.make_with_text (" right")
			cb2_right.select_actions.extend (~on_two_handles_right_selected)
			create cb_reset.make_with_text ("Remove handles")
			cb_reset.select_actions.extend (~on_reset_selected)
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
			create frm.make_with_text ("Put handle")
			create frm2.make_with_text ("Put two handles")
			create frm3.make_with_text ("Reset")

			hb.extend (create {EV_CELL})
			hb.extend (cb_reset)
			frm3.extend (hb)

			hb2.extend (create {EV_CELL})
			hb2.extend (cb_left)
			hb2.extend (cb_right)
			frm.extend (hb2)

			hb3.extend (create {EV_CELL})
			hb3.extend (cb2_left)
			hb3.extend (cb2_right)
			frm2.extend (hb3)

			hb5.extend (create {EV_CELL})
			extend_button (hb5, ok_button)
			extend_button (hb5, cancel_button)
			extend_button (hb5, apply_button)

			extend (main_vb)
			main_vb.extend (frm)
			main_vb.disable_item_expand (frm)
			main_vb.extend (frm2)
			main_vb.disable_item_expand (frm2)
			main_vb.extend (frm3)
			main_vb.disable_item_expand (frm3)
			main_vb.extend (hb5)			
			main_vb.disable_item_expand (hb5)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)

			set_minimum_size (width, height)
		end

feature -- Status report

	handle_left_selected: BOOLEAN
			-- Did the user choose "Put handle left on this link"?

	handle_right_selected: BOOLEAN
			-- Did the user choose "Put handle right on this link"?

	two_handles_left_selected: BOOLEAN
			-- Did the user choose "Put two handles left on this link"?

	two_handles_right_selected: BOOLEAN
			-- Did the user choose "Put two handles right on this link"?

	reset_selected: BOOLEAN
			-- Did the user choose "Remove handles on this link"?

	cancelled: BOOLEAN
			-- Was the action cancelled?

	applied: BOOLEAN
			-- Was the apply action performed?

feature {EB_LINK_TOOL_COMMAND} -- Status setting

	preset (display_labels: BOOLEAN) is
			-- Re-initialize previous choices.
		do
			applied := False
			if cb_left.is_selected then
				cb_left.toggle
				handle_left_selected := False
			end
			if cb_right.is_selected then
				cb_right.toggle
				handle_right_selected := False
			end
			if cb2_left.is_selected then
				cb2_left.toggle
				two_handles_left_selected := False
			end
			if cb2_right.is_selected then
				cb2_right.toggle
				two_handles_right_selected := False
			end
			if cb_reset.is_selected then
				cb_reset.toggle
				reset_selected := False
			end
		ensure
			nothing_is_selected: not something_selected
		end

	set_for_client_link is
			-- Add list of features represented by `link_figure'.
		local
			frame_list: EV_FRAME
			vb: EV_VERTICAL_BOX
		do
			create vb
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.set_border_width (Layout_constants.Default_border_size)
			create frame_list.make_with_text ("Feature list")
			frame_list.extend (vb)
			vb.extend (feature_list)
			main_vb.finish
			main_vb.put_left (frame_list)
			set_minimum_size (width, height + 120)
			set_maximum_width (width)
		end
		
feature {NONE} -- Events

	on_handle_left_selected is
			-- The user has selected "Put handle left on this link".
			-- Deselect any previously selected button.
		do
			if cb_left.is_selected then
				if cb_right.is_selected then
					cb_right.toggle
					handle_right_selected := False
				end
				if cb2_left.is_selected then
					cb2_left.toggle
					two_handles_left_selected := False
				end
				if cb2_right.is_selected then
					cb2_right.toggle
					two_handles_right_selected := False
				end
				if cb_reset.is_selected then
					cb_reset.toggle
					reset_selected := False
				end
				handle_left_selected := True
			else
				handle_left_selected := False
			end
		end

	on_handle_right_selected is
			-- The user has selected "Put handle right on this link".
			-- Deselect any previously selected button.
		do
			if cb_right.is_selected then
				if cb_left.is_selected then
					cb_left.toggle
					handle_left_selected := False
				end
				if cb2_left.is_selected then
					cb2_left.toggle
					two_handles_left_selected := False
				end
				if cb2_right.is_selected then
					cb2_right.toggle
					two_handles_right_selected := False
				end
				if cb_reset.is_selected then
					cb_reset.toggle
					reset_selected := False
				end
				handle_right_selected := True
			else
				handle_right_selected := False
			end
		end

	on_two_handles_left_selected is
			-- The user has selected "Put two handles left on this link".
			-- Deselect any previously selected button.
		do
			if cb2_left.is_selected then
				if cb_left.is_selected then
					cb_left.toggle
					handle_left_selected := False
				end
				if cb_right.is_selected then
					cb_right.toggle
					handle_right_selected := False
				end
				if cb2_right.is_selected then
					cb2_right.toggle
					two_handles_right_selected := False
				end
				if cb_reset.is_selected then
					cb_reset.toggle
					reset_selected := False
				end
				two_handles_left_selected := True
			else
				handle_left_selected := False
			end
		end

	on_two_handles_right_selected is
			-- The user has selected "Put two handles right on this link".
			-- Deselect any previously selected button.
		do
			if cb2_right.is_selected then
				if cb_left.is_selected then
					cb_left.toggle
					handle_left_selected := False
				end
				if cb_right.is_selected then
					cb_right.toggle
					handle_right_selected := False
				end
				if cb2_left.is_selected then
					cb2_left.toggle
					two_handles_left_selected := False
				end
				if cb_reset.is_selected then
					cb_reset.toggle
					reset_selected := False
				end
				two_handles_right_selected := True
			else
				two_handles_right_selected := False
			end
		end
		
	on_reset_selected is
			-- The user has selected "Remove handles on this link".
			-- Deselect any previously selected button.
		do
			if cb_reset.is_selected then
				if cb_right.is_selected then
					cb_right.toggle
					handle_right_selected := False
				end
				if cb_left.is_selected then
					cb_left.toggle
					handle_left_selected := False
				end
				if cb2_left.is_selected then
					cb2_left.toggle
					two_handles_left_selected := False
				end
				if cb2_right.is_selected then
					cb2_right.toggle
					two_handles_right_selected := False
				end
				reset_selected := True
			else
				reset_selected := False
			end
		end

feature {EB_LINK_TOOL_COMMAND} -- Element change

	set_strings (a_string_array: INDEXABLE [STRING, INTEGER]) is
			-- Wipe out `feature_list' and re-initialize with an item
			-- for each of `a_string_array'.
		do
			create feature_list
			feature_list.set_strings (a_string_array)
		end

	set_link_tool_command (ltc: EB_LINK_TOOL_COMMAND) is
			-- Assign `ltc' to `link_tool_command'.
		require
			command_exists: ltc /= Void
		do
			link_tool_command := ltc
		ensure
			assigned: link_tool_command = ltc
		end

	set_link_figure (lf: LINK_FIGURE) is
			-- Assign `lf' to `link_figure'.
		require
			figure_exists: lf /= Void
		do
			link_figure := lf
		ensure
			assigned: lf = link_figure
		end

feature {NONE} -- Contract support

	something_selected: BOOLEAN is
			-- Is any check button currently selected?
		do
			Result := handle_left_selected or
				handle_right_selected or
				two_handles_left_selected or
				two_handles_right_selected or
				reset_selected
		end

feature {EB_LINK_TOOL_COMMAND} -- Events

	cancel_action is
			-- Close dialog.
		do
			cancelled := True
			hide
			link_tool_command.on_dialog_closed
		end	

feature {EB_LINK_TOOL_COMMAND} -- Access

	link_figure: LINK_FIGURE
			-- Figure on which `Current' has an effect.

feature {NONE} -- Implementation

	main_vb: EV_VERTICAL_BOX
			-- Main container inside `Current'.

	cb_left, cb_right, cb2_left, cb2_right, cb_reset: EV_CHECK_BUTTON
			-- Buttons to tweak link handles.

	feature_list: EV_LIST
			-- Graphical list of links represented by `link_figure'.
			-- Void if `link_figure' is an inheritance link.

	link_tool_command: EB_LINK_TOOL_COMMAND
			-- Associated command.

	ok_action is
			-- Close dialog.
		do
			cancelled := False
			hide
			link_tool_command.on_dialog_closed
		end

	apply_action is
			-- Close dialog.
		do
			applied := True
			
				-- We need to check if `link_figure' is still on the diagram.
			if link_figure.world /= Void then
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

end -- class EB_LINK_TOOL_DIALOG
