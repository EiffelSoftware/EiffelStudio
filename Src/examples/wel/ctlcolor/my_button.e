indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_BUTTON

inherit
	WEL_PUSH_BUTTON
		rename
			make as wel_make
		redefine
			on_bn_clicked
		end

creation
	make

feature -- Initialization

 	make (a_parent: WEL_WINDOW; a_name: STRING; a_x, a_y, a_width, a_height, an_id, a_type: INTEGER) is
			-- Create the button.
		do
			wel_make (a_parent, a_name, a_x, a_y, a_width, a_height, an_id)
			window ?= a_parent
			type := a_type
		end

feature -- Access

	window: PRECOMP_MAIN_WINDOW
		-- The main_window.

	type: INTEGER
		-- The type : foreground or background

feature {NONE} -- Implementation

  	on_bn_clicked is
   			-- Called when the button is clicked
		local
			dialog: WEL_CHOOSE_COLOR_DIALOG 
		do
			create dialog.make
			dialog.activate (window)
			if dialog.selected then
				if type = 1 then
					window.set_frgnd_ctlcolor (dialog.rgb_result)
				else
					window.set_bkgnd_ctlcolor (dialog.rgb_result)
				end
				window.invalidate
			end
 		end

end -- class MY_BUTTON

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
