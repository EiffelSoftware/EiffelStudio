indexing

	description: 
		"EiffelVision implementation of popup shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	POPUP_S_M 

inherit

	POPUP_S_I;

	SHELL_M
		rename
			popdown as mel_popdown,
			is_shown as shown
		end;

	SHELL_M
		rename
			is_shown as shown
		redefine
			popdown
		select
			popdown
		end

	MEL_CALLBACK

feature -- Status report

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		do
			Result := grab_type = 2
		end; 

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		do
			Result := grab_type = 1
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		do
			Result := grab_type = 0
		end; 

	is_popped_up: BOOLEAN;
			-- Is the popup widget popped up on screen ?

feature -- Status setting

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		do
			grab_type := 2
		end; 

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		do
			grab_type := 1
		end;

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		do
			grab_type := 0
		end;

feature -- Display

	popdown is
			-- Popdown popup shell.
		do
			if is_popped_up then
				mel_popdown
			end;
			is_popped_up := False
		end;

	popup is
			-- Popup a popup shell.
		do
			if not is_popped_up then
				inspect 
					grab_type
				when 0 then
					popup_none
				when 1 then
					popup_exclusive
				when 2 then
					popup_non_exclusive
				end;
				is_popped_up := True
			end
		end;

feature {NONE} -- Implementation

	grab_type: INTEGER;
			-- Type of grab
	
	initialize (shell: MEL_SHELL) is
			-- Initialize the current dialog
		do
			shell.set_allow_shell_resize (False);
			shell.add_popup_callback (Current, True);
			shell.add_popdown_callback (Current, False);
		end;

feature {NONE} -- Execution

	execute (up: ANY) is
		local
			bool_ref: BOOLEAN_REF
		do
			bool_ref ?= up;
			check
				non_void_bool_ref: bool_ref /= Void
			end;
			is_popped_up := bool_ref.item
		end;

end -- class POPUP_S_M

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
