class EV_VSEPARATOR_IMP

inherit

	EV_SEPARATOR_I

	EV_PRIMITIVE_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_vseparator_new
			show
                end

end -- class EV_VSEPARATOR_IMP
