indexing 
    status: "See notice at end of class."; 
    date: "$Date$"; 
    revision: "$Revision$" 
 
class
	DIALOG_IMP
  
inherit 
	WM_SHELL_IMP
		redefine
			x,
			show,
			destroy,
			default_style,
			class_name,
			realize,
			unrealize,
			set_default_position
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

	x: INTEGER is
			-- X axis position.
			-- If `default_position' is set, we just need to
			-- set `x' to `cw_usedefault'.
		do
			if default_position then
				Result := cw_usedefault
			else
				Result := Precursor
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
			Precursor {WM_SHELL_IMP} (wid_list)
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
		
	realize is
		do
			Precursor
				-- set initial focus
			{WM_SHELL_IMP} if initial_focus /= void then
				initial_focus.wel_set_focus
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

	font: FONT;
			-- Font of the dialog

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




end -- class DIALOG_IMP

