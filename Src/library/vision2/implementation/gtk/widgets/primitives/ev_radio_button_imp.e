indexing

        description: 
                "EiffelVision radio button, gtk implementation.";
        status: "See notice at end of class";
        id: "$Id$";
        date: "$Date$";
        revision: "$Revision$"
        
class
        EV_RADIO_BUTTON_IMP
        
inherit
        EV_RADIO_BUTTON_I
	
	EV_CHECK_BUTTON_IMP
		redefine
			make_with_text
		end
        
creation

         make_with_text

feature {NONE} -- Initialization

        make_with_text (par: EV_CONTAINER; txt: STRING) is
                        -- Create a gtk push button.
                local
                        a: ANY
			parent_imp: EV_CONTAINER_IMP
		do
			a ?= txt.to_c
			parent_imp ?= par.implementation
			check
				valid_parent: parent_imp /= Void
			end
                        widget := gtk_radio_button_new_with_label (parent_imp.radio_button_group,
								   $a)
			parent_imp.set_rbg_pointer (gtk_radio_button_group (Current.widget))
                end
	
end
