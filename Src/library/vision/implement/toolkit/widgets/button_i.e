indexing

	description: "General button implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BUTTON_I 

inherit

	PRIMITIVE_I;

	FONTABLE_I
	
feature -- Status setting

	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		deferred
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		deferred
		end;

	set_center_alignment is
			-- Set text alignment of current label to center
		deferred
		end;
 
	set_left_alignment is
			-- Set text alignment of current label to left.
		deferred
		end;

	text: STRING is
			-- Text of current button
		deferred
		end;

	set_text (a_text: STRING) is
			-- Set current button text to `a_text'.
		require
			not_text_void: a_text /= Void
		deferred
		ensure
			text.is_equal (a_text)
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_arm_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is armed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when current
			-- push button is released.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_arm_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is armed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current push button is released.
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




end -- class BUTTON_I

