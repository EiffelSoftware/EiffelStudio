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
			width,
			height,
			show,
			default_style,
			class_name,
			unrealize,
			set_default_position
		end

	WM_SHELL_WINDOWS
		redefine
			width,
			height,
			show,
			destroy,
			default_style,
			class_name,
			unrealize,
			set_default_position
		select
			destroy
		end

	DIALOG_I

	GRABABLE_WINDOWS

feature -- Status report

	default_position: BOOLEAN
			-- Use default position?

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		do
			Result := realized and then shown
		end

	width: INTEGER is
			-- Width of dialog
		do
			if exists then
				Result := wel_width
			else
				Result := private_attributes.width
			end
		end
 

	height: INTEGER is
			-- Height of dialog
		do
			if exists then
				Result := wel_height
			else
				Result := private_attributes.height
			end
		end

feature -- Status setting

	show is
			-- Show composite.
		do
			if exists then 
				wel_show
				show_children
			end
			shown := True
		end

	set_default_position (flag: BOOLEAN) is
		do
			default_position := flag
		end

	destroy (wid_list: LINKED_LIST [WIDGET]) is
		do
			if is_popped_up then
				if insensitive_list /= Void then
					set_windows_sensitive
				end
			end
			wm_shell_destroy (wid_list)
		end

	popdown is
			-- Popdown popup shell.
		do
			if is_popped_up then
				if insensitive_list /= Void then
					set_windows_sensitive
				end
				hide
			end
		end

	popup is
			-- Popup a popup shell.
		do
			if not is_popped_up then
				if realized then
					show
				else
					realize
					show
				end
				if grab_style = modal then
					set_windows_insensitive
				end
			end
		end

	unrealize is
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			wel_destroy
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
			Result := Ws_overlapped + Ws_dlgframe + Ws_thickframe
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
