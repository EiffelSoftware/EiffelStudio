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
		select
			interface,
			make
		end

	EV_ANY_IMP
		redefine
			interface
		end

	EV_WINDOW_IMP
		rename
			interface as ev_window_imp_interface,
			make as ev_window_imp_make
		undefine
			destroy,
			title,
			set_title,
			set_blocking_window,
			block
		redefine
			blocking_window,
			on_key_event,
			initialize_client_area,
			call_close_request_actions
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP
	
feature -- Initialization

	initialize_client_area is
			-- Implementation not needed as this is already done by toolkit
		do
			-- Do nothing
		end

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		do
			check
				c_object /= NULL
			end
			check
				C.gtk_window_struct_title (c_object) /= NULL
			end
			create Result.make_from_c (C.gtk_window_struct_title (c_object))
		end

	blocking_window: EV_WINDOW
			-- Window this dialog is a transient for.

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the dialog and wait until the user closes it.
		do
			user_clicked_ok := False
			set_blocking_window (a_window)
			selected_button := Void
			C.gtk_widget_show (c_object)
			block
			set_blocking_window (Void)
			if selected_button /= Void then
				if selected_button.is_equal ("OK") then
					interface.ok_actions.call ([])
				elseif selected_button.is_equal ("Cancel") then
					interface.cancel_actions.call ([])
				end
			end
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		do
			C.gtk_window_set_title (c_object, eiffel_to_c (a_title))
		end

	set_blocking_window (a_window: EV_WINDOW) is
			-- Set as transient for `a_window'.
		local
			win_imp: EV_WINDOW_IMP
		do
			blocking_window := a_window
			if a_window /= Void then
				win_imp ?= a_window.implementation
				C.gtk_window_set_transient_for (c_object, win_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end
		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
		do
			Precursor {EV_WINDOW_IMP} (a_key, a_key_string, a_key_press)
			if a_key /= Void and then a_key.code = app_implementation.Key_constants.key_escape and then not a_key_press then
				on_ok
			end				
		end

	block is
			-- Wait until window is closed by the user.
		local
			dummy: INTEGER
		do
			from
			until
				is_destroyed or else selected_button /= Void
			loop
				dummy := C.gtk_main_iteration_do (True)
			end
		end

	enable_closeable is
			-- Set the window to be closeable by the user
		do
			C.gdk_window_set_functions (
				C.gtk_widget_struct_window (c_object),
				C.GDK_FUNC_CLOSE_ENUM + C.GDK_FUNC_MOVE_ENUM
			)
		end
		
	call_close_request_actions is
			-- Call `on_cancel' if user wants to quit dialog.
		do
			on_cancel
		end

	on_cancel is
			-- Close window and call action sequence.
		do
			selected_button := "Cancel"
			C.gtk_widget_hide (c_object)
		end

	on_ok is
			-- Close window and call action sequence.
		do
			user_clicked_ok := True
			selected_button := "OK"
			C.gtk_widget_hide (c_object)
		end
		
	user_clicked_ok: BOOLEAN
		-- Has the user explicitly cancelled the dialog.

	interface: EV_STANDARD_DIALOG

end -- class EV_STANDARD_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

