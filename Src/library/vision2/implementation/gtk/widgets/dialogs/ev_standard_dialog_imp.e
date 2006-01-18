indexing
	description: "Eiffel Vision standard dialog. GTK+ implementation."
	status: "See notice at end of class"
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
			has_wm_decorations,
			on_key_event,
			initialize
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Implementation

	initialize is
			-- Initialize dialog
		local
			on_key_event_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
		do
			Precursor {EV_GTK_WINDOW_IMP}
			on_key_event_intermediary_agent := agent (App_implementation.gtk_marshal).on_key_event_intermediary (c_object, ?, ?, ?)
			real_signal_connect (event_widget, "key_press_event", on_key_event_intermediary_agent, key_event_translate_agent)
		end

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := app_implementation.reusable_gtk_c_string
			a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_window_struct_title (c_object))
			Result := a_cs.string
		end

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		local
			was_modal: BOOLEAN
			parent_was_modal: BOOLEAN
			a_window_imp: EV_WINDOW_IMP
		do
			user_clicked_ok := False
			selected_button := Void

				-- Remove the modality of the parent if it is modal
			if a_window /= Void then
				a_window_imp ?= a_window.implementation

				if a_window_imp.is_modal then
					parent_was_modal := True
					a_window_imp.disable_modal
				end
			end

			if is_modal then
				was_modal := True
			else
				enable_modal
			end
				-- Hack - Blocking window needs to be set before and after show otherwise it is not modal.
			set_blocking_window (a_window)
			show
			set_blocking_window (a_window)
			block
			set_blocking_window (Void)

			if not is_destroyed and then not was_modal then
				disable_modal
			end
				-- Put parent's original modality back.
			if a_window /= Void and then parent_was_modal then
				a_window_imp.enable_modal
			end

			if selected_button /= Void then
				if selected_button.is_equal (internal_accept) then
					interface.ok_actions.call (Void)
				elseif selected_button.is_equal (ev_cancel) then
					interface.cancel_actions.call (Void)
				end
			end
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_title
			{EV_GTK_EXTERNALS}.gtk_window_set_title (c_object, a_cs.item)
		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- `a_key' has either been pressed or released
		do
			if a_key /= Void then
				if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
					on_cancel
				else
					if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
						on_ok
					end
				end
			end
		end

	block is
			-- Wait until window is closed by the user.
		local
			events_pending: BOOLEAN
			l_app_imp: like app_implementation
		do
			from
				l_app_imp := app_implementation
			until
				is_destroyed or else selected_button /= Void
			loop
				if not {EV_GTK_EXTERNALS}.g_main_iteration (False) then
						-- There are no more events left
					if
						l_app_imp.idle_actions_pending
					then
							-- If there are idle actions waiting then these will be called.
						l_app_imp.call_idle_actions
					else
						events_pending := {EV_GTK_EXTERNALS}.g_main_iteration (True)
					end
				end
			end
		end

	enable_closeable is
			-- Set the window to be closeable by the user
		local
			close_fct: INTEGER
		do
			close_fct := {EV_GTK_EXTERNALS}.Gdk_func_close_enum
			close_fct := close_fct.bit_or ({EV_GTK_EXTERNALS}.Gdk_func_move_enum)
			close_fct := close_fct.bit_or ({EV_GTK_EXTERNALS}.Gdk_func_resize_enum)
			{EV_GTK_EXTERNALS}.gdk_window_set_functions (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				close_fct
			)
		end

	call_close_request_actions is
			-- Call `on_cancel' if user wants to quit dialog.
		do
			on_cancel
		end

	user_clicked_ok: BOOLEAN
		-- Has the user explicitly cancelled the dialog.

	interface: EV_STANDARD_DIALOG

	has_wm_decorations: BOOLEAN is
			-- Does 'Current' have Window Manager decorations?
		do
			Result := True
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_ok is
			-- Close window and call action sequence.
		do
			user_clicked_ok := True
			selected_button := internal_accept
			{EV_GTK_EXTERNALS}.gtk_widget_hide (c_object)
		end

	on_cancel is
			-- Close window and call action sequence.
		do
			selected_button := ev_cancel
			{EV_GTK_EXTERNALS}.gtk_widget_hide (c_object)
		end

end -- class EV_STANDARD_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

