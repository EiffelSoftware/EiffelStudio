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
        
creation

        make

feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a gtk push button.
                local
                        a: ANY
			s: STRING
		do
			!!s.make (0)
			s := ""
			a ?= s.to_c
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
