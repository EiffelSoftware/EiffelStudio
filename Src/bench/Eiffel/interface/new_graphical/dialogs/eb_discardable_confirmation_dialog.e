indexing
	description	: "Dialog asking the user if he really wants to start a command"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DISCARDABLE_CONFIRMATION_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			destroy,
			show_modal_to_window,
			is_in_default_state
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_DIALOGS_DATA
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize to default state.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb2: EV_HORIZONTAL_BOX
			vb2: EV_VERTICAL_BOX
			pixmap_clone: EV_PIXMAP
			label_box: EV_VERTICAL_BOX
			option_box: EV_HORIZONTAL_BOX
			label: EV_LABEL -- Text label where `text' is displayed.
			pixmap_box: EV_CELL -- Container to display pixmap in.
			button_box: EV_HORIZONTAL_BOX -- Bar with all buttons of the dialog.
		do
			Precursor {EV_DIALOG}
			set_title (dialog_title)
			disable_user_resize

			create check_button.make_with_text (Check_button_label)

			button_box := build_buttons_box

			create label
			label.align_text_left
			label.set_text (confirmation_message_label)

			create label_box
			label_box.extend (create {EV_CELL})
			label_box.extend (label)
			label_box.disable_item_expand (label)
			label_box.extend (create {EV_CELL})

			create pixmap_box
			pixmap_clone := clone (Default_pixmaps.Question_pixmap)
			pixmap_box.extend (pixmap_clone)
			pixmap_box.set_minimum_size (pixmap_clone.width, pixmap_clone.height)

			create option_box
			option_box.extend (check_button)
			option_box.disable_item_expand (check_button)
			option_box.extend (create {EV_CELL})

			create vb2
			vb2.extend (pixmap_box)
			vb2.disable_item_expand (pixmap_box)
			vb2.extend (create {EV_CELL})
	
			create hb
			hb.extend (vb2)
			hb.disable_item_expand (vb2)
			hb.extend (label_box)
			hb.set_padding (Layout_constants.Default_border_size)
			hb.set_border_width (Layout_constants.Default_border_size)

			create hb2
			hb2.extend (create {EV_CELL})
			hb2.extend (button_box)
			hb2.disable_item_expand (button_box)
			hb2.extend (create {EV_CELL})

			create vb
			vb.extend (hb)
			vb.extend (option_box)
			vb.disable_item_expand (option_box)
			vb.extend (hb2)
			vb.disable_item_expand (hb2)
			vb.set_border_width (Layout_constants.Default_border_size)
			extend (vb)

			set_default_push_button (ok_button)
			if buttons_count > 1 then
				set_default_cancel_button (cancel_button)
			else
				set_default_cancel_button (ok_button)
			end
		end
		
	build_buttons_box: EV_HORIZONTAL_BOX is
			-- Build the button box.
		do
			create Result
			Result.set_padding (Layout_constants.Default_border_size)
			Result.set_border_width (Layout_constants.Default_border_size)
			Result.enable_homogeneous

			ok_button := create_button (ok_button_label)
			ok_button.select_actions.extend (agent save_check_state)
			Result.extend (ok_button)
			if buttons_count >= 3 then
				no_button := create_button (no_button_label)
				Result.extend (no_button)
			end
			if buttons_count >= 2 then
				cancel_button := create_button (cancel_button_label)
				Result.extend (cancel_button)
			end
		ensure
			valid_Result: Result /= Void and then not Result.is_empty
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			if assume_ok then
				if ok_action /= Void then
					ok_action.call([])
				end
			elseif assume_cancel then
				check
					cancel_action_not_void: cancel_action /= Void
				end -- `assume_cancel' ensures `cancel_action' /= Void.
				cancel_action.call([])
			else
				Precursor (a_window)
			end
		end

feature -- Access

	buttons_count: INTEGER is
			-- Number of buttons. 
			--
			-- Typically: 
			--   1 for OK
			--   2 for OK, Cancel
			--   3 for Yes, No, Cancel
		deferred
		end

feature -- Status setting

	set_ok_action (an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Set the action performed when the Ok button is selected.
		do
				-- Remove the previous `ok_action' if any.
			if ok_action /= Void then
				ok_button.select_actions.prune_all (ok_action)
			end
				-- Setup the new ok_action.
			ok_action := an_agent
			ok_button.select_actions.extend (an_agent)
		end

	set_no_action (an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Set the action performed when the No button is selected.
		require
			no_button_exists: buttons_count >= 3
		do
			if no_action /= void then
				no_button.select_actions.prune_all (no_action)
			end
			no_action := an_agent
			no_button.select_actions.extend (an_agent)
		end
	
	set_cancel_action (an_agent: PROCEDURE [ANY, TUPLE]) is
			-- Set the action performed when the Cancel button is selected.
		require
			cancel_button_exists: buttons_count >= 2
		do
				-- Remove the previous `cancel_action' if any.
			if cancel_action /= Void then
				cancel_button.select_actions.prune_all (cancel_action)
			end
				-- Setup the new cancel_action.
			cancel_action := an_agent
			cancel_button.select_actions.extend (an_agent)
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
				-- FIXME: Manu 02/27/2001
				-- Does not check everything that EV_DIALOG was
				-- checking because parent is using Precursor
				-- and here we do not have access to those `Precursor'.
			Result := not user_can_resize and menu_bar = Void
		end

feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
			-- Check button labeled "Do not ask me again"

	ok_button: EV_BUTTON
			-- Button for "Ok" or "Yes" answer.

	no_button: EV_BUTTON
			-- Button for "No" answer.

	cancel_button: EV_BUTTON
			-- Button for "Cancel" answer.

	ok_action: PROCEDURE [ANY, TUPLE]
			-- Action performed when ok is selected.

	cancel_action: PROCEDURE [ANY, TUPLE]
			-- Action performed when Cancel is selected.

	no_action: PROCEDURE [ANY, TUPLE]
			-- Action performed when ok is selected.
	
	destroy is
			-- Destroy the dialog (update the preferences based on the check button first)
		do
			Precursor {EV_DIALOG}
		end

	save_check_state is
			-- Save the state of the check button to the preferences.
		do
			save_check_button_state (check_button.is_selected)
		end

	create_button (a_text: STRING): EV_BUTTON is
			-- Create a new button labeled `a_text'
		do
			create Result
			Result.align_text_center
			Result.set_text (a_text)
			Layout_constants.set_default_size_for_button (Result)
			Result.select_actions.extend (~destroy)
		end

	dialog_title: STRING is
			-- Title for this confirmation dialog
		do
			Result := "Confirmation"
		end

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		deferred
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	ok_button_label: STRING is
			-- Label for the Ok/Yes button.
		do
			if buttons_count >= 3 then
				Result := Interface_names.b_Yes
			else
				Result := Interface_names.b_Ok
			end
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	no_button_label: STRING is
			-- Label for the No button.
		do
			Result := Interface_names.b_No
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	cancel_button_label: STRING is
			-- Label for the Cancel/No button.
		do
			Result := Interface_names.b_Cancel
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		deferred
		ensure
			valid_label: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		deferred
		ensure
			Assume_ok_implies_ok_action_not_void:
				Result implies ok_action /= Void
		end

	assume_cancel: BOOLEAN is
			-- Should `Cancel' be assumed as selected?
		do
			Result := False
		ensure
			Assume_cancel_implies_cancel_action_not_void:
				Result implies cancel_action /= Void
		end

	save_check_button_state (check_button_checked: BOOLEAN) is
			-- Save the preferences according to the state of the check button.
		deferred
		end

end -- class EB_DISCARDABLE_CONFIRMATION_DIALOG
