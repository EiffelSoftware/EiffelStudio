class EV_VERTICAL_SEPARATOR_IMP

inherit

	EV_VERTICAL_SEPARATOR_I

	EV_SEPARATOR_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_vseparator_new
			show
                end

end -- class EV_VERTICAL_SEPARATOR_IMP
