class
	EV_CIRCLE

inherit
	EV_ELLIPSE
		rename
			radius1 as radius,
			set_radius1 as set_radius
		export
			{NONE} orientation, radius2,
			set_orientation, set_radius2
		redefine
			set_radius, is_superimposable
		end

create
	make

feature -- Status setting

	set_radius (new_radius: like radius) is do end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is do end

end -- class EV_CIRCLE
