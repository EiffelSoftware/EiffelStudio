class
	EV_SEGMENT

inherit
	EV_LINE
		redefine
			make,
			contains
		end

	EV_ENDED_FIGURE

create
	make
	
feature {NONE} -- Initialization

	make is do end

feature -- Access

	center: EV_POINT is do end

	contains (p: EV_POINT): BOOLEAN is do end

feature -- Element change

	set (o1, o2: like p1) is do end

	set_p1 (p: like p1) is do end

	set_p2 (p: like p2) is do end

feature -- Output

	draw is do end

feature -- Status report

	is_null: BOOLEAN is do end

	is_superimposable (other: like Current): BOOLEAN is do end

end -- class EV_SEGMENT
