note
	description: "Eiffel Vision standard dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I
		redefine
			interface
		end

	EV_GTK_WINDOW_IMP
		redefine
			interface,
			make,
			default_wm_decorations,
			blocking_condition,
			show_modal_to_window
		end

feature {NONE} -- Initialization

	make
			--<Precursor>
		do
			real_signal_connect (c_object,
					{EV_GTK_EVENT_STRINGS}.response_event_name,
					agent (App_implementation.gtk_marshal).gtk_dialog_response_event (c_object, ?))
			Precursor
		end

feature -- Access

	title: STRING_32
			-- Title of dialog shown in title bar.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := app_implementation.reusable_gtk_c_string
			a_cs.share_from_pointer ({GTK}.gtk_window_get_title (c_object))
			Result := a_cs.string
		end

feature -- Status report

	selected_button: detachable IMMUTABLE_STRING_32
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		do
			selected_button := Void

			Precursor (a_window)

			if user_clicked_ok then
				ok_actions.call (Void)
			else
				cancel_actions.call (Void)
			end

		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set the title of the dialog.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_title
			{GTK}.gtk_window_set_title (c_object, a_cs.item)
		end

feature {EV_GTK_WIDGET_IMP} -- Implementation

	on_key_event (a_key: detachable EV_KEY; a_key_string: detachable STRING_32; a_key_press: BOOLEAN)
			-- `a_key' has either been pressed or released
		do
			-- Default Dialog Key handling handled by "response" signal.
		end

feature {NONE} -- Implementation

	user_can_resize: BOOLEAN = False
		-- By default the user cannot resize standard dialogs.

	blocking_condition: BOOLEAN
			-- Condition which causes blocking to cease if enabled.
		do
			Result := is_destroyed or else selected_button /= Void or else app_implementation.is_destroyed
		end

	enable_closeable
			-- Set the window to be closeable by the user
		local
			close_fct: INTEGER
		do
			close_fct := {GTK}.Gdk_func_close_enum
			close_fct := close_fct.bit_or ({GTK}.Gdk_func_move_enum)
			close_fct := close_fct.bit_or ({GTK}.Gdk_func_resize_enum)
			{GDK}.gdk_window_set_functions (
				{GTK}.gtk_widget_get_window (c_object),
				close_fct
			)
		end

	call_close_request_actions
			-- Call `on_cancel' if user wants to quit dialog.
		do
			on_cancel
		end

	user_clicked_ok: BOOLEAN
			-- Has the user clicked the default action button of the dialog.
		do
			Result := selected_button = internal_accept
		end

	default_wm_decorations: INTEGER
			-- Default Window Manager decorations of `Current'.
		do
			Result := {GDK}.gdk_decor_all_enum
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_STANDARD_DIALOG note option: stable attribute end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_response (a_response_id: INTEGER)
		do
			if a_response_id = {GTK2}.gtk_response_ok_enum then
				on_ok
			else
				on_cancel
			end
		end

	on_ok
			-- Close window and call action sequence.
		do
			selected_button := internal_accept
			hide
		end

	on_cancel
			-- Close window and call action sequence.
		do
			selected_button := ev_cancel
			hide
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_STANDARD_DIALOG_IMP
