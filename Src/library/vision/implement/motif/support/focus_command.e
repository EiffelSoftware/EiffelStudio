indexing

	description: "Command to handle leave and enter actions for a focusable."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FOCUS_COMMAND 

inherit

	COMMAND

creation

	make

feature {NONE} -- Initialize

	make (a_focus_label: like focus_label) is
			-- Set `focus_label' to `a_focus_label'.
		do
			focus_label := a_focus_label
			!! delayed_focus_command.make (Current);
			!! popup_timer.make;
			!! popdown_timer.make
		end;

feature -- Execution

	execute (arg: FOCUSABLE) is
		local
			w: WIDGET
		do
			if arg /= Void then
				if popup_timer.is_call_back_set then
					popup_timer.set_no_call_back
				end;
				if popup_timer_initialized then
					last_focusable := arg;
					focus_label.set_text (arg.focus_string);
					if popdown_timer.is_call_back_set then
						popdown_timer.set_no_call_back
					end;
				else
					popup_timer.set_next_call_back (2000, delayed_focus_command, arg);
					if popdown_timer.is_call_back_set then
						popdown_timer.set_no_call_back
					end;
				end
			else
				focus_label.reset;
				last_focusable := Void;
				if popup_timer.is_call_back_set then
					popup_timer.set_no_call_back
				end
				if not popdown_timer.is_call_back_set then
					popdown_timer.set_next_call_back (2000, delayed_focus_command, Void);
				end
			end;
		end;

feature {NONE} -- Properties

	focus_label: FOCUS_LABEL;
			-- Focus label

	last_focusable: FOCUSABLE;
			-- Last focusable

	delayed_focus_command: DELAYED_FOCUS_COMMAND;
			-- Focus command to popup the label after a certain delay.

	popup_timer: TIMER;
			-- Timer used to popup the label after a certain delay.

	popdown_timer: TIMER;
			-- Timer used to unintialize the `popup_timer'.

	popup_timer_initialized: BOOLEAN
			-- Has the `popup_timer' been initialized?
			-- Ie: Has a popup already occured?

feature {DELAYED_FOCUS_COMMAND} -- Implementation

	popup_label (arg: FOCUSABLE) is
			-- Pops up label. Requested by `delayed_focus_command'.
		do
			last_focusable := arg;
			focus_label.set_text (arg.focus_string);
			popup_timer_initialized := True
		end;

	uninitialize_timer is
			-- Uninitializes the timer.
		do
			popup_timer_initialized := False;
			if popup_timer.is_call_back_set then
				popup_timer.set_no_call_back;
			end;
		end;

end -- class FOCUS_COMMAND


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

