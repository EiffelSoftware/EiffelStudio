deferred class
	EV_LINE

inherit

	EV_OPEN_FIGURE
		redefine
			contains,
			recompute
		end

	EV_PATH

feature -- Access

	origin: EV_POINT is do end

	p2: like p1

	p1: EV_POINT

	contains (p: EV_POINT): BOOLEAN is do end

feature -- Element change

	set (o1, o2: like p1) is deferred end

	set_origin_to_first_point is do end

	set_origin_to_middle is do end

	set_origin_to_second_point is do end

	set_p1 (p: like p1) is deferred end

	set_p2 (p: like p2) is deferred end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is do end

	xyscale (f: REAL; px,py: INTEGER) is do end

	xytranslate (vx, vy: INTEGER) is do end

feature -- Status report

	is_horizontal: BOOLEAN

	is_null: BOOLEAN

	is_vertical: BOOLEAN

feature -- Updating

	recompute is do end

end -- class EV_LINE
