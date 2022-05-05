note
	description: "Eiffel Vision dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP_MODELESS

inherit
	EV_DIALOG_IMP_COMMON
		redefine
			setup_dialog,
			show,
			is_relative,
			is_show_requested,
			hide,
			destroy
		end

create
	make_with_dialog_window

feature -- Status report

	is_relative: BOOLEAN
			-- Is `Current' shown relative to another window?
		do
			Result := is_show_requested
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			if is_destroyed then
					-- If we have upgraded the implementation, then
					-- we need to query the interface.
				if 
					attached attached_interface.implementation as imp and then
					imp /= Current
				then
					Result := imp.is_show_requested
				end
			else
				Result := flag_set (style, {WEL_WINDOW_CONSTANTS}.Ws_visible)
			end
		end

feature -- Basic operations

	show_modal_to_window (a_parent_window: EV_WINDOW)
			-- Show `Current' and wait until window is closed.
		do
			promote_to_dialog_window
			attached_interface.implementation.show_modal_to_window (a_parent_window)
		end

	show_relative_to_window (a_parent_window: EV_WINDOW)
			-- Show `Current' and wait until window is closed.
		local
			parent_window_imp: detachable WEL_WINDOW
				-- Create the dialog.
			other_menu_bar: detachable EV_MENU_BAR
		do
			if exists then
					-- We handle the case where `Current' has already been
					-- shown relative to a window, hidden and now is being shown
					-- relative to a new window.
				if a_parent_window /= parent_window then
					promote_to_dialog_window
					attached_interface.implementation.show_relative_to_window (a_parent_window)
					parent_window := a_parent_window
					parent_window_imp ?= a_parent_window.implementation
				else
					show_internal
				end
				if show_actions_internal /= Void then
					show_actions_internal.call (Void)
				end
			else
				other_menu_bar := attached_interface.implementation.menu_bar
				parent_window := a_parent_window
				parent_window_imp ?= a_parent_window.implementation
				check parent_window_imp /= Void end
				internal_dialog_make (parent_window_imp, 0, Void)
				if show_actions_internal /= Void then
					show_actions.call (Void)
				end
				if other_menu_bar /= Void then
					attached_interface.set_menu_bar (other_menu_bar)
				end
			end
		end

	show
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
			attached_interface.implementation.show
		end

	terminate (a_result: INTEGER)
			-- Terminate the dialog with `a_result'.
			-- `result_id' will contain `a_result'.
		do
			result_id := a_result
			destroy_item_from_context (False)
		end

feature {NONE} -- Implementation

	hide
			-- Hide `Current'.
		do
				--| FIXME, this is a hack to avoid unwanted behaviour when closing a focused
				--| modeless dialog. To reproduce, create two dialogs and show one, followed by the
				--| other, relative to a window. Then hide the first and then the second. The
				--| Window to which they were relative is moved behind the second window in the Z order.
				--| This is far from good. Another way to see this bug in action is to use a 5.4 or earlier
				--| of EiffelStudio, open a class in the editor and introduce a syntax error. Compile, and
				--| the development window is then obscured by the window that was behind it. Julian.
			check parent_window /= Void then end
			if
				has_focus and then
				not parent_window.is_destroyed and then
				parent_window.is_displayed and then
				parent_window.is_sensitive
			then
				parent_window.set_focus
			end
			promote_to_dialog_window
			attached_interface.implementation.hide
		end

	destroy
			-- Destroy `Current'.
		do
				--| FIXME, this is the same hack as in `hide' which has a full explanation.
			check parent_window /= Void then end
			if
				has_focus and then
				not parent_window.is_destroyed and then
				parent_window.is_displayed and then
				parent_window.is_sensitive
			then
				parent_window.set_focus
			end
			Precursor {EV_DIALOG_IMP_COMMON}
		end

	setup_dialog
   			-- Setup the dialog and its children.
		do
			Precursor {EV_DIALOG_IMP_COMMON}
			result_id := Idcancel
		end

	internal_dialog_make (a_parent: detachable WEL_WINDOW; an_id: INTEGER; a_name: detachable READABLE_STRING_GENERAL)
			-- Create the dialog
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
			tmp_result: POINTER
			err: WEL_ERROR
		do
				-- Make sure that parent is attached.
			check a_parent /= Void then
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
					if tmp_result = default_pointer then
						create err
						err.display_last_error
					end
				end

					-- Display the window
				show_internal
			end
		end

feature {NONE} -- External

	cwin_create_dialog_indirect (hinst, lptemplate, hparent, dlgprc: POINTER): POINTER
			-- SDK DialogBoxIndirect
		external
			"C [macro <wel.h>] (HINSTANCE, LPCDLGTEMPLATE, HWND, DLGPROC): HWND"
		alias
			"CreateDialogIndirect"
        end


note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DIALOG_IMP_MODELESS











