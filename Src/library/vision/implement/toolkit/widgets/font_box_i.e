indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONT_BOX_I 

inherit

	TERMINAL_I
	
feature -- Access

	font: FONT is
			-- Font currently selected by the user
		deferred
		ensure
			result_not_void: Result /= Void
		end;

feature -- Status setting

	show_apply_button is
			-- Make apply button visible.
		deferred
		end;

	show_cancel_button is
			-- Make cancel button visible.
		deferred
		end;

	show_ok_button is
			-- Make ok button visible.
		deferred
		end

	hide_apply_button is
			-- Make apply button invisible.
		deferred
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		deferred
		end;

	hide_ok_button is
			-- Make ok button invisible.
		deferred
		end;

feature -- Element change

	add_apply_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		require
			a_font_exists: a_font /= Void
		deferred
		end;

feature -- Removal

	remove_apply_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

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




end -- class FONT_BOX_I

