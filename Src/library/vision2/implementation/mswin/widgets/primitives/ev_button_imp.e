indexing

        description: 
                "EiffelVision push button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_BUTTON_IMP
        
inherit
        EV_BUTTON_I
        
	EV_BAR_ITEM_IMP
		redefine
			wel_window
		end
        
	EV_TEXT_CONTAINER_IMP
		redefine
			wel_window
		end
	
creation

        make

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a wel push button.
		local
			cont_imp: EV_CONTAINER_IMP
		do
			cont_imp ?= par.implementation
			check
				valid_container: cont_imp /= Void
			end
			-- Create a button with 0 size
			!!wel_window.make (cont_imp.wel_window, "", 0, 0, 0, 0, 0)
			set_font (font)
			set_default_size
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
			set_size (fw.string_width (Current, text) +
				  Extra_width,
				  (7 * fw.string_height (Current, text)) // 4 - 2)
		end
	
	Extra_width: INTEGER is 10

feature {NONE} -- Implementation	
	
	wel_window: WEL_PUSH_BUTTON
end



