class
	EV_PATH

inherit

	EV_DRAWING_ATTRIBUTES
		redefine
			get_drawing_attributes,
			set_drawing_attributes
		end

create

	make

feature {NONE} -- Initialization

	make is do end

feature -- Status report 

	line_width: INTEGER

feature -- Status setting

	set_line_width (a_line_width: INTEGER) is do end

feature {EV_FIGURE} -- Element change

	get_drawing_attributes (drawing: EV_DRAWABLE) is do end

	set_drawing_attributes (drawing: EV_DRAWABLE) is do end


end -- class EV_PATH
