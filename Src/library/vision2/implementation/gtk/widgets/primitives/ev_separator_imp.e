class EV_SEPARATOR_IMP

inherit

	EV_SEPARATOR_I

	EV_PRIMITIVE_IMP
		undefine
			make
		end

creation
	make_horizontal,
	make_vertical

feature {NONE} -- Initialization

	make_horizontal (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_hseparator_new
			show
                end

	make_vertical (par: EV_CONTAINER) is
                        -- Create a gtk seperator
                do
                        widget := gtk_vseparator_new
			show
                end

end -- class EV_SEPARATOR_IMP
