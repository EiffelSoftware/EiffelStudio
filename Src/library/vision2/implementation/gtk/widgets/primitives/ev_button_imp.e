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
        
	EV_PRIMITIVE_IMP
	
	EV_BAR_ITEM_IMP
        
	EV_TEXT_CONTAINER_IMP
        
creation

        make_with_label

feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is
		do
			make_with_label (par, "")
		end
		
        make_with_label (par: EV_CONTAINER; txt: STRING) is
                        -- Create a gtk push button.
                local
                        a: ANY
		do
			a ?= txt.to_c
                        widget := gtk_button_new_with_label ($a)
                end
	
feature {NONE} -- Implementation
	
	gtk_command_id: INTEGER
                        -- Id of the command handler
        
        
        label_widget: POINTER is
                        -- gtk widget of the label inside the button
                do
                        Result := c_gtk_get_label_widget (widget)
                end

end
