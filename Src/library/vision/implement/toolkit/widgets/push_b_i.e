indexing

	description: "General push button implementation";
	status: "See notice at end of class";
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

end -- class PUSH_B_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

