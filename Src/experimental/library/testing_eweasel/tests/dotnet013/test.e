class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			l_size: DRAWING_SIZE_F
			l_pt_f: DRAWING_POINT_F
		do
			l_pt_f := l_size.empty.to_point_f (l_size)
			l_pt_f := l_size.empty.to_point_f_2
		end

end
