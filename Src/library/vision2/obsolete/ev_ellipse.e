class
	EV_ELLIPSE

inherit
--	EV_CLOSED_FIGURE
--		redefine
--			contains, recompute
--		end

--	EV_ANGLE_ROUTINES
--		export
--			{NONE} all
--		end

create
	make

feature -- Initialization

	make is do end

feature -- Access

	center: EV_POINT

	orientation: EV_ANGLE

	origin: EV_POINT

	radius1: INTEGER

	radius2: INTEGER

	contains (p: EV_POINT): BOOLEAN is do end

feature -- Status setting

	set_center (a_point: like center) is do end

	set_orientation (an_orientation: like orientation) is do end

	set_origin_to_center is do end

	set_radius1 (new_radius1: like radius1) is do end

	set_radius2 (new_radius2: like radius2) is do end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is do end

	xyscale (f: REAL; px,py: INTEGER) is do end

	xytranslate (vx, vy: INTEGER) is do end

feature -- Output

	draw is do end

feature -- Updating

	recompute is do end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is do end

end -- class EV_ELLIPSE
