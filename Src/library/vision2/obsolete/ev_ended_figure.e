class
	EV_ENDED_FIGURE

feature -- Status setting

	set_butt_cap is do end

	set_notlast_cap is do end

	set_projecting_cap is do end

	set_round_cap is do end


feature -- Status report

	is_butt_cap: BOOLEAN is do end

	is_notlast_cap: BOOLEAN is do end 

	is_projecting_cap: BOOLEAN is do end

	is_round_cap: BOOLEAN is do end

feature {NONE} -- Access

	cap_style: INTEGER

	CapButt: INTEGER is 1

	CapNotLast: INTEGER is 0

	CapProjecting: INTEGER is 3

	CapRound: INTEGER is 2

end -- class EV_ENDED_FIGURE
