indexing
        description: "EiffelVision push button.%
					% Mswindows implementation."
        status: "See notice at end of class"
        id: "$$"
        date: "$$"
        revision: "$$"
        
class
    EV_BUTTON_IMP
        
inherit
    EV_BUTTON_I
		redefine
			build
		end
 
	EV_PRIMITIVE_IMP
		redefine
			wel_window,
			build
		end
       
	EV_BAR_ITEM_IMP
		redefine
			wel_window,
			set_insensitive,
			build
		end
        
	EV_TEXT_CONTAINER_IMP
		redefine
			set_default_size
		end
	
	EV_FONTABLE_IMP

creation
        make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		do
			test_and_set_parent (par)
			!WEL_PUSH_BUTTON!wel_window.make (parent_imp.wel_window, "", 0, 0, 0, 0, 0)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
        		-- Create a wel push button.
		do
			test_and_set_parent (par)
			!WEL_PUSH_BUTTON!wel_window.make (parent_imp.wel_window, txt, 0, 0, 0, 0, 0)
		end

	build is
			-- Called after creation. Set the current size and
			-- notify the parent.
		do
			Precursor
			set_font (font)
			set_default_size
		end

feature -- Event - command association
	
	add_click_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is	
		do
			add_button_press_command (1, command, arguments)
		end
		
feature {NONE} -- Implementation	
	
	set_default_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			set_minimum_width (fw.string_width (Current, text) + Extra_width)
			set_minimum_height (7 * fw.string_height (Current, text) // 4 - 2)
			set_size (minimum_width, minimum_height)
		end

	Extra_width: INTEGER is 10

feature {NONE} -- Implementation

	wel_window: WEL_BUTTON
			-- Current wel_window
			-- We can't use directly a wel_push_button here,
			-- because of the descendants classes that use 
			-- other kind of wel_button

end -- class EV_BUTTON_IMP

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
