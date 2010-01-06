expanded class E2
inherit
E1

feature
	y: E0

	set_xy (an_x: like x; an_y: like y)
		do
			-- Hier passierts, irgendwie wird x nicht gesetzt
			-- x := an_x hingegen läuft wunderbar
			set_x (an_x)
			y := an_y
		end
end
