indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP_MODELESS

inherit
	EV_DIALOG_IMP_COMMON
		rename
			show as show_internal
		redefine
			setup_dialog,
			is_relative,
			is_show_requested
		end
		
	EV_DIALOG_IMP_COMMON
		redefine
			setup_dialog,
			show,
			is_relative,
			is_show_requested
		select
			show
		end

create
	make_with_dialog_window
	
feature -- Status report

	is_relative: BOOLEAN is
			-- Is `Current' shown relative to another window?
		do
			Result := is_show_requested
		end
		
	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			if is_destroyed then
					-- If we have upgraded the implementation, then
					-- we need to query the interface.
				Result := interface.implementation.is_show_requested
			else
				Result := flag_set (style, feature {WEL_WINDOW_CONSTANTS}.Ws_visible)
			end	
		end

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		do
			promote_to_dialog_window
			interface.implementation.show_modal_to_window (a_parent_window)
		end

	show_relative_to_window (a_parent_window: EV_WINDOW) is
			-- Show `Current' and wait until window is closed.
		local
			parent_window_imp: WEL_WINDOW
				-- Create the dialog.
			other_menu_bar: EV_MENU_BAR
		do
			if exists then
					-- We handle the case where `Current' has already been
					-- shown relative to a window, hidden and now is being shown
					-- relative to a new window.
				if a_parent_window /= parent_window then
					promote_to_dialog_window
					interface.implementation.show_relative_to_window (a_parent_window)
					parent_window := a_parent_window
					parent_window_imp ?= a_parent_window.implementation
				else
					show_internal
				end
				if show_actions_internal /= Void then
					show_actions_internal.call (Void)
				end
			else
				other_menu_bar := interface.implementation.menu_bar
				parent_window := a_parent_window
				parent_window_imp ?= a_parent_window.implementation
				internal_dialog_make (parent_window_imp, 0, Void)
				if show_actions_internal /= Void then
					show_actions_internal.call (Void)
				end
				if other_menu_bar /= Void then
					interface.set_menu_bar (other_menu_bar)
				end
			end
		end
		
	show is
			-- Show window represented by `interface'
			-- no longer modeless to a window. We need
			-- to promote this implementation, to effect
			-- this change.
			-- Note that we had to inherit from EV_DIALOG_IMP_COMMON
			-- twice, so that we could get two versions - `show' and
			-- `show_internal' as we need different implementations
			-- depending on from where they were called.
		do
			promote_to_dialog_window
			interface.implementation.show
		end

	terminate (a_result: INTEGER) is
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		local
			l_result: INTEGER
		do
			result_id := a_result
			l_result := cwin_destroy_window (wel_item)
		end

feature {NONE} -- Implementation

	setup_dialog is
   			-- Setup the dialog and its children.
		do
			Precursor {EV_DIALOG_IMP_COMMON}
			result_id := Idcancel
		end

	internal_dialog_make (a_parent: WEL_WINDOW; an_id: INTEGER;
			a_name: STRING) is
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_result: INTEGER
			err: WEL_ERROR
		do
				-- Initialise the common controls
			create common_controls_dll.make	

				-- Register the dialog to set `wel_item' later.
			register_dialog

				-- Launch the right dialog box modeless.
			result_id := 0
			tmp_result := cwin_create_dialog_indirect (
				main_args.current_instance.item,
				dlg_template.item, 
				a_parent.item,
				cwel_dialog_procedure_address
				)

			debug ("VISION2_WINDOWS")
				if tmp_result = 0 or tmp_result = -1 then
					create err
					err.display_last_error
				end
			end

				-- Display the window
			show_internal
		end
		
feature {NONE} -- External

	cwin_create_dialog_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): INTEGER is
			-- SDK DialogBoxIndirect
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): EIF_INTEGER"
		alias
			"CreateDialogIndirect"
        end
                         

end -- class EV_DIALOG_IMP_MODELESS

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

