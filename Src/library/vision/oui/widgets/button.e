indexing

	description: "General button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BUTTON 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

feature -- Access

	text: STRING is
			-- Text of current button
		require
			exists: not destroyed
		do
			Result:= implementation.text
		end; 

feature -- Status setting

	allow_recompute_size is
			-- Allow current button to recompute its size according to
			-- changes on its text.
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- changes on its text.
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size
		end; 

	set_center_alignment is
			-- Set text alignment of current label to center
		require
			exists: not destroyed
		do
			implementation.set_center_alignment
		end;
 
	set_left_alignment is
			-- Set text alignment of current label to left.
		require
			exists: not destroyed
		do
			implementation.set_left_alignment
		end;

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		require
			exists: not destroyed;
			not_text_void: a_text /= Void
		do
			implementation.set_text (a_text)
		ensure
			text_set: equal (without_ampersands (text), without_ampersands (a_text)) 
			-- The comparison has to be done without
			-- ampersands, because X version will change
			-- the position of ampersand to the first 
			-- occurence of the letter. (For ex. "Save 
			-- &as" becomes "S&ave as"
		end 

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is activated.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_activate_action (a_command, argument)
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is armed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_arm_action (a_command, argument)
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when current
			-- arrow button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_release_action (a_command, argument)
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_activate_action (a_command, argument)
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is armed.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_arm_action (a_command, argument)
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' with `argument' from the list of action 
			-- to be executed when current arrow button is released.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_release_action (a_command, argument)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I} -- Implementation

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: BUTTON_I;
			-- Implementation of button
	
feature {NONE} -- Implementation
	
	without_ampersands (a_text: STRING): STRING is
			-- Returns a string which is a_text without ampersands
		do
			Result := clone(a_text)
			Result.prune_all('&')
		end
	
end -- class BUTTON



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

