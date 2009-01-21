

class TEST

create
	make

feature

	make
		local
			x: INTEGER
			d: DOUBLE
			s: STRING
		do
			d := x / x
			s := d.out
			print (s); io.new_line
		end

end
