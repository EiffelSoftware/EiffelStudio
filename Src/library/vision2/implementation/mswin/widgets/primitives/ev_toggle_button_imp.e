indexing
	description: "EiffelVision Toggle button.%
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		undefine
			build
		end

	EV_BUTTON_IMP
		redefine
			wel_window,
			make,
			make_with_text
		end

creation
	make, make_with_text


feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a wel toggle button with an empty text.
		do
			test_and_set_parent (par)
			!WEL_SELECTABLE_BUTTON!wel_window.make (parent_imp.wel_window, "", 0, 0, 10, 10, 0)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
        		-- Create a wel toggle button.
		do
			test_and_set_parent (par)
			!WEL_SELECTABLE_BUTTON!wel_window.make (parent_imp.wel_window, txt, 0, 0, 10, 10, 0)
		end

feature -- Status report
	
	pressed: BOOLEAN is
			-- Is toggle pressed
		do
			Result := wel_window.checked
		end 
	

feature -- Status setting

	set_pressed (button_pressed: BOOLEAN) is
			-- Set Current toggle on and set
			-- pressed to True.
		do
			if button_pressed then
				wel_window.set_checked
			else
				wel_window.set_unchecked
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposite
		do
			set_pressed (not pressed)
		end

feature -- Event - command association
	
	add_toggle_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is	
		do
			
		end	

feature -- Implementation

	wel_window: WEL_CHECK_BOX
			-- Current wel_window. 
			-- It's not possible to define directly a 
			-- WEL_SELECTABLE_BUTTON because of the hierarchy
			-- of EiffelVision buttons.

end -- class EV_TOGGLE_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
