class
	EV_INTERIOR

inherit

	EV_DRAWING_ATTRIBUTES
		redefine
			set_drawing_attributes
		end

create

	make

feature {NONE}-- Initialization 

	make is do end

feature {EV_FIGURE} -- Element change

	set_drawing_attributes (drawing: EV_DRAWABLE) is do end

end -- class EV_INTERIOR
