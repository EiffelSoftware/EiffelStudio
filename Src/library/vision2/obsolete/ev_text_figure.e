class
	EV_TEXT_FIGURE

inherit
	EV_FIGURE
		redefine
			recompute
		end

	EV_INTERIOR
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make is do end

feature -- Access

	ascent: INTEGER
	
	descent: INTEGER

	string_width: INTEGER

	text: STRING

	top_center: like top_left is do end

	top_left: EV_POINT

	top_right: like top_left is do end

	base_center: like top_left is do end

	base_left: like top_left is do end

	base_right: like top_left is do end 

	bottom_center: like top_left is do end

	bottom_left: like top_left is do end 

	bottom_right: like top_left is do end

	font: EV_FONT

	middle_center: like top_left is do end

	middle_left: like top_left is do end

	middle_right: like top_left is do end

	origin: EV_POINT is do end

feature -- Element change

	set_base_center (a_point: like top_left) is do end

	set_base_left (a_point: like top_left) is do end

	set_base_right (a_point: like top_left) is do end

	set_bottom_center (a_point: like top_left) is do end

	set_bottom_left (a_point: like top_left) is do end

	set_bottom_right (a_point: like top_left) is do end

	set_font (a_font: EV_FONT) is do end

	set_middle_center (a_point: like top_left) is do end

	set_middle_left (a_point: like top_left) is do end

	set_middle_right (a_point: like top_left) is do end

	set_origin_to_base_center is do end

	set_origin_to_base_left is do end

	set_origin_to_base_right is do end

	set_origin_to_bottom_center is do end

	set_origin_to_bottom_left is do end

	set_origin_to_bottom_right is do end

	set_origin_to_middle_center is do end

	set_origin_to_middle_left is do end

	set_origin_to_middle_right is do end

	set_origin_to_top_center is do end

	set_origin_to_top_left is do end

	set_origin_to_top_right is do end 

	set_text (a_text: STRING) is do end

	set_top_center (a_point: like top_left) is do end

	set_top_left (a_point: like top_left) is do end

	set_top_right (a_point: like top_left) is do end


	xyrotate (a: EV_ANGLE; px,py: INTEGER) is do end

	xyscale (f: REAL; px,py: INTEGER) is do end

	xytranslate (vx, vy: INTEGER) is do end

feature -- Output

	draw is do end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is do end 


	recompute is do end

end -- class EV_TEXT_FIGURE
