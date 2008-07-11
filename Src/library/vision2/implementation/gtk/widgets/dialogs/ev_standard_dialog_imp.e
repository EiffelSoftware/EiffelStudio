indexing
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
			default_wm_decorations,
			blocking_condition,
			show_modal_to_window
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	title: STRING_32 is
			-- Title of dialog shown in title bar.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := app_implementation.reusable_gtk_c_string
			a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_window_struct_title (c_object))
			Result := a_cs.string
		end

feature -- Status report

	selected_button: STRING_32
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		do
			user_clicked_ok := False
			selected_button := Void

			Precursor (a_window)

			if selected_button /= Void then
				if selected_button.is_equal (internal_accept) then
					interface.ok_actions.call (Void)
				elseif selected_button.is_equal (ev_cancel) then
					interface.cancel_actions.call (Void)
				end
			end
		end

	set_title (a_title: STRING_GENERAL) is
			-- Set the title of the dialog.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_title
			{EV_GTK_EXTERNALS}.gtk_window_set_title (c_object, a_cs.item)
		end

feature {EV_GTK_WIDGET_IMP} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN) is
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

feature {NONE} -- Implementation

	user_can_resize: BOOLEAN is False
		-- By default the user cannot resize standard dialogs.

	blocking_condition: BOOLEAN is
			-- Condition which causes blocking to cease if enabled.
		do
			Result := is_destroyed or else selected_button /= Void or else app_implementation.is_destroyed
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

	default_wm_decorations: INTEGER is
			-- Default Window Manager decorations of `Current'.
		do
			Result := {EV_GTK_EXTERNALS}.gdk_decor_all_enum
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_ok is
			-- Close window and call action sequence.
		do
			user_clicked_ok := True
			selected_button := internal_accept
			hide
		end

	on_cancel is
			-- Close window and call action sequence.
		do
			selected_button := ev_cancel
			hide
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_STANDARD_DIALOG_IMP

