indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	DIALOG_SHELL_WINDOWS

inherit

	WM_SHELL_WINDOWS
		redefine
			class_name
		end

	DIALOG_S_I

	GRABABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE) is
		do
			a_dialog_shell.set_wm_imp (Current)
		end

feature -- Status report

	is_popped_up: BOOLEAN is
			-- Is this widget currently popped up?
		do
		end

feature -- Status setting

	popup is
			-- Popup the shell
		do
		end

	popdown is
			-- Popdown the widget
		do
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionDialogShell"
		end
 
end -- class DIALOG_SHELL_WINDOWS

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


