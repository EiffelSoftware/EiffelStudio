class TEST
create
	make
feature
	
	make is
		local
			a: ANY
			s: ANY
		do
			a := $x
			print (a.generating_type); io.new_line

			s := Current
			a := $s
			print (a.generating_type); io.new_line
		end

	x: TEST1
end
