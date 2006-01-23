indexing

	description: "General push button implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PUSH_B_I 

inherit

	BUTTON_I

feature -- Element change

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		require
			translation_not_void: a_translation /= Void
		deferred
		end

feature -- Removal

	remove_accelerator_action is
			-- Remove the accelerator action.
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




end -- class PUSH_B_I

