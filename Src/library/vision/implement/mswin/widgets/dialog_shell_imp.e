indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	DIALOG_SHELL_IMP

inherit

	WM_SHELL_IMP
		redefine
			class_name
		end

	DIALOG_SHELL_I

	GRABABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE) is
		do
			!!private_attributes
			parent ?= oui_parent.implementation
			a_dialog_shell.set_wm_imp (Current)
			managed := True
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
 
end -- class DIALOG_SHELL_IMP




--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

