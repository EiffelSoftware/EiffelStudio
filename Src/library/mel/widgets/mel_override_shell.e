indexing

	description:
			"Popup shell that bypasses window management.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_OVERRIDE_SHELL

inherit

	MEL_SHELL

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a override shell widget.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xt_create_override_shell ($widget_name, a_parent.screen_object);
			Mel_widgets.put (Current, screen_object);
			set_default
		ensure
			exists: not is_destroyed
		end;

feature {NONE} -- Implementation

	xt_create_override_shell (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_OVERRIDE_SHELL

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
