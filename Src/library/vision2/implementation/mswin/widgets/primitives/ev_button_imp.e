indexing

        description: 
                "EiffelVision push button. Mswindows implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
    EV_BUTTON_IMP
        
inherit
    EV_BUTTON_I
 
	EV_PRIMITIVE_IMP
		redefine
			wel_window
		end
       
	EV_BAR_ITEM_IMP
		redefine
			wel_window
		end
        
	EV_TEXT_CONTAINER_IMP
		redefine
			set_default_size
		end
	
	EV_FONTABLE_IMP

creation
        make_with_text


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		do
		end


	make_with_text (par: EV_CONTAINER; txt: STRING) is
        		-- Create a wel push button.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				valid_container: par_imp /= Void
			end
			!WEL_PUSH_BUTTON!wel_window.make (par_imp.wel_window, txt, 0, 0, 0, 0, 0)
			set_font (font)
			set_default_size
		end

feature -- Basic operation

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

feature -- Event - command association
	
	add_click_command ( command: EV_COMMAND; 
			    arguments: EV_ARGUMENTS) is	
		do
			add_button_press_command (1, command, arguments)
		end
		
feature {NONE} -- Implementation	
	
	wel_window: WEL_BUTTON
			-- Current wel_window
			-- We can't use directly a wel_push_button here,
			-- because of the descendants classes that use 
			-- other kind of wel_button
end

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
