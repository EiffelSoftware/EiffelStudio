class TEST

create
	make

feature

	make
		local
			x: INTEGER
			d: REAL_64
			s: STRING
		do
			d := x / x
			s := d.out
			print (s); io.new_line
			d := d.nan
			s := d.out
			print (s); io.new_line
			d := d.negative_infinity
			s := d.out
			print (s); io.new_line
			d := d.positive_infinity
			s := d.out
			print (s); io.new_line
		end

end
