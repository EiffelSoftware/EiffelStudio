indexing
	description: "Window that contains a status bar at bottom and %
			%provides access to the shared objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STATUS_WINDOW

inherit
	SHARED
		undefine
			default_create,
			copy
		end	

	EV_TITLED_WINDOW

feature -- Initialization

	make is
			-- Set the window status bar.
		local
			f: EV_FRAME
			st: EV_STATUS_BAR
		do
			default_create
			create container.make
			container.disable_borders
			container.disable_padding
			create_window_content
			create st
			st.set_minimum_height (Status_bar_height)
			create f
			f.set_style (f.Ev_frame_lowered)
			st.extend (f)
			create status_label
			status_label.align_text_left
			f.extend (status_label)
			container.extend (st)
			container.disable_item_expand (st)
			extend (container)
		end

	set_initial_focus is
			-- Set window focus when popped up.
		deferred
		end

feature -- Access

	send_warning (message: STRING) is
			-- Display warning `message' in a dialog modal to `Current'.
		require
			not_void: message /= Void
		local
			warning_dialog: EV_WARNING_DIALOG
		do
			create warning_dialog.make_with_text (message)
			warning_dialog.show_modal_to_window (Current)
		end

	send_status (message: STRING) is
			-- Display status `message' in `window' status bar.
		require
			not_void: message /= Void
		do
			if not message.is_empty then
				status_label.set_text (message)
			else
				status_label.remove_text
			end
		end

	send_confirmation (message: STRING; action: PROCEDURE [ANY, TUPLE]) is
			-- Prompt user for confirmation with `message' in a dialog modal to `Current' before
			-- executing `action'.
		require
			message_not_void: message /= Void
			action_not_void: action /= Void
		local
			warning_dialog: EV_WARNING_DIALOG
			ok_b, cancel_b: EV_BUTTON
		do
			create warning_dialog.make_with_text (message)
			warning_dialog.set_buttons (<<Ok_text, Cancel_text>>)
			ok_b := warning_dialog.button (Ok_text)
			ok_b.select_actions.extend (action)
			warning_dialog.set_default_push_button (ok_b)
			cancel_b := warning_dialog.button (Cancel_text)
			cancel_b.select_actions.extend (warning_dialog~destroy)
			warning_dialog.set_default_cancel_button (cancel_b)
			warning_dialog.show_modal_to_window (Current)
		end

feature {NONE} -- Implementation

	create_window_content is
			-- Add widgets to the window.
		deferred			
		end

	container: DV_VERTICAL_BOX
			-- Window content container.

	status_label: DV_LABEL
			-- Status label.

	Status_bar_height: INTEGER is 15
			-- Status bar height.
 
end -- class STATUS_WINDOW
