class EV_HORIZONTAL_SEPARATOR_IMP

inherit

	EV_HORIZONTAL_SEPARATOR_I

	EV_SEPARATOR_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_hseparator_new
			show
                end

end -- class EV_HORIZONTAL_SEPARATOR_IMP
