class TEST
create
	make

feature

	make is
		local
			t: TUPLE [REAL, DOUBLE, DOUBLE]
			r: REAL
			d: DOUBLE
		do
			t := [{REAL} 4.5, {DOUBLE} 5.6, 5.6]

			r := t.real_item (1)
			if (r - 4.5).abs > 0.01 then
				print ("Error%N")
			end

			d := t.double_item (2)
			if (d - 5.6).abs > 0.01 then
				print ("Error%N")
			end

			d := t.double_item (3)
			if (d - 5.6).abs > 0.01 then
				print ("Error%N")
			end
		end;

end

