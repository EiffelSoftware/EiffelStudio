indexing 
    status: "See notice at end of class"; 
    date: "$Date$"; 
    revision: "$Revision$" 
 
class
	DIALOG_WINDOWS
  
inherit 
	WM_SHELL_WINDOWS
		rename
			destroy as wm_shell_destroy
		redefine
			realize, 
			realized,
			default_style,
			class_name,
			unrealize
		end

	WM_SHELL_WINDOWS
		redefine
			destroy,
			realize, 
			realized,
			default_style,
			class_name,
			unrealize
		select
			destroy
		end

	DIALOG_I

	GRABABLE_WINDOWS

feature -- Initialization

	realize is
			-- Realize current widget
		do
			realized := True
		end

	dialog_realize is
			-- Really realize current widget
		do
			if not exists then
				realize_current
				realize_children
			end
		end

feature -- Status report

	realized: BOOLEAN
			-- Is this widget realized?

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		do
			Result := realized and then shown
		end

feature -- Status setting

	destroy (wid_list: LINKED_LIST [WIDGET]) is
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			wm_shell_destroy (wid_list)
		end

	popdown is
			-- Popdown popup shell.
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			if realized then
				hide
			end
		end

	popup is
			-- Popup a popup shell.
		do
			if exists then
				show
			else
				dialog_realize
			end
		end

	unrealize is
		do
			realized := false
		end

	dialog_command_target is
			-- set the command target to the dialog_shell
		do
		end

	widget_command_target is
			-- set the command target to the widget
		do
		end

	set_font (a_font: FONT) is
			-- Set the font to `a_font'
		do
			font := a_font
		ensure
			font_is_set: font = a_font
		end

	action_target: POINTER is
			-- Target for actions
		do
		end

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY) is
			-- Set the dialog shell action to
			-- `cmd', with argument `arg'.
		do
		end

feature -- Removal

	remove_parent_action (action: STRING) is
			-- Remove the dialog shell action of
			-- `cmd', with argument `arg'.
		do
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "Evisiondialog"
		end

	default_style: INTEGER is
			-- Deafult style for a dialog
		do
			Result := Ws_visible + Ws_overlapped + Ws_dlgframe + Ws_thickframe
		end

	font: FONT
			-- Font of the dialog

end -- class DIALOG_WINDOWS
 
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
