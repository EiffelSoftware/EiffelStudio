note
	description: "Eiffel Vision toggle button. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		undefine
			process_notification
		redefine
			interface,
			update_current_push_button,
			on_bn_clicked,
			has_pushed_appearence,
			make,
			internal_background_brush,
			fire_select_actions_on_enter
		end

create
	make

feature -- Initialization

	make
			--
		do
			Precursor {EV_BUTTON_IMP}
			is_selected := False
		end

feature -- Access

	is_selected: BOOLEAN
		-- Is `Current' selected?

feature -- Status setting

	enable_select
			-- Ensure `is_selected' is True.
		do
			is_selected := True
			select_actions.call (Void)
			invalidate
		ensure then
			is_selected = True
		end

	disable_select
			-- Ensure `is_selected' is False.
		do
			is_selected := False
			select_actions.call (Void)
			invalidate
		ensure then
			is_selected = False
		end

feature {NONE} -- Implementation, focus event

	has_pushed_appearence (state: INTEGER): BOOLEAN
			-- Should `Current' have the appearence of being
			-- pressed?
			-- As `Current' is a toggle, button, it must be displayed as
			-- pushed when `is_selected', or if `state' has `button_in' enabled.
		do
			Result := Precursor {EV_BUTTON_IMP} (state)
			if not Result then
				Result := is_selected
			end
		end

	on_bn_clicked
			-- Bn_clicked message received from Windows,
			-- so toggle `is_selected', redraw `Current' and
			-- fire `select_actions'.
		do
			is_selected := not is_selected
			invalidate
			select_actions.call (Void)
		ensure then
			state_changed: old is_selected = not is_selected
		end

	on_bn_double_clicked
			-- Bn_clicked message received from Windows,
			-- so toggle `is_selected', redraw `Current' and
			-- fire `select_actions'.
		do
			is_selected := not is_selected
			invalidate
			select_actions.call (Void)
		ensure
			state_changed: old is_selected = not is_selected
		end

	process_notification (notification_code: INTEGER)
			-- Process any windows notification messages.
			-- In this case, it is redefined to handle
			-- BN_doubleclick.
		do
			if notification_code = Bn_doubleclicked then
				on_bn_double_clicked
			else
				Precursor {EV_BUTTON_IMP} (notification_code)
			end
		end

	update_current_push_button
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
		local
			top_level_dialog_imp: detachable EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

 	internal_background_brush: WEL_BRUSH
 			-- `Result' is brush used for redrawing background of `Current'.
 		do
 			if not is_selected then
 				Result := Precursor {EV_BUTTON_IMP}
 			else
	 			Result := splitter_brush
	 		end
	 	ensure then
	 		Result_not_void: Result /= Void
 		end

	fire_select_actions_on_enter
			-- Call select_actions to respond to Enter key press if
			-- Current supports it.
		do
		end

 	splitter_brush: WEL_BRUSH
			-- Create the brush used to draw the invert splitter.
		local
			l_helper: WEL_BITMAP_HELPER
		do
			create l_helper
			Result := l_helper.half_tone_brush
		end


feature {EV_ANY_I} -- Implementation

	interface: detachable EV_TOGGLE_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOGGLE_BUTTON_IMP











