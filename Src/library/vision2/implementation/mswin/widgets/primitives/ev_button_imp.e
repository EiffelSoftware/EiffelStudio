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
        
	EV_TEXT_CONTAINER_IMP
	
	WEL_PUSH_BUTTON
        
creation

        make

feature {NONE} -- Initialization

        make (parent: EV_CONTAINER) is
                        -- Create a wel push button.
                local
                        a: ANY
			s: STRING
			parent_imp: WEL_WINDOW
		do
			!!s.make (0)
			s := ""
			a ?= s.to_c
			parent_imp ?= parent
			check
				valid_parent: parent_imp /= Void
			end
			wel_make (parent_imp, x, y, width, height, 0)
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
				  extra_width,
				  (7 * fw.string_height (Current, text)) // 4 - 2)
		end
end



