indexing

	description: "General toggle button gadget implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOGGLE_BG_I 

inherit

	TOGGLE_B_I

feature -- Element change

	set_accelerator_action (a_translation: STRING) is
			-- Set the accerlator action (modifiers and key to use as a shortcut
			-- in selecting a button) to `a_translation'.
			-- `a_translation' must be specified with the X toolkit conventions.
		do
		end

feature -- Removal

	remove_accelerator_action is
			-- Remove the accelerator action.
		do
		end

end --class TOGGLE_BG_I


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
