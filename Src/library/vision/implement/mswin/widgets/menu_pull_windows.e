indexing
    status: "See notice at end of class";
    date: "$Date$";
    revision: "$Revision$"

class
	MENU_PULL_WINDOWS

inherit
	PULLDOWN_WINDOWS

	MENU_PULL_I

	SIZEABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_pulldown: MENU_PULL; man: BOOLEAN; oui_parent: MENU) is
			-- Create a menu_pull.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			check
				valid_parent: parent /= Void
			end
			managed := man
			text := a_pulldown.identifier
			!! menu_button.make (text, oui_parent)
			menu_button.attach_menu (a_pulldown)
		end

	create is
		do
			wel_make
		end

feature -- Element change

	set_text (t: STRING) is
			-- Set `text' to `t'
		do
			text := t
			menu_button.set_text (t)
		end

feature {NONE} -- Implementation

	set_default_size is
			-- Useless here
		do
		end


	text: STRING 

end -- class MENU_PULL_WINDOWS

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
