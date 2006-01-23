indexing
	status: "See notice at end of class.";
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

create
	make

feature -- Initialization

	make (a_dialog_shell: DIALOG_SHELL; oui_parent: COMPOSITE) is
		do
			create private_attributes
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




end -- class DIALOG_SHELL_IMP

