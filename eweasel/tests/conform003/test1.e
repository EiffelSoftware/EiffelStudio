class TEST1 [G]

create
	make

feature {NONE} -- Creation

	make
		do
			create y.make (10)
		end

feature

	test_formals (v1: G; v2: G; v3: G) is
		do
		end

	test_anchors_1 (v1: like x; v2: like att_x; v3: like det_x) is
		do
		end

	test_anchors_2 (v1: like y; v2: !like y; v3: ?like y) is
		do
		end

	y: ?STRING

	x: like y
	att_x: !like y
	det_x: ?like y


end
