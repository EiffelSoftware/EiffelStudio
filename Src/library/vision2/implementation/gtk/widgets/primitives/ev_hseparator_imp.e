class EV_HSEPARATOR_IMP

inherit

	EV_SEPARATOR_I

	EV_PRIMITIVE_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_hseparator_new
			show
                end

end -- class EV_HSEPARATOR_IMP
